# Software and Apps

# tailscale
### `curl -fsSL https://tailscale.com/install.sh | sh`
#### Problem

this command doesn't work and cause error of 
```
Err:2 https://pkgs.tailscale.com/stable/ubuntu kinetic InRelease                                                                             
  Could not handshake: Error in the pull function. [IP: 167.172.11.40 443]
```

#### Reason 

apt-get update will use the proxy settings in `/etc/apt/apt.conf.d`, rather than the proxy setting in bash-env

#### Solution

add following codes to `/etc/apt/apt.conf.d/05proxy`
```
Acquire::http::proxy "http://127.0.0.1:7890/";
Acquire::https::proxy "http://127.0.0.1:7890/";
Acquire::ftp::proxy "http://127.0.0.1:7890/";
```
### No machine found in admin console
#### Problem
after install the tailscale, there is no machine avaliable in admin console
#### Reason
tailscale doesn't assumpt that the user is using the VPN, so the proxy isn't correct for tailscale when the VPN running backend
#### Solution
1. use `sudo bash` to open a bash terminal, set proxy and run `tailscaled` in backend, then use `sudo tailscale up` to create connection. (You may need to approve the machine in admin console when new machine is added)
2. add `tailscaled` to a systemd service and do the same thing as 1
