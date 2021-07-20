# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

* Given that i am super-admin or admin in LinShare 
* I logged-in to Admin portal successfully

#### Description

- I select a domain in Domain tree and go to Configuration tab on top navigation bar
- I click on Mime policies, the screen Mine policies listing list will be opened.

#### Postconditions

- If i am selecting root domain in domain tree, i can see the list of mime policies that i created. They can be used for any lower-level domains.
- If i am selecting a nested domain in the domain tree, i can see the list of mime policies that i created and the mime policies from higher level domain. 
- I can see a tooltip icon on screen name, which i can click on and see the explaination text. 
- The mime policies list includes columns:
   - Name
   - Read-only: True/False. If false, this mime policy is created by the selected domain on tree memu. If true, this mime policy is created by the higher-level domain. 
   - Domain: The name of domain that created the mime policy
   - Creation date
   - Modification date
   - In use: Yes/No. This column indicates which mime policy is used for the current selected domain in the domain tree. Each domain can use only 1 mime policy a time 
   - Action: When i click on three-dot button, i can see actions: 
      - If the selected domain is root domain, the actions are: Duplicate, Edit, Delete. 
      - If the selected domain is a nested domain (top domain/Sub domain/Guest domain), the actions are: Assign, Duplicate, Edit, Delete
      - If the mime policy is currently used, the In use value is Yes, the option "Assign" is disabled. 
- I can sort by columns: Name, Read only, Domain, Creation date, Modification date
- Default sort is last modification date
- I can see a search bar and typing in, the system will search by Mime policy's name and display corresponding result in the table below
- When i click button "Create", the screen Create new mime policy screen will be opened.

[Back to Summary](#summary)

## UI Design

#### Mockups

![story35](./mockups/35.1.png)
![story35](./mockups/35.2.png)
![story35](./mockups/35.3.png)
![story35](./mockups/35.4.png)

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



