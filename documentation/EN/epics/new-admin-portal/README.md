# Summary

* [Context](#context)
* [Definition](#definition)
* [Stories](#stories)
* [Misc](#misc)

## Context

We want to build a new webapp for administrators to replace the current linshare-ui-admin app.
The goal of this task is get rid of the old application because it is using outdated frameworks.

All the current screens managing LinShare functionnalities must be developed in this new app but the whole design and the user experience.


[Back to Summary](#summary)

## Definition

### Audience

This new SPA is designed to admininistrate LinShare. For now it is mainly about the configuration of the product itself but this application provides also some pages to view the activity of all users in the platform. Later we will also provide some other pages display some reporting figures and charts.

Currently, we have only two profiles which are allowed to access to admin portal:

* Profile SUPERADMIN: The only user with this profile is root@localhost.localdomain, provided by default by the app. This user is allowed to read, modify and delete resources except files stored in personal spaces or shared spaces (workgroups). The main purpose of this user is to configure the link between LinShare and your LDAP directory. Then you should use user with ADMIN profiles to administrate the platform

* Profile ADMIN: Every user in LinShare can be promoted to ADMIN, they are still able to use the current user portal but they are also allowed to log in into the admin portal.

In the future, we will introduce some new profiles like REPORTING, or AUDIT, to be able to access to the admin portal but with less permissions.


### Roles and permissions

At first we need to define which categories will be available per each profile:


|Pages / Profiles                    | SUPERADMIN | ADMIN |
|------------------------------------|------|-------|
| Home page                          |  X   |   X   |
|  |  |  |
| Configuration > Domains            |  X   |       |
| Configuration > Parameters         |  X   |   X   |
| Configuration > Email Templates    |  X   |   X   |
| Configuration > Welcome Messages   |  X   |   X   |
| Configuration > Type Mime Policies |  X   |   X   |
| Configuration > Domain Policies    |  X   |       |
| Configuration > Providers          |  X   |       |
| Configuration > Quota Management   |  X   |   ?   |
| Configuration > Public keys        |  X   |   X   |
|  |  |  |
| Administration > Users             |  X   |   X   |
| Administration > Drives/Workgroups |  X   |   X   |
| Administration > Contact Lists     |  X   |   X   |
| Administration > Inconsistent Users|  X   |       |
| Administration > Loggers ?         |  X   |   X   |
|  |  |  |
| Reporting > Basic statistics       |  X   |   X   |
| Reporting > Advanced statistics    |  X   |   X   |
| Reporting > Error statistics       |  X   |   ?   |
| Reporting > Activities             |  X   |   X   |
| Reporting > Upgrades               |  X   |   ?   |

In order to grant access to these pages (display the menu links) into the new admin interface, we need to implement a basic permission management in the frontend app itself. Of course, the backend won't rely on this because it already have fine access control checks.
These permissions will be used to dynamically build the admin interface at the authentication step according to the user's profile.


[Back to Summary](#summary)
## Stories

> A list of all the story documentation in the epic, must format as a list of links to corresponding user story files inside epic folder

1. [As a user, i can do something](./link-to-the-file.md)

[Back to Summary](#summary)

## Misc

> Link references, UI mockup, link to gitlab issye or any extra documents related to the EPIC

* [Gitlab issue]()
* [UI Mockup]()

[Back to Summary](#summary)
