# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [Screenshots](#screenshots)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions

* Given that i am super-admin in Linshare 
* I logged-in to Amin portal successfully
* On Domain tree, i select a domain. 
* I go to Configuartion tab on top navigation bar and select Details, the screen Domain Detail of current selected domain on domain tree will be disppayed.

#### Description

* On Details page of top domain/guest domain/sup domain, i can see a Delete button
* I click Delete, there will be a confirmation message: "You are about to delete this domain, this procedure is irreversible and destroy all associated users. Do you want to proceed?" and Yes/No button
* If i choose Yes, the system will validate:
   * If the domain is top domain and has no Sub domain or guest domain, the deletion is executed 
   * If the domain is top domain and there is any sub domain/guest domain, the system will display message: "Please remove all sub-domains and guest-domain of this Top domain then you can delete this Top domain" 
   * If the domain is sub-domain or guest domain, the deletion is executed. 

#### Postconditions

* When a domain is deleted succesfully, there will be a toast message to notice the deletion.
* The deleted domain is removed from the domain tree. 
* I will be navigated to the Details page of root domain Details page
* Note: Only root domain see the Delete button. 

[Back to Summary](#summary)

## UI Design

#### Mockups

![story19](./mockups/19.1.png)

#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)
