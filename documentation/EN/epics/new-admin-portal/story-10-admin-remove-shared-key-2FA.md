# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

*  Given that I am an LinShare admin and my 2FA is enabled 
*  I logged in the admin UI successfully 

#### Description

*  I click on the human head icon in the top right corner 
*  I click 2 factor authentication, I am redirected to [2FA  page]
*  I click button “Remove shared key”, the system will display confirmation popup. 

#### Postconditions

*  If i choose Yes, the system will delete the shared key in LinShare server, the 2 FA is also disabled. 
*  When i log out Admin UI and open log-in screen, i just need to fill my username and password to log-in. It is the same on User UI. 

[Back to Summary](#summary)

## UI Design

#### Mockups
#### Final design

![10.1](./mockups/10.1.png)

![10.2](./mockups/10.2.png)

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
