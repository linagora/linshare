# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [Guests](./README.md)

## Definition

#### Preconditions

- Given that I am a LinShare user and I logged-in LinShare successfully

#### Description

- From menu, I go to Contacts => Guests
- I can see all guests in my domain

**UC1. Edit a guest as moderator** 

- If I am moderator of the guest, When I click on three-dot button, I can see options: Detail, Edit
- I select option Edit, then the Edit guest form will be opened. [Screen1](#screen-1)
- I can edit fields:
   - First name: A text field, mandatory. If the field is blank, there will be error message below:"This field cannot be blank".
   - Last name: A text field, mandatory. If the field is blank, there will be error message below:"This field cannot be blank".
   - Expiration date: I can change the expiration date as current rules.
   - Advanced options: Activate user space and restrict contact list: I can edit these field ad current rules 
- I can read but cannot edit guest'Email field.
- I click button update, if there is no error (permission, validation...), the guest is updated with a successful toast notification.

**UC2. Edit a guest as manager**

- If I am manager of the guest, When I click on three-dot button, I can see options: Detail, Edit, Delete
- I select option Edit, then the Edit guest form will be opened.[Screen 2](#screen-2) [screen 3](#screen-3)
- I can edit fields as UC1 and Controller list :
   - Add guest's manager/moderator : I select role manager/moderator then input user in "Add people" field
   - Remove guest's manager/moderator: On the controller list, I can click icon "x", that manager/moderator will be removed from the list
   - Edit manager/moderator's role: On the controller list, I can click icon Edit, a drop-down list will be shown with 2 options: Manager or moderator. I can select the new role.
- I click button update, if there is no error (permission, validation...), the guest is updated with a successful toast notification.

#### Postconditions

- After I click button Update, if there is any new guest's manager/moderator or any current manager/moderator is removed, the controllers list in Guest detail panel is updated too
- If I click button Cancel, every update will not be saved. 

[Back to Summary](#summary)

## UI Design

### Mockups

#### Screen 1

![story482](./mockups/482.1.png)

#### Screen 2

![story482](./mockups/482.2.png)

#### Screen 3

![story482](./mockups/482.3.png)

####Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
