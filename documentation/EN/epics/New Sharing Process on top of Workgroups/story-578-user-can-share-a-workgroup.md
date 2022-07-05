# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

* Given that I am a LinShare user 
* After logged-in successfully, I go to Shared space.

#### Description
**UC1. Get Sharing link**
* When I click three-dots button of a workgroup that I am admin of, I can see option "Get sharing link" 
* I select this option, a new screen will be opened:
* In this new screen, I can see:
  - A link: this link is generated automatically when sharing first time by the system. I can click button Copy next to this link. Another button should let me renew this link.
  - Checkbox "Expiration":
     - When I select this checkbox, a date picker will be shown and I can select an expiry date for this share.
     - The expiry date must > today. 
     - On the expiry date, the sharing link will be removed. 
  - Checkbox: Allow people with this link to request access
     - When I select this checkbox, people with this link can send a request to access the workgroup.

**UC2. Add a member who is not yet an user to a workgroup**

- Given that I am a workgroup admin
- I click button Add member, then the Member tab of that workgroup will be opened.
- I select a role and input an email to the field "Add people"
- If I can not found the user I am looking for (because it does not exist), the system should propose to me a specific entry in the auto-complete result list to create an guest account : "Create guest account?" 
- I select this button, then there will be a popup:"You will invite [inputted email] to be a guest" and Yes/No button
- If I choose Yes, the inputted email will be added as a guest account automatically, and there will be a toast message :"The guest account was created successfully"
- The external email now become a guest and added as a member to the workgroup.

#### Postconditions

* After a sharing link of a workgroup is created, if I click on three dot button of that workgroup, the option "Get sharing link" will be replaced by "Manage sharing link"

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design


[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
