# Software and Apps

# tailscale
### `curl -fsSL https://tailscale.com/install.sh | sh` doesn't work
#### Problem

this command causes error of 
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

