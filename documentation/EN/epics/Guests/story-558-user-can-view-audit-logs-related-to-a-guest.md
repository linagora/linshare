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

- From menu, I go to Activities logs 
- I can see activities logs of a guest depending on following audit rules:
    - Create guest : Guest/Guest's author/Guests' moderators (at creation time) can see this log
    - Edit guest's name : All Guest's moderators and the guest can see this log
    - Edit guest's restricted contact list: Enable or disable checkbox, Add or remove restricted contact": All Guest's moderators and the guest can see this log 
    - Edit "Expiration date": All Guest's moderators and the guest can see this log
    - Edit checkbox "Activate user space": All Guest's moderators and the guest can see this log
    - Edit moderator list:  Enable or disable checkbox, Add or remove moderator: All admin moderators can see this log
    - Create Moderator request: 
       - A user requests to become Simple moderator: The requestor and all admin moderators can see this log 
       - A simple moderator requests to become admin moderator: The requestor and all admin moderators can see this log
    - Approve or deny moderator requests: All admin moderators and the requestors can see this log
    - Delete guest account: All guest moderators can see this log.
- Technical user can perform some actions on behalf of a user, so the actor who performed the action may not be the same as the authenticated user. In this case, in the audit trace, I can see an asterisque near the actor name, which on hovering, I can see a message: "This action was performed by the [authUser name] on behalf of [Actor]"

#### Postconditions

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
