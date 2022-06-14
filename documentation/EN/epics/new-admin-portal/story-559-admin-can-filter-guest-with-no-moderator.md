# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

*  Given that I am an admin of LinShare
*  After log-in successfully to Admin portal from the left menu, I click on the option "User"

#### Description

* The screen User list will be opened, and I can see the search bar
* When I click on the search bar, there will be a drop-down list of search criteria [story12](story-12-admin-view-and-search-user-list.md)
* When I select Account type = Guest, there will be a new criteria appearing in the list: "Number of Moderator"
* When I select this search criteria, the search bar will display Number of Moderators = "inputted number". I can only input number as 0,1,2 ... and click Enter, the search tag is completed with a delete icon.
* I click enter the system will search for guests with number of moderators defined.

#### Postconditions

* If I want to filter Guests with no moderator, I input "Number of moderators" = 0 
* In Search bar, If I do not select "Account type" = "Guest", the criteria "Moderator" will not be available.

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
