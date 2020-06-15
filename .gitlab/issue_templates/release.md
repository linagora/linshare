/title RELEASE LinShare {VERSION} 
* Build and Perform Mvn release of each component

 * [ ] core {VERSION}
 * [ ] ui-user {VERSION}
 * [ ] ui-admin {VERSION}
 * [ ] thunderbird {VERSION}

* Update all new versions in components Dockerfiles
  * [ ] [linshare-ui-user-dockerfile](https://ci.linagora.com/linagora/lgs/linshare/saas/linshare-ui-user-dockerfile)
  * [ ] [linshare-ui-admin-dockerfile](https://ci.linagora.com/linagora/lgs/linshare/saas/linshare-ui-admin-dockerfile)
  * [ ] [linshare-backend-dockerfile](https://ci.linagora.com/linagora/lgs/linshare/saas/linshare-backend-dockerfile)
  * [ ] [linshare-database](https://ci.linagora.com/linagora/lgs/linshare/saas/linshare-database-dockerfile)
  * [ ] [linshare-backend-documentation](https://ci.linagora.com/linagora/lgs/linshare/saas/linshare-backend-documentation-webservice-dockerfile)
  * [ ] [linshare-init](https://ci.linagora.com/linagora/lgs/linshare/saas/linshare-init-dockerfile)

* Update linshare-github pom.xml

* Update the project CHANGELOG
    * [ ] Backend changeLog  
    * [ ] User changeLog 
    * [ ] Admin ChangeLog

* [ ] Build and Perform Mvn release of release-linshare-suite

* [ ] Update Linshare.org Download link to the new version. 
    * [ ] Update link to last version
    * [ ] Create a new `ticket GLPI` for (support team) to update the new changes.

* [ ] Update docker-compose files:
    * [ ] [linshare-docker](https://ci.linagora.com/linagora/lgs/linshare/saas/linshare-docker) 
    * [ ] [docker-compose.yml](https://ci.linagora.com/linagora/lgs/linshare/saas/linshare-docker-dev)

* [ ] Tweet the release with the new features. (With LinShare tweeter account)