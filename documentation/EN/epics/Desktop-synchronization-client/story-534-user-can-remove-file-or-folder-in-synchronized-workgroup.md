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

- After login successfully to LinShare desktop app, I am redirected automatically to screen: "Synchronized Workgroups"
- Or I can click on LinShare icon at the top or bottom right of screen (depending on OS) and select option "Open synchronized workgroups"
- I right-click on a workgroup and select option: "Open with file explorer", then the synchronized workgroup will be opened.

**UC1. Remove file in a synchronized workgroup**

- I can remove files in a synchronized workgroup as normally in file system of my computer: Right-click on a file and select option Delete/ Move to trash , Move files to another place, Drag file and drop to another place
- After file(s) is removed locally, the file system will notify the desktop app about this change, and it will be synchronized to the server immediately 

**UC2. Remove folder(s) in a synchronized workgroup**

- I can remove folder in a synchronized workgroup as normally in file system of my computer: Right-click on a folder and select option Delete/ Move to trash , Move folder to another place, Drag folder and drop to another place
- After folder is removed locally, the file system will notify the desktop app about this change, and it will be synchronized to the server immediately

#### Postconditions

- After the synchronization has been completed, I can see the new file/folder is removed in the corresponding workgroup on the web
- On the other side, If there is a new file/Folder is removed in the workgroup on web, it will be updated in my synchronized workgroup in my computer in 3 ways:
  - 1. Automatically: There will be a synchronization task running in background every hour. This task will update all the changes of the client in that 1 hour app to the server and vice versa.
  - 2. Manually: I can right-click on the synchronized workgroup and select option :" Synchronize Workgroup": The synchronization of this Workgroup will be trigger immediately except if there is already a synchronization task running in background (auto or manual) . I can see the status symbol when syncing is in process and completed
  - 3. When I start the app on my computer, the synchronization of all workgroups will be trigger.

[Back to Summary](#summary)

## UI Design

#### Mockups

![story533](./mockups/533.1.png)

#### Final design

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)



