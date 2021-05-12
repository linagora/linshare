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

Of course, we also want to have the possiblity to create standalone workgroups, with the requirement of being part of a Drive.

[Back to Summary](#summary)

## Definition

### Rules

* This feature must be available on sharedSpace. 
* The Drive will be managed as a new functionality.
* A Drive can only contain workgroups. A Drive can't contain a Drive, a Document or a Folder.
* Among a Drive, a member has two roles, one role dedicated to the Drive by itself. A second one which will be his role by default in workgroups created inside that Drive.
    - Drive roles (DRIVE_ADMIN, for example) is applied to the current Drive. <br> 
    - Default workgroups roles : Defined on the Drive and applied on the workgroups inside it as a default value. <br>
* The workgroup members inside a Drive inherit from the defaut workgroup roles and properties but they can be overridden locally.
* When an external user (from the drive) is added to a nested workgroup, he can't see the Drive name, only the workgroup name. (To be confirmed)

### Actions 

* Create a Drive :
  - Anyone can create Drives if the functionality is enabled.
  - The Drive creator is Admin by default, and has default admin role on workgroups inside the Drive.

* Add member to a Drive :
  -  To add new members to the Drive, member must have the role of __DRIVE_ADMIN__.
  -  The new member is added with a Drive role and a default Workgroups role.
  -  The new member is also added to all nested workgroups inside the Drive with the default role defined on the Drive. If he already exists in a nested workgroup, the higher role is kept in order to resolve the conflict.

* Create new Workgroups inside a Drive :
  - Members must have at least the __DRIVE WRITER__ role.
  - The __WORKGROUP ADMIN__ role is automatically assigned to the creator of the workgroup
  - All drive members are also added to the workgroup with their own default workgroup roles

* Add an external user of the Drive to workgroup :
  - Just edit the workgroup to add the user with his role.
  - You must be admin of the drive or the workgroup.

* Update the Drive informations and member of Drive :
  - All member with DRIVE_WRITER role can update a Drive.
  - We need to propagate all modifications on Drive members into the workGroups. we have two mode :
       - Soft : the changes are only applied to workgroup members if they were not upgraded locally, with a higher rrole for example.
       - Force : overrides member's role in all nested workgroups by the drive's one.

* Delete a workgroup :
   - All member with the right permissions on the workgroup
   - All member with ADMIN or WRITER role on the workgroup.

### Drive Permissions 


Drive are managed using 3 different roles. Workgroup roles are just here as reminder.

| Permissions / Role | DRIVE READER | DRIVE WRITER | DRIVE ADMIN | WORKGROUP READER | WORKGROUP CONTRIBUTOR | WORKGROUP WRITER | WORKGROUP ADMIN |
| :-------: | :-------: | :-------: | :-------: | :-------: | :-------: | :-------: | :-------: |
| See member of the Drive        |X|X|X| | | | |
| Add member to the Drive        | | |X| | | | |
| Update member on the Drive     | | |X| | | | |
| Delete Member on the Drive     | | |X| | | | |
| Update The Drive               | | |X| | | | |
| Delete the Drive               | | |X| | | | |
| - |
| Add a workgroup                | |X|X| | | | |
| Update a Workgroup             | |X|X| | | |X|
| Delete a Workgroup             | |X|X| | | |X|
| Add member to the Workgroup    | | |?| | | |X|
| Delete Member on the Workgroup | | |?| | | |X|
| Update member on the Workgroup | | |?| | | |X|
| - |
| See the documents              | | | |X|X|X|X|
| Download a document            | | | |X|X|X|X|
| Upload Document                | | | | |X|X|X|
| Delete a document              | | | | | |X|X|

[Back to Summary](#summary)

## Stories

1. [As an user, I want to view list of Drives and Workgroups in Shared Space](./story-1-user-view-list-of-drives-or-workgroups.md)
2. [As an user, I want to create a Drive](./story-2-user-create-a-drive.md)
3. [As an user, I want to view all members of a Drive](./story-3-user-see-all-members-of-a-drive.md)
4. [As an user, I want to view all Workgroups inside a drive](./story-4-user-see-all-workgroups-inside-my-drive.md)
5. [As an user, I want to delete my Drive](./story-5-user-delete-my-drive.md)
6. [As an user, I want to view Drive detail](./story-6-user-view-drive-detail.md)
7. [As an administrator, I want to enable/disable Drive functionality](./story-7-administrator-enable-or-disable-functionality.md)
8. [As an user, I want to delete Drive member](./story-8-user-delete-drive-member.md)
9. [As an user, I want to add Drive member](./story-9-user-add-member-to-drive.md)
10. [As an user, I want to delete Workgroup inside my Drive](./story-10-user-delete-workgroup-inside-Drive.md)
11. [As an user, I want to create Workgroup inside my Drive](./story-11-user-create-workgroup-inside-Drive.md)
12. [As an user, I want to delete member of a Workgroup inside Drive](./story-12-user-delete-member-of-a-workgroup.md)
13. [As an user, I want to add external member to a Workgroup inside Drive](./story-13-user-add-external-member-to-workgroup-inside-Drive.md)
14. [As an user, I want to rename Drive](./story-14-user-rename-Drive.md)
15. [As an user, I want to view Drive's activity](./story-15-user-view-Drive's-activity.md)
16. [As an user, I want to update member's role on Drive](./story-16-user-update-member-role-on-Drive.md)
17. [As an user, I want to update default Workgroup's role of Drive member](./story-17-user-update-default-workgroup-role-of-Drive-member.md)
18. [As an user, I want to be noticed when I am added to a Drive](./story-18-user-noticed-when-I-am-added-to-a-Drive.md)

[Back to Summary](#summary)

## Misc

> Link references, UI mockup, link to gitlab issye or any extra documents related to the EPIC

* [Gitlab issue]()
* [UI Mockup]()

[Back to Summary](#summary)
