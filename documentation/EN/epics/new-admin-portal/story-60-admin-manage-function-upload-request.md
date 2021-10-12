# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

- Given that am super admin or nested admin of LinShare admin
- After log-in successfully, I go to Configuration Tab
- I click on Parameters, then select Upload request, the screen setting for this feature will be opened.

#### Description

- There are 11 settings in this screen: Upload request is original function and 10 sub-functions.

**Original function: Upload request**
- On the screen title, I can see a collapsible legend:" An upload request is a feature through which a person (email) can upload files for a LinShare user, in a temporary and regulated manner. The uploaded documents will impact the issuer’s personal space quota. When this functionality is not activated, the below sub-functions will not work"
- There is only 1 policy and 1 parameter in this setting
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, the feature is enabled, user can see the menu Upload request in his LinShare account.
            - If the toggle is disabled, the menu Upload request will be hidden in user's LinShare account.
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Parameters: A text field
        - When I click on icon "i",  I can see a collapsible legend: "This URL will be used as the website base URL for every email notifications that will be sent by the server. ex https://upload-request.linshare.local"

**Sub-function 1: Upload request-closure right**
- When I click on the screen title, I can see a collapsible legend:
   - "Close an Upload Request (issuer/recipient):
      - The issuer and, possibly, the recipient can close an upload request.
      - The recipient can no longer modify or add documents to the upload request.
      - The upload request then appears as closed in the current view.
      - Once an upload request expires, it is automatically closed."
- There are 3 policies and 1 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user creates upload request, there will be a checkbox "Allow closure" in Advanced options.
            - If the toggle is disabled, user cannot see the checkbox
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user creates an upload request, he can change default value of checkbox "Allow closure"
            - If the toggle is off, user cannot change default value of this checkbox.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Default parameter: A checkbox
        - When I click on icon "i",  I can see a collapsible legend: "User will see the checkbox "Allow closure" on Upload request creation form. This setting will decide the default value of the checkbox"
        - If the checkbox is ticked, the text displays: The recipient can close the upload request. When the upload request is created with this option, the recipient can see button "Close" in the upload request portal.
        - If the checkbox is un-ticked, the text displays: The recipient can not close the upload request.

**Sub-function 2: Upload request - Recipient delete right**
- When I click on the screen title, I can see a collapsible legend:" By enabling, this functionality allows recipients of an upload request to delete the uploaded documents"
- There are 3 policies and 1 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user creates an Upload request, he can see the checkbox "Allow deletion" in Advanced options.
            - If the toggle is disabled, user cannot see the checkbox
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user creates an upload request, he can change default value of checkbox "Allow deletion"
            - If the toggle is off, user cannot change default value of this checkbox.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Default parameter: A checkbox
        - When I click on icon "i",  I can see a collapsible legend: "User will see the checkbox "Allow deletion" on Upload request creation form. This setting will decide the default value of the checkbox"
        - If the checkbox is ticked, the text displays: The recipient can delete files. When the upload request is created with this option, the recipient can see button "Delete" in uploaded documents from the upload request portal.
        - If the checkbox is un-ticked, the text displays: The recipient can not delete files.

**Sub-function 3: Upload request - Delay before activation**
- When I click on the screen title, I can see a collapsible legend:"This functionality allows to manage the delay between the upload request's creation date and the activation date (upload request is available and users can upload documents)"
- There are 3 policies and 2 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user creates an Upload request, he can see the field "Activation date"
            - If the toggle is disabled, user cannot see this field and the activation date is creation date.
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user creates an upload request, he can change default value of "Activation date"
            - If the toggle is off, user cannot change default value Activation date. The field value depends on the default parameter below.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Parameters:
       - When I click on icon "i",  I can see a collapsible legend:"The default Activation date is calculated as current date + default value. The date range is defined as:
         - At creation time: between [Current date] and [ current date + max value] .
         - At update time: The date range is between [Current date] and [ creation date + max value]"
       - The parameter include 2 fields:
           - Default value: A text field that only accepts number with a drop-down list contains options: Month, week, day.
           - Max value: A text field that only accepts number with a drop-down list contains options: Month, week, day or I can select the checkbox "Unlimited" for the max value.

**Sub-function 4: Upload request - Delay before expiration**
- When I click on the screen title, I can see a collapsible legend:"This functionality allows to manage the delay between the activation date and the expiry date. Ex: if an Upload request is activated on 3 January and the delay before expiration is 2 days, the expiry date will be 6 January at 00h00."
- There are 3 policies and 2 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user creates an Upload request, he can see the field "Expiration date"
            - If the toggle is disabled, user cannot see this field and there will be no expiration date for Upload request
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user creates an upload request, he can change default value of "Expiration date"
            - If the toggle is off, user cannot change default value Expiration date. The field value depends on the default parameter below.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Parameters:
        - When I click on icon "i",  I can see a collapsible legend:"The default expiration date is calculated as Activation date + default value. The date range is defined as:
            - At creation time: between [Activation date] and [ Activation date + max value] .
            - At update time: If Activation date is < current date The date range is between [Current date] and [ Activation date + max value]". If Activation date is > current date, the date range will be between [Activation date] and [ Activation date + max value] .
        - The parameter include 2 fields:
            - Default value: A text field that only accepts number with a drop-down list contains options: Month, week, day.
            - Max value: A text field that only accepts number with a drop-down list contains options: Month, week, day or I can select the checkbox "Unlimited" for the max value.

