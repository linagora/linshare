# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [Desktop synchronization client](./README.md)

## Definition

#### Preconditions

- Given that I have installed LinShare desktop app in my computer

#### Description

**UC1. Sign up to LinShare SAAS**

- After I finished the installation, the screen Sign up/log-in LinShare desktop app will be opened automatically, or I can search LinShare app on the computer and open it
- On the screen, I can see options Create an account/Login/Use your own server
- I select option :"Create account", then a new screen will be shown
- I input email and click button to continue:
   - If the email is invalid, there will be an error message
   - If the email is valid, a new screen will be displayed
- I input fields "Name" and "Surname" (mandatory), then click button Send me a password:
   - If there is any error, there will be a notification with option "Sign-up again" or Contact technical. 
   - If there is no error, an email with password will be sent to the inputted email and the confirmation screen will be shown with text message "A password has been sent to your email [inputted email], check your email and continue login" and a button "Continue"
   - I click on button :"Continue" the screen Log-in LinShare SAAS will be opened.
- When I open email, I can see a password and a verification link. I click on the link then the account is activated and I can start using LinShare SAAS with the provided password

**UC2: Log-in to LinShare SAAS**

- Given that I had an LinShare SAAS account 
- On the screen, I can see options Create an account/Login/Use your own server, I select option :"Log in"
- The browser will be opened with OIDC log-in screen:
   - I input my SSO account credentials, then the OIDC provider will validate.
   - If the information is valid, I will log-in successfully to the LinShare app

**UC3. Log-in to self-hosted server**

- On the screen, I can see options Create an account/Login/Use your own server, I select option :"User your own server"
- A new screen will be displayed that asking me to input server link and a checkbox:" My server is using a SSO"
- I input my server URL
- If I do not select the checkbox and click button Log-in
   - If the server URL is valid, a new screen will be displayed 
   - I input username and password to login: The log-in process is as normal
   - I can select a button "Forgotten password". If I click on this button, I am re-direct to a web-link to reset password. 
   - If 2FA is enabled:
      - If log-in credentials are correct, 2FA popup is displayed. I have to fill the 6-digits code on my FreeOTP app and click button Log-in to validate 
      - If the code is valid, I log-in system successfully
      - If the code is invalid, the system will display error message.

- If I select checkbox "My server is using a SSO" then click button Log-in:
   - If the server URL is valid, the browser will be opened with OIDC log-in screen
   - I input my SSO account credentials, then the OIDC provider will validate.
   - If the information is valid, I will log-in successfully to the LinShare app

#### Postconditions


[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)



