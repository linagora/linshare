# How to use file versioning

## Overview
* [Introduction](#introduction)
* [1. Definition](#1-definition)
* [2. Rules](#2-rules)
* [3. Behavior of operations on files with Versioning](#3-behavior-of-operations-on-files-with-versioning)
* [4. Test the API](#4-test-the-api)

### Introduction
LinShare on its new  version implements a file versioning, this new feature will give a better collaborative experience for users, The main goal of file versioning is to track changes between versions (also called revisions) of a file.


### 1. Definition
Versioning allows to have a several documents' versions. Any uploaded document with same name as an existent one, will automatically be saved as the latest version. Versioning ensures that no changes will be lost between updates or edittions on documents, and that any user may view the available versions for a given document.
All allowed operations on files can be done with versions as, copy, delete  and download, the behavior of those operations is explained in the table below.

### 2. Rules
* The versioning feature is intended to be just for shared spaces, and not in personal spaces.  
* Only files will support versioning, not folders.
* Revisions can be managed as a simple files.
* The administrator of a workgroup can enabble/disable the versioning.
* There is no limited number of revisions number.
* No special mime type for revisions
* Any workgroup member can see the revisions on the workgroup.


### 3. Operations on documents with versioning


| Operation                                                              | Behavior                                                                                                                                                                                                  |
|------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Upload a document having same name with an existent document                   | Current document is automatically  transformed into a revision of the old one                                                                                                                        |
| Merge an existent document as a revision of an existent document | The document source will be a revision  of the document destination                                                                                                                                                            |
| Duplicate a document                                         | a new document is created and renamed and new revision of it is created                                                                                                                      |
| Copy a document or revision to workGroup or personal space                                            | a new renamed document (in case of an existent one with same name) is created from the most recent revision of document source                                                                                                                        |
| Delete a file                                                          | The document and its all revisions will be deleted                                                                                                                                                        |
| Delete one or more revisions                                          | The revision is deleted, if it is the most recent, the penultimate revision is made as the most recent. deletion is prohibited if it is the unique revision of the document |
| Restore a revision                                                     | Take a past version of the file and apply it as the most recent                                                                                                                                              |
| download a document                                                        |The most recent  revision will be downloaded                                                                                                                                                          |

### 4. Test the API

1. Create a revision in a shared space:  

When a user uploads a file with the same name as an existing document in the workgroup, it will be automatically a revision of the old one.
```
curl -X POST \
http://0.0.0.0:30000/linshare/webservice/rest/user/v2/work_groups/{workGroupUuid}/nodes \ -F file=@/{full_path}/{fileName} -u "{email}:{password}"
```
2. Restore a revision:
this operation allows the user to make from an old revision the most recent.
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
Duplicating a document creates a new document based on its latest revision. The new document's name will be auto-renamed

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

Copy a revision to another location:

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
5. Download a document or a revision  
When downloading a document, its **most recent revision** is downloaded.

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
