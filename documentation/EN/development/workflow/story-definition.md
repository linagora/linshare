## Story definition

For any new feature or update on an existing feature, Project Owner and Business Analyst should work together to validate the details of the change of the product.

#### Participants

- Product Owner, Business Analyst, UI Designer
- To be informed: QA department, Engineering Teams

#### Activities

| Outcomes | Activities | Participants |
|----------|------------|--------------|
| **Well defined EPIC** <br/> For any EPIC, there should be one created issue and and another document store in this repository. The content stored in this repository is the single source of truth for any changes to the EPIC | - Create an issue with a label `EPIC::Draft` using the [Epic Template](../../../../.gitlab/issue_templates/epic.md). <br/> - Update the label to `EPIC::Writing` once the EPIC content is finished | Product Owner |
| **A complete list of user stories** <br/> Similarly with EPIC, for any user stories, there are one User Story issue and a document stored in this repository. | These following activities are applied two scenarios: <br/> 1. When defining the user stories of an epic <br/> 2. When a user story requires an update <br/> <br/> - For each user stories, create an issue for it using the [Story template](../../../../.gitlab/issue_templates/story.md), use the label `STORY::Draft` <br/> - Create a merge request to commit all the user stories to this repository <br/> - Participants will then review and make changes on the content of the merge request, any updates must be mirrored in the story issue, use the label `STORY::Writing` <br/> - During this process, UI designer might be involved for any graphic examples <br/> - Once the user stories are ready, screenshots of final design are exported and added to the final docomentation. Finally, the merge request is then merged. <br/> - Update the user story label to `STORY::READY` <br/> - QA department and Engineering team are informed to move on with [development process](./development.md) | Product Owner, Business Analyst, UI Designer |

#### Document storage structure

For every epic, create a folder named similarly with the epic title, words are separated by dashes (f.i: `upload-requests`). Inside the folder, a README.md contains all the basic information of the epic (following [epic template](../../epics/template-epic.md)). For each story of the epic, create a markdown file to describe the story (following [story template](../../epics/template-story.md)). The mardown must be named using following format:

> story-[story number]-[actor]-[an action toward an entity].md

There is also a `resources` folder to store files (images, documents) that are attached in the epic or stories.

Folder structure example:
```
epics
└── upload-requests
    ├── resources
    ├── story-1-user-create-upload-request.md
    ├── story-2-admin-manage-user-upload-requests.md
    └── README.md
```
