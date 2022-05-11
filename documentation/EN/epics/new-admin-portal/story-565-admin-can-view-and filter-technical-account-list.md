# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

* Given that I am root admin of Linshare
* After log-in successfully to Admin portal, I select menu Administration => Technical account 
* The screen listing technical accounts will be displayed 

#### Description

*  In The screen Technical account  list, I can see:
    * Information tooltip: When I click on the icon information, a page description will be shown, then I click on the icon again, the description will be collapsed.
    * Technical account list including:
        * User icon
        * Name 
        * Email 
        * Status: Enabled or disabled
        * Role: Currently there is only 1 role : Delegation 
* A search bar
* A sort field

#### Postconditions

* When I click on the search bar, there will be a drop-down list of search criteria including:
    * Status: When select this search citeria, the search bar will display: Status = "dropdown list" The options are: Enabled/Disabled. I select one status, the search tag is completed with a delete icon.Then I click enter the system will search technical account which have selected status.
    * Name: When I select this search citeria, the search bar will display: Name contains = "text input". I click Enter, the search tag is completed and an icon Delete. Then I click enter the system will search technocal accounts which have field Name contains text inputted.
    * Identifier: When I select this search citeria, the search bar will display: Id = "text input". I click Enter, the search tag is completed and an icon Delete. Then I click enter the system will search technical accounts which have id contains  inputted text. 
* When I start typing on search bar, the system will show default search criteria is email 
- I can search technical account by one of above criteria or combine them
- Each search criteria in the search bar is seperated by a delete icon. I can click this icon to delete the criteria
- After select one criteria in search bar, that option is hidden in the dropdown list of search criteria.
* When I click on Sort field, there will be drop-down list containing sort criteria: Name, Email, Creation date, Modification date.
* I can select sort criteria from the list and use the arrow up and down to change order of sorting.
* The default number of displayed items is 25, I can change the number of items at the bottom of page.

[Back to Summary](#summary)

## UI Design

#### Mockups

![story565](./mockups/565.1.png)


#### Final design


[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
