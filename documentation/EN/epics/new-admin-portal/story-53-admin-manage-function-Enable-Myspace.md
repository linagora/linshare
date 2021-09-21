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
- I click on Parameters, then select Enable Myspace, the screen setting for this feature will be opened.

#### Description

- When I click on the When I click on the icon "i"  next to screen tittle, I can see a collapsible legend: "This functionality allows users in your domain can access menu Myspace. My space is a personal space where user can upload his documents and share with other users/work space "
- There is only Configuration policy, including 2 toggles:
  - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
  - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
  - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
  - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
  - Default parameter: a checkbox
      - When I click on icon "i",  I can see a collapsible legend: " This setting decides when a new user is created, he can use Myspace by default or not."
      - If the checkbox is selected, the text displays "User can use Myspace." Which means when user is created, he can see and upload file in Myspace in LinShare
      - If the checkbox is not selected, the texts displays "User cannot use Myspace." Which means My space will be hidden on new user's account

#### Post-conditions

The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



