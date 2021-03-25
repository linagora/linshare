## Development

#### Participants

- Engineering Teams (Frontend, Backend), QA Department

#### Outcome and activities

| Outcomes | Activities | Participants |
|----------|------------|--------------|
| **A prioritized technical backlog** <br/> From the Product Owner, Engineering Team should be aware of the prioritizeds topic for the development process | - From the list of user stories, A series of technical issues are established <br/> - Technical issues must be linked with corresponding Story issues <br/> - After a user story is implemented, update the story issue label to `STORY::Implemented` <br/> - Notify the QA department to start testing process | Engineering Team (specifically current Scrum Master or Lead Developer) |
| **A series of test criteria** <br/> These activities are commenced right when user stories are finished | - For each user stories, QA personnel in charge at the moment will create a series of test critera | QA Department |
| **Stable feature, ready for release** <br/> These activities start after a feature is implemented from Engineering Team | - In case of any issue regarding the implemented user story, QA personnel will create an issue in linshare-qa repository. <br/> - Issues must be well defined, using provided template, labelled accordingly. (Refer to [Severity labels](##severity-labels)) <br/> - Engineering teams then will analyze the issue in QA board, create technical issues in the related repository <br/> - Update the label of QA issue according to the related component, f.i backend issue with `DEVELOPMENT::core`, frontend web app with `DEVELOPMENT::ui` <br/> - After the final technical issues are handled for a QA issue, update the QA issue status to `To Do` <br/> - When the issue is fixed or implemented, satisfying the definition of done. QA personnel will then close the issue | Engineering Team, QA Department |


#### Severity labels

| Severity label | Description |
|----------------|-------------|
| Severity::Critical | This defect indicates complete shut-down of the application, nothing can proceed further |
| Severity::Major | It is a highly severe defect and collapses the system. However, certain parts of the system remain functional |
| Severity::Medium | It causes some undesirable behavior, but the application is still functional |
| Severity::Minor | It won't cause any major break-down of the application |


#### Priority labels

| Priority label | Description |
|----------------|-------------|
| Priority::Urgent | This issue must be handled right now.|
| Priority::High | This issue must be handled by the end of the current sprint or at the begining of next one. |
| Priority::Medium | This issue should be handled when we have spare time, when the sprint finishes earlier than planned.|
| Priority::Low | This issue can be handled by for say newcommers, as a way to discover LinShare without pressure. |
