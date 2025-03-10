# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [SAAS](./README.md)

## Definition

#### Preconditions

- Given that I am LinShare SaaS user

#### Description

- A new key is added in ui-user/config/config.js file: saasMode
   - If saasMode=false, user is not in SAAS offer, the error messages when user reaches limitations are described as in below stories:
     - Number of workspaces: [story 536](https://ci.linagora.com/linagora/lgs/linshare/products/linshare-github/-/blob/master/documentation/EN/epics/new-admin-portal/story-536-admin-can-manage-number-of-workspaces-that-can-be%20created-in-a-domain.md) 
     - Number of workgroups inside a workspace: [story 538](https://ci.linagora.com/linagora/lgs/linshare/products/linshare-github/-/blob/master/documentation/EN/epics/new-admin-portal/story-538-admin-can-manage-number-of-workgroups-that-can-be-created-inside-a-workspace.md)
     - Number of recipients in an Upload request: [story 539](https://ci.linagora.com/linagora/lgs/linshare/products/linshare-github/-/blob/master/documentation/EN/epics/new-admin-portal/story-539-admin-can-manage-number-of-recipients-of-an-upload-request.md)
     - Number of uploaded file per day: [story 560](./story-560-limit-the-number-of-uploaded-files-per-day.md)
     - Number of upload requests (Pending/Active/Closed): [story561](./story-561-admin-can-manage-number-of-upload-request-per-user.md)
   - If saasMode=true, user is using SAAS offer, the error messages when user reaches limitations are changed as following: 
     - With number of workspaces:
        - The message is "You have reached maximum number of workspaces. Please contact your company owner to upgrade the company plan at [Console]()."
     - With number of workgroups inside a workspace:
        - The message is: " You have reached maximum number of workgroups inside this workspace. Please contact your company owner to upgrade the company plan at [Console]()."
     - With number of recipients of an upload request: 
        - The message is: "You have reached maximum number of recipients for this upload request.  Please contact your company owner to upgrade the company plan at [Console]()."
     - With number of uploaded files per day:
        - The message is: "You have reached maximum number of uploaded files per day. Please contact your company owner to upgrade the company plan at [Console]()."
     - With number of upload requests: 
        - The message is: "You have reached maximum number of uploaded requests. Please contact your company owner to upgrade the company plan at [Console]()."
- When user clicks on the link [Console](), user is redirected to Console page. 

#### Postconditions

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)

