# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

* Given that I am root admin or nested admin of LinShare
* I log-in successfully to Admin portal

#### Description

- I click on Configuration tab:
- On this page, I can see the list of domains:
- If I am root admin, I can see every domain in the whole platform
- If I am nested admin, I can see my own domain and nested domain (if any)
- I can open/expand the domain list to see nested domains
- In each domain, I can see a three-dot button that when I click on, there are options:
    - View domain detail
    - Create a child domain: Only root admin can see this option.
    - Settings
- When I select option "View domain detail", the Detail screen of that selected domain is opened. I can edit as currently
- When I select option "Settings", I can see a list of setting items including:
   - Domain detail 
   - Parameters (Aka Functionalities)
   - Mine type policies
   - Welcome messages 
   - Quota 
   - Public key (JWT)
- I can select one item on the list and continue setting as currently.
- On each setting screen, I can see a button Next and Previous and when I click on this button, I am navigated to this setting of next/previous sibling domain (domain at same level).
- On the breadcrumb, I can see the full path of current domain. I can select a parent/child domain in the breadcrumb. 
- Eg: If I am in currently on a setting screen, e.g Parameters of a sub-domain A1 , then I click button :"Next", then I am navigated to the Parameters setting screen of sub-domain A2.  Or in breadcrumb, I can select it's top domain A or root domain (if I am root admin).

#### Postconditions

[Back to Summary](#summary)

## UI Design

#### Mockups


#### Final design


[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
