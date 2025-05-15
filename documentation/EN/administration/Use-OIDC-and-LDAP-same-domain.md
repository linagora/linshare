
# Using LDAP server as search provider in case of OIDC user provider

## Description

Searching internal users (autocomplete) not already authenticated in case of OIDC user provider can be done if users are stored in LDAP server.

## Key Limitations

- **No Auto-Provisioning**: LDAP search only - users won't be auto-created

- **Anonymous Shares**: Unprovisioned users can get anonymous shares

- **Search Scope**: Limited to LDAP branch defined in `baseDn`

## Configuration Workflow

When configuring OIDC with LDAP autocomplete, internal users **not existing in LinShare's database** will receive anonymous shares. This guide explains how to enable LDAP user search while maintaining expected sharing behavior.

You can avoid this problem by :

1- Creating a new LDAP connection (UI-Admin -> Configuration -> Remote servers) and set LDAP information.

2- Creating new User filter (UI-Admin -> Configuration -> User filters) and set LDAP information.

3- When creating/editing your OIDC provider:

- Specify the baseDn parameter to target the LDAP branch containing internal users (e.g., ou=People,dc=linshare,dc=org).

- This ensures user searches during file sharing are constrained to the correct LDAP subtree.

After that you should add those lines in linshare.properties :

### Update `linshare.properties` guide

Two properties have been introduced:
```
# LDAP Connection UUID (From: Remote Servers UI)
oidc.ldap.connectionUuid=76ef5ee0-6513-4a64-b711-90a1bbdbfc55 

# LDAP Pattern UUID (From: User Filters UI - Filter labeled 'pattern-ldap-local')
oidc.ldap.provider.patternUuid=cd02e600-f324-4cea-9724-21d8647e9533
```

### Database Configuration

To persist the LDAP branch configuration:

1. Table: user_provider
2. Column: base_dn
3. Target Row:

`UPDATE user_provider 
SET base_dn = 'ou=People,dc=linshare,dc=org'
WHERE 
    uuid = 'your-user_provider-uuid' AND 
    provider_type = 'OIDC_PROVIDER';`

They allow to link every oidc connection to a ldap connection and pattern to be used as backup user provider (to retrieve client informations if absent from the DB)
