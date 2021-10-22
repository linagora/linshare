# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

### Preconditions

- Given that i am super-admin in LinShare
- I logged-in to Admin portal successfully
- I choose a nested domain in domain tree and click on Configuration screen, I click on  Providers. (If I select root domain or guest domain in domain tree, I cannot see menu Providers)
- On screen Providers, I can see 3 types: User providers, Groups Provider, Drive Providers.

### Description

#### UC1. Create Twake User Provider

- I select User Providers, if the current selected domain doesn't have an user provider, screen 2 will be displayed.
- When I click button "Add user provider", there will be a drop-down list with 3 options: LDAP provider, OIDC provider, Twake provider
- I select Twake provider, screen 3 will be displayed, the button "Add user provider" will be disabled
- To add an Twake user provider, i need to fill the followings:
    - Twake connection: mandatory field, a drop-down list which contain current Twake connections list. There is a button next to this field that when I click on, I am navigated to Create Twake connection screen
    - After I created and saved a Twake connection successfully, I am navigated back to this screen instead of Remote server listing screen
    - Company id:  a text field and mandatory. When I hover the tooltip, there will be a legend: "LinShare will start retrieving users from this company in Twake."
- When I click button Save, the system will validate:
   - If any mandatory field is blank, it will be highlighted in red and a message:"[field name] cannot be blank"
- If there is no error, the User provider is saved and there will be a successful notification, I am redirected to Screen 4.
- If I click button Cancel, I am navigated to the screen 2

#### UC2. Edit Twake User Provider

- I select User Providers, if current selected domain already had an user provider, screen 4 will be displayed.
- On this screen, I can edit all fields: Twake connection, Company id
- When I click button Save, the system will validate:
  - If any mandatory field is blank, it will be highlighted in red and a message:"[field name] cannot be blank"
- If there is no error, the User provider is updated and there will be a successful notification.
- If I click button Reset, all the fields will be reset to the before-updated values.

#### UC3.Delete Twake User Provider

- On screen 4, i can see a Delete button
- When I click on this button, there will be a confirmation popup:"You are about to delete this user provider, this procedure is irreversible. Do you want to proceed?" and Yes/No button
- I choose Yes to confirm, the Twake user provider will be deleted.
- System will prompt a deletion confirmation toast.
- I am navigated to screen 1.

### Postconditions

- The user provider is associated with the selected nested domain in the left domain tree.
- Root domain is not associated with any User provider
- Guest domain is not associated with any USer provider

[Back to Summary](#summary)

## UI Design

#### Mockups

![story65](./mockups/65.1.png)
![story65](./mockups/65.2.png)
![story65](./mockups/65.3.png)
![story65](./mockups/65.4.png)


#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
