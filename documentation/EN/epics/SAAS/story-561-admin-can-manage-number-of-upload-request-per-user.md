# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [SAAS](./README.md)

## Definition

#### Preconditions

#### Description

**UC1. As an admin,  I want to manage the functionality Limit number of uploaded requests per user**

- Given that am super admin or nested admin of LinShare admin
- After log-in successfully, I go to Configuration Tab
- I click on Parameters, then select Upload request, then the screen setting for this feature will be opened.
- There is a new sub-function: Limit number of upload requests per user
- On the sub-function title, I can see a collapsible legend:" This functionality allows admin to set limitation for number of uploaded requests (pending/active/closed) per user in this domain."
- There are 2 policies and 1 parameter:
    - Activation policy includes 2 toggles:
        - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
            - If this toggle is switched on, the number of uploaded requests per user in this domain will be limited. The limitation will be applied for upload requests with statuses: Pending/Active/Closed. The limitation number will be set in the below parameter.
            - If the toggle is disabled, the number of uploaded request in this domain will not be limited.
        - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL
    - Configuration policy includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    -  Parameter: a text field, named "Max uploaded request count"
        - When I click on icon "i",  I can see a collapsible legend: "Max number of upload requests of a user in this domain. The number is counted on upload requests with status: Pending/Active/Closed".
        - I can only input number in this field.
- By default, this functionality is disabled. It is only enabled when user is using LinShare SAAS. 
- Default value for the parameter is depending on the user's subscription in SAAS offer.

**UC2. As a user, I cannot create upload request if the number of my upload requests have reached the limitation**

- Given that I am a LinShare user
- Given that the functionality Limit number of uploaded request is enabled
- When I click button create a new Upload request in LinShare, the system will validate:
- If my total uploaded requests with status: Pending/Active/Close is smaller than value of "Max uploaded request count" (set by domain admin), I can continue creating upload request as normally.
- If my total uploaded requests with status: Pending/Active/Close has reached the value of "Max uploaded request count" (set by domain admin), there will be an error message: "You have reached maximum number of uploaded requests."

#### Postconditions

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)

