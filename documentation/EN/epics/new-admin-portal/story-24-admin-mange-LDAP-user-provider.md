# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

- Given that i am super-admin in LinShare 
- I logged-in to Admin portal successfully
- I choose a nested domain in domain tree and click on Configuration screen, i click on item Providers. (If i select root domain or guest domain in domain tree, i cannot see item Providers)
- On screen Providers, i can see 3 types: User providers, Groups Provider, Drive Providers. 

#### Description

**UC1. Create LDAP User Provider** 

- I select User Providers, if the current selected domain doesn't have an user provider, screen 2 will be displayed.
- When i click button "Add user provider", there will be a drop-down list with 3 options: LDAP provider, OIDC provider, Twake provider
- I select LDAP provider, screen 3 will be displayed, the button Add user provider will be disabled
- To add an LDAP user provider, i need to fill the followings:
   - LDAP connection: mandatory field, a drop-downlist which contain current LDAP connections list. There is a button next to this field that when i click on, i am navigated to Create LDAP connection screen
   - After I created a LDAP connection successfully, i am navigated back to this screen
   - User filter: mandatory field,  a drop-down list which contain current LDAP user filter list. There is a button next to this field that when i click on, i am navigated to Create LDAP user filter Screen
   - After I created an User filter successfully, i am navigated back to this screen.  
   - Base dn:  a text field and mandatory. When i hover the tooltip, there will be a legend: "LinShare will start looking for users from this position in your LDAP."
- When i click button Save, the system will validate if any mandatory field is blank, it will be highlighted in red and a message:"[field name] cannot be blank"
- If there is no error, the User provider is saved and there will be a successful notification, I am redirected to Screen 4. 
- If i click button Cancel, i am navigated to the screen 2

**UC2. Edit LDAP User Provider**

- I select User Providers, if current selected domain already had an user provider, screen 4 will be displayed.
- On this screen, i can edit all fields: LDAP connection, User filter, Basedn 
- I click button Save, the system will validate if any mandatory field is blank, it will be highlighted in red and a message:"[field name] cannot be blank"
- If there is no error, the User provider is updated and there will be a successful notification. 
- If i click button Reset, all the fields will be reset to the before-updated values.

**UC3.Delete LDAP User Provider**

- On screen 4, i can see a Delete button
- When i click on this button, there will be a confimation popup:""You are about to delete this user provider, this procedure is irreversible. Do you want to proceed?" and Yes/No button
- I choose Yes to confirm, the LDAP user provider will be deleted.
- System will prompt a deletion confirmation toast. 
- I am navigated to screen 1.

#### Postconditions

- The user provider is associated with the selected nested domain in the left domain tree. 
- Root domain is not associated with any User provider
- Guest domain is not associated with any USer provider

[Back to Summary](#summary)

## UI Design

#### Mockups

![Screen1](./mockups.24.1.png)

![Screen2](./mockups.24.2.png)

![Screen3](./mockups.24.3.png)

![Screen4](./mockups.24.4.png)

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
