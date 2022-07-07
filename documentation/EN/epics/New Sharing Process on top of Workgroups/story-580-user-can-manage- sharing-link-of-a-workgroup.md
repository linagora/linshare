# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

- Given that I am a LinShare user
- Admin enabled the functionality about sharing link for workgroup

#### Description

**UC1. Get Sharing link**
* When I click three-dots button of a workgroup that I am admin of, I can see option "Get sharing link"
* I select this option, a new screen will be opened:
* In this new screen, I can see:
    - A link: this link is generated automatically when sharing first time by the system. I can click button Copy next to this link. Another button should let me renew this link.
    - Checkbox "Expiration": Default value of the checkbox is set by admin. 
          - When I select this checkbox, a date picker will be shown and I can select an expiry date for this share.
        - The expiry date must > today.
        - On the expiry date, the sharing link will be removed.
    - Checkbox: Allow people with this link to request access. Default value of the checkbox is set by admin 
        - When I select this checkbox, people with this link can send a request to access the workgroup.
        - When the checkbox is un-ticked, when an user who is not shared yet access the workgroup link, he will not be able to create access request to the workgroup. 
    - Checkbox: Enable/disable the link: Default value is enabled. When the link is disabled, button "Copy link" is disabled too. User cannot access a disabled link. 

**UC2. Edit a sharing link of a workroup**

- When I click on three-dot button of a workgroup, I can see option :"Get sharing link"
- I select this option, then the sharing link popup will be opened.
- I can edit fields on the popup:
   - Checkbox "Expiration": If the checkbox is ticked, I can untick this checkbox . If the checkbox is not selected, I can select and choose an expiration date > current date 
   - Checkbox: Allow people with this link to request access. I can tick/untick this checkbox to allow/not allow people with the sharing link create access request to this workgroup
   - Checkbox: Enable/disable the link
   - When I click button Renew the link, all the checkboxes will be set to default values. 
- After edit, I can click button Save, then the popup will be closed.

**UC3. Remove sharing link of a workgroup**

- As workgroup admin, When I click three-dot button of a workgroup, I select option:"Get sharing link", then the sharing link popup will be opened
- On this popup I can see button "Remove"
- When I click this button, there will be a confirmation message
- If I choose Yes, then the sharing link of the workgroup will be deleted 
- Now when workgroup admin select option "Get sharing link" of that workgroup, a new link will be generated.

#### Postconditions

- A receiver can get the sharing link of workgroup through email or get directly from the sender.
- Only workgroup admin can create and edit/remove a sharing link
- Worgkoup's reader /contributor/writer can only copy the sharing link of that workgroup.
- After a sharing link is removed or disabled, when a user access the link, there will be a message that the link is invalid

[Back to Summary](#summary)

## UI Design

#### Mockups


#### Final design


[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
