## Add a "Functionality" on LinShare

    Here are a few steps how to add a "Functionality" to LinShare.

1. **EPIC and Stories:**

 - The first and essential step to make it easier for the developers is to implement an EPIC that describes the functionality and then divide this EPIC into user stories.
The EPIC and stories are featured on the LinShare Github Project ([LinShare_github](https://ci.linagora.com/linagora/lgs/linshare/products/linshare-github/issues))  
Existing example: [Epic and stories](https://ci.linagora.com/linagora/lgs/linshare/products/linshare-github/issues/58)  


2. **The name of the Functionality:**

Add the name of the "Functionality" to the Enum that is `(src / main / java / org / linagora / linshare / core / domain / constants / FunctionalityNames.java)`.

** Note: ** The choice of the name of the Functionality is important because it has to be added to the Enum which contains all the existing functionalities on LinShare.

3. **Declaration:**

 Declaring the method reteiving the desired functionality in the class `org.linagora.linshare.core.service.FunctionalityReadOnlyService`
as follows:
```java
FunctionalityType getYourFunctionalityName(AbstractDomain);
```
The types of existing functionalities are as follows:  
`Functionality`  
`StringValueFunctionality`  
`TimeUnitValueFunctionality`  
`BooleanValueFunctionality`  
`LanguageEnumValueFunctionality`  
`IntegerValueFunctionality`

These types depend on the parameters of the sub "Functionality". For example in addition to the activation of a functionality you can add an expiry time parameter by using TimeUnitValueFunctionality as a type of return.

4. **Addition of the dependency:**  
Add the `FunctionalityReadOnlyService` dependency in the service calling your functionality ``

5. **Add queries to SQL script:**  
To correctly initialize the database with your newly created functionalities, add SQL queries to the file `src/main/resources/sql/common/import-functionalities.sql` according to the following example :

Example:  
- Functionality: JWT_PERMANENT_TOKEN
```SQL
INSERT INTO policy (id, status, default_status, policy, system)
VALUES (290, true, true, 1, false);
INSERT INTO policy (id, status, default_status, policy, system)
VALUES (291, true, true, 1, false);
INSERT INTO functionality (id, system, identifier, policy_activation_id, policy_configuration_id, domain_id, creation_date, date_range)
VALUES (60, true, 'JWT_PERMANENT_TOKEN', 290, 291, 1, now (), now ());
```

> **NB: The value of "id" must be the incrementation of the last key of the table.**

- *status*: enable or disable of the functionality
*  0 in the case of Mandatory
*  1 in the case allowed
*  2 in the forbiden case

> A functionality is defined by  activation policy and a configuraton policy.  
> Activation policy enables or disable the functionality.  
> Configuraton policy inherits and depends on the activation policy it allowed to
add another rule when functionality is activated

- *system*: configure if the policy is editable by the admin ihm (true by default)
In the functionality table:
- *identifier*: key with the name of the functionality this one is the same as the name appearing in the Enum
- *policy_activation_id*: the identifier of the first table policy that corresponds to the simple configuration that enables or disables the functionality completely
- *policy_configuration_id:* the identifier of the 2nd policy table corresponds to a more advanced configuration by adding three parameters (policy).
- *policy_delegation_id:* for the delegation role we need to create a 3rd policy table  to parameter the  curent functionality.

- In order to add a sub-functionality: it is necessary to proceed at the same way except that it is necessary to add the field *parent_identifier* which corresponds to the parent functionality and the field *param* which confirms that functionality is a sub-functionality of relative.  

6.**Migration Script**:  
update the migration script with functionality SQL queries.
Ex: /linshare-core/src/main/resources/sql/postgresql/Migration_2.2.0_to_2.3.0.sql

7.**Test**:  
create the SQL script to load the functionality for testing.
/linshare-core/src/test/resources/import-tests-your-functionality-name.sql
