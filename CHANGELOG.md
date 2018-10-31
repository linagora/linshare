<a name="1.12.7"></a>
# [1.12.7](https://github.com/linagora/linshare/compare/1.12.6...1.12.7) (2018-10-31) [Download link](http://download.linshare.org/components/linshare-core/1.12.10/)

## Upgraded components

* **core** : 1.12.10 [changelog](https://github.com/linagora/linshare-core/compare/1.12.8...1.12.10)
* **linshare-plugin-thunderbird** : 1.8.0

### Bug Fixes

* **core** Avoid successfull authentication when LDAP password policies locks an account
* **thunderbird** Add support of thunderbird 60.

<a name="1.12.6"></a>
# [1.12.6](https://github.com/linagora/linshare/compare/1.12.5...1.12.6) (2017-07-18) [Download link](http://download.linshare.org/versions/1.12.6/)

## Upgraded components

* **core** : 1.12.8

### Bug Fixes

* **user** Avoid rollback when we delete data related to a invalid email address (shared files)
* **user** Avoid rollback when we delete data related to a invalid email address (upload request)
* **user** Display document's expiration date in user-ui when possible.
* **core** Fix missing activation notification in grouped mode for the second recipient (upload request)
* **core** Fix MySQL upgrade scripts
* **core** New cleaner job: ComputeDocumentExpirationBatch.
* **core** Better logging for FineUploader: filename is included in error messages.
* **core** Better logging when user upload fails because of TSA.
* **core** Bugfix: 2 cron jobs where accidentally disabled.
* **core** Bugfix: fix possible NPE in cleaning batches.  The NPE could occurs when document already vanished.


<a name="1.12.5"></a>
# [1.12.5](https://github.com/linagora/linshare/compare/1.12.4...1.12.5) (2016-04-05) [Download link](http://download.linshare.org/versions/1.12.5/)

## Upgraded components

* **core** : 1.12.6
* **ui-upload-request** : 1.1.2

### Bug Fixes

* **user** Fix quota when copying a shared file.
* **user** Fix bug #1183 Max file size cannot be disabled in Upload request
* **user** Workaround for virus scanner lib overhead.
* **upload-request** Fix route for 404 page.


<a name="1.12.4"></a>
# [1.12.4](https://github.com/linagora/linshare/compare/1.12.3...1.12.4) (2016-12-22) [Download link](http://download.linshare.org/versions/1.12.4/)

## Upgraded components

* **core** : 1.12.4
* **ui-admin** : 2.6.1
* **ui-upload-request** : 1.1.0
* **plugin-thunderbird** : 1.7.1

### Bug Fixes

* **user** Many fixes about access rights checks (read, write) for groups, group members
  and files inside groups.
* **upload-request** Display the recipient firstname and upload request expiry Date
  on uplod request external page.
* **admin** Fix role labels in domain creation form.
* **thunderbird** Fix uploading file feature with recent Tomcat.


<a name="1.12.3"></a>
# [1.12.3](https://github.com/linagora/linshare/compare/1.12.2...1.12.3) (2016-07-20) [Download link](http://download.linshare.org/versions/1.12.3/)

## Upgraded components

* **core** : 1.12.3

### Bug Fixes

* Fix Proxy error on delegation API for documents.
* Adding new audit trace for user which are purged (fully removed) by the
  system.
* Fix 1.11 to 1.12 sql upgrade scripts.
