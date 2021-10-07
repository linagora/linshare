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
- I click on Parameters, then select Mime type, the screen setting for this feature will be opened.

#### Description

- On the screen title, I can see a collapsible legend:" By enabling this functionality, the Mime policy which is configured in Domain detail page will be applied for this domain ".
- There is only Activation policy which includes 2 toggles:
    - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
        - If this toggle is switched on, when user of this domain upload a file, it must comply with the Mime policy of the domain
        - If the toggle is disabled, the uploaded document is not validated by Mime policy. 
    - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
    - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL

#### Post-conditions

The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



