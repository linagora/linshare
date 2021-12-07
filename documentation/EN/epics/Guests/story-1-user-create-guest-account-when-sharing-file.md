# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* [Sharing file](./README.md)

## Definition

#### Preconditions

- Given that i am an Linshare user and i log-in Linshare successfully

#### Description

- From menu, i go to MySpace and see the list of files 
- I click on three-dot button of a file and select option Share 
- The Quick share panel will be shown
- On Add recipients filed, i type email address, for example [Email address 1]
- If the email is an valid email but is an external account, the system will display a suggestion with the same email and a button "Create guest account?"
- If i click on Create guest account, there will be a confirmation popup "You will invite "[Email address 1]" as your guest?" 
    - If i choose Yes, the selected email will be used to create a guest.
    - If i choose No, the popup will disappear.
- If i do not click on Create guest account, i can select the email as recipient as currently.
#### Postconditions

- After guest account is created from the email, i can see a toast message " Guest account created". The guest is automatically added to the list of recipients. The toast message should also contain a "see" action .
- When i access my guest list, i can see the [Email address 1] on the list, i can edit that guest to add first name and last name. 

[Back to Summary](#summary)

## UI Design

#### Mockups

![1.1](./mockups/1.1.png)

![1.2](./mockups/1.2.png)

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
