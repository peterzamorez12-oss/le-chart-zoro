#!/usr/bin/env python3
import os, sys, time, signal, socket, subprocess
from pathlib import Path

APP = '/app/LECHART_JAMES_V23_9_34_RAILWAY_EXACT_PC_OG.py'
DISPLAY = os.environ.get('DISPLAY', ':99')
PORT = int(os.environ.get('PORT', '8765'))
VNC_PORT = int(os.environ.get('VNC_PORT', '5900'))
NOVNC_WEB = os.environ.get('NOVNC_WEB', '/usr/share/novnc')
children = []

def log(msg):
    print('[RAILWAY-DESKTOP] ' + str(msg), flush=True)

def spawn(name, cmd, env=None):
    log(f'starting {name}: {" ".join(cmd)}')
    p = subprocess.Popen(cmd, env=env or os.environ.copy())
    children.append((name,p))
    return p

def port_open(host, port, timeout=0.25):
    try:
        with socket.create_connection((host, port), timeout=timeout): return True
    except OSError: return False

def wait_port(host, port, proc, name, seconds=12):
    end=time.time()+seconds
    while time.time()<end:
        if proc.poll() is not None:
            raise RuntimeError(f'{name} exited early with code {proc.returncode}')
        if port_open(host,port): return
        time.sleep(.15)
    raise RuntimeError(f'{name} did not open {host}:{port} within {seconds}s')

def cleanup(*_):
    log('shutting down child processes')
    for name,p in reversed(children):
        if p.poll() is None:
            try: p.terminate()
            except Exception: pass
    deadline=time.time()+3
    for _,p in reversed(children):
        if p.poll() is None:
            try: p.wait(max(0.1,deadline-time.time()))
            except Exception:
                try: p.kill()
                except Exception: pass
    sys.exit(0)

signal.signal(signal.SIGTERM, cleanup)
signal.signal(signal.SIGINT, cleanup)

try:
    # Persistent memory: use the mounted Railway volume automatically when present.
    if Path('/data').is_dir():
        os.environ.setdefault('JAMES_DATA_DIR','/data')
    home=Path(os.environ.get('HOME','/app/home'))
    (home/'Downloads').mkdir(parents=True,exist_ok=True)

    web=Path(NOVNC_WEB)
    if not (web/'vnc.html').exists():
        raise RuntimeError(f'noVNC web files missing: expected {web}/vnc.html')
    # Root URL goes straight into the desktop, scaled to the phone/browser viewport.
    (web/'index.html').write_text(
        '<!doctype html><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">'
        '<script>location.replace("/vnc.html?autoconnect=true&resize=scale&reconnect=true&show_dot=true&path=websockify");</script>',
        encoding='utf-8')

    env=os.environ.copy(); env['DISPLAY']=DISPLAY
    xvfb=spawn('Xvfb',['Xvfb',DISPLAY,'-screen','0','2400x900x24','-ac','-nolisten','tcp','-noreset'],env)
    # Xvfb has a unix X socket rather than a TCP listener, so give it a short bounded boot.
    for _ in range(30):
        if xvfb.poll() is not None: raise RuntimeError(f'Xvfb exited early with code {xvfb.returncode}')
        dnum=DISPLAY.split(':')[-1].split('.')[0]
        if Path('/tmp/.X11-unix/X'+dnum).exists(): break
        time.sleep(.1)
    else: raise RuntimeError('Xvfb display socket never appeared')

    vnc=spawn('x11vnc',['x11vnc','-display',DISPLAY,'-forever','-shared','-rfbport',str(VNC_PORT),'-localhost','-nopw','-noxdamage','-quiet'],env)
    wait_port('127.0.0.1',VNC_PORT,vnc,'x11vnc')

    ws=spawn('noVNC/websockify',['websockify','--web='+str(web),'--heartbeat=30',f'0.0.0.0:{PORT}',f'127.0.0.1:{VNC_PORT}'],env)
    wait_port('127.0.0.1',PORT,ws,'websockify')
    log(f'public desktop listener READY on 0.0.0.0:{PORT}')

    app=spawn('LeChart James PC OG',['python3','-u',APP],env)
    # Catch true startup crashes instead of advertising a dead desktop as healthy.
    startup_deadline=time.time()+8
    while time.time()<startup_deadline:
        if app.poll() is not None: raise RuntimeError(f'LeChart James exited during startup with code {app.returncode}')
        if xvfb.poll() is not None: raise RuntimeError('Xvfb died during startup')
        if vnc.poll() is not None: raise RuntimeError('x11vnc died during startup')
        if ws.poll() is not None: raise RuntimeError('websockify died during startup')
        time.sleep(.2)
    log('LeChart James Zoro desktop survived startup; deployment is live')

    while True:
        for name,p in children:
            rc=p.poll()
            if rc is not None:
                raise RuntimeError(f'{name} exited unexpectedly with code {rc}')
        time.sleep(1)
except Exception as exc:
    log('FATAL: '+repr(exc))
    for name,p in children:
        log(f'{name} status={p.poll()}')
    for name,p in reversed(children):
        if p.poll() is None:
            try:p.terminate()
            except Exception:pass
    sys.exit(1)
