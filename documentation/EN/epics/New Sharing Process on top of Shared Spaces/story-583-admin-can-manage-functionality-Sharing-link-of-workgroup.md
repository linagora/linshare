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
- I click on Parameters, then select Shared Space - Sharing link for workgroups, the screen setting for this feature will be opened.

#### Description

- Below the functionality title, I can see an explanation text field " This functionality determines the expiration date range of Sharing link of a workgroup."
- I can see 3 policies:
    - Activation policy includes 2 toggles
        - Enable functionality:
           - If this toggle is switched on, user of this domain accesses his shared space and click on three-dot button of a Workgroup, he can see option "Get sharing link". 
           - If the toggle is disabled, when user accesses his shared Space and click on three-dot button of a Workgroup, he cannot see option "Get sharing link".
        - Allow nested admin to override this section: When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
           - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
       - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
          - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
       - Allow nested to override this section: When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
          - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  
           - If the toggle is on, when user opens screen sharing link of a workgroup, he can select/un-select the checkbox "Expiration".
           - If the toggle is off, user cannot change value of this checkbox.
        - Allow nested admin to override this section:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
           - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL

    - Parameter: A checkbox:
       - If the checkbox is selected, the text displays: " The checkbox Expiration will be selected by default." On UI user, when user create a new sharing link of workgroup , The checkbox "Expiration" will be selected by default.
       - If the checkbox is un-selected, the text displays: " The checkbox Expiration will be unselected by default." On UI user, when user create a new sharing link of workgroup , The checkbox "Expiration" will be un-selected by default.

- There are 2 nested-functionalities under this functionality: Sharing link expiration policy and Access request to workgroup

**Nested functionality: Sharing link expiration policy**

- Below the functionality title, I can see an explanation text field " This functionality determine whether users can create Sharing link of a workgroup."
- There are 2 policies and 2 parameters:
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override this section : When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter: 
            - If the toggle is on, when user opens screen sharing link of a workgroup and select the checkbox "Expiration", he can change default value of expiration date
            - If the toggle is off, user cannot change value of Expiration date of a workgroup sharing link. The field value depends on the default parameter below.
        - Allow nested admin to override this section:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Allow user to change default parameter" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Parameters:
      - When user select checkbox "Expiration" of a workgroup sharing link, the date picker field will appear. The default expiration date is calculated as creation date + default value. The date range is defined between [Creation date] and [ creation date + max value] "
      - The parameter include 2 fields:
          - Default value: A text field that only accepts number with a drop-down list contains options: Month, week, day.
          - Max value: A text field that only accepts number with a drop-down list contains options: Month, week, day or I can select the checkbox "Unlimited" for the max value.

**Nested functionality:  Allow Workgroup access requests**

- There is an explanation text field "This functionality determine whether people (any user with or without an LinShare account) with sharing link  can request access to the workgroup or not"
- I can see 3 policies:
    - Activation policy includes 2 toggles
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, when user open screen sharing link of a workgroup, he can see a checkbox: "Allow people with this link to request access".
            - If the toggle is disabled, this checkbox will not appear on screen sharing link of workgroup.
        - Allow nested admin to override this section: When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
        - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override this section: When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user edit a workgroup sharing link, he can select/un-select the checkbox "Allow people with this link to request access".
            - If the toggle is off, user cannot change value of this checkbox.
        - Allow nested admin to override this section:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Parameter: A checkbox
        - If the checkbox is selected, the text displays: "Allow people with sharing link to request access". On UI user, when user create a new sharing link of workgroup , The checkbox "Allow people with this link to request access"  will be selected by default.
        - If the checkbox is un-selected, the text displays: " Do not allow people with sharing link to request access". On UI user, when user create new a sharing link of workgroup, The checkbox "Allow people with this link to request access" will be unselected by default.
    
#### Post-conditions

The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)



