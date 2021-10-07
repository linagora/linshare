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
- I click on Parameters, then select Acknowledgement of share creation, the screen setting for this feature will be opened.
#### Description
- On the screen title, I can see a collapsible legend:" This functionality allows user to receive email notification when he shares a document in LinShare."
- There are 3 policies and 1 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user shares a document, he can see a checkbox "Sharing acknowledgement" in Advanced options.
            - If the toggle is disabled, When user creates a new guest, he cannot see that checkbox.
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user shares a document, he can select/un-select the checkbox "Sharing acknowledgement".
            - If the toggle is off, user cannot change value of this checkbox. The checkbox value depends on the default parameter below.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Parameter: A checkbox
        - When I click on the icon "i", I can see a collapsible legend:" This parameter will decide the default value of the checkbox "Sharing acknowledgement" on Advanced option of guest creation form"
            - If the checkbox is selected, the text displays: "An acknowledgement will be sent to the issuer of the share." In sharing form, the checkbox "Sharing acknowledgement" will be selected and the issuer will receive an email when the document is shared successfully.
            - If the checkbox is selected, the text displays: "No acknowledgement will be sent to the issuer of the share". The checkbox "Sharing acknowledgement" in sharing form is un-selected by default.

#### Post-conditions

The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



