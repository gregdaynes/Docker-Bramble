# Docker Bramble

download raspberry pi docker image from
[Hypriot](http://blog.hypriot.com/downloads)

download latest docker-machine with hypriot driver
[Docker-Machine](http://downloads.hypriot.com/docker-machine_darwin-amd64_0.4.1)

definitions
pi = prefix for tower nodes
4  = number of nodes to use

Run init script to flash image to SD cards for Raspberry Pi
insert each SD card as needed

```bash
sh init.sh pi 4
```

Insert flashed SD cards into pis and power on.
Make sure network cables are connected as well.

Ping one of the pis in the cluster using

```bash
ping -c1 pi1.local
```

If it is successfully, cluster is ready for the next steps


Run ssh-key script to write pub key to each pi

```bash
sh ssh-key.sh pi 4 ~/.ssh/id_rsa.pub
```

each pi will need you to confirm writing key, as well as the root password
which is "hypriot"


Run start script to create the docker swarm
pi1.local will be swarm master

```bash
sh start.sh pi 4
```

connect to docker swarm

```bash
eval $(./docker-machine env --swarm pi1.local);
```

test if everything is good

```bash
docker info
```

---

To destroy contents of each pi

```bash
sh purge.sh pi 4
```

---

Shudown each pi

```bash
sh shutdown.sh pi 4
```
