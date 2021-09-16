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
- I click on Parameters, then select Guests, the screen setting for this feature will be opened.

#### Description

- There are 5 settings in this screen:
   - "Guests" is the original setting: I can click on the icon "i" to see a collapsible legend :"This functionality allows user to manage Guests. When a guest with an external email is invited by LinShare user, he can use every function of LinShare as an internal user, except that he has an expiration date. When this functionality is not activated, the below sub-functions will not work"
   - And when I click icon "i": next to "Guests", all below legends will be expanded too.
   - 4 Sub-functions include:
      - Enable Myspace 
      - Expiration
      - Postpone guest expiry date
      - Contacts restriction

**Original function: Guests**
- There is only Activation policy, including 2 toggles:
    - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
        - If this toggle is switched on, user of this domain can access to menu Contact => Guests then create guest accounts and manage them. 
        - If the toggle is disabled, user cannot see the menu Contact => Guests in his LinShare account.
    - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
    - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL

**Sub-function 1. Enable Myspace**
- When the original function - Guests is enabled, this sub-function is also enabled by default and cannot be changed. 
- When I can click on the icon "i" next to "Enable Myspace", I see a collapsible legend: "This function allows user to choose if his guests can use Myspace or not"
- There are 2 policies and 1 parameter:   
   - Configuration policy: Includes 2 toggles:
      - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
         - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
      - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
         - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
   - Delegation policy: Includes 2 toggles:
      - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
         - If the toggle is on, when user creates guest account, he can tick/un-tick the checkbox :"Activate user space".
         - If the toggle is off, end user cannot change the value of checkbox "Activate user space". The value of checkbox depends on default parameter.
      - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
         - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
   - Default parameter: a checkbox 
      - When I click on icon "i",  I can see a collapsible legend: "User will see a checkbox "Activate user " on Guest creation form. This setting decides how to show the default value of this checkbox"
      - If the checkbox is selected, the text displays "The guest can use Myspace." Which means guest account can see and upload file in Myspace in LinShare
      - If the checkbox is not selected, the texts displays "The guest cannot use Myspace." Which means My space will be hidden on that guest account. 

**Sub-function 2. Expiration**
- When the original function - Guests is enabled, this sub-function is also enabled by default and cannot be changed.
- When I can click on the icon "i" next to "Expiration", I see a collapsible legend: "This function allows user to set the expiration date for his guest account"
- There are 2 policies and 1 parameter:
    - Configuration policy: Includes 2 toggles:
        - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
            - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
        - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
            - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
    - Delegation policy: Includes 2 toggles:
        - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
            - If the toggle is on, when user creates guest account, he can change the value of field Expiration date. 
            - If the toggle is off, user cannot change the value of field Expiration date. The expiration date depends on default parameter.
        - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
            - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
    - Default parameter: 
        - When I click on icon "i",  I can see a collapsible legend:"User will see the field "Expiration date" on Guest creation form. The default expiration date is calculated as current date + default value. The date range is defined as:
           - At creation time: between [Current date] and [ current date + max value] .
           - At update time: The date range is between [Current date] and [ creation date + max value]"
        - The parameter include 2 fields:
          - Default value: A text field that only accepts number with a drop-down list contains options: Month, week, day.
          - Max value: A text field that only accepts number with a drop-down list contains options: Month, week, day.
             
**Sub-function 3. Postpone guest expiry date**
- When I can click on the icon "i" next to "Postpone guest expiry date", I see a collapsible legend:" This functionality allows internal users to edit and postpone the expiry date of a guest"
- There is only Activation policy, including 2 toggles:
    - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
        - If this toggle is switched on, When user edit a guest's information, he can see the date range of expiration date is between [current date] and [current date + max value of expiration parameter]. Therefore, the user can extend guest's expiry date since the max expiry date is now calculated by current date, not creation date.
        - If the toggle is disabled, When user edit a guest's information, he can see the date range of expiration date as defined in sub-function Expiration above
    - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
       - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL

**Sub-function 4.  Contacts restriction**
- When I can click on the icon "i" next to "Contacts restriction", I see a collapsible legend:"You can restrict guests to share only with a restricted and personal list of emails. By default, the guest will be restricted to his owner."
- There are 3 policies and 1 parameter:
   - Activation policy includes 2 toggles:
      - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
         - If this toggle is switched on, When user creates a new guest, he can see a checkbox "Restrict contact list" in Advanced options. 
         - If the toggle is disabled, When user creates a new guest, he cannot see the checkbox. 
       - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
         - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL 
   - Configuration policy includes 2 toggles:
       - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
           - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
       - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
           - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
   - Delegation policy includes 2 toggles:
       - Allow user to change default parameter:  When I click on the icon "i", I can see a collapsible legend:
           - If the toggle is on, when user creates guest account, he can select/un-select the checkbox "Restrict contact list". 
           - If the toggle is off, user cannot change value of this checkbox. The checkbox value depends on the default parameter below. 
       - Allow nested admin to override Delegation:  When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Allow user to change default parameter" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
           - The rule is as same as toggle (3.2) in story 43. Admin manage function anonymous URL
   - Parameter: A checkbox
      - When I click on the icon "i", I can see a collapsible legend:" This parameter will decide the default value of the checkbox "Restrict contact list" on Advanced option of guest creation form"
         - If the checkbox is selected, the text displays: "The guest will be restricted to a list of emails." In Guest creation form, the checkbox "Restrict contact list" will be selected and the guest owner will be added to this list by default. User can add/remove people to this list.
         - If the checkbox is selected, the text displays: "The guest will not be restricted.". The checkbox "Restricted contact list" in guest creation form is un-selected by default.
   
#### Post-conditions

The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



