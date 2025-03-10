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

- There are 6 settings in this screen:
    - "Guests" is the original setting 
    - 5 Sub-functions include:
        - Enable Myspace 
        - Expiration
        - Postpone guest expiry date
        - Contacts restriction
        - Moderators

Refer to [story51](story-51-admin-manage-function-guest.md)

**Sub-function 5. Moderators request**

- When I can click on the icon "i" next to "Moderators request", I see a collapsible legend: "This functionality allows users to delegate administration rights of his guest to other users. A user will be able to promote another user as:
   - Simple moderator of guest: edition of guest's properties
   - Admin moderator: edition of guest's properties and managing other moderators.
   - The author of a guest, is by default added as his admin moderator.
   - When a user is not a moderator of a guest, he can only view guest's detail information (guest reader)"

- There are 2 policies and 1 parameter:

- Activation policy includes 2 toggles:
    - Enable functionality: When I click on the icon "i", I can see a collapsible legend:
        - If this toggle is switched on:
           - When user create or edit a guest, he can see a field :" Moderators list". He can add other people to this list with role Admin or Simple. The guest's author is automatically added as admin moderator.
        - If this toggle is switched off:
           - When user create a guest, he cannot see the field:"Moderators list". The guest's author automatically has admin moderator role.
           - When user edit a guest: he cannot see the field:"Moderators list". The moderator list before switch off will be hidden. Now only guest's author has admin moderator role to that guest. If the toggle is switched on again, the moderator list before will be added too. 
    - Allow nested admin to override "Enable functionality": Toggle. When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the setting "Enable  functionality" for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
        - The rule is as same as toggle (1.2) in story 43. Admin manage function anonymous URL

- Configuration policy includes 2 toggles:
    - Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
        - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
    - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
        - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
        
- Parameter: A checkbox:
   - If the checkbox is selected, the text displays: "Users are allowed to ask current admin moderators to be promoted moderators."
     - A user with read-right can create request to become simple moderator of that guest. A Guest's simple moderator can send request to become admin moderator of that guest. Then requester can track the status of his request in Activities task and detail panel of the guest. Guest's admin moderator can manage (approve or deny) all the pending requests in tab "Pending request" of that guest
   - If the checkbox is selected, the text displays: " Users are not allowed to ask current admin moderators to be promoted moderators. (Moderator requests are disabled.)"
      - The option "Ask for moderator right" on guest list screen and the tab "Pending request" in Guest detail panel will be hidden. User cannot create moderator request and guest admin cannot see the pending request list.
    
#### Post-conditions

The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



