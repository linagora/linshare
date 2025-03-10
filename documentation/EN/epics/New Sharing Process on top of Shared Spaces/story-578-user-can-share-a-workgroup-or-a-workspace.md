# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

* Given that I am a LinShare user 
* After logged-in successfully, I go to Shared space.

#### Description

**UC1. Add a member who is not yet an user to a workgroup**

- Given that I am a workgroup admin
- I click button Add member, then the Member tab of that workgroup will be opened.
- I select a role and input an email to the field "Add people"
- If I can not found the user I am looking for (because it does not exist), the system should propose to me a specific entry in the auto-complete result list to create an guest account : "Create guest account?" 
- I select this button, then there will be a popup:"You will invite [inputted email] to be a guest" and Yes/No button
- If I choose Yes, the inputted email will be added as a guest account automatically, and there will be a toast message :"The guest account was created successfully"
- The external email now become a guest and added as a member to the workgroup.

**UC2. Add a member who is not yet an user to a workspace**

- Given that I am a workspacd's admin
- I click button Add member, then the Member tab of that workspace will be opened.
- I select workspace's role, workgroup's role and input an email to the field "Add people"
- If I can not found the user I am looking for (because it does not exist), the system should propose to me a specific entry in the auto-complete result list to create an guest account : "Create guest account?"
- I select this button, then there will be a popup:"You will invite [inputted email] to be a guest" and Yes/No button
- If I choose Yes, the inputted email will be added as a guest account automatically, and there will be a toast message :"The guest account was created successfully"
- The external email now become a guest and added as a member to the workspace with selected roles.

**UC3 Receiver can access to a shared workgroup/workspace**

- Given that I am an external user who have not had LinShare account and a LinShare user granted me access to a LinShare workgroup/workspace
- I received an email notification via email about the share.
- If I am an external user with no LinShare account: I receive 2 emails:
   - The first email to inform that I am invited to a LinShare with a guest account. I need to activate guest account by clicking on the link and change password. 
   - The second email is to inform that I am invited to a workgroup/workspace. There will be a link to the shared workgroup/workspace. When I click to this link:
      - If I am logging in LinShare with activated guest account, I am redirected to the shared workgroup/workspace in Shared space
      - If I have not logged in LinShare, the log-in screen will be opened.

#### Postconditions

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design


[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
