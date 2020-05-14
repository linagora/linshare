# MongoDB UPGRADE


## Upgrade Recommendations :

To upgrade MongoDB from 3.6 to 4.2 , you must be running 4.0 release, so we are obliged to upgrade to 4.0 version then we can upgrade successfully our MongoDB to 4.2 version.

#### Upgrade to MongoDB 4.0 :

We can follow this steps to upgrade our MongoDB to 4.0 version:

* `systemctl stop mongod`

* To upgrade to 4.0 we need to have this lines in `mongodb-org.repo`:

* `vi /etc/yum.repos.d/mongodb-org.repo`

```
[mongodb-org-4.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc
```

* `yum update` : to update and download the mongod 4.0 packages

The 4.0 instance must have featureCompatibilityVersion set to 4.0, so to check `featureCompatibilityVersion` run the following commands:

* `mongo`
* `db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )`

The operation should return a result that includes "featureCompatibilityVersion": "4.0".

If not we can set it or update the `featureCompatibilityVersion` by running:

* `db.adminCommand( { setFeatureCompatibilityVersion: "4.0" } )`

Here is the result what we should have: `{ "ok" : 1 }`

Then `exit`

The next step will be the upgrade to 4.2 version.

#### Upgrade to MongoDB 4.2 :

We can follow this steps to upgrade our MongoDB to 4.2:

* `systemctl stop mongod`

* In `mongodb-org.repo` we need to have:

  * `vi /etc/yum.repos.d/mongodb-org.repo`

```
[MongoDB]
name=MongoDB Repository
baseurl=http://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc
```

* `yum update` to download mongod 4.2 packages

* `systemctl restart mongod`

* At this point, you can run the 4.2 binaries without the 4.2 features that are incompatible with 4.0, to enable these 4.2 features you should run:

`db.adminCommand( { setFeatureCompatibilityVersion: "4.2" } )`

#### Helpful documentation :

  https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/
