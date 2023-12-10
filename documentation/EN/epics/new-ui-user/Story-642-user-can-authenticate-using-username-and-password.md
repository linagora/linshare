# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New UI user](./README.md)

## Definition

### Preconditions

- Given that I (the user) already have LinShare log-in credentials from the user provider (LDAP)

### Description 

- When I open LinShare UI-User URL of my company, I can see a log-in screen:
- The log-in screen includes fields: 
   - Email: A text field and mandatory 
   - Password: A text field and mandatory 
   - Keep me Signed-in: A checkbox
   - Forgot password: A link 
- After input fields, I click Log-in button, the system will validate:
   - If field email or password is blank, there will be an error message: This field cannot be blank 
   - If email format is invalid, there will be an error message: Invalid email format 
   - IF the email or password is incorrect, there will be an error message: Authentication failed, either the email or the password is invalid
- If there is no error, I am logged-in successfully to LinShare 

### Postcondition 

- If I input correct log-in credentials, I am logged in and  redirected to LinShare homepage. 
- The system should create a LinShare user account for me if I do not already have one. 


[Back to Summary](#summary)

## UI Design

### Mockups

![image.png](./image.png)

### Final design

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)




