# Installation Guide

To set up the nginx and alpine docker compose project, follow these steps:

**Prerequisites**
- You must have a computer :)
- The computer mush have Windows or Linux
- Make sure you have the following software installed on your machine:
```
Docker
Docker Engine
```
Check this [link](https://docs.docker.com/engine/install/) for more info

## Steps
1. Download the file using git

`git clone https://github.com/JohnTa15/Load-Balancing-5-replicas-with-nginx/`

2. Run `chmod +x install.sh` to install the containers
3. Run install.sh

`./install.sh` *(use sudo in case of permission denied error message)*

4. Open a browser
5. Finally, type `localhost:8080`
6. Enjoy! 😄

## Uninstalling.. 
- To uninstall those containers you have to `chmod +x uninstall.sh`
- Then execute `./uninstall.sh`
### If something fails
**Make sure you don't use port 8080. In case you use it change the port to make the program work!**
