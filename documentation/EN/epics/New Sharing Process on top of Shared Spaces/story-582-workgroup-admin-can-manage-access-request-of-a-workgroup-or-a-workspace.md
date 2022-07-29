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

- I go to shared space 
- When I click on three-dot button of a workgroup/workspace that I am admin of, I can see option "Access request"
- When I click on this option, then "Access request" tab will be opened.
- I can see the list of all pending requests to access this workgroup/workspace
- Each request include:  Name/Email of the requester, the role and 2 buttons: Approve or Reject 
- For workgroup, the default role is reader, I can click on this field, a drop-down list will be shown to select other roles: Contributor/Writer/Admin. 
- For workspace, there are 2 roles: Default workgroup role and workspace role. The default selected role is Reader, and the list of roles for workspace are: Admin, Writer, Reader
- When I click on button "Approve":
   - If the requester is already a LinShare user, that requester will become member of the workgroup/workspace with selected role
   - If the requester is not an user yet, there will be a notification message:" By approving this request, you will invite [external email] as a guest user". If I choose Yes, a guest account will be created automatically for this email then he will be added to the workgroup/workspace with selected role.
- When I click on button "Reject", there will be a confirmation popup:" You are about to reject this request ! Beware, this action cannot be undone." and 2 button Close and Proceed." If I choose Proceed, the request will be denied.

#### Postconditions

- When there is a new request, every admin of the workgroup/workspace will receive and email notification about that request with information:
    - Requester full name (if any - in case the requester is already a LinShare user) and email
    - Date/time of creation
    - Status : Pending
    - And a button links to navigate to Pending request list of that workgroup/workspace
- When an admin approves or rejects a pending request, other admins of that workgroup/workspace receive an email notification with information:
    - Requester full name (if any - in case the requester is already a LinShare user) and email
    - Date of creation
    - Status :Approved or rejected
    - Date/time of approval of rejection
    - Full name and email of the admin who approve or reject the request
- When an admin approves or rejects a pending request, the requester also receives an email notification with information:
    - Date of creation
    - Status :Approved or rejected
    - Date/time of approval of rejection
    - Full name and email of the admin who approves or rejects the request
- In case that a requester is not yet a LinShare user and the request is approved, he received 2 email:
   - The first email to inform that I am invited to a LinShare with a guest account. I need to activate guest account by clicking on the link and change password.
   - The second email is to inform that I am approved to become workgroup/workspace member.
- When a request is approved or denied, it will be removed from the pending list.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)