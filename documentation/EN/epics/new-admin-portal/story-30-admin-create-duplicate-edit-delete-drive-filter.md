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

**UC1. Create LDAP drive filter**
- I go to Configuration tab on top navigation bar, and select Remote filters
- The screen listing Remote filters will be displayed, i select Drive filters, the screen listing drive filters is opened. 
- I click on button Create, screen Create LDAP Drive filter will be displayed.
- In this screen i can see a helper message on screen name when i click information icon
- To create an LDAP Drive filter, i need to input fields:
   - Model selector: optional field, i can choose option from a drop-down list
      - When i select the model, other fields on screen excepting "Name" will be filled out automatically.
   - Name: a text field and mandatory
   - Description: a text field and optional
   - Search all drives query: a text field and mandatory
   - Search drive query: a text field and mandatory
   - Drive prefix: a text field and optional
   - Search page size: a text field and mandatory
   - Attributes fields on the right of screen are:
      - Member email: a text field and mandatory
      - Member first name: a text field and mandatory
      - Member last name: a text field and mandatory
      - Drive name: a text field and mandatory
      - Drive member: a text field and mandatory
      - Below each of filed,  there will be a grey text to explain what is this field used for (check the screen 2)
- When i click button Save, the system will validate if any mandatory field is blank, it will be highlighted in red and a message:"[field name] cannot be blank"
- If there is no error, the new LDAP drive filter is created and there will be a successful notification
- I am redirected to the Screen Drive filters listing, and the new create LDAP drive filter appears on the list.
- If i click button Cancel, i am navigated to the Listing drive filters screen.

**UC2. Edit LDAP Drive filter**

- There are 2 ways to access Edit LDAP drive filter screen:
   - In the Drive filters listing screen, i click on three dot-button of an LDAP drive filter and select option Edit from the drop-down list
   - Or i can click an the LDAP drive filter row on the  drive filter listing table. 
- On the LDAP drive filter screen, i can edit all fields excepting "Model selector" (this field will not be shown in Edit mode) then click button Save.
- If any mandatory field is blank, it will be highlighted in red and a message:"[field name] cannot be blank"
- If none of the mandatory fields is  blank, the updates will be saved and there will be a successful toast message.
- If i click button Reset, all the updates will be reset to the before values.
- I can click Drive filters on the breadcrumb to navigate back to the Drive filter listing screen.

**UC3. Duplicate an LDAP Drive filter**

- On the Drive filter listing screen, i click on thee-dot button of an LDAP drive filter and select option Duplicate from the drop-down list 
- The screen Create LDAP drive filter will be opened
- Except the field Name is blank, other fields will have the same value as the LDAP drive filter that i selected to duplicate
- I input the field Name, and can edit other fields
- When i click button Save, the system will validate if any mandatory field is blank, it will be highlighted in red and a message:"[field name] cannot be blank"
- If there is no error, the new LDAP drive filter is created and there will be a successful notification
- If i click button Cancel, i am navigated to the Drive filter listing screen.

**UC4. Delete an LDAP Drive filter**

- There are 2 ways to delete an LDAP drive filter:
   - In the Drive filter listing screen, i click on three dot-button of an LDAP Drive filter  and select option Delete from the drop-down list
   - Or i can click an LDAP Drive filter row on the Drive filter listing table to go to LDAP Drive filter detail screen. On this screen i can see the button Delete.
- When i click on button Delete:
   - If the Drive filter is not accociated with any domain, there will be an confirmation popup: "You are about to delete this Drive filter, this procedure is irreversible. Do you want to proceed?" and Yes/No button
      - I choose Yes to confirm, the Drive filter will be deleted.
      - System will prompt a deletion confirmation toast.
   - If the Drive filter is accociated with any domain, the system will display message: "This Drive filter is accociated with at least one domain. You cannot delete."

**UC5. Delete multiple Drive filters**

- On Drive filter listing screen, i can select multiple Drive filters on the list by tick the checkbox of each item
- There will be a top bar that indicates number of selected Drive filters, an isolation icon, an Undo icon and a Delete icon. 
- When i click on Isolation icon, the screen only shows selected items 
- When i click on Undo icon, all the selected items are unselected 
- When i click on button Delete:
   - If any of selected Drive filters is not associated with any domain, there will be an confirmation popup: "You are about to delete [number of selected items] drive filters, this procedure is irreversible. Do you want to proceed?" and Yes/No button 
      - I choose Yes to confirm, the selected Drive filters will be deleted.
      - System will prompt a deletion confirmation toast.
   - If any of selected Drive filters is associated with any domain, the system will display message: " One of selected Drive filters is associated with at least one domain. You cannot delete."

**UC6. View associated domains**

- On Drive filter listing screen, i click on three-dot button on Action column.
- I select option "View associated domains"
- A new screen will be opened
- I can see the list of domain's name which are using the Drive filter. 
- There will be a lable next to each domain's name that indicating domain type of that domain
- Only Top domain or sub domain can use an Drive filter, Root domain and guest domain can't.
- When i click one domain on the list, i am navigated to Drive provider page of that domain. 
- If the Drive filter is not associated with any domain, there will be a text message: " There is no domain using this drive filter. "

#### Postconditions


[Back to Summary](#summary)

## UI Design

#### Mockups

![story30](./mockups/30.1.png)

![story30](./mockups/30.2.png)

![story30](./mockups/30.3.png)

![story30](./mockups/30.4.png)

![story30](./mockups/30.5.png)

![story30](./mockups/30.6.png)

![story30](./mockups/30.7.png)

![story30](./mockups/30.8.png)

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
