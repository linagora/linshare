# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC


## Definition

- Given that I am an LinShare user and my 2FA is already enabled.
- When I open log-in screen, I can see the login form. 
   - I input username and password and click button Login
   - If log-in credentials are not correct, system will display error notification as normal. 
   - If log-in credentials are correct, 2FA popup is displayed. I have to fill the 6-digits code on my FreeOTP app and click button Log-in to validate 
- If the code is valid, I log-in system successfully
- If the code is invalid, the system will display error message. 
- If the authentication is failed for multiple times (code is invalid), the account will be locked by following rules :
   * After 3 attempts : account locked for 10 minutes
   * After 6 attempts : account locked for 20 minutes
   * After 9 attempts : account locked for 60 minutes (1 hour)
   * After 12 attempts : account locked for 1440 minutes (1 day)
   * After 15 attempts : account locked indefinitely


- When account is locked, I can see a message: "Your account has been locked for [locked time] due to failed login attempts"

[Back to Summary](#summary)

## Screenshots

![image](/uploads/a63ab09770191d8f1187270e5fa85cec/image.png)

![image](/uploads/6e1a90dc96917d4ee9cd5e182e3691e0/image.png)

[Back to Summary](#summary)

## Misc

None

[Back to Summary](#summary)

UI Design: https://www.figma.com/file/YaAuajPYpMGHsKyGBePaJ9/Admin-LinShare?node-id=304%3A13106
