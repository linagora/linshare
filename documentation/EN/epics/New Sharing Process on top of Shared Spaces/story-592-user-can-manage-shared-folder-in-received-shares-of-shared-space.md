# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

* Given that I am a LinShare user
* After logged-in successfully, I go to Shared space.
* I select the tab: Shared by links. In this list I can see all the folders/files which have been shared to me. 

#### Description

- If I have "Read" permission to the folder, I can :
   - Open folder and see all child folders/files inside 
   - When I click on three-dot button of the folder, I can see the options: Details, Download, Leave share
   - When I click on thee-dot button of the file inside that folder, I can see options: Details, Preview, Download, Copy to Myspace/Shared Space
- If I have "Read and Write" permission to the folder, I can:
   - Open folder and see all child folders/files inside
   - Create a folder, Upload file/folder
   - When I click on three-dot button of the folder, I can see the options: Details, Rename, Download, Leave share
   - When I click on thee-dot button of the file inside that folder, I can see options: Details, Rename, Preview, Download, Duplicate, Copy to Myspace/Shared Space
- If I have "Full access"  to the folder, I have all permissions as above "Read and Write" right, and can Delete files/folder inside the Shared folder.
- If I am in Shared by links view of a shared folder/file and also a member of the parent workgroup of that shared folder/file, I can see an option: View in Shared Space. When I select this option, I am redirected to this folder/file in Shared Space tab.
- If I am in the Shared Space view of a folder/file and I am also added as a recipient of Shared folder, I can see option :" View in Shared by links". When I select this option, I am redirected to this folder/file in Shared by link tab.
- My permissions to a folder/file between "Shared space" and "Shared by links" do not depend on each other.
- When I select one "Shared by link" folder, there will be an actions bar displayed:
  - There will be options: Download as zip, Leave Share
  - If I select Download, the selected folder will be downloaded as zip
  - If I select Leave Share, there will be a confirmation message. If I choose Yes, the selected folders will be removed.
- When I select multiple "Shared by link" folders, there will be an actions bar displayed:
  - There will be options: Leave Share
  - If I select Leave Share, there will be a confirmation message. If I choose Yes, all the selected shared by link folders will be removed.
- When I select multiple "Shared by link" files, there will be an actions bar displayed:
  - There will be options: Download them all, Download as zip, Leave Share
  - If I select Download, all the selected files will be downloaded
  - If I select Download as zip, all the selected file will be downloaded as a zipped folder. 
  - If I select Leave Share, there will be a confirmation message. If I choose Yes, all the selected shared by link files will be removed.

  
#### Postconditions

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
