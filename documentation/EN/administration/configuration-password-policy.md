# How to configure password policy on LinShare

## Overview
 * [Definition](#1-definition)
 * [How to configure password complexity](#2-howTo)

### <a name="1-definition">1. Definition</a>

Since the version 4.0, a library of Password generation and validation called `Passay` is added in order to enhance LinShare's passwords policy.

The list of different rules which should be agreed in the entered password are:
  * Minimum/Maximum length
  * Minimum number of upper/lower case
  * Minimum number of digits
  * Minimum number of special characters

### <a name="2-howTo">2. How to configure password policy</a>

* The different password policies are editable on the file `linshare.properties`, the default configuration is:

```
# Minimum length of password
password.min.length=12

# Maximum length of password
password.max.length=30

# Minimum Number of uppercase in password
uppercase.character.password=1

# Minimum Number of lowercase in password
lowercase.character.password=1

# Minimum Number of digits in password
digits.character.password=1

# Minimum Number of special characters in password
special.character.password=1

# Maximum Number of stored passwords
password.history.max.number=10
```

* In addition of the different rules of password's complexity, in the 4.0 version of LinShare, LinShare does not allow the user to reuse the last 10 old passwords.
