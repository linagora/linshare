# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

* Given that I am root admin or nested admin of LinShare
* After log-in successfully to Admin portal, I select menu Administration => Users 
* The listing user page will be displayed. 

#### Description

**UC1. Delete multiple user accounts**

- On Listing account screen, I can select multiple account and see option Delete
- When I select Delete, there will be a confirmation popup.
- If I choose Yes, all selected accounts will be removed from the list

**UC2. Unlock multiple accounts**

- On listing account screen, If I select multiple locked accounts, the option Unlock will be enabled.
- I select Unlock, all selected account will be unlocked.

#### Postconditions

- Root admin can perform bulk operations in user lists of whole platform 
- Nested admin can perform bulk operations in user list of his domain and nested domain (if any)
- Admin can perform bulk operations in search result screen: For e.g, admin can search for locked account then unlock them .

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design


[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
