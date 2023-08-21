# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

- Given that I am supper admin or domain admin of New Admin Portal

#### Description

After log-in successfully, I go to  Tab Reporting
On this screen I can see the widget Top 50 receivers by agregated shared files size

By default, the filters include:
- Domain: All domains
- Time: All time
- If the user is the root admin by default he can see top 50 receivers of all domains
- If the user is the domain admin by default he can see top 50 receivers of all nested domains

When I click on Filter button, I can see a filter screen
- Domain:
    - If I am root admin, I can select any domain in platform
    - If I am nested admin, I can select any of my nested domains
    - Then the result will be calculated in selected domain.
      Time: I can select one time range then the result will be calculated based on selected time.

- After I select filters Domain/Time then click Enter, there will be a new a table "Top 50 Receivers by aggregated shared file size" with two columns will be displayed accordingly  :
    - Share receiver: Name and email of receiver
    - Domain name (of the receiver)
    - Size of aggregated shared files

#### Postconditions

- Rows should by shared file size in descending order
- Rows should be displayed with pagination

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)



