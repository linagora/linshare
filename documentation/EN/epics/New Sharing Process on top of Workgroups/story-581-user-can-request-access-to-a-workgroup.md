# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

- Given that I received a sharing link of a LinShare workgroup but I am not one of the recipients in the list.

#### Description

- When I click on that link,  it will be opened in the browser and system will check:

    - If I have logged-in LinShare: (1)
        - There will be a new screen saying that my current account is not granted permission.
        - If in the setting of that shared workgroup, the checkbox " Allow people with this link to request access" is selected, I can see a button:"Request access". and a field :"Add a message"
        - If in the setting of the shared workgroup, the checkbox :"" Allow people with this link to request access" is not selected,I cannot request access to the workgroup
        - I can input message to that field (optional) then click button Request access, then the worgkroup's admins can see a new request to access the workgroup with status "Pending".

    - If I have not logged-in, I can see options:
        - Log-in: When I select this option, the Log-in screen will be opened. After I logged in successfully, the system will validate:
            - If the logged-in account is granted access permission, then I can see the shared workgroup in my shared space
            - If the logged-in account is not granted access permission, the process is as case (1) above
        - Request access: When I select this option, a new screen will be opened:
            - If in the setting of that shared workgroup, the checkbox " Allow people with this link to request access" is not selected, I can see a message that I cannot access to the workgroup.
            - If in the setting of that shared workgroup, the checkbox " Allow people with this link to request access" is  selected, I can see a field to input my email, and a text field to input my message (optional)
            - After inputting my email and personal message , I can click button Request access. I can also see an explanation that if my access request is approved, my inputted email will be used to create a guest account.
            - The system will validate:
               - If the inputted email already exists in the current pending access requests of the workgroup, a message will be shown:" You already created an access request with this email on [creation date or pending request]. Plesae wait for approval."
               - If the inputted email does not exist in current pending access requests, a new access request will be sent. 
               - The worgkroup's admins will receive a new request to access the workgroup with status "Pending".
               

#### Postconditions

- After I click button Send access request to a workgroup, I can see a message:"You request has been sent. You will receive an email notification if your request is approved or not"
- When there is a new access request to the workgroup, the workgroup admins will receive an email notification.

[Back to Summary](#summary)

## UI Design

#### Mockups


#### Final design


[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
