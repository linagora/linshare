# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

- Given that am super admin or nested admin of LinShare admin
- After log-in successfully, I go to Configuration Tab
- I click on Parameters, then select  Upload request, the screen setting for this feature will be opened.

#### Description

- Current sub-functions are described in story [story 60](story-60-admin-manage-function-upload-request.md)
- There is a new sub-function: Maximum number of recipients

**Sub-function: Maximum number of recipients**

- On the screen title, I can see a collapsible legend:" This functionality allows admin to set maximum number of recipients that a user can send an upload request to"
- There are 2 policies and 1 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, When user create an upload request, the number of recipients for every upload request will be limited. The limitation number will be set in the below parameter. 
              - If the toggle is disabled, the number of recipients for every upload request created by user in this domain will not be limited. Default behavior.
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    -  Parameter: a text field, named "Max recipient count"
        - When I click on icon "i",  I can see a collapsible legend: "Max number of recipients for every upload request ".
        - I can only input number in this field.Default value : 5

#### Post-conditions

- The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.
- On UI for user, When user create a new upload request and inputting the field "Add recipient", if the number of inputted recipients have reached the maximum limitation, there will be a message: "You have reached maximum number of recipients for this upload request. To send this upload request to more recipients, Please Upgrade your plan"
- The recipient limitation is also applied when user edit an upload request 
- The recipient limitation is applied for both collective and individual upload request 

[Back to Summary](#summary)

## UI Design

#### Mockups


#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



