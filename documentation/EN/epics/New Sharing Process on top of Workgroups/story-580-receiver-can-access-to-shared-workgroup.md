# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

* Given that a LinShare user granted me access to a LinShare workgroup
* I received an email notification via email about the share.

#### Description

**UC1. I had LinShare account (internal user/guest)**
- In case that I had a LinShare account, I will receive an email notification that I am invited to the workgroup and the link to that workgroup.
- When I click on that link from email or in the case I got the link directly from the sender then click on that link, it will be opened in the browser and system will check:
   - If I have logged-in LinShare, the system will check:
      - If the logged-in account is shared, I am redirected to the shared workgroup in Shared Space. 
      - If the logged-in account is not the account that has been shared, there will be a new screen saying that my current account is not granted permission.
  - If I have not logged-in, the log-in screen will be opened. And after I logged-in successfully, I am redirected to the shared workgroup in Shared Space.

**UC2. I am an external user with no LinShare account**

- I received an email that I am invited to a LinShare workgroup with a guest account. To access the shared workgroup, I need to activate guest account. 
- In the email, there will be a link to the shared workgroup and my guest account's activate link
- After I finished activating my guest account, I am redirected to the shared workgroup in Shared space

#### Postconditions

- A receiver can get the sharing link of workgroup through email or get directly from the sender.

[Back to Summary](#summary)

## UI Design

#### Mockups


#### Final design


[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
