# LinShare Virtual machines

## Description

You can try LinShare using the following virtual machine.
It is a pre-installed version of LinShare packaged as a box [(cf Vagrant)](https://www.vagrantup.com/)

## Downloads

* [LinShare 2.0.0-beta1](http://download.linshare.org/virtual-machines/linshare_v2_beta1.box)
* [LinShare 2.0.0-beta3](http://download.linshare.org/virtual-machines/linshare_v2_beta3.box)


## Documentation

This box contains a full version of LinShare binded to an embedded ldap directory for tests.
We suppose Vagrant and Virtualbox are installed.

First, you have to add a new box and create a new instance :

```
vagrant box add --name linshare_v2_beta3 http://download.linshare.org/virtual-machines/linshare_v2_beta3.box
mkdir -p ~/vagrants/beta3
cd ~/vagrants/beta3
vagrant init linshare_v2_beta3
```

A new file was created name 'Vagrantfile', edit it and enable/add the following line if it
not already present :

```
config.vm.network "forwarded_port", guest: 80, host: 30080
```


Then, you have to add these lines to your /etc/hosts file :

```
127.0.0.1    linshare-user.local
127.0.0.1    linshare-admin.local
```


Finally you can loggin to the [admin interface linshare-admin.local:30080 ](http://linshare-admin.local:30080/#/) using
root@localhost.localdomain:adminlinshare and to the [user interface linshare-user.local:30080 ](http://linshare-user.local:30080/) using the following credentials :


* John Doe

```
    login : user1@linshare.org
    password : password1
```

* Jane Smith

```
    login : user2@linshare.org
    password : password2
```
