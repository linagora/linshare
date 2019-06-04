# MongoDB UPGRADE


## Upgrade Recommendations :

To upgrade MongoDB from 3.2 to 3.6, you must be running 3.4 release, so we are obliged to upgrade to 3.4 version then we can upgrade successfully our MongoDB to 3.6 version.

#### Upgrade to MongoDB 3.4 :

We can follow this steps to upgrade our MongoDB to 3.4 version:

* stop mongo services

 `sudo service mongod stop`

* Add MongoDB 3.4 key:

`apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6`

* Add MongoDB 3.4 package source for apt-get

`echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/ mongodb-org-3.4.list`

* update Packages:

`apt-get update`

* Install MongoDb 3.4

`apt-get install -y mongodb-org`

*  start ur mongo service:

`sudo service mongod start`

The 3.4 instance must have featureCompatibilityVersion set to 3.4, so to check `featureCompatibilityVersion` run the following commands:

* `mongo`

* `db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )`

The operation should return a result that includes "featureCompatibilityVersion": "3.4".

If not we can set it or update the `featureCompatibilityVersion` by running:

* `db.adminCommand( { setFeatureCompatibilityVersion: "3.4" } )`

Here is the result what we should have: `{ "ok" : 1 }`

Then
      `exit`

#### Upgrade to MongoDB 3.6 :

* stop mongo services

 `sudo service mongod stop`

* Add MongoDB 3.6 package source for apt-get:

`echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/ mongodb-org-3.6.list`

  `apt-get upgrade`

*  start ur mongo service:

  `sudo service mongod start`

#### Helpful documentation :

  https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/
