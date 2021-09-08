# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

* Given that i am super-admin in LinShare 
* I logged-in to Admin portal successfully

#### Description

**UC1. Create LDAP user filter**
- I go to Configuartion tab on top navigation bar, and select Remote filters
- The screen listing Remote filters will be displayed, i select User filters, the screen listing user filters is opened. 
- I click on  button Create, there will be 2 options: LDAP filters and Twake filters
- I select LDAP filters, screen Create LDAP User filter will be displayed.
- In this screen i can see a helper message on screen name when i click information icon
- To create an LDAP User filter, i need to input fields:
   - Model selector: optional field, a drop-down list includes 4 options: default-pattern-AD; default-pattern-demo; default-pattern-obm; default-pattern-openldap
      - When i select one model, other fields on screen excepting "Name" will be filled out automatically.
   - Name: a text field and mandatory
   - Description: a text field and optional
   - Search all workgroup query: a text field and mandatory
   - Search workgroup query:  a text field and mandatory
   - Attributes fields on the right of screen are:
      - Mail: a text field and mandatory
      - First name: a text field and mandatory
      - Last name: a text field and mandatory
      - User unique identifier: a text field and mandatory
      - Search page size: a text field and mandatory
      - Search limit: Completion page size: a text field and mandatory
      - Completion limit: a text field and mandatory
- When i click button Save, the system will validate if any mandatory field is blank, it will be highlighted in red and a message:"[field name] cannot be blank"
- If there is no error, the new LDAP User filter is created and there will be a successful notification
- I am redirected to the Screen User filters listing, and the new create LDAP user filter appears on the list.
- If i click button Cancel, i am navigated to the Listing user filters screen.

**UC2. Edit LDAP User filter**

- There are 2 ways to access Edit LDAP user filter screen:
   - In the User filters listing screen, i click on three dot-button of an LDAP user filter and select option Edit from the drop-down list
   - Or i can click an the LDAP user filter row on the  User filter listing table. 
- On the LDAP user filter screen, i can edit all fields excepting "Model selector" (this field will not be shown in Edit mode) then click button Save.
- If any mandatory field is blank, it will be highlighted in red and a message:"[field name] cannot be blank"
- If non of the mandatory fields is  blank, the updates will be saved and there will be a successful toast message.
- If i click button Reset, all the updates will be reset to the before values.
- I can click User filters on the breadcrumb to navigate back to the User filter listing screen.

**UC3. Duplicate an LDAP User filter**

- On the User filter listing screen, i click on thee-dot button of an LDAP User filter and select option Duplicate from the drop-down list 
- The screen Create LDAP USer filter will be opened
- Except the field Name is blank, other fields will have the same value as the LDAP User filter that i slected to duplicate
- I input the field Name, and can edit other fields
- When i click button Save, the system will validate if any mandatory field is blank, it will be highlighted in red and a message:"[field name] cannot be blank"
- If there is no error, the new LDAP user filter is created and there will be a successful notification
- If i click button Cancel, i am navigated to the User filter listing screen.

**UC4. Delete an LDAP User filter**

- There are 2 ways to delete an LDAP user filter:
   - In the User filter listing screen, i click on three dot-button of an LDAP user filter  and select option Delete from the drop-down list
   - Or i can click an the LDAP user filter row on the User filter listing table to go to LDAP user filter detail screen. On this screen i can see the button Delete 
- When i click on button Delete:
   - If the user filter is not accociated with any domain, there will be an confirmation popup: "You are about to delete this User filter, this procedure is irreversible. Do you want to proceed?" and Yes/No button
      - I choose Yes to confirm, the User filter will be deleted.
      - System will prompt a deletion confirmation toast.
   - If the user filter is accociated with any domain, the system will display message: "This user filter is accociated with at least one domain. You cannot delete."

**UC5. Delete multiple user filters**

- On User filter listing screen, i can select multiple User filters on the list by tick the checkbox of each item
- There will be a top bar that indicates number of selected user filters, an isolation icon, an Undo icon and a Delete icon. 
- When i click on Isolation icon, the screen only shows selected items 
- When i click on Undo icon, all the selected items are unselected 
- When i click on button Delete:
   - If any of selected user filters is not accociated with any domain, there will be an confirmation popup: "You are about to delete [number of seleted items] user filters, this procedure is irreversible. Do you want to proceed?" and YEs/No button 
      - I choose Yes to confirm, the selected User filters will be deleted.
      - System will prompt a deletion confirmation toast.
   - If any of selected user filters is accociated with any domain, the system will display message: " One of selected user filters is accociated with at least one domain. You cannot delete."

**UC6. View Associated domains**

- On User filter listing screen, i click on three-dot button on Action column
- I select option "View associated domains"
- A new screen will be opened
- I can see the list of domain's name which are using the user filter. 
- There will be a lable next to each domain's name that indicating domain type of that domain
- Only Top domain or sub domain can use an user filter, Root domain and guest domain can't.
- When i click one domain on the list, i am navigated to User provider page of that domain. 
- If the user filter is not associated with any domain, there will be a text message: " There is no domain using this user filter. "

#### Postconditions


[Back to Summary](#summary)

## UI Design

#### Mockups

![story23](./mockups/23.1.png)

![story23](./mockups/23.2.png)

![story23](./mockups/23.3.png)

![story23](./mockups/23.4.png)

![story23](./mockups/23.5.png)

![story23](./mockups/23.6.png)

![story23](./mockups/23.7.png)

![story23](./mockups/23.8.png)

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
