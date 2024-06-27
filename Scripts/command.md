# command use to put static ip

**1 - identifying the network interface** 
```
nmcli d
```

**2 - Disabling DHCP**
```bash
sudo nmcli con mod [interface_name] ipv4.method manual
```

**3 - Assigning the Static IP Address**
```bash
sudo nmcli con mod [interface_name] ipv4.addresses [your_static_ip]/[subnet_mask] ipv4.gateway [gateway_ip] ipv4.dns [dns_servers]
```

**4 - Applying the Changes**
```bash
sudo nmcli con up [interface_name]
```

**5 - Verifying the Configuration**
```bash
ip addr show [interface_name]
```
-------------------------------------------------------------------------------


# command for AlmaLinux for our project

**1 - identifying the network interface** 
```
nmcli d
```

**3 - Assigning the Static IP Address**
```bash
sudo nmcli con mod ens192 ipv4.addresses 192.168.140.68/24 ipv4.gateway 168.168.140.1 ipv4.dns 8.8.8.8
```

**4 - Applying the Changes**
```bash
sudo nmcli con up ens192
```

**5 - Verifying the Configuration**
```bash
ip addr show ens192
```

---------------------------------------------------------------------

# ssh-key



