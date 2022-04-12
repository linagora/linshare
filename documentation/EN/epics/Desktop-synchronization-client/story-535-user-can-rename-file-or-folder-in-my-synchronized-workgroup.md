# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [Desktop synchronization client](./README.md)

## Definition

#### Preconditions

- Given that I have installed LinShare desktop app in my computer
- Given that I had LinShare account and have synchronized workgroups on my computer

#### Description

- After login successfully to LinShare desktop app, I am redirected automatically to screen: "Synchronized Workgoups"
- Or I can click on LinShare icon at the top or bottom right of screen (depending on OS) and select option "Open synchronized workgroups"
- I right-click on a workgroup and select option: "Open with file explorer", then the synchronized workgroup will be opened.

**UC1. Rename a file in a synchronized workgroup**

- I can rename files in a synchronized workgroup as normally in file system of my computer: Right-click on a file and select option Rename 
- There will be a dialog that displaying current file name and I can edit this name then click button Save
- If the new name is valid, it will be changed successfully. If the name is invalid (contains special character, already existed name...), there will be corresponding error message. 
- After file(s) is renamed locally, the file system will notify the desktop app about this change, and it will be synchronized to the server immediately
- When a new file is renamed on local and it has same name with a file on web, there will be a notification for user that it will become the latest version of that file

**UC2. Rename a folder in a synchronized workgroup**

- I can rename folder in a synchronized workgroup as normally in file system of my computer:  Right-click on a file and select option Rename
- - There will be a dialog that displaying current file name and I can edit this name then click button Save
- If the new name is valid, it will be changed successfully. If the name is invalid (contains special character, already existed name...), there will be corresponding error message.
- After folder is renamed locally, the file system will notify the desktop app about this change, and it will be synchronized to the server immediately
- When a folder is renamed on local and it has same name with a folder on web, there will be a notification for user that it will have a number added to its name. 

#### Postconditions

- After the synchronization has been completed, I can see the new file/folder is renamed in the corresponding workgroup on the web
- On the other side, If a file/Folder is renamed in the workgroup on web, it will be updated in my synchronized workgroup in my computer in 3 ways:
   - 1. Automatically: There will be a synchronization task running in background every hour. This task will update all the changes of the client in that 1 hour app to the server.
   - 2. Manually: I can right-click on the synchronized workgroup and select option :" Synchronize Workgroup": The synchronization of this Workgroup will be trigger immediately except if there is already a synchronization task running in background (auto or manual) . I can see the status symbol when syncing is in process and completed
   - 3. When I start the app on my computer, the synchronization of all workgroups will be trigger.

[Back to Summary](#summary)

## UI Design

#### Mockups


#### Final design

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)



