# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New UI user](./README.md)

## Definition

### Preconditions

- Given that I (the user) already have log-in credentials from the user provider 
- Given that the user provider that contains my account is an external user providers such as openID Connect provider and SSO is configed to login LinShare. 

### Description 

- When I open LinShare UI-User URL of my company, I am redirected to the OIDC provider log-in screen
 I need to inout my log-in credentials including:
   - Login (Email, UPN, ...) depending on the IDP
   - Password
 then click Sign-in
- The  OIDC provider will validate if my email and password are correct or not :
   - If the inputted credendials are incorrect, there will be error message
   - If the inputted credentials are correct, I logged-in successfully in the  OIDC provider. 
- Then the system will redirect me back to the LinShare application.

### Postcondition 

- From my UI-user URL, the system can automatically detect if it is using SSO and redirect me to the SSO log-in page. 
- Once I have successfully authenticated with the user provider, the system should redirect me back to the application.
- The system should create a LinShare user account for me if I do not already have one. 


[Back to Summary](#summary)

## UI Design

### Mockups

### Final design

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)



