# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New UI user](./README.md)

## Definition

### Preconditions

- Given that I haved loged-in successfully to my account 

### Description 

- I click on my avatar on the left corner then select Manage account => Select "Token management" on the left menu 

**UC1. Listing tokens**
- I can see the list of my current tokens 
- Each row includes token's name and creation date 
- I can sort the token list by name and creation date 
- The list is paginated and I can select number of items /page. 

**UC2. View the detail of a token**

- When I hover each row of the token list, I can see 3 icons: Details, Edit, Delete 
- OR When I click on 3-dots buttons of the token, I can see a list of 3 options:  Details, Edit, Delete 
- I select "Detais", then the details screen of token is opened 
- I can see information:
   - token's creator 
   - token name
   - Creation date
   - Modification date

**UC3. Edit the token**

- When I select Edit option of the token, the Edit screen is opened
- I can edit token name and description. (Name cannot be empty)
- Then I click Save button, the token is updated and there will be a notification message.

**UC4. Delete the token**
- When I select Delete option of the token, there will be a confirmation popup
- If I choose Proceed, the token is deleted, there will be a confimation message
- The authentication using that token will be terminated immediately.

**UC5. Create a new token**
- When I click Create button, the Create token screen will be opened 
- I need to input token name field (mandatory) and Add a description (optional)
- Then I click Create button, there a popup display with a text : "You have created a new token
Beware, the token is only shown once and cannot be restored. Please save the token before closing:"
- And the token that I created is displayed with a Copy button next to it. 
- When I click Copy, the token is copied to clipboard and I can saved it in another place
- When I click button Close, the popup disappear and I can see the new token name in the list.


### Postcondition 



[Back to Summary](#summary)

## UI Design

### Mockups

![Group 64.png](./Group 64.png)

![Group 65.png](./Group 65.png)

![Group 66.png](./Group 66.png)

![Group 67.png](./Group 67.png)

![Group 68.png](./Group 68.png)

### Final design

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)





