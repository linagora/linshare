# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

*  Given that I am an domain admin and my 2FA is already enabled.

#### Description

*  When I open log-in screen, I can see the login form. 
*  I input username and password and click button Login
*  If log-in credentials are not correct, system will display error notification as normal. 
*  If log-in credentials are correct, 2FA popup is displayed. I have to fill the 6-digits code on my FreeOTP app and click button Log-in to validate.

#### Postconditions

   *  If the code is valid, I log-in system successfully
   *  If the code is invalid, the system will display error message. 

[Back to Summary](#summary)

## UI Design

#### Mockups
#### Final design

![9.1](.mockups/9.1.png)

![9.2](.mockups/9.2.png)

![9.3](.mockups/9.3.png)

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
