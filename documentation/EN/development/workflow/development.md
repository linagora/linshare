# Development

## Participants

- Engineering Teams (Frontend, Backend), QA Department

## Glossary

- PO: Product Owner
- Back team:   Backend developers team.        See @teamss/linshare/back
- Front team:  Frontend developers team.       See @teamss/linshare/front
- Engineering team: Aka Dev team. Both backend and frontend team. See @teamss/linshare/dev
- QA team:     Quality assurance team.         See @teamss/linshare/qa


## Outcome and activities

| Outcomes | Activities | Participants |
|----------|------------|--------------|
| **A prioritized technical backlog** <br/> From the Product Owner, Engineering Team should be aware of the prioritized topics for the development process | - From the list of user stories with the label `STORY::READY`, a series of technical issues are established. all developers must subscribe to this label to get updates. <br/> - Technical issues must be linked with corresponding Story issues, `Development:xxx` labels must be added to the story to identify the needs. (Refer to [Development labels](##development-labels)) <br/> - `BACKEND:xxx` and/org`FRONTEND:xxx` labels must also be added to materialize the progress of this achievement. (Refer to [Development state labels](##development-state-labels)). Frontend developers should subscribe to `BACKEND:READY` label to get updates.  <br/> - After a user story is implemented, update the story issue label to `STORY::IMPLEMENTED` <br/> - Notify the QA department to start testing process | Engineering Team (specifically current Scrum Master or Lead Developer) |
| **A series of test criteria** <br/> These activities are commenced right when user stories are finished | - For each user stories, QA personnel in charge at the moment will create a series of test critera | QA Department |
| **Stable feature, ready for release** <br/> These activities start after a feature is implemented from Engineering Team | - In case of any issue regarding the implemented user story, QA personnel will create an issue in linshare-qa repository. <br/> - Issues must be well defined, using provided template, labelled accordingly. (Refer to [Severity labels](##severity-labels)) <br/> - Dev team  will analyze the issue in QA board and add one state label (Refer to [State labels](##state-labels)), and then, if needed, create technical issues in the related repository <br/> - Dev team will update the QA issue according to the related component, f.i backend issue with `DEVELOPMENT::core`, frontend web app with `DEVELOPMENT::ui`, <br/> - Then the PO must define the priority and the target of the issue, ie in which versions this issue must be fixed, <br/> - Once the technical issues are handled, developers must update the QA issue status to `To Do` <br/> - When the issue is fixed or implemented, satisfying the definition of done. QA personnel will then close the issue | Engineering Team, QA Department |


> At the first daily of the week, each week, two members of the Dev team, one front, one back, will be chosen to review the QA board and analyse issues.

## Development rules

* Once the technical issue is created, severity, priority and target labels must be set according to the QA issue (if they are defined)
* For each merge request, we must set the milestone field according to the release, ex "LinShare release 4.1.3" or "LinShare release 4.0.4".
* Once the QA issues have been reviewed and technical issues created, dev team must assign the QA issue to the PO, then he will be able to set TARGET and PRIORITY labels.


## Releases

### Milestones and labels

Before planning a new release for a component, a new "LinShare release x.y.z" milesone must be created as long as its related TARGET label.
For the version 4.1.3, we must create the label TARGET:4.1.3 and the milestone "LinShare release 4.1.3".

Once a component is released, all closed issues marked with the label TARGET:4.1.3 must be updated with the milestone "LinShare release 4.1.3".
 

Once the sprint is completed, the PO updates the milestone field with "LinShare release" milestone according to the higher target label. ie: if an issue has the target 4.0.4 and 4.1.3, the milestone value will be "LinShare release 4.1.3".


## Annexes

#### Severity labels

| Severity label | Description |
|----------------|-------------|
| Severity::Critical | This defect indicates complete shut-down of the application, nothing can proceed further |
| Severity::Major | It is a highly severe defect and collapses the system. However, certain parts of the system remain functional |
| Severity::Medium | It causes some undesirable behavior, but the application is still functional |
| Severity::Minor | It won't cause any major break-down of the application |

> Labels handle by the QA team

#### State labels

| State label | Description |
|----------------|-------------|
| STATE::CONFIRMED | This issue is confirmed and need to be fixed.|
| STATE::PENDING | This issue is not yet confirmed, it may be a false positive, a missing feature, a corner case, same data are needed to pursuit the investigation. |
| STATE::REJECTED | This isn't a bug, it could be a false positive, a feature or a corner case that we won't handle. |

> Labels handle by the Dev team

#### Priority labels

| Priority label | Description |
|----------------|-------------|
| Priority::Urgent | This issue must be handled right now.|
| Priority::High | This issue must be handled by the end of the current sprint or at the begining of next one. |
| Priority::Medium | This issue should be handled when we have spare time, when the sprint finishes earlier than planned.|
| Priority::Low | This issue can be handled by for say newcommers, as a way to discover LinShare without pressure. |

> Labels handle by the PO


#### Development labels

| Development label | Description |
|----------------|-------------|
| Development::Core | This issue has an impact on backend components.|
| Development::UI | This issue has an impact on the frontend components. |

> Labels handle by the Dev team, they must be added once tech issues are created.



#### Development state labels

| Development state label | Description |
|----------------|-------------|
| BACKEND::TODO  | Tech issues were created, waiting to be implemented. |
| BACKEND::READY  | Tech issues were created and implemented. |
| FRONTEND::TODO  | Tech issues were created, waiting to be implemented. |
| FRONTEND::READY  | Tech issues were created and implemented. |


> Labels handle by the Dev team, they must be added once tech issues are created/implemented.

