# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* [drive](./README.md)

## Definition

#### Preconditions
*  Given that i am a LinShare user 
*  Given that the functionality of Drives is enabled in Admin setting

#### Description

*  After logged-in successfully, I go to Shared Space 
*  I can see the list of my Drives and workgroups that are not inside any Drive.
*  When i hover any Drive, i can see the icon Member and i click on this icon, the member tab (second tab) will be opened. 
*  Or when i click on three-dot button of a Drive, if i am the admin of Drive, the option Add member will be enabled. If i am not the admin of Drive, this option will be disabled. I choose Add a member, the Member tab will be opened on the right. 
*  I can see the the Add a member section that includes fields: 
   *  Drive role: A drop-down list including options: Admin, Writer, Reader. The default selection is Reader 
   *  Default Workgroup role: A drop-down list including options: Admin, Writer, Contributor, Reader. The default selection is Reader 
   *  Add people: I can input text in this field to search Linshare user (internal users and guests) by name or email. The system will display result instantly and i can choose one user from the list. 
   *  If the selected user is already a member of Drive, there will be an error toast message. 
   *  If not, That user will be added to the Drive. Now he will be listed in section Existing member of the Drive.

#### Postconditions
*  The new member is added to the Drive  with selected role
*  He is added to all workgroups inside the Drive with the default workgroup role 
*  I can see this action on the Drive audit

[Back to Summary](#summary)

## UI Design

#### Mockups
![story9](./mockups/9.1.png)
![story9](./mockups/9.2.png)
![story9](./mockups/9.3.png)
#### Final design
![story9](./design/9.1.png)
![story9](./design/9.2.png)
![story9](./design/9.3.png)
![story9](./design/9.4.png)
![story9](./design/9.5.png)
[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
