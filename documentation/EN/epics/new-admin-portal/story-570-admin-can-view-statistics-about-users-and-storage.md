# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

- Given that am super admin or nested admin of LinShare
- After log-in successfully, I go to  Tab Reporting
- A new page will be opened.

#### Description

- On this screen, I can see:

**UC1**

- Total numbers of users: 
   - If I am root admin, and filter Domain I select "All domain", I can see total number of users of whole platform
   - If I am nested admin,and filter Domain I select "All domain", I can see total number of users of my domain and my nested domain (if any)
   -  When I select a domain in the filter, the screen will display number of users in selected Domain
- Number of guests:
  - If I am root admin,and filter Domain I select "All domain" I can see total number of guests of all domains
  - If I am nested admin, and filter Domain I select "All domain", I can see total number of guests of my domain and my nested domains
- Currently, all guests under a top domain are stored in a dedicated domain, no matter what sub-domain created the guest account. In this screen:
   - When I select a TOP domain in the filter, the guest number = created guests from this TOP domain
   - When I select a SUB domain in the filter, the guest number = created guests from this SUB domain
   - When I select a guest domain in the filter, the number of guests = Total guest in this domain = total of guest of all SUB domains under that top domain, adn the top domain itself;
  
     For e.g: TOP domain A has 1 guest domain and 2 sub domains A1 and A2.
      - If I select Top domain A in filter, the guest number = Guest created from Top domain A domain A1 + Guest created from A2 = Guest number in guest domain
      - If I select sub-domain A1 in filter, the guest number = Guest created from domain A1
      - If I select sub- domain A2 in filter the guest number = guest created from domain A2
      - If I select Guest domain under Top domain A, the guest number = Total guests = Guest created from Top domain A+ Guests created from sub-domain A1 + Guest created from sub-domain A2

**UC2**

- I can see a list of top 100 of users by their used quota
- In this list, I can see information:
   - The order: Base on user'used storage 
   - User's name
   - Email
   - Domain 
   - Storage used of the user/current quota
   
- If in filter Domain I select "All domain":
   - If I am root domain, this top 100 users list by their used quota will be calculated on whole platform 
   - If I am nested domain, this top 100 users list by their used quota will be calculated on my domain and my nested domains 

- If in filter Domain I select a domain, this top 100 users list by their used quota will be calculated on selected domain

#### Post-conditions

  [Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



