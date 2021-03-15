# Summary

* [Context](#context)
* [Definition](#definition)
* [Stories](#stories)
* [Misc](#misc)

## Context
In LinShare we have workgroups in shared spaces. These groups are design to make a team works together on one topic.
If you have multiple topics in a team, you have to create one workgroup per team. This allows you to add different external people for each workgroup.

The main goal of Drive are :

* regroup all worgkoups of a team in one item
* define default team members in the Drive to avoid workgroup members redefinition 
* Manage globally team members rigths (right should be applied from drive to its workgroups
* a workgroup can be in a drive or be standalone

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


# POST meeting :


## Rules :

* [Rule] When an user creates a workgroup inside a Drive (obviously he must have the right), he should be added to it as a member with the role WORKGROUP_ADMIN.

   So his default workgroup role set up in the Drive is ignored. We should be able to ignore this behaviour and just give him his default role according to a preference (store in the Drive ? per Drive or per person ?)

* [Rule] When we are updating user's default role in a Drive, we must detect if, for this particular user, his role was updated (overridden) in any workgroups inside the Drive.

     [Tech] Maybe it could be handled by a Dry-Run.


* [Rule] When we are about to add an user to a Drive, we should be able to list all workgroups in this drive and to "exclude" the current user to be added in. This imply we must be able to remove a user in a workgroup which is still present in the Drive.

* [Rule] How can we detect Drive members which there are no more part of each workgroups ?

* [Rule] When we update a Drive member (says workgroup role), the update is spread to all workgroups of the Drive where he is still part of it. If he was previously removed from a workgroup, he is not added or updated.

## Documentation : 

* We need to explain : adding a local/external member in a workgroup contained in a Drive is possible. __[Documentation]__

* Drive name is bad, unclear and fuzzy. We need to define a new name. __TBD__ UX decision.

* We have to explain/detail the drive role versus the workgroup role.
 __[documentation]__ we need to be explicit compared to internal/external of LinShare.


## Question 

* [Question] As a Drive Admin, how can see / detect / count external users of my drive ?

* [Question] How do we know if a workgroup is created inside a Drive or not ? And in which Drive ? (it is related to Audit traces)

* For one user in a Drive, how to detect in which workgroup he is not part anymore ? there is maybe a conflict if the current user is admin of the Drive but not part of a workgroup. Do we need to return all workgroups the user is currently member or all workgroups in the current Drive regardless his role/right/membership. ?

* Is it possible to create a Drive in a Drive, without spreading any hierarchical rules, just for the layout/structure ?



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