**Sub-function 5: Upload request - Delay before notification**
- When I click on the screen title, I can see a collapsible legend:"This functionality allows to manage the delay before sending a notification (to issuer and recipient) about upload request expiration. It will be an email notifications reminding the recipient that the issuer is expecting something from him."
- There are 3 policies and 2 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user creates an Upload request, he can see the field "Reminder date"
            - If the toggle is disabled, user cannot see this field and the reminder notification about the upload request's expiration will not be sent
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user creates an upload request, he can change default value of "Reminder date"
            - If the toggle is off, user cannot change default value Reminder date. The field value depends on the default parameter below.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Parameters:
        - When I click on icon "i",  I can see a collapsible legend:"The default Reminder date is calculated as Expiration date - default value. The date range is defined as:
            - At creation time: the date range is between [ creation date] and [expiration date]
            - At update time: the date range is between [current date] and [expiration date]
        - The parameter:
            - Default value: A text field that only accepts number with a drop-down list contains options: Month, week, day.

**Sub-function 6: Upload request - Maximum deposit size**
- When I click on the screen title, I can see a collapsible legend:"This functionality allows to define a maximum size for total upload request's files"
- There are 3 policies and 2 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user creates an Upload request, he can see the field "Total size of files"
            - If the toggle is disabled, user cannot see this field and the Total size of files is not limited.
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user creates an upload request, he can change default value of field "Total size of files"
            - If the toggle is off, user cannot change default value.The field value depends on the default parameter below.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Parameters:
        - When I click on icon "i",  I can see a collapsible legend:" The default value of field "Total size of files" will be displayed when user open upload request creation form. If user is allowed to edit, the range is between 0 and max value."
        - The parameter include 2 fields:
            - Default value: A text field that only accepts number with a drop-down list contains options: Kilobyte, Megabyte, Gigabyte
            - Max value: A text field that only accepts number with a drop-down list contains options:Kilobyte, Megabyte, Gigabyte or I can select the checkbox "Unlimited" for the max value.

**Sub-function 7: Upload request - Maximum file count**
- When I click on the screen title, I can see a collapsible legend:"This functionality allows to set a limit for the number of documents that can be uploaded to the upload request."
- There are 3 policies and 2 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user creates an Upload request, he can see the field "Max number of files"
            - If the toggle is disabled, user cannot see this field and the number of files is not limited.
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user creates an upload request, he can change default value of field "Max number of files"
            - If the toggle is off, user cannot change default value.The field value depends on the default parameter below.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Parameters:
        - When I click on icon "i",  I can see a collapsible legend:" The default value of field "Max number of files" will be displayed when user open upload request creation form. If user is allowed to edit, the range is between 0 and max value."
        - The parameter include 2 fields:
            - Default value: A text field that only accepts integer
            - Max value: A text field that only accepts integer

**Sub-function 8: Upload request - Maximum file size**
- When I click on the screen title, I can see a collapsible legend:"This functionality allows to set a limit for each file size that can be uploaded. "
- There are 3 policies and 2 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user creates an Upload request, he can see the field "Max size of a file"
            - If the toggle is disabled, user cannot see this field and the size of a file.
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user creates an upload request, he can change default value of field "Max size of a file"
            - If the toggle is off, user cannot change default value.The field value depends on the default parameter below.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Parameters:
        - When I click on icon "i",  I can see a collapsible legend:" The default value of field "Max size of a file" will be displayed when user open upload request creation form. If user is allowed to edit, the range is between 0 and max value."
        - The parameter include 2 fields:
            - Default value: A text field that only accepts number with a drop-down list contains options: Kilobyte, Megabyte, Gigabyte
            - Max value: A text field that only accepts number with a drop-down list contains options:Kilobyte, Megabyte, Gigabyte or I can select the checkbox "Unlimited" for the max value.

**Sub-function 9: Upload request - email notification language**
- When the original function - Upload request is enabled, this sub-function is also enabled by default and cannot be changed.
- When I can click on the icon "i" next to the title, I see a collapsible legend: "This function allows user to choose if his guests can use Myspace or not"
- There are 2 policies and 1 parameter:
    - Configuration policy: Includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy: Includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user creates an upload request, he can change the value of field "Notification language"
            - If the toggle is off, end user cannot edit  this field. The field value depends on default parameter.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Default parameter: a drop-down list
        - When I click on icon "i",  I can see a collapsible legend: "This is setting for default value of field "Notification language" in upload request creation form."
        - The options are: English, French

**Sub-function 10: Upload request - Protected by password URL**
- When I click on the screen title, I can see a collapsible legend:"This functionality allows to secure the shared access URL's by a generated password (which is sent by mail for each recipient). "
- There are 3 policies and 2 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user creates an Upload request, he can see the checkbox "Password protected"
            - If the toggle is disabled, user cannot see this checkbox and recipient can access the upload request URL without a password.
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user creates an upload request, he can change default value of checkbox "Password protected"
              - If the toggle is off, user cannot change default value.The field value depends on the default parameter below.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Parameters:
        - When I click on icon "i",  I can see a collapsible legend:" The default value of checkbox "Password protected" will be displayed when user open upload request creation form."
        - If the checkbox is ticked, the text displays: The access to the invitation will be protected by a password.
        - If the checkbox is un-ticked, the text displays: The access to the invitation will not be protected by a password.

#### Post-conditions

The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



