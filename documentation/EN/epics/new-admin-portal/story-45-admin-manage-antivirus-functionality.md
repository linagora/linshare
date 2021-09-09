# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

#### Preconditions
- Given that am super admin or nested admin of LinShare admin
- After log-in successfully, I go to Configuration Tab
- I click on Parameters, then select Antivirus, the screen setting for this feature will be opened.
#### Description
- On the screen Antivirus, I can see a collapsible legend:"By enabling this functionality, When user uploads a file in LinShare, it will be scanned for the virus before uploading to server. In order to use this functionality, you need first to configure the IP and the port of the antivirus in the linshare.properties configuration file. Tomcat restart is required. We only support ClamAV"
- There is only Activation policy for this function, which includes 2 toggles:
    - Enable functionality: When I click on the icon "i", I can see a collapsible legend: " Once activated, when user upload a file, it will be scanned for virus. If de-activated, the uploaded file will not be scanned."
    - Allow nested admin to override "Enable functionality": When I click on the icon "i", I can see a collapsible legend: " Once activated, nested admin can override the activation for his own domain. When disabled, the value of setting "Enable functionality" is applied for all nested domains and nested admin cannot update"
- The other rules for this function is as same as Activation policy in story 43. Admin manage function Anonymous URL
- Documentation: In order to use this functionality, you need first to configure the IP and the port of the antivirus in the linshare.properties configuration file. Tomcat restart is required. We only support ClamAV.

[Back to Summary](#summary)

## UI Design

#### Mockups
#### Final design

[Back to Summary](#summary)
## Misc

[Back to Summary](#summary)



