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
- I click on Parameters, then select Domain, the screen setting for this feature will be opened.
#### Description
- On the function Domain screen , I can see 2 sub-functions: Domain email and Notification URL

**Sub-function 1. Domain email**
- I can click on the icon "i" to see a collapsible legend :"By enabling, this functionality allows admin to configure his domain email. This email will be the sender's email address of any notification sent from this domain."
- There is only Configuration policy, including 2 toggles:
    -  Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
        - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
    - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
        - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
- Default parameter: a text field.
    - When I click on icon "i",  I can see a collapsible legend: " You can input your domain email in this field. This email address will appear as sender's email address of any notification from your domain"

**Sub-function 2. Notification URL**
- I can click on the icon "i" to see a collapsible legend :"By enabling, this functionality allows admin to configure his domain's notification URL. This URL will appear in any notification from this domain except for anonymous sharing notification."
- There is only Configuration policy, including 2 toggles:
    -  Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
        - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
    - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
        - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
- Default parameter: a text field.
    - When I click on icon "i",  I can see a collapsible legend: " You can input your domain's notification URL in this field. This URL will appear in receiver's notification content, e.g when user in this domain create an upload request, share a file with internal user..." 
#### Post-conditions
The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



