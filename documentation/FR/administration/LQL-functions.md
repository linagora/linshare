# Fonctions LQL (LDAP Query Language)

## Fonction __ldap.search__
Cette fonction permet de faire une recherche de type __ldapsearch__ avec un spectre de recherche __SUBTREE__ : c’est-à-dire qu’elle recherche récursivement dans l’arbre toutes les entrées correspondantes au filtre __ldapFilter__ spécifié à partir du nœud dans l’arbre correspondant au paramètre __baseDN__.
```
ldap.search (baseDN, ldapFilter) [ Perform with a SUBTREE_SCOPE ]
```

## Fonction __ldap.list__
Cette fonction permet de faire une recherche type __ldapsearch__ avec un spectre de recherche __ONELEVEL__ : c’est-à-dire qu’elle recherche dans l’arbre toutes les entrées correspondantes au filtre __ldapFilter__ spécifié à partir du nœud correspondant au paramètre __baseDN__ et parmi tous les fils directs de ce nœud.
```
ldap.list (baseDN, ldapFilter) [ Perform with a ONELEVEL_SCOPE ]
```

## Fonction __ldap.read__
Cette fonction lit l’entrée correspondant dans l’arbre à l’entrée spécifiée par le paramètre __baseDN__.
```
ldap.read (baseDN, ldapFilter) [ Perform with an OBJECT_SCOPE ]
```

## Fonction __ldap.or__
Cette fonction prend en paramètre deux listes de DN et retourne l’ensemble joint de ces deux listes.
```
ldap.or (ListDN, ListDN)
```

## Fonction __ldap.and__
Cette fonction prend en paramètre deux listes de DN et retourne la liste correspondante aux DN qui sont communs aux deux listes.
```
ldap.and (ListDN, ListDN)
```

## Fonction __ldap.attribute__
Cette fonction permet de récupérer dans l’entrée spécifiée par le paramètre __DN__ la/les valeur(s) de l’attribut spécifié dans le paramètre __Attribute__.
```
ldap.attribute (DN, Attribute)
```

## Fonction __ldap.retain__
Cette fonction permet de retourner une liste de DN correspondant à la liste __ListDN1__ à laquelle on retire tous les DN présents dans la liste __ListDN2__.
```
ldap.retain (ListDN1, ListDN2)
```

## Fonction __ldap.sup__
Cette fonction retourne la liste de tous les DN des parents du DN spécifié à partir du niveau __intLevel__.
```
ldap.sup (DN, intLevel)
```
Exemple : __ldap.sup("cn=test,dc=linshare,dc=linagora,dc=org", "1")__ retournera :
```
dc=linshare,dc=linagora,dc=org
dc=linagora,dc=org
dc=org
```
> Attention  :<br/>
Un __intLevel__ de 0 (zéro) signifie remonter tous les parents à partir du DN spécifié, celui-ci inclus.

## Fonction __ldap.fsup__
Cette fonction est similaire à la fonction __ldap.sup(DN, 0)__ (cf. § 4.1.8, ci-avant) à laquelle on va appliquer un filtre LDAP pour ne retourner que la liste des DN correspondant au filtre spécifié.
```
ldap.fsup (DN, ldapFilter)
```
