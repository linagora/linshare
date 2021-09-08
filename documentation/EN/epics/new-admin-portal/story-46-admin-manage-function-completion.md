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
- I click on Parameters, then select Completion, the screen setting for this feature will be opened.
#### Description
- On the screen Completion, i can see a collapsible legend:"When user types in fields to add people, a suggestion list will appear base on inputted characters. The number of characters is defined in the Default parameter field below."
- This function is enabled by default and admin cannot disable it.
- There is only Configuration policy for this function, which includes 2 toggles:
   -  Configure functionality: Allow nested admin to change the default parameter. When I click on the icon "i", I can see a collapsible legend: "By enabling, you allow your nested domain admin to change default parameter field in his domain".
      - The rule is as same as toggle (2.1) in story 43. Admin manage function anonymous URL
   - Allow nested to override "Configure functionality": When I click on the icon "i", I can see a collapsible legend:"By enabling, nested admin can re-enable the Configure functionality toggle and then change the default parameter"
      - The rule is as same as toggle (2.2) in story 43. Admin manage function anonymous URL
- Default parameter: a text field. 
   - When I click on icon "i",  I can see a collapsible legend: "Number of input characters. Base on these characters, system will search for the matched users and display in suggestion list"
   - I can only input number in this field.
#### Post-conditions
The rule is as same as Post-condition of Story 43. Admin manage function anonymous URL.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



