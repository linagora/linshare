# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Description

#### 1. Share expiration
**UC1. Admin UI**
- Given that I am an Admin LinShare 
- In Admin portal, I go to Domain => Functionalities => Share expiration 
- I can see there are 2 parameters in Share expiration setting : 
   - Default value: include a text box that only contain number and a dropdown-list with option: day/week/month
   - Max value: include a text box that only contain number and a dropdown-list with option: day/week/month
     - or I can select a checkbox unlimited for max value. 

**UC2. User UI**
* Given that I am a LinShare user and the Functionalities "Share expiration" is enabled in Admin UI
* when i try to share a file in LinShare, on Quick Share screen, I can see the field :" Expiration date"
* If the Delegation policy of Share expiration in Admin is disabled, the value of this field is defined = current date + default value of Share expiration. And user cannot change this value
* If the Delegation policy of Share expiration in Admin is enabled, the value of this field is defined as :
   * The default Share expiry date = current date + Default value of Share Expiration set by Domain Admin
   * The date range is between [Current date] and [current date + max max value]  of Share Expiration set by Domain Admin.

#### 2. Guest Expiration

**UC1. Admin UI**
- Given that I am an Admin LinShare
- In Admin portal, I go to Domain => Functionalities => Guest => Guest expiration
- I can see there are 2 parameters in Share expiration setting :
  - Default value: include a text box that only contain number and a dropdown-list with option: day/week/month
  - Max value: include a text box that only contain number and a dropdown-list with option: day/week/month

**UC2. User UI**
* Given that I am a LinShare user and the Functionalities "Guest" is enabled in Admin UI
* When i create a guest on LinShare, I can see the field Expiration date
* If the Delegation policy of Guest Expiration in Admin is disabled, the value of this field is defined = current date + default value of Guest Expiration. And user cannot change this value
* If the Delegation policy of Guest Expiration in Admin is enabled, when creating a guest, the value of this field is defined as :
    * Default value = current date + default period of Guest Expiration
    * The date range is between [Current date] and [ current date + max value] of Guest Expiration set by domain admin.
* If the function Postpone guest expiry date is disabled, when I edit a guest's expiration date, the date range is  defined as : [ Current date ] and [Creation date + max value] 
* If the function Postpone guest expiry date is enabled, when I edit a guest's expiration date, the date range is defined as : [Current date] and [ current date + max value] 

#### 3. Un-downloaded shared document alert - Days before the alert

**UC1. Admin UI**
- Given that I am an Admin LinShare
- In Admin portal, I go to Domain => Functionalities => Un-downloaded shared document alert => Days before the alert
- I can see there are 2 parameters in Share expiration setting :
  - Default value: include a text box that only contain number 
  - Max value: include a text box that only contain number

**UC2. User UI**
* Given that I am a LinShare user and the Functionalities "Undownloaded shared document alert" is enabled in Admin UI
* When I share a file, I can see the checkbox Expiration date
* If I tick this checkbox, the field Notification of the un-downloaded is displayed that allow me to choose date
* If the Delegation policy of "Un-downloaded shared document alert - Days before the alert" in Admin is enabled, the value of this field is defined as :
   * Default value = current date + default value of days before alert
   * The date range is between [Current date] and [ current date + max value] of Days before alert. If the expiration date is < [ current date + max value], the date range will be between [Current date] and expiration date

[Back to Summary](#summary)

## UI Design

#### Mockups

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



