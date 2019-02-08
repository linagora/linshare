# How to use file versioning

## Overview
* [Introduction](#introduction)
* [1. Definition](#1-definition)
* [2. Rules](#2-rules)
* [3. Behavior of operations on files with Versioning](#3-behavior-of-operations-on-files-with-versioning)
* [4. Test the API](#4-test-the-api)

### Introduction
The new LinShare version implements a file versioning feature in workgroups. This new feature will give a better collaborative experience for users, The primary purpose of file versioning is to track changes between version (also called revisions) of a file.


### 1. Definition
Versioning allows to have a several files versions at the same time in a workgroup, in this way user can retain multiple versions of a single file. Any files with the exact same file name  will automatically be saved as the latest version when it's uploaded in the workgroup. Versioning ensures that no changes will be lost between updates or edits, and that any user may view the available file versions for a given file.
All applied operations on files can be done with files versions as , copy, delete  and download, the behavior of those operations is explained in the table below.

### 2. Rules
* The versioning feature is only implemented in shared spaces, not in personal spaces.  
* Only files will support versioning, not folders.
* File revisions can be managed as a simple files.
* Versioning can be activated/deactivated in a workgroup.
* There is no limit to a revision number or mime type.
* Any workgroup member can see the revisions on the workgroup.


### 3. Behavior of operations on files with versioning

>**Prerequisites:** When a user uploads a file in a workgroup a document is created and is initialized with it as first revision

| Operation                                                              | Location                                                                | Behavior                                                                                                                                                                                                  |
|------------------------------------------------------------------------|-------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Upload a file having same name with file destination                   | file system => workgroup/folder                                         | curent file is automatically  transformed into a revision of the existing document                                                                                                                        |
| Merge an existing document as a revision of anotherr existing document | document in a workgroup/folder => document in the same workgroup/folder | The document source is converted to a revision                                                                                                                                                            |
| Duplicate a file/file revision                                         | In the same workgroup/folder                                            | a new document renamed is created from the most recent revision of document source                                                                                                                        |
| Copy a file/file revision                                              | workgroup/folder => workgroup/folder/personal space                     | a new document renamed is created from the most recent revision of document source                                                                                                                        |
| Delete a file                                                          | workgroup/folder                                                        | The document and its all revisions will be deleted                                                                                                                                                        |
| Delete one/all file revisions                                          | workgroup/folder                                                        | The revision is deleted, note that if the most recent file revision has been deleted, the penultimate file revision is restored as current version. the file modification date is updated to present date |
| Restore a revision                                                     | worgroup/folder                                                         | Take a past version of the file and apply it as last version                                                                                                                                              |
| download a file                                                        | workgroup => to file system                                             | The most recent file revision will be downloaded                                                                                                                                                          |

### 4. Test the API

1. Create a document revision in a shared space:  

a. When user Uploads a document in a workgroup a document revision is created automatically.  
```
curl -X POST \
http://0.0.0.0:30000/linshare/webservice/rest/user/v2/work_groups/{workGroupUuid}/nodes \ -F file=@/{full_path}/{fileName} -u "{email}:{password}"
```
b. When a user uploads a file with the same name as an existing document in the workgroup, a revision is added to this document.
```
curl -X POST \
http://0.0.0.0:30000/linshare/webservice/rest/user/v2/work_groups/{workGroupUuid}/nodes \ -F file=@/{full_path}/{fileName} -u "{email}:{password}"
```
2. Restore a revion:
This operation allows the user to make an old revision as the most recent one.
```
curl -X POST \
  http://127.0.0.1:30000/linshare/webservice/rest/user/v2/work_groups/{workGroupUuid}/nodes/{documentParentUuid}/copy \
  -d '{
	 "kind" : "SHARED_SPACE",
	 "uuid" : "{documentRevisionUuid}"
}'
-u "{email}:{password}"

{workGroupUuid} => uuid of the  workgroup destination.
{documentParentUuid} => uuid of the document parent uuid.
{documentRevisionUuid} => The uuid of document revision source to restore.
```
3. Duplicate a document:  
Duplicating a document creates a new document based on the latest revision of the source document. The name of the new document will be different from the source file and provided by (user or system)

```
curl -X POST \
  http://127.0.0.1:30000/linshare/webservice/rest/user/v2/work_groups/{workGroupUuid}/nodes/copy \
  -d '{
	 "kind" : "SHARED_SPACE",
	 "uuid" : "{workgroupDocumentUuid}"
}'
-u "{email}:{password}"

{workgroupDocumentUuid} => The uuid of document source to duplicate.
```

4. Copy a revision:

Copy a document revision in another location  :

```
curl -X POST \
  http://127.0.0.1:30000/linshare/webservice/rest/user/v2/work_groups/{workGroupUuid}/nodes/{workGroupNodeParentUuid}/copy \
  -d '{
	 "kind" : "SHARED_SPACE",
	 "uuid" : "{documentRevisionUuid}"
}'
-u "{email}:{password}"

{workGroupUuid} => uuid of the  workgroup destination.
{workGroupNodeParentUuid} => uuid of the node destination.
{documentRevisionUuid} => The uuid of revision source to copy.
```
5. Download a document revision  
When downloading a document, the **most recent revision** is downloaded.

```
curl -X GET \
  http://127.0.0.1:30000/linshare/webservice/rest/user/v2/work_groups/{workGroupUuid}/nodes/{documentParentUuid}/download
```
> NB: You can also download an older revision.

6. Delete a document:  
Deleting a document will delete all its revisions.

```
curl -X DELETE \
  http://127.0.0.1:30000/linshare/webservice/rest/user/v2/work_groups/{workGroupUuid}/nodes/{workgroupDocumentUuid}
```
7. Delete a revision:

```
curl -X DELETE \
  http://127.0.0.1:30000/linshare/webservice/rest/user/v2/work_groups/{workGroupUuid}/nodes/{workgroupDocumentRevisionUuid}
```
