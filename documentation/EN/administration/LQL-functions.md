# LQL Functions (LDAP Query Language)

## __ldap.search__ function

This function brings an __ldapsearch__ like request, with a __SUBTREE__ scope : it recursively lookup in the tree all entries matching the specified __ldapFilter__ filter, beginning at the
__baseDN__ path.
```
ldap.search (baseDN, ldapFilter) [ Perform with a SUBTREE_SCOPE ]
```

## __ldap.list__ function
This function brings an __ldapsearch__ like request, with a __ONELEVEL__ scope : itlookup in the tree all entries matching the __ldapFilter__ filter, looking into the specified __baseDN__ and its
children.
```
ldap.list (baseDN, ldapFilter) [ Perform with a ONELEVEL_SCOPE ]
```

## __ldap.read__ function
This function reads the entry specified by __baseDN__.
```
ldap.read (baseDN, ldapFilter) [ Perform with an OBJECT_SCOPE ]
```

## __ldap.or__ function
This function takes as arguments two LDAP __DN__ lists, merge them and returns the merged list.
```
ldap.or (ListDN, ListDN)
```

## __ldap.and__ function
This function takes as arguments two LDAP __DN__ lists, and returns the list of __DN__ that are in both lists.
```
ldap.and (ListDN, ListDN)
```

## __ldap.attribute__ function
This function fetch the value(s) of the specified __Attribute__ parameter, for the specified __DN__ object.
```
ldap.attribute (DN, Attribute)
```

## __ldap.retain__ function
This function returns the DN that are in __ListDN1__ but aren't on __ListDN2__.
```
ldap.retain (ListDN1, ListDN2)
```

## __ldap.sup__ function
This function returns the list of all DN of the parents of the specified __DN__, starting at the
level __intLevel__.
```
ldap.sup (DN, intLevel)
```
Example : "ldap.sup("cn=test,dc=linshare,dc=linagora,dc=org", "1")" will return :
```
dc=linshare,dc=linagora,dc=org
dc=linagora,dc=org
dc=org
```
> Warning :<br/>
An __intLevel__ of 0 means __returning all the parents of the specified DN, which is also included.

## __ldap.fsup__ function
This function works like "ldap.sup(DN, 0)", to which an LDAP filter is applied, to get back only the DN that matches the pattern.
```
ldap.fsup (DN, ldapFilter)
```
