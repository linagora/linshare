# Summary

* [Context](#context)
* [Definition](#definition)
* [Stories](#stories)
* [Misc](#misc)

## Context

[Back to Summary](#summary)

## Definition

A guest is like a regular user except he has an expiration date, we can optionally give him a personal space, and we can optionally restrict the list of contacts he can see and share with.

A guest is only managed by it's author, we called it the owner.

In this epic we want to change the way it is working by introducing a new concept, a moderator of guest.
We will keep the term owner to keep track of the person who created the guest but beeing the owner will not mean you have the right to manage the guest.

when a guest is created, the current authenticated user will be automatically added as the moderator of a guest. Of course he can also add other users (internals) as moderator at creation and update time.

A moderator will be able to administrate the guest, changing his first name, last name, enabling the contact restriction, etc ...

As an administrator, I should be able to add or remove moderators from a guest account.


[Back to Summary](#summary)

## Stories

TODO

> A list of all the story documentation in the epic, must format as a list of links to corresponding user story files inside epic folder

1. [As a user, i can do something](./link-to-the-file.md)

[Back to Summary](#summary)

## Misc

> Link references, UI mockup, link to gitlab issye or any extra documents related to the EPIC

* [Gitlab issue]()
* [UI Mockup]()

[Back to Summary](#summary)
