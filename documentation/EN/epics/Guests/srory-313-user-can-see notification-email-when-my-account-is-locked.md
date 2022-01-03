# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* EPIC: https://ci.linagora.com/linagora/lgs/linshare/products/linshare-github/issues/266

## Definition

### Pre-condition 

* Given that I am a LinShare user (internal or guest)

### Description

**UC1. As a user, I should receive an email to inform  that my account has been locked**
* Given that I am a LinShare user
* I go to  log-in LinShare page and enter my user  name but wrong password for 3 attempts
* At third time, after entering wrong password, I can see the toast message: “Your account has been locked due to failed attempts. Please check your email for more details”.

   - When I open my email (which is linked with LinShare account), I can see a notification from LinShare that told me the reason why my account has been locked and how long my Linshare account will be locked”

**UC 2. As a user, I should receive an email to inform me that my account has been unlocked**
*  Given that I am a LinShare user and my account has been locked due to failed attempts to log-in
*  My account can be locked for different times:

        *  After 3 attempts : account locked for 10 minutes
        *  After 6 attempts : account locked for 20 minutes 
        *  After 9 attempts : account locked for 60 minutes (1 hour)
        *  After 12 attempts : account locked for 1440 minutes (1 day) 
        *  After 15 attempts : account locked indefinitely

*  There are 2 ways that my account can be unlocked:
    1. After the locked time defined by the rule above,  my account will be unlocked automatically
    2. Admin can unlock a user account manually in admin portal
*  In both case when my account is unlocked, I will receive an email informing that my LinShare account has been unlocked, and a link to LinShare login page.
*  Now in log-in LinShare page, if I enter correct user name and password, I can log-in successfully. If wrong, the system will follow locking rules.

[Back to Summary](#summary)

### Postconditions

## Screenshots

None

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)