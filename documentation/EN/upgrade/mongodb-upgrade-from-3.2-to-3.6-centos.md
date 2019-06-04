# MongoDB UPGRADE


## Upgrade Recommendations :

To upgrade MongoDB from 3.2 to 3.6, you must be running 3.4 release, so we are obliged to upgrade to 3.4 version then we can upgrade successfully our MongoDB to 3.6 version.

#### Upgrade to MongoDB 3.4 :

We can follow this steps to upgrade our MongoDB:

*  systemctl stop mongod

* To upgrade to 3.4 we need to have this lines in `mongodb-org.repo`:

  *  vi /etc/yum.repos.d/mongodb-org.repo

```
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
```


  * yum update : to update and download the mongod 3.4 packages

The 3.4 instance must have featureCompatibilityVersion set to 3.4, so to check `featureCompatibilityVersion` run the following commands:

  * mongo
  * db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )

  The operation should return a result that includes "featureCompatibilityVersion": "3.4".

If not we can set it or update the `featureCompatibilityVersion` by running:

  * db.adminCommand( { setFeatureCompatibilityVersion: "3.4" } )

  Here is the result what we should have: `{ "ok" : 1 }`

  Then `exit`

The next step will be the upgrade to 3.6 version.


#### Upgrade to MongoDB 3.6 :

We can follow this steps to upgrade our MongoDB to 3.6:

*  systemctl stop mongod

* In `mongodb-org.repo` we need to have:

  *  vi /etc/yum.repos.d/mongodb-org.repo
  

```
[mongodb-org-3.6]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.6/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc
```

* yum update to download mongod 3.6 packages
* Finally just restart your mongo services
  *  systemctl restart mongod

#### Helpful documentation :

  https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/
