# docker-k8s-setup
### Here are instructions on how to Setup Docker on windows machine without using Docker Desktop
https://dev.to/bowmanjd/install-docker-on-windows-wsl-without-docker-desktop-34m9
1. Enable wsl in Turn Windows Features On/Off
2. Download ubuntu as Linux distributor: <br>
`wsl --set-default-version 2` <br>
`wsl --install -d Ubuntu` <br>
Check installation with:
`wsl -l -v`
3. Open Ubuntu as Windows application
4. Update packages and test network connectivity: <br>
`sudo apt update && sudo apt upgrade`
5. Install Docker (until [Upgrade Docker Engine](https://docs.docker.com/engine/install/ubuntu/#upgrade-docker-engine))<br>
https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
6. Start dockerd in TCP <br>
`sudo mkdir -p /etc/systemd/system/docker.service.d/`<br>
create tcp.conf and add -H argument<br>
`sudo vi /etc/systemd/system/docker.service.d/tcp.conf`<br>
add/update lines:
```
[Service]
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375 --containerd='/run/containerd/containerd.sock'
```
Restart docker daemon
```
sudo systemctl daemon-reload
sudo systemctl restart docker
```
8. Post-installation steps:
https://docs.docker.com/engine/install/linux-postinstall/
9. Download Docker on Windows: <br>
https://download.docker.com/win/static/stable/x86_64/
10. Set DOCKER_HOST in Windows
To enable communication to docker (on WSL) from Windows:
- run docker container on ubuntu. This command creates a container that exposes docker daemon to tcp 23750 port
```
docker run -d --restart=always -p 127.0.0.1:23750:2375 -v /var/run/docker.sock:/var/run/docker.sock  alpine/socat  tcp-listen:2375,fork,reuseaddr unix-connect:/var/run/docker.sock
```
- add environment variable for Windows:
```
DOCKER_HOST = "tcp://localhost:23750" 
```


