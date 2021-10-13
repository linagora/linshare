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
- I click on Parameters, then select Undownloaded shared document alert, the screen setting for this feature will be opened.

#### Description

- There are 2 settings in this screen: Undownloaded shared document alert is original function and Undownloaded shared document alert - Days before the alert is sub-function

**Original function: Undownloaded shared document alert**
- On the screen title, I can see a collapsible legend:" By enabling this functionality, users will have the opportunity to get notified when a document has not been downloaded following a share. That notification is sent if at least one document of the share has not been downloaded at all.When this functionality is not activated, the below sub-function will not work"
- There are 3 policies and 1 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user shares a document, he can see the checkbox "Undownloaded document alert" in advanced options.
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
            - If the toggle is on, when user shares a document, he can change default value of checkbox "Undownloaded document alert"
            - If the toggle is off, user cannot change default value of this checkbox
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Default parameter: A checkbox
        - When I click on icon "i",  I can see a collapsible legend: "User will see the checkbox "Undownloaded document alert" on Sharing form. This setting will decide the default value of the checkbox"
        - If the checkbox is ticked, the text displays: The undownloaded shared document alert is activated
        - If the checkbox is un-ticked, the text displays: The undownloaded shared document alert is deactivated

**Sub-function: Number of work days before undownloaded alert"**
- On the screen title, I can see a collapsible legend: "When the checkbox "Undownloaded document alert" is ticked on user's Sharing form, the field "Notification date for undownloaded file" is appeared. This setting is for the number of work days (weekends and holidays are excluded) between sharing date and the alert notification date"
- There are 2 policies and 2 parameters:
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user shares a document and the checkbox "Undownloaded document alert" is ticked, he can change default value of field "Notification date for undownloaded file"
            - If the toggle is off, user cannot change the default value of undownloaded notification date. The field value depends on the default parameter below.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Parameters:
        - When I click on icon "i",  I can see a collapsible legend: " When the checkbox "Undownloaded document alert is ticked on sharing form, User will see the field "Notification date for undownloaded file". The default date is calculated as creation date + default value. The date range is defined between [Creation date] and [Expiration date] "
        - The parameter:
           - Field name: Number of worked days between creation date and the alert notification.
           - Default value: A text field that only accepts number. 
    
#### Post-conditions

The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



