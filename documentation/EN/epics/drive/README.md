# Summary

* [Context](#context)
* [Definition](#definition)
* [Stories](#stories)
* [Misc](#misc)

## Context
In LinShare we have workgroups in shared spaces. These workgroups are designed to let a team works together on one topic.
If you have multiple topics in a team, you have to create one workgroup per topic, each time you will also need to add team members as part of this workgroups.
So the membership of a workgroup can differ for each workgroups.


The main goals of Drive are :

* to group some workgroups together, like workgroups were belonging to the same team or project.
* to avoid workgroup membership redefintion each time you are creating a new workgroup.

Of course, we also want to keep to pisiblity to create standalone workgroups, with the requirement to be part of a Drive.

[Back to Summary](#summary)

## Definition

### Rules

* This feature must be available on sharedSpace. 
* The Drive will be managed as a new functionality.
* A Drive can only contain workgroups. A Drive can't contain a Drive, a Document or a Folder.
* Among a Drive a member have two roles, one role dedicated to the Drive by itself. A second one wich will be his role by default in workgroups created inside a Drive.
    - Drive roles (DRIVE_ADMIN, for example) is applied to the current Drive. <br> 
    - Default workgroups roles : Defined on the Drive and applied on the workgroups inside it as a default value. <br>
* The workgroups inside the Drive inherite the Drive roles and properties but they can be overriden locally.
* When an external user (from the drive) is added to a nested workgroup, he can't see the Drive name, only the workgroup name. (To be confirmed)

### Actions 

* Create a Drive :
  - Anyone can create Drives if the functionality is enabled.
  - The Drive creator is Admin by default, and has default admin role on workgroups inside the Drive.

* Add member to a Drive :
  -  To add member to the Drive we need to have __DRIVE_ADMINISTRATOR__ permission.
  -  The new member is added with a Drive role and a default Workgroups role.
  -  The new member is also added to all nested workgroups inside the Drive with the default role defined on the Drive. If he already exists in a nested workgroup, the higher role is kept in order to resolve the conflict.

* Create Workgroups into a Drive :
  - We must have the DRIVE_WRITER role to create workgroups.
  - The WORKGROUP_ADMIN role is attributed to the creator of the workgroup
  - All drive members are also added to the workgroup with their own default workgroup role

* Add an external user of the Drive to workgroup :
  - Just edit the workgroup to add the user with his role.
  - You must be admin of the drive or the workgroup.

* Update the Drive informations and member of Drive :
  - All member with DRIVE_WRITER role can update a Drive.
  - We need to propagate all modifications on Drive members into the workGroups. we have two mode :
       - Soft : the changes are only applied to workgroup members if they were not upgraded locally, with a higher rrole for example.
       - Force : it overrides all workgroups preferencies by the drives one.

* Delete a workgroup :
   - All member with the right permissions on the workgroup
   - All member with ADMIN or WRITER role on the workgroup.

### Drive Permissions 

TODO: use markdown format
![permission](./resources/permission.png)


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
