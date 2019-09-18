# How to setup the link between LinShare and LDAP for workgroups synchronisation

## Overview
* [Introduction](#introduction)
* [1. Define an LDAP connection](#1-define-an-ldap-connection)
* [2. Define a workgroup pattern](#2-define-a-workgroup-pattern)
* [3. Add a workgroup provider to your domain](#3-add-a-workgroup-provider-to-your-domain)
* [4. Configure the synchronization schedule](#4-configure-the-synchronization-schedule)
* [5. More about the synchronization](#5-more-about-the-synchronization)

## Introduction

  The 2.2 LinShare version introduces the workgroups synchronization functionality. 
  The same way you manage users with an LDAP directory, you can now define groups inside your LDAP and just synchronize them with LinShare workgroups.

  Log in with a **_root account_** and go to the LinShare administration interface to start configuring your domains.

### 1. Define an LDAP connection
  Once connected, go to `Domains > LDAP connections`. To define an LDAP connection you need to provide the directory URL and your credentials to your LDAP directory. 
  > Notes
  
  > * You can also reuse the previous LDAP connection you created for getting your users.
  
  > * Don't forget to click on the "Save" button.

### 2. Define a workgroup pattern

Go to `Domains > Workgroup patterns`. Here you provide the information to bind the workgroups with the users from your LDAP directory.
*  Queries
	-  Search all workgroups query : query to retrieve all your workgroups according to a baseDn
	-  Search workgroup query : allows you define a query to search a workgroup according to a pattern `pattern`
*  Attributes
	Please provide the following fields to correctly map your LDAP directory schema with LinShare workgroups.

    | Label             | Description                                               | Mandatory |
    | ----------------- |:----------------------------------------------------------|:---------:|
    | Member email      | used to map the user mail                                 | TRUE      |
    | Member first name | Field used to retrieve the first name                     | TRUE      |
    | Member last name  | Field used to retrieve the last name                      | TRUE      |
    | Workgroup prefix  | Field providing the prefix to strip to the workgroup name | FALSE     |
    | Workgroup name    | Field to retrieve the workgroup name                      | TRUE      |
    | Workgroup member  | Field to retrieve the member identifier of a workgroup    | TRUE      |
    | Search page size  | Maximum result per page in search                         | TRUE      |

    *  Example :
	    * For this entry in an LDAP directory...

		USER 1
		```
		dn: uid=test1,ou=People,dc=linshare,dc=org
		uid: test1
		objectClass: inetOrgPerson
		objectClass: organizationalPerson
		objectClass: person
		objectClass: top
		sn: Test1
		cn: Test, Test1
		userPassword: password1
		mail: test1@linshare.org
		```

		USER 2 : 
		```
		dn: uid=test2,ou=People,dc=linshare,dc=org
		uid: test2
		objectClass: inetOrgPerson
		objectClass: organizationalPerson
		objectClass: person
		objectClass: top
		sn: Test2
		cn: Test, Test2
		userPassword: password2
		mail: test2@linshare.org
		```
		
		WORKGROUP wg-1 with USER 1 and USER 2 as READER users : 
		```
		dn: cn=workgroup-wg-1,ou=Groups,dc=linshare,dc=org
		cn: workgroup-wg-1
		objectClass: posixGroup
		member: uid=user1,ou=People,dc=linshare,dc=org
		member: uid=user2,ou=People,dc=linshare,dc=org
		```
		*  ... we have the following mapping :
		
		
        | Label                | Mapped value |
        | -------------------- |:-------------|
        | Member email         | mail         | 
        | Member first name    | givenName    |
        | Member last name     | sn           |
        | Workgroup prefix     | workgroup-   |
        | Workgroup name       | cn           |
        | Workgroup member     | member       |
        | Search page size     | 100          |
		
    #### Role access management
    You can define roles inside your LDAP directory and have them directly mapped inside LinShare workgroups.
    For example, to add users to a LinShare workgroup with one of the LinShare role, you can declare them in your LDAP directory as follows :


	WORKGROUP wg-1 with USER 1 and USER 2 as users with role {role}: 
	```
	dn: cn={role},cn=workgroup-wg-1,ou=Groups,dc=linshare,dc=org
	cn: {role}
	objectClass: posixGroup
	member: uid=user1,ou=People,dc=linshare,dc=org
	member: uid=user2,ou=People,dc=linshare,dc=org
	```
    	
	There are 2 possible values for this {role} parameter :

     * writers
     * contributors
    
    If no role is provided, the user has the READER role by default.

### 3. Add a workgroup provider to your domain

Once you have configured an LDAP connection and a workgroup pattern, go to the domain from which you want to provide your workgroups.

Select an LDAP connection and then a pattern. 
Provide the `Base dn` of your LDAP directory where you have your groups defined. 

By enabling the option `Search in other domains`, you specify that you want to seek users who are members of the remote LDAP groups in others domains than your own domain, according to the domain policies. These policies are defined in the interface `Domains > Inter-domains communication rules`


### 4. Configure the synchronization schedule 

By default the task synchronizing the LDAP groups with LinShare work groups is launched every 4 hours.
You can edit this value in the following part of your file `linshare.properties` according to the syntax for CRON( the syntax caption can be found in this file).
```
# Batches are launched every 4 hours
# This cron is responsible of :
#   - synchronizing LdapGroups with Workgroups
job.ldapgroups.cron.expression=0 0 0/4 * * ?
```
### 5. More about the synchronization

>  **WARNING  :  The state of your LDAP directory overrides the state of synchronized LinShare work groups.**

 - Each time the synchronization is executed, the users not found
   remotely will be removed from the work groups.  
   
 - If a group is removed in the LDAP directory, all the members of the related LinShare work group will be removed from it. The work group is not automatically deleted to prevent any loss of documents uploaded inside it.