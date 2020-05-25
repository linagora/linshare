# MongoDB UPGRADE


## Upgrade Recommendations :

To upgrade MongoDB from 3.6 to 4.2 , you must be running 4.0 release, so we are obliged to upgrade to 4.0 version then we can upgrade successfully our MongoDB to 4.2 version.

#### Upgrade to MongoDB 4.0 :

We can follow this steps to upgrade our MongoDB to 4.0 version:

* stop mongo services

 `sudo service mongod stop`

* Import MongoDB 4.0 key:

`wget -qO - https://www.mongodb.org/static/pgp/server-4.0.asc | sudo apt-key add -`

* Create a `/etc/apt/sources.list.d/mongodb-org-4.0.list` file for MongoDB 4.0 and add the package source for apt-get

`echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.listt`

* update Packages:

`apt-get update`

* Install MongoDb 4.0

`apt-get install -y mongodb-org`

*  start your mongo service:

`sudo service mongod start`

The 4.0 instance must have featureCompatibilityVersion set to 4.0, so to check `featureCompatibilityVersion` run the following commands:

* `mongo`

* `db.adminCommand( { getParameter: 1, featureCompatibilityVersion: 1 } )`

The operation should return a result that includes "featureCompatibilityVersion": "4.0".

If not we can set it or update the `featureCompatibilityVersion` by running:

* `db.adminCommand( { setFeatureCompatibilityVersion: "4.0" } )`

Here is the result what we should have: `{ "ok" : 1 }`

Then
      `exit`

#### Upgrade to MongoDB 4.2 :

* stop mongo services

 `sudo service mongod stop`

 * Import MongoDB 4.2 key:

 `wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -`

* Create a `/etc/apt/sources.list.d/mongodb-org-4.2.list` file for MongoDB 4.2 and add the package source for apt-get:

`echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list`

* update Packages:

`apt-get update`

* Install MongoDb 4.2:

`apt-get install -y mongodb-org`

*  start your mongo service:

  `sudo service mongod start`

* At this point, you can run the 4.2 binaries without the 4.2 features that are incompatible with 4.0, to enable these 4.2 features you should run:

`db.adminCommand( { setFeatureCompatibilityVersion: "4.2" } )`

#### Helpful documentation :

You can follow this link for more [informations](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/)
