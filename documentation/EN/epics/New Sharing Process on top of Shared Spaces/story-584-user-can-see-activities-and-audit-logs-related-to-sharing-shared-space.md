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

**UC1. User can see activities related to sharing workgroup/workspace**
- From menu, I go to Shared space and open Detail page of a workgroup/workspace. 
- I select Activities tab, then I can see activities: 
    - Share with external user: Only admin can see this log
    - Create/Edit/Renew/Delete a sharing link for workgroup/workspace: All members can see this log
    - Enable/Disable a sharing link for workgroup/workspace: All members can see this log
    - Access request to workgroup/workspace:
       - A new request is created: Workgroup/workspace admin can see this log
       - Approve or deny access requests: All admins and can see this log
- Technical user can perform some actions on behalf of a user, so the actor who performed the action may not be the same as the authenticated user. In this case, in the audit trace, I can see an asterisque near the actor name, which on hovering, I can see a message: "This action was performed by the [authUser name] on behalf of [Actor]"

**UC2. User can see audit logs related to sharing workgroup/workspace**

- From menu, I go to Activities logs
- I can see activities logs related to sharing a workgroup/workspace:
    - Share with external user: Ony admin can see this logs
    - Create/Edit/Renew/Delete a sharing link for workgroup/workspace: All members can see this log
    - Enable/Disable a sharing link for workgroup/workspace: All members can see this log
    - Access request to workgroup/workspace:
        - A new request is created: Workgroup/workspace admin can see this log
        - Approve or deny access requests: All admins and can see this log

- Technical user can perform some actions on behalf of a user, so the actor who performed the action may not be the same as the authenticated user. In this case, in the audit trace, I can see an asterisque near the actor name, which on hovering, I can see a message: "This action was performed by the [authUser name] on behalf of [Actor]"

**UC3. Admin can see audit logs related to sharing workgroup/workspace**

- After log-in successfully to Admin portal, admin can go to Activities logs and search for a workgroup/workspace
- He can see all the activities related to a sharing a workspace/workgroup as listed above.

#### Postconditions

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
