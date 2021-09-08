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
- I click on Parameters, then select Contacts list, the screen setting for this feature will be opened.
#### Description
- On the screen Contacts list, I can see 2 functions: Contacts list and Creation right

**UC1. Contacts list**
- Contact list is the original function. I can click on the icon "i" to see a collapsible legend :"The functionality allows user of this domain to create his contact lists. A Contact list may include internal/guest users, or external users and can be public or private. When a contact list is public, other LinShare users can use this contact list when sharing document, creating upload request... If the contact list is private, only the owner can use it. When this functionality is not activated, the below sub-function will not work"
- In Contacts list setting, there is only Activation policy, including 2 toggles:
   - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
      - If this toggle is switched on, user of this domain can access the menu Contact > Contacts list and manage available Contacts list.
      - If the toggle is disabled, user of this domain cannot see the menu Contacts list in his LinShare account. 
   - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
   - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL

**UC2. Creation right**
- In Creation right setting, there is only Activation policy, including 2 toggles:
    - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
        - If this toggle is switched on, user of this domain can see the button Create new Contacts list on screen Listing Contacts.
        - If the toggle is disabled, the button Create new Contacts list is disabled. 
    - Allow nested admin to override "Enable functionality": . When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
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



