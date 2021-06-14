# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* [drive](./README.md)

## Definition

#### Preconditions
*  Given that i am a Linshare user 
*  Given that the functionality of Drives is enabled in Admin setting
#### Description
*  After logged-in successfully, i go to Shared Space 
*  I can see the list of my drives and workgroups that are not inside any drives 
*  When i  click button "+" on top left of screen, there will be 2 options: Create a drive / Create a workgroup
*  When i hover the option Create Workgroup, there will be a helper message:"A workgroup is a collaborating space that that can be managed by internal users or guests. A workgroup can be inside a drive (as nested) or standalone. Only Workgroups contains files or folders."
*  When i hover the option Create Drive, there will be a helper message:" A Drive contains only Workgroups, a Drive will allow you to define a list of default members for all nested Workgroups." 
*  I choose create a Drive 
*  A popup will be displayed with a default drive name 
*  I can edit the name or not then click button Create  
#### Postconditions
*  If The Drive is created successfully, the system will display a successful notification message. If there is any error (invalid name, permission, network...), system will display an error message.
*  My role to the new created drive is Admin and my default role on the workgroups inside the drive is admin 
*  I can see this action on the Drive audit.

[Back to Summary](#summary)

## UI Design

#### Mockups
![view list of drives workgroups](./mockups/Create drive 1.png)
![view list of drives workgroups](./mockups/Create drive 2.png)

#### Final design
![story2.1](./design/story2.1.png)
![story2.2](./design/story2.2.png)
[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
