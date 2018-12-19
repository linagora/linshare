# Виртуальные машины LinShare

## Описание

Вы можете попробовать демоверсию LinShare, используя следующую виртуальную машину.
Это пре-установленная версия LinShare [(cf Vagrant)](https://www.vagrantup.com/)

## Для скачивания

* [LinShare 2.0.0-beta1](http://download.linshare.org/virtual-machines/linshare_v2_beta1.box)
* [LinShare 2.0.0-beta3](http://download.linshare.org/virtual-machines/linshare_v2_beta3.box)
* [LinShare 2.0.1](http://download.linshare.org/virtual-machines/linshare_v2.0.1.box)


## Документация

Этот пакет содержит полную версию LinShare, объединенную с встроенной ldap directory для тестов.
Мы полагаем, что Vagrant и Virtualbox уже установлены.

В первую очередь, вы должны добавить новый контейнер и создать новый экземпляр:

```
vagrant box add --name linshare_v2_beta3 http://download.linshare.org/virtual-machines/linshare_v2_beta3.box
mkdir -p ~/vagrants/beta3
cd ~/vagrants/beta3
vagrant init linshare_v2_beta3
```

Новый файл был создан с именем 'Vagrantfile'. Отредактируйте его и включите/добавьте следующую строку, если она отсутствует:

```
config.vm.network "forwarded_port", guest: 80, host: 30080
```


Далее вы должны добавить эти строки в ваш /etc/hosts file:

```
127.0.0.1    linshare-user.local
127.0.0.1    linshare-admin.local
```


Теперь вы можете войти в [admin interface linshare-admin.local:30080 ](http://linshare-admin.local:30080/#/), используя
root@localhost.localdomain:adminlinshare и в [user interface linshare-user.local:30080 ](http://linshare-user.local:30080/), используя следующие данные:


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
