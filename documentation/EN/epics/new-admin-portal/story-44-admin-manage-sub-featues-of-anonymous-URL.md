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
- I click on Parameters, then select Anonymous URL, the screen setting for this feature will be opened.

#### Description

- Anonymous URL is the original function: When this functionality is not activated, the below 4 sub-functions will not work"

**Sub-function 1. Force anonymous sharing process**
- I can click on the title of this function to collapse/expand the settings
- I click on the icon "i" to see the collapsible legend: "By Enabling this functionality, the user can choose to share documents only with Anonymous Url. In this case, the users will not see the shared document in the Received Share Menu"
- There are 3 policies and 1 default parameter :
- Activation policy includes 2 toggles:
    -  Enable functionality: Toggle. When I click on the icon "i", I can see a collapsible legend:
        - If this toggle is switched on, when a user of this domain shares a document, he can see a checkbox "Force anonymous share for all recipients". If this checkbox is ticked, the document will be shared with anonymous URL for both internal/external recipients.
        - If the toggle is disabled, end user of this domain  will not see the checkbox "Force anonymous share for all recipients" when sharing a file.
    -  Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
        - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
- Configuration policy includes 2 toggles:
    -  Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
        - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
    -  Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
        - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
- Delegation policy includes 2 toggles:
    -  Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
        - If the toggle is on, when a user share a file, he can see a checkbox "Force anonymous share for all recipients". He can enable or disable this option.
        - If the toggle is off, end user cannot change the value of checkbox "Force anonymous share for all recipients" when sharing a file. The value of checkbox depends on it's admin setting
    -  Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
        - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
- Default activation checkbox value in share form: A checkbox. When I click on the icon "i", I can see a collapsible legend:" User will see a checkbox "Force anonymous share for all recipients" on sharing form. This setting decides how to show the default value of this checkbox."
  - If the checkbox is selected, the text displays "Anonymous Sharing with all users(internal and guests)." Which means every recipient will received this file with an anonymous URL in email, either internal/guest or external users.
  - If the checkbox is not selected, the texts displays "Anonymous Sharing with only anonymous users." Which means The anonymous sharing is only applied for external users. Internal user and guests are still received file in his Received Shares menu

**Sub-function 2. Hide Received Shares menu**
- I can click on the title of this function to collapse/expand the settings
- I click on the icon "i" to see the collapsible legend: "By Enabling this functionality, users will not have the access to the Received Share menu."
- There is only Activation policy that includes 2 toggles for this functionality:
    - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
        - If this toggle is switched on, users of this domain cannot see and access the Received Share menu
        - If this toggle is switched off, users of this domain can access the Received Share menu as normal
    - Allow nested admin override "Enable functionality"
        - If the toggle is on, the nested admin can enable/disable the setting "Enable functionality"  for his domain.
        - If the toggle is off, the nested admin see but cannot change the setting of "enable functionality" for his domain.  When i update "enable functionality" toggle on or off for my domain, it is also applied for my nested domains. In lower-level domain, this setting is inherited from parent domain and displayed in read only mode (the toggle is in grey)
    - When the 2 toggles are both disabled, the functionality disappear on every lower domains.

**Sub-function 3. Anonymous download notification**
- I click on the icon "i" to see the collapsible legend:"Anonymous download notification will be sent for every download or only for the first."
- There is only Configuration policy that includes 2 toggles for this functionality:
    -  Configure functionality: Allow nested admin to change the default parameter. When i click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter in his domain".
        - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
    -  Allow nested admin to override "Configure functionality": When i click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
        - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
- Default parameter: A checkbox
    - When the checkbox is ticked, the text displays: "Notification will be sent for every download." Every time a recipient download a file from anonymous sharing, the sender will receive an email notification.
    - When the checkbox is un-ticked, the text displays: "Notification will be sent for the first download only." The download notification of an anonymous share will be sent to the sharer on the fist time.

**Sub-function 4. Email notification URL**
- I click on the icon "i" to see the collapsible legend:"This setting is for receiver's file URL when anonymous sharing."
- There is only Configuration policy that includes 2 toggles for this functionality:
    - (1.1) Configure functionality: Allow nested admin to change the field: "LinShare UI user URL".  When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change the field: "LinShare ui user URL" in his domain".
        - If the toggle is on in a parent domain, the nested admin can change the value of "LinShare UI user URL" his domain.
        - If the toggle is off, the nested admin can see but cannot change the value of "LinShare UI user URL". This field value of nested domain is inherited from it's parent domain and displayed in read only mode.
    - (1.2) Allow nested admin to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the field: "LinShare ui user URL""
          - If the toggle is on in parent domain, then nested admin can see and update both toggles for his domain.
              - If default value of toggle "1.1" in nested domain is disabled, the field ""LinShare ui user URL" is non-editable. Nested Admin can re-enable toggle 1.1 and the field "LinShare ui user URL"is editable now.
          - If this toggle is off in parent domain, and toggle (1.1) is on, then in nested domain, admin see the toggle (1.1) in read only mode and toggle (1.2) disappear. I can edit the field: "LinShare ui user URL"
    - When 2 toggles  are both disabled, they also disappear on nested domains, the field: "LinShare ui user URL" is in read only mode and inherited from parent domain.
- Default parameter: 
   - Field name: LinShare UI User URL
   - This is a text field
   - When I click on icon "i",  I can see a collapsible legend: "You can input your email notification URL in this field. This URL will be appeared in receiver 's notification when user in this domain shares file with anonymous URL'

#### Postconditions
[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
