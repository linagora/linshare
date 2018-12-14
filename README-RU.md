# LinShare

## Описание

Разработанное для обеспечения надежного безбумажного обмена информацией внутри компаний, для которых совместная работа и конфеденциальность имеют первостепенное значение, LinShare представляет простое в использовании и интуитивно-понятное приложение.

* Linshare позволяет сотрудникам загружать файлы в личное пространство
* Linshare может делиться файлами с внутренними или внешними сотрудниками
* Linshare предлагает различные функций для безопасного обмена

Больше информации на http://www.linshare.ru/

## Демоверсия:

Демонстрационная версия LinShare доступна по следующей ссылке https://demo.linshare.org/.
Эта демоверсия содержит последние разработки LinShare, она
регулярно обновляется параллельно с основной версией.

Эта версия LinShare настроена для следующих тестовых пользователей от user1 до user7:
 * user1@linshare.org : password1
 * user2@linshare.org : password2
 * user3@linshare.org : password3
 * user4@linshare.org : password4
 * user5@linshare.org : password5
 * user6@linshare.org : password6
 * user7@linshare.org : password7

Если вы хотите поделиться файлами с внешними пользователями, используйте эти два адреса электронной почты: *external1@linshare.org* и *external2@linshare.org*.
Внешние пользователи - это обычный адрес электронной почты без учетной записи. Вы также можете использовать эти два адреса для создания гостей.

NB: Вы не сможете отправлять или получать электронные письма, если ваш адрес электронной почты не @linshare.org.

Для просмотра электронных писем, отправленных через LinShare, используйте электронную почту,
доступную по адресу *https: //demo-webmail.linshare.org*.

Пароли от e-mail:
 * user1@linshare.org : password1
 * ...
 * external1@linshare.org : password1
 * external2@linshare.org : password2


## Все репозитории

LinShare теперь разделен на несколько репозиториев.
Вы можете клонировать весь проект, используя следующие команды:

### Главный репозиторий:

* git clone https://github.com/linagora/linshare.git

NB: Вы можете скачать все компоненты, используя Maven:

$ mvn dependency:copy-dependencies -DoutputDirectory='linshare'

### Компоненты сервера LinShare:

* git clone https://github.com/linagora/linshare-core.git
* git clone https://github.com/linagora/linshare-ui-admin.git
* git clone https://github.com/linagora/linshare-ui-user.git
* git clone https://github.com/linagora/linshare-ui-upload-request.git
* git clone https://github.com/linagora/linshare-ui-upload-proposition.git
* git clone https://github.com/linagora/linshare-upload-proposition.git

### LinShare компоненты клиента:

* git clone https://github.com/linagora/linshare-plugin-thunderbird

### Для тестов и демонстраций:

* git clone https://github.com/linagora/linshare-docker

