# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* [Drive](./README.md)

## Definition

#### Preconditions

* Given that I am a LinShare user
* Given that the functionality of Drives is enabled in Admin setting

#### Description

* After logged-in successfully, I go to Shared Space
* I can see the list of my drives and workgroups that are not inside any drive.
* I click on a Drive and the the list of workgroups inside
* when I hover a workgroup that I have Admin role, I can see an icon human or click three dot button of that workgroup, I can see the option Add a member is enabled, I click on this option and Member tab of workgroup will be opened. 
*  On Member tab, I can see the list of current workgroup members and there is two types of members:
   *  Internal members are users who also are members of the parent Drive 
   *  External member is an user not a member of parent Drive
*  When I am admin of Drive, I can see the difference of this 2 kinds of members: beside internal member, there will be only one icon Edit, while with external members, there will be 2 icon Delete and Edit 
*  I  select the role and search member on "Add team member" field, the list of suggestion will be displayed.
*  I  choose one user from the list.

#### Postconditions

*  The new member will be added to the workgroup
*  On Existing members section, I can filter user by new criteria : external user or Drive member
*  I can see this action in Workgroup audit. 

[Back to Summary](#summary)

## UI Design

#### Mockups

![story13](./mockups/13.1.png)

#### Final design

![story13](./design/13.1.png)
![story13](./design/13.2.png)
![story13](./design/13.3.png)
![story13](./design/13.4.png)

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)
