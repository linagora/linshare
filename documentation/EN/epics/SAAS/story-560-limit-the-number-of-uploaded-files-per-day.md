# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [SAAS](./README.md)

## Definition

#### Preconditions

#### Description

**UC1. As an admin,  I want to manage the functionality Limit number of uploaded files per day per user**

- Given that am super admin or nested admin of LinShare admin
- After log-in successfully, I go to Configuration Tab
- I click on Parameters, then select Number of uploaded files per day , the screen setting for this feature will be opened.
- On the screen title, I can see a collapsible legend:" This functionality allows admin to set limitation for number of uploaded files per day per user in this domain."
- There are 2 policies and 1 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, the number of uploaded files per day per user in this domain will be limited. The uploaded files will be counted in only Myspace. The limitation number will be set in the below parameter.
            - If the toggle is disabled, the number of uploaded files per day per user in this domain will not be limited.
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    -  Parameter: a text field, named "Max uploaded files count"
        - When I click on icon "i",  I can see a collapsible legend: "Max number of files that a user in this domain can upload to Myspace in a day".
        - I can only input number in this field. Default value : 20

**UC2. As a user, I cannot upload more than my max number of files per day**

- Given that I am a LinShare user 
- Given that the functionality Limit number of uploaded files per day is enabled 
- When I upload a file to Myspace in LinShare, the system will validate:
- If my total uploaded files in Myspace today are smaller than value of "Max uploaded file count" (set by domain admin), the uploading is processed as normally 
- If my total uploaded files in Myspace today has reached the value of "Max uploaded file count" (set by domain admin), there will be an error message: "You have reached maximum number of uploaded files per day."

**UC3. As a user, I want to upload multiple files to Myspace with the limitation of number of files**

- If I upload multiple files in once or I upload a folder which contains multiple files, and the number of uploading files makes my total uploaded files a day greater than the limitation, for example:
   - My limitation is 20 files per day and I have not uploaded any file today
   - On Myspace , I click button Upload and select 25 files from my computer to upload
- The files list will be appeared in the Current upload section. The system will validate:
   - If any file in the list is greater than file size limitation, there will be an error message as currently
   - If there is no available space, there will be an error message for remaining files as currently
   - After the twentieth file is uploaded successfully, there will be an error message for remaining files in the list: "You have reached maximum number of uploaded file per day"

#### Postconditions

- The file count will be reset every day for each user in the domain
- The time is calculated by user' time zone.
- When user copy/move files in LinShare, it will not be counted as new uploads 

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)

