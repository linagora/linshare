# LinShare Virtual machines

## Description

You can try LinShare using the following virtual machine.
It is a pre-installed version of LinShare packaged as a box [(cf Vagrant)](https://www.vagrantup.com/)

## Downloads

* [LinShare 2.0.0-beta1](http://download.linshare.org/virtual-machines/linshare_v2_beta1.box)


## Documentation

This box contains a full version of LinShare binded to an embedded ldap directory for tests.


First, you have to add these lines to your /etc/hosts file :

```
127.0.0.1    linshare-user.local
127.0.0.1    linshare-admin.local
```

Then you can loggin to the [admin interface](http://linshare-admin.local:30080/#/) using
root@localhost.localdomain:adminlinshare and to the [user interface](http://linshare-user.local:30080/) using the following credentials :


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
