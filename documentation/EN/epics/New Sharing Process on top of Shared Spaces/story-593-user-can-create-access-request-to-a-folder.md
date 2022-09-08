# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

- Given that I received a sharing link of a LinShare folder but I am not one of the recipients of shared by link folder.

#### Description

- When I click on that link,  it will be opened in the browser and system will check:

    - If I have logged-in LinShare: (1)
           - There will be a message "Access denied" and a link back to Homepage. 
           - If in the setting of that shared folder, the checkbox " Allow people with this link to request access" is selected, I can see a button:"Request access". and a field :"Add a message"
           - If in the setting of the shared folder, the checkbox :" Allow people with this link to request access" is not selected, I cannot see button:"Request access".
           - I can input message to that field (optional) then click button Request access, then the parent workgroup 's admins/writer of the folder can see a new request to access the folder with status "Pending".

    - If I have not logged-in, I can see options:
        - Log-in: When I select this option, the Log-in screen will be opened. After I logged in successfully, the system will validate:
            - If the logged-in account is granted access permission, then I can see the shared by link folder in my shared space/ Shared by link tab
            - If the logged-in account is not granted access permission, the process is as case (1) above
        - Request access: When I select this option, a new screen will be opened:
            - If in the setting of that shared folder, the checkbox " Allow people with this link to request access" is not selected, I can see a message that I cannot access to the folder
            - If in the setting of that shared folder, the checkbox " Allow people with this link to request access" is  selected, I can see a field to input my email, and a text field to input my message (optional)
            - After inputting my email and personal message , I can click button Request access. I can also see an explanation that if my access request is approved, my inputted email will be used to create a guest account.
            - The system will validate:
                - If the inputted email already exists in the current pending access requests of the folder, a message will be shown:" You already created an access request with this email on [creation date or pending request]. Please wait for approval."
                - If the inputted email does not exist in current pending access requests, a new access request will be sent.
                - The parent workgroup's admins/writers will receive a new request to access the folder with status "Pending".


#### Postconditions

- After I click button Send access request to a folder, I can see a message:"You request has been sent. You will receive an email notification if your request is approved or not"
- When there is a new access request to the folder, the workgroup/workspace admins will receive an email notification.

[Back to Summary](#summary)

## UI Design

#### Mockups


#### Final design


[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
