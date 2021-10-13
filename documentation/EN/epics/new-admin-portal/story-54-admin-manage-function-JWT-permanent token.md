# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

- Given that am super admin or nested admin of LinShare domain
- After log-in successfully, I go to Configuration Tab
- I click on Parameters, then select JWT permanent token, the screen setting for this feature will be opened.

#### Description.

- I can click on the icon "i" to see a collapsible legend :"This functionality allows user to manage his JWT permanent token and authenticate by using a permanent token. "
- There are 2 policies and 1 parameter:
   - Activation policy includes 2 toggles:
      - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
         - If this toggle is switched on, When user clicks on human icon on his account, he can select the option "JWT token management" and navigate to Token management page. 
         - If the toggle is disabled, When user clicks on human icon on his account, he will not see the option Token management and cannot authenticate by using permanent token
      - Allow nested admin to override "Enable functionality": When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
         - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
   - Configuration policy: Includes 2 toggles:
      - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
         - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
      - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
      - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
   - Default parameter: A checkbox 
      - When I click on icon "i",  I can see a collapsible legend: "This parameter decides if the admin can create permanent token for his domain's users or not"
      - When the checkbox is ticked, the text displays:" Admin can create JWT token for his domain's users ". When admin go to Manage user page, on the JWT management tab, he can see the button Create token
      - When the checkbox is un-ticked, the text displays:" Admin cannot create JWT token for his domain's users". When admin go to Manage user page, on the JWT management tab, he cannot see the button Create token
      
#### Post-conditions

The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)
