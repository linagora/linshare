# Architecture

## Resume

Since LinShare 2.4, the project is using Java 11. Before this version, all
versions 2.x are using Java 8.

LinShare is based around Spring (Spring, SpringSecurity, SpringData, ...),
Apache CXF and Hibernates.

## Layers

LinShare is organised by layers, each one dedicated to some specific purposes
and located in a dedicated package.

### Layer 1: Repositories

There is two kind of repository in LinShare because LinShare is using two
databases. The switch from PostgreSQL to MongoDB is not yet completed.
Repositories are responsible of all basic operations on databases, create,
delete, update. They are not designed to contains business rules.

### Hibernate: PostgreSQL

All entities store in the PostgreSQL database are managed by classes store in
the package 'org.linagora.linshare.core.repository'

### Spring-Data: MongoDB

All entities store in the MongoDB database are managed by classes store in
the package 'org.linagora.linshare.mongo.repository'.


### Layer 2: Business Services

This layer is built on top of repositories and ensure that business rules are
applied. Classes are located in the package 'org.linagora.linshare.core.business.service'.


### Layer 3: Services

This layer is built on top of business services, it has multiple puroposes:
 * Check access rules
 * Audit: ensure that every action is generating traces in the audit.
 * Sending emails


### Layer 4: Facades

Facades use services to ensure that every methods are atomics (sql
transaction). Facades are designe to be the bridge between entities (from
service) and DTO (for webservices)


### Layer 5: Web Services

The Web Services layer contains on REST API. The following package 'org.linagora.linshare.webservice' contains all LinShare api; split by usage and version.
example: user, userv2, admin, ... This layer is desgned to use Facades and
expose them as REST services.
