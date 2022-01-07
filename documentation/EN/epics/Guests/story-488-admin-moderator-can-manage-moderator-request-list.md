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
- When I click on three-dot button of a guest that I have admin moderator right, I can see option "Pending request"
- When I click on this option, then "Moderator request" tab will be opened.
- I can see the list of all pending requests to become moderators of this guest 
- Each request include:  Full name of the requester, the role he wants to request ( simple or admin) and 2 options: Approve or Deny icons 
- When I hover the icon, I can see the tooltip to show the button meaning: Approve or Deny 
- When I click on option "Approve", that requester will become the moderator of the guest with the requested right. 
- When I click on option "Deny", there will be a confirmation popup:" You are about to deny this request ! Beware, this action cannot be undone." and 2 button Close and Proceed
- If I choose Proceed, the requested will be denied. 

#### Postconditions

- When a request is approved or denied, it will be removed from the pending list. 
- When a requester is approved to become a guest's moderators, he will be appeared in moderator list in Edit tab of that guest.
- After the request is approved or denied, when the requester open Detail panel of the guest, he can see the status of request is updated from "pending" to "Approved" or "Denied" and If the request is approved, his right is also updated too.

[Back to Summary](#summary)

## UI Design

#### Mockups

![story488](./mockups/488.1.png)
![story488](./mockups/488.2.png)
![story488](./mockups/488.3.png)
![story488](./mockups/488.4.png)

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)