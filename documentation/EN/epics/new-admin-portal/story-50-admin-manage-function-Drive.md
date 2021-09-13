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
- I click on Parameters, then select Drive, the screen setting for this feature will be opened.

#### Description

- On the function Drive screen , I can see 2 settings: 
   - Drive is the original function and Drive-Creation is sub-function
   - And when I click icon "i": next to "Drive", all below legends will be expanded too.

**Drive**
- I can click on the icon "i" to see a collapsible legend :"This functionality allow users to manage Drives. The main goal of Drives is to gather workgroups together and to define default membership and roles for a bunch of users. You may see workgroups as projects and Drive as team, a team who handle theses projects. When this functionality is not activated, the below sub-function will not work"
- I can see 2 policies: 
   - Activation policy includes 2 toggles
      - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
         - If this toggle is switched on, When user of this domain accesses his Shared Space, he can see drives and workgroups.
         - If the toggle is disabled, when user accesses his shared Space, he can only see workgroups.
      - Allow nested admin to override "Enable functionality": When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
      - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
   - Configuration policy includes 2 toggles:
      - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
         - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
      - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
         - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL

**Sub-function. Drive-Creation right**
- I can click on the icon "i" to see a collapsible legend :"This functionality allows user to create Drives "
- I can see 2 policies:
    - Activation policy includes 2 toggles
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user of this domain accesses his Shared Space and click Create button, he can see 2 options: Create drive or create workgroup
            - If the toggle is disabled, when user accesses his shared Space and click Create button, he can only create workgroup. When he goes inside a drive, he also cannot create a workgroup
        - Allow nested admin to override "Enable functionality": When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
        - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL

#### Post-conditions
    
The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)