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
- I click on Parameters, then select Share expiration, the screen setting for this feature will be opened.

#### Description

- There are 2 settings in this screen: Share expiration is original function and Deleting files on expiration shares is sub-function

**Original function: Share expiration**
- On the screen title, I can see a collapsible legend:" By enabling, this functionality allows user to set expiration date for shared document in LinShare.When this functionality is not activated, the below sub-function will not work"
- There are 3 policies and 2 parameters:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user shares a document, he can see the field Expiration date
            - If the toggle is disabled, user cannot see the field Expiration date in Sharing form
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user shares a document, he can change default value of expiration date
            - If the toggle is off, user cannot change value of Expiration date. The field value depends on the default parameter below.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Parameters:
      - When I click on icon "i",  I can see a collapsible legend: "User will see the field "Expiration date" on Sharing form. The default expiration date is calculated as creation date + default value. The date range is defined between [Creation date] and [ creation date + max value] "
      - The parameter include 2 fields:
          - Default value: A text field that only accepts number with a drop-down list contains options: Month, week, day.
          - Max value: A text field that only accepts number with a drop-down list contains options: Month, week, day or I can select the checkbox "Unlimited" for the max value.

**Sub-function: Deleting files on expiration shares**
- When I click on the screen title, I can see a collapsible legend:" This functionality allows admin to set if the shared document is removed on the last share's expiration or not"
- There is only Configuration policy and one Parameter
- Configuration policy includes 2 toggles:
    - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
       - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
    - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
       - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
- Parameter: A checkbox
   - If the checkbox is selected, the text displays: The document will be removed at the expiration of the last share. The document will be removed on sharer's Myspace on expiration date of the last share.
   - If the checkbox is not selected, the text displays: The document will not be removed at the expiration of the last share.

#### Post-conditions

The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



