## Forward Internet connection over ssh to remote computer

```
source: https://askubuntu.com/questions/609922/forward-internet-connection-over-ssh-to-remote-computer
```
* *give_internet.sh* - small script that set up your local PC as a NAT-router.
* *take_internet.sh* - small script that set up your server's default gateway

### usage:
1) run ***give_internet.sh*** on local PC that has access to Internet
2) run **take_internet.sh** on remote server

> tested on ubuntu 18.04 20.04