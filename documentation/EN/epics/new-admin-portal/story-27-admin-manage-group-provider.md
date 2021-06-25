# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

- Given that i am super-admin in Linshare 
- I logged-in to Admin portal successfully
- I choose a nested domain in domain tree and click on Configuration screen, i click on item Providers. (If i select root domain or guest domain in domain tree, i cannot see item Providers)
- On screen Providers, i can see 3 types: User providers, Groups Provider, Drive Providers. 

#### Description

**UC1. Create LDAP group Provider** 
- I select Group Providers, if the current selected domain doesn't have a group provider, screen 2 will be displayed.
- When i click button "Add Group provider", there will be a drop-down list with 2 options: LDAP provider, Twake provider
- I select LDAP provider, screen 3 will be displayed, the button Add group provider will be disabled.
- To add an LDAP group provider, i need to fill the followings:
   - LDAP connection: mandatory field, a drop-downlist which contain current LDAP connections list. There is a button next to this field that when i click on, i am navigated to Create LDAP connection screen
   - Group filter:  mandatory field,  a drop-down list which contain current LDAP group filter list. There is a button next to this field that when i click on, i am navigated to Create LDAP group filter Screen 
   - Base dn:  a text field and mandatory.
   - Search in other domains: A checkbox, if i select, i will search users who are members of the remote LDAP groups in others domains than my own domain, according to the domain policies. 
- When i click button Save, the system will validate if any mandatory field is blank, it will be highlighted in red and a message:"[field name] cannot be blank"
- If there is no error, the Group provider is saved and there will be a successful notification, I am redirected to Screen 4. 
- If i click button Cancel, i am navigated to the Screen 2.

**UC2. Edit LDAP Group Provider**

- I select Group Providers, if current selected domain already had an group provider, screen 4 will be displayed.
- On this screen, i can edit all fields: LDAP connection, group filter, Basedn, chekcbox Search user in other domains. 
- I click button Save, the system will validate if any mandatory field is blank, it will be highlighted in red and a message:"[field name] cannot be blank"
- If there is no error, the Group provider is updated and there will be a successful notification. 
- If i click button Reset, all the fields will be reset to the before-updated values.

**UC3.Delete LDAP Group Provider**

- On screen 4, i can see a Delete button
- When i click on this button, there will be a confimation popup:""You are about to delete this group provider, this procedure is irreversible. Do you want to proceed?" and Yes/No button
- I choose Yes to confirm, the LDAP group provider will be deleted.
- System will prompt a deletion confirmation toast. 
- I am navigated to screen 1.

#### Postconditions

- The group provider is associated with the selected nested domain in the left domain tree. 
- Root domain is not associated with any group provider
- Guest domain is not associated with any group provider

[Back to Summary](#summary)

## UI Design

#### Mockups

![Screen1](./mockups.27.1.png)

![Screen2](./mockups.27.2.png)

![Screen3](./mockups.27.3.png)

![Screen4](./mockups.27.4.png)

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
