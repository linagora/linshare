# How to use mail attachment on LinShare

## Overview
 * [Definition](#1-definition)
 * [How to use mail attachment](#2-howTo)

### <a name="1-definition">1. Definition</a>

In previous versions of LinShare, the template of the email notification is predefined and uneditable. Since the version 2.3, LinShare allows the administrator to personalize the logo in the email notification by overriding the default one without the need to duplicate the current mail configuration. It is the only part of the mail configuration which is editable. All the rest remains in read only mode. For more advanced customisation, you must create your own mail configuration, with your own mail layout and mail contents.


### <a name="2-howTo">2. How to use mail attachment</a>

Only API are available for the mail attachment feature for now. It means there is no screens in the administration interface, you must use the command line interface, aka `linshareadmcli`, to use this feature. The CLI is available through PyPi (Python Package index) [here](https://pypi.org/project/linsharecli/).

By default `LinShare` provides a MailConfiguration object containing a layout and a set of mail contents. In this layout, you will find the default linShare logo referenced by the CID (Content ID) `logo.linshare@linshare.org`.

**Use case 1: Override the default logo:**

You can override the default logo by creating a mail attachment object into the default mail configuration as we will see in the example below.

`linshareadmcli mail_configs list`

```
+---------------------+--------------------------------------+--------------------+----------+---------+---------------------+---------------------+
| name                | uuid                                 | domain             | readonly | visible | creationDate        | modificationDate    |
+---------------------+--------------------------------------+--------------------+----------+---------+---------------------+---------------------+
| Default mail config | 946b190d-4c95-485f-bfe6-d288a2de1edd | LinShareRootDomain | False    | True    | 2020-07-24 12:40:13 | 2020-07-24 12:40:13 |
+---------------------+--------------------------------------+--------------------+----------+---------+---------------------+---------------------+
```

* We can see here, by default we have an empty list of mail attachments related the default mail configuration:

`linshareadmcli mail_attachments 946b190d-4c95-485f-bfe6-d288a2de1edd list`

```
+------+------+-----+--------+--------------+----------+-------------+
| uuid | name | cid | enable | enableForAll | language | description |
+------+------+-----+--------+--------------+----------+-------------+
+------+------+-----+--------+--------------+----------+-------------+
```

* You can find below the list of information which you need to know before starting the mail attachment's upload process

`
linshareadmcli mail_attachments 946b190d-4c95-485f-bfe6-d288a2de1edd create -h
`

Output:

```
usage: linshare-admin-cli mail_attachments mail_config create
       [-h] [--cid CID] [--name NAME] [--description DESCRIPTION]
       [--language {ENGLISH,FRENCH,RUSSIAN}] [--alt ALT] [--disable]
       [--cli-mode]
       logo

positional arguments:
  logo                  Path to the file (logo) to upload

optional arguments:
  -h, --help            show this help message and exit
  --cid CID             Content id for the mail attachment. Use the
                        'logo.linshare@linshare.org' CID to override the
                        default LinShare logo. If you are using your own CID,
                        you must create your own mail layout and reference it.
  --name NAME
  --description DESCRIPTION
  --language {ENGLISH,FRENCH,RUSSIAN}
                        By default, the new logo will be used with all
                        languages. If set, you will override only one
                        language.
  --alt ALT
  --disable             When enabled, mail attachment will be used during
                        server side mail rendering. By default, mail
                        attachments are enabled.
  --cli-mode            It will only display the created resource uuid.
```

* Create a new mail attachment related to the default  mail configuration:

`
linshareadmcli mail_attachments 946b190d-4c95-485f-bfe6-d288a2de1edd create --cid logo.linshare@linshare.org --name mailAttachment --description `test upload custom mail attachment` --language ENGLISH  <Path to logo to upload>
`

* List of mail attachments related to the default mail configuration:

```
+--------------------------------------+-------------------+----------------------------+--------+--------------+----------+------------------------------------+
| uuid                                 | name              | cid                        | enable | enableForAll | language | description                        |
+--------------------------------------+-------------------+----------------------------+--------+--------------+----------+------------------------------------+
| ca2cb026-9c08-4dd9-bb55-947e19265475 | mailAttachment    | logo.linshare@linshare.org | True   | False        | ENGLISH  | upload my custom attachment        |
+--------------------------------------+-------------------+----------------------------+--------+--------------+----------+------------------------------------+
```

In this example the language is specified (ENGLISH) so this mail attachment will be applied just for the chosen language and the field `enableForAll` will be `False`.

And when we do not specify the language the uploaded mail attachment will be applied for all languages as we will see below

`linshareadmcli mail_attachments 946b190d-4c95-485f-bfe6-d288a2de1edd create --cid logo.linshare@linshare.org --name mailAttachment --description 'upload my second custom attachment' <Path to logo to upload>`

```
+--------------------------------------+-------------------+----------------------------+--------+--------------+----------+------------------------------------+
| uuid                                 | name              | cid                        | enable | enableForAll | language | description                        |
+--------------------------------------+-------------------+----------------------------+--------+--------------+----------+------------------------------------+
| ca2cb026-9c08-4dd9-bb55-947e19265475 | mailAttachment    | logo.linshare@linshare.org | True   | False        | ENGLISH  | upload my custom attachment        |
| ee35582c-a8f4-44c4-9c50-cbcb57c0eafd | mailAttachment    | logo.linshare@linshare.org | True   | True         | -        | upload my second custom attachment |
+--------------------------------------+-------------------+----------------------------+--------+--------------+----------+------------------------------------+
```
In this example, we have to rows, one with `enableForAll` enabled and one for `ENGLISH`. It means we will apply this attachment to all languages except for `ENGLISH` because it has its own mail attachment.

* In the following screeshots we will see the overrided mail attachment:

* The mail content with the default logo:

  <img src="http://download.linshare.org/screenshots/2.3.0/mailcontent/mail.content.with.default.logo.png" alt="mail content with default logo" width="400"/>

  * The mail content with the overrided logo:

  <img src="http://download.linshare.org/screenshots/2.3.0/mailcontent/mail.content.with.overrided.logo.png" alt="mail content with overrided logo" width="400"/>

**Use case 2: Provide your own layout and your own logo:**

In this second use case the first step is to create your new mail configuration through the admin interface.

* The interface where you can create your custom mail configuration:

  <img src="http://download.linshare.org/screenshots/2.3.0/mailConf.png" alt="custom mail configuration" width="400"/>

`linshareadmcli mail_configs list`

```
+-----------------------+--------------------------------------+--------------------+----------+---------+---------------------+---------------------+
| name                  | uuid                                 | domain             | readonly | visible | creationDate        | modificationDate    |
+-----------------------+--------------------------------------+--------------------+----------+---------+---------------------+---------------------+
| Default mail config   | 946b190d-4c95-485f-bfe6-d288a2de1edd | LinShareRootDomain | False    | True    | 2020-07-24 12:40:13 | 2020-07-24 12:40:13 |
| MyCustomConfiguration | f0661920-074e-43bc-a234-3ac461c2f928 | LinShareRootDomain | False    | True    | 2020-08-26 11:02:06 | 2020-08-26 11:02:06 |
+-----------------------+--------------------------------------+--------------------+----------+---------+---------------------+---------------------+
```
The new mail configuration is created.

* An empty list of mail attachments related the new mail configuration:

`linshareadmcli mail_attachments f0661920-074e-43bc-a234-3ac461c2f928 list`

```
+------+------+-----+--------+--------------+----------+-------------+
| uuid | name | cid | enable | enableForAll | language | description |
+------+------+-----+--------+--------------+----------+-------------+
+------+------+-----+--------+--------------+----------+-------------+
```

* Then you can upload the new mail attachment related to your new mail configuration.

`linshareadmcli mail_attachments f0661920-074e-43bc-a234-3ac461c2f928 create --cid logo.linshare@linshare.org --name mailAttachment --description 'upload my custom attachment' <Path to logo to upload> `
```
+--------------------------------------+------------------+----------------------------+--------+--------------+----------+-----------------------------+
| uuid                                 | name             | cid                        | enable | enableForAll | language | description                 |
+--------------------------------------+------------------+----------------------------+--------+--------------+----------+-----------------------------+
| 323c4849-8b26-40d8-9666-b35e370564a1 |   mailAttachment | logo.linshare@linshare.org | True   | True         | -        | upload my custom attachment |
+--------------------------------------+------------------+----------------------------+--------+--------------+----------+-----------------------------+
```

* Finally you will have your new mail configuration with the new uploaded mail attachment as we will see in the screenShot.

  <img src="http://download.linshare.org/screenshots/2.3.0/mailcontent/mail.content.with.overrided.logo.png" alt="mail content with overrided logo" width="400"/>
