# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

* Given that i am super-admin or nested admin in LinShare 
* I logged-in to Admin portal successfully

#### Description

- I go to Configuration tab on top navigation bar
- I click on Welcome messages, the screen welcome messages listing list will be opened.

**UC1.Super-admin view the list of welcome messages**
- If i am selecting root domain in domain tree, i can see the list of welcome messages that i created. They can be used for any lower-level domains.
- If i am selecting a nested domain in the domain tree, i can see the list of welcome messages that created by that domain and the welcome messages from higher level domain. 
- I can see a tooltip icon on screen name, which i can click on and see the explaination text. 
- The welcome messages list includes columns:
   - Name
   - Read-only: True/False. If false, this welcome message is created by the selected domain on tree memu. If true, this welcome message is created by the higher-level domain. 
   - Domain: The name of domain that created the welcome message
   - Creation date
   - Modification date
   - Assigned: Yes/No. This column indicates which welcome message is used for the current selected domain in the domain tree. Each domain can use only 1 welcome message a time 
   - Action: When i click on three-dot button, i can see actions: 
      - If the selected domain is root domain, the actions are: Duplicate, Edit, Delete. 
      - If the selected domain is a nested domain (top domain/Sub domain/Guest domain), the actions are: Assign, Duplicate, Edit, Delete
      - If the welcome message is currently used, the option "Assign" is disabled. 

**UC2. Nested admin view the list of welcome messages**
   - I can see the list of welcome messages that created for selected domain, which can be used for lower-level domain, and welcome messages from higher-level domain. 
   - The welcome messages list includes columns:
      - Name
      - Read-only: True/False. If false, this welcome message is created by the selected domain on tree memu. If true, this welcome message is created by the higher-level domain. 
      - Domain: The name of domain that created the welcome message
      - Creation date
      - Modification date
      - Assigned: Yes/No. This column indicates which welcome message is used for the current selected domain in the domain tree. Each domain can use only 1 welcome message a time 
   - Action: When i click on three-dot button, i can see actions: 
      - If the welcome message is from my higher-level domain (eg: i am admin of Top domain and the welcome message is from Root domain), i can see the action: Assign, Duplicate, View
      - If the welcome message is from my domain or lower-level domain, i can see the action: Assign, Duplicate, Edit, Delete

#### Postconditions

- I can sort by columns: Name, Read only, Domain, Creation date, Modification date
- Default sort is last modification date
- I can see a search bar and typing in, the system will search by welcome message's name and display corresponding result in the table below
- When i click button "Create", the screen Create new welcome message screen will be opened.
- If i log-in as nested admin, i can only see the domain tree that contains only my nested domain and see the welcome message list of my nested domain
[Back to Summary](#summary)

## UI Design

#### Mockups

![story37](./mockups/37.1.png)
![story37](./mockups/37.2.png)
![story37](./mockups/37.3.png)
![story37](./mockups/37.4.png)
![story37](./mockups/37.5.png)

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



