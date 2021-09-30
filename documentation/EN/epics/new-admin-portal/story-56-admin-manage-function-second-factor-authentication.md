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
- I click on Parameters, then select Second factor authentication, the screen setting for this feature will be opened.

#### Description

- I click on the icon "i" next to the screen title to see the collapsible legend: "The functionality manages second factor authentication feature. Any changes of this page will have impact on all users of LinShare"
- There are 3 policies and 1 default parameter :
- Activation policy includes 2 toggles:
    -  Enable functionality: Toggle. When I click on the icon "i", I can see a collapsible legend:"By enabling, users in this domain can use the second factor authentication for their account."
        - If this toggle is switched on, When user logged-in his LinShare account and click human icon on top right, he can select the option "Second factor authentication", then the setting 2FA page will be opened. 
        - If the toggle is disabled, user will not see the option Second factor authentication when clicking on human icon. 
    -  Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
        - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
- Configuration policy includes 2 toggles:
    -  Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
        - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
    -  Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
        - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
- Delegation policy includes 2 toggles:
    -  Allow user to remove shared key:  When I click on the icon "i", I can see a collapsible legend:
        - If the toggle is on, When user is already set up 2FA for his LinShare account, he can access 2FA setting page and remove Shared key then create a new one 
        - If the toggle is off, user cannot remove the shared key
    -  Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to remove shared key" for his own domain. When disabled, the value of setting "Allow user to remove shared key"  is applied for all nested domains and nested admin cannot update"
        - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
- Default parameter: A checkbox. When I click on the icon "i", I can see a collapsible legend:"This setting decides if second factor authentication is required or optional for this domain users"
    - If the checkbox is selected, the text displays "The second factor authentication will be required for all users". If user has not set up 2FA, after logging-in with username and password, he is automatically navigated to 2FA setting page and cannot access other screens until he finishes the setting.
    - If the checkbox is not selected, the texts displays "The second factor authentication can be enabled by users (optional)." The user can decide to use second factor authentication or not.

#### Post-conditions

The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
