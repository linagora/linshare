  

# LinShare User Manual

> Note :<br/>
  This user guide is only for 2.x LinShare versions.

## Summary

* [1. Home](#1-home)
* [2. My space](#2-my-space)
  * [My files](#my-files)
  * [Received shares](#received-shares)
  * [Activity logs](#activity-logs)
* [3. Current uploads](#3-current-uploads)
* [4. Shared space](#4-shared-space)
* [5. Contact lists](#5-contact-lists)
* [6. Guests](#6-guests)
* [7. Activity logs](#7-activity-logs)  

### Language

You can choose your language on the login page of LinShare. The language list is available at the upper right corner. Note that it won't be possible to do it once you are logged in.  

### 1. Home

This home page is a welcome page, filled with three links according to enabled functionalities and your own rights :

- *HOST YOUR FILES* : which redirects you to your [own space](#2-my-space).

- *UPLOAD & SHARE* : which redirects you to your [current uploads](#3-current-uploads).

- *UPLOAD TO A GROUP* : which redirects you to your [shared space](#4-shared-spaces).

  

### 2. My space

**My space** consists in 2 sides: your own files and the ones shared with you.
  * <a  name=my-files>**_My files_**</a>

    **My files** gather all the files you uploaded on _your space_. Each shared file (which is not past the expiration date) is labeled "_shared_".</br>

    To upload a new file, you have 2 choices:
    - Click on the **+** button on the upper left side.
    - Drag and drop your file from your file browser to your own space (you can then see the center circle become blue).  

    When a uploaded file is hoovered, 3 icons appear on the right side. From left, those icons mean:
    - Display file's infos.
    - Share the file with other users (internal or external, refer to <a  name="share">Share</a>).
    - Download the file.


  * <a  name=received-shares>**_Received shares_**</a>

    In this section, you can see all the files shared to you.
    Most of the section **My files** functionalities are the same in here.

  * <a  name=activity-logs>**_Activity logs_**</a>

    Within all sections containing files, the activity logs is available in the right sidebar (by clicking on the ![User logo](../../img/adduser.png) icon).
    This activity logs gather all actions done on the files.

### 3. Current uploads

All current uploads are listed in this section. It gathers the current uploads from [My space](#2-my-space) and [Shared space](#4-shared-spaces).

To exclusively visualize the uploads on My space, or Shared space, you need to click on the corresponding tab on the upper right side.

Some actions are available in the upper right corner, near the _My space_ and _Shared space_ tabs. Those actions are the following:
- Pause the selected upload.

- Resume the upload.

- Cancel the upload.

- Clean up the upload history.

### 4. Shared spaces

> The **Shared spaces** gather the workgroups. Those are sharing areas in which other internal users or guests (refer to [Guests](#guests)) can see or even upload files.

Each group member can see all files within this sharing area.

- _**Roles**_

    The 2.2 LinShare release version introduced a new role access management in workgroups. Refer to the tables below to see the link between permissions and roles.

    - **Before 2.2.x...**


        | Role    | View/Download workgroup files/folders  | Upload, Rename files/folders| Delete files/folders          | View members and roles      | Update member role | Remove workgroup member| Update/Delete workgroup |
        | :-------: |:--------------------------------------| :--------------------------|:-----------------------------| :--------------------------|:------------------| :---------------------| :---------------------|
        | READER  | <ul><li> - [x] </li></ul>              | `X`                         |           `X`                 |  <ul><li> - [x] </li></ul>  |      `X`           |        `X`             | `X` |
        | WRITER  | <ul><li> - [x] </li></ul>              | <ul><li> - [x] </li></ul>   |           `X`                 |  <ul><li> - [x] </li></ul>  |      `X`           |        `X`             |`X`  |
        | ADMIN   | <ul><li> - [x] </li></ul>              | <ul><li> - [x] </li></ul>   |   <ul><li> - [x] </li></ul>   |  <ul><li> - [x] </li></ul>  | <ul><li> - [x] </li></ul>  | <ul><li> - [x] </li></ul>  | <ul><li> - [x] </li></ul>  |


    - **What's new in 2.2.x ?**

        Workgroups are managed with 4 different roles:
      
        | Role         | View/Download workgroup files/folders  | Upload, Rename files/folders| Delete files/folders          | View members and roles      | Update member role | Remove workgroup member| Update/Delete workgroup |
        | :-------:    |:--------------------------------------| :--------------------------|:-----------------------------| :--------------------------|:------------------| :---------------------| :---------------------|
        | READER       | <ul><li> - [x] </li></ul>              | `X`                         |           `X`                 |  <ul><li> - [x] </li></ul>  |      `X`           |        `X`             | `X` |
        | CONTRIBUTOR  | <ul><li> - [x] </li></ul>              | <ul><li> - [x] </li></ul>   |           `X`                 |  <ul><li> - [x] </li></ul>  |      `X`           |        `X`             | `X` |
        | WRITER       | <ul><li> - [x] </li></ul>              | <ul><li> - [x] </li></ul>   | <ul><li> - [x] **NEW** </li></ul>   |  <ul><li> - [x] </li></ul>  |      `X`           |        `X`             | `X` |
        | ADMIN        | <ul><li> - [x] </li></ul>              | <ul><li> - [x] </li></ul>   |   <ul><li> - [x] </li></ul>   |  <ul><li> - [x] </li></ul>  | <ul><li> - [x] </li></ul>  | <ul><li> - [x] </li></ul>  | <ul><li> - [x] </li></ul>  |
 

- _**Members**_

    Once a group is created (using the **+** in the upper left corner), members must be added by the group administrator. 2 options are available to do so:

    - Come inside the group (by clicking on it), then use the **+** button to find the menu entry "Member".

    - Hoover the group name and click on the ![User logo](../../img/adduser.png) icon.

    A sidebar appear on the right side, from there you can add members with specifying there rights in the group: read only, write/read or administrate (same rights as the owner).

 
- _**Activity log**_

  All actions done within the group are listed in the "Activity log" tab of the sidebar (file upload, share, deletion, folder making, folder copy, etc).

- _**Folders**_

  It is possible to create a whole folder tree within a workgroup. To make a new folder, just click on the **+** on the upper left corner and then press "Folder".


### 5. Contact lists

Click on the "**+**" button on the upper left corner to add a contact list.</br>
A list can be private or public (visible or invisible to the same domain users). To manage a contact list, simply use the icons that appear when the list is hoovered.

### 6. Guests

Guests are special users. They are external users that once added, can be treated like internal users: they can be added to a contact list, to a workroup or you can even allow them to share files with you.

### 7. Activity logs

You can monitor your LinShare usage by accessing the activity logs table. You can keep track of your authentications on LinShare, your shares, your uploads or workgroup invites.
