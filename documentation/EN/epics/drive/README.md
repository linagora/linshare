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
* The Drive will be managed as nested workgroups functionality.
* A Drive can only contain workgroups. A Drive can't contain a Drive, a Document or a Folder.
* Add preferences to manage the Drive. 
* List all permissions related to Drive.
* List all roles related to Drive.

> Note : <br>
   We need to have two kind of roles on Drive: <br>
    - Drive roles (DRIVE_ADMIN for example) is applied to the current Drive. <br> 
    - Default workgroups roles : Defined on the Drive and applied on the workgroups inside it. <br>

* The workgroups inside the Drive inherite the Drive roles and properties.
* When an external user (from the drive) is added to a workgroup, he can't/shouldn't see the Drive name

### Actions 

* Create a Drive :
  - Anyone can create Drives if the functionality is enabled.
  - The Drive creator is Admin by default, and has default admin role on workgroups inside the Drive.

* Add member to the Drive :
  -  To add member to the Drive we need to have __DRIVE_ADMINISTRATOR__ permission.
  -  The new member is added with a Drive role and a default Workgroups role.
  -  The new member is added also to all workgroups inside the Drive with the default role defined on the Drive.

* Add Workgroups to the Drive :
  -  We need to have a specificate role to add a workgroups.
  -  The ADMIN role is attributed to the creator of workgroups and the members who had this role defined on the Drive.

* We can add an external member of the Drive to the workgroups :

  
* Update the Drive informations and member of Drive :
  - All member with the Right permissions  can update a Drive.
  - We need to propagate all modifications on Drive members into the workGroups. we have two mode :
       - Force : it overrides all workgroups preferencies by the drives one.
       - Soft : the changes is only applied if the members of workgroups is not overridden before.

* Delete a workgroup :
   - All member with the right permissions on the workgroup
   - All member with ADMIN or WRITER role on the workgroup.

### Drive Permissions 

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
