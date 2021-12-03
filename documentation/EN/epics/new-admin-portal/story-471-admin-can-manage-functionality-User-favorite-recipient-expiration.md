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
- I click on Parameters, then select User favorite recipient expiration, the screen setting for this feature will be opened.

#### Description

- On the screen title, I can see a collapsible legend:"When a LinShare user shares filed with a new recipient (internal/external or guest), his email will be saved in a recipient list so that user can easily find them next time. This functionality allows admin to set retention period for emails in that list. "
- I can see 2 policies and 1 default parameter field
- Activation policy includes 2 toggles
  - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
    - If this toggle is switched on, when user of this domain shares a file with a new email, the email will be stored in LinShare DB with expiration date  = current date + value in Default parameter field. When it expires, the email is automatically removed. On active period, if the user shares file with this recipient again, the expiration date of this email is re-calculated = sharing date + value in default parameters".
    - If the toggle is disabled, the emails in recipient list will not expire. 
  - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
  - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
- Configuration policy includes 2 toggles:
  -  Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
    - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
  - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
    - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
- Default parameter:
  - When I click on icon "i",  I can see a collapsible legend: "The period setting used to calculate expiration date of new recipient's email. Expiration date = Created date + expiration period"
  - The parameter include 2 fields:
    - A tex field that only accepts number
    - A drop-down list contains options: Month, week, day.

#### Post-conditions

The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



