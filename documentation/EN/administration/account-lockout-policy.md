To enhance security into LinShare, lockout accounts feature is integrated in LinShare 4.0.0.

# Lockout Rules:

Account lockout rules are used by LinShare to lock out an account when user tries to log on unsuccessfully several times in a row.
Here are the rules :

- After 3 attempts : account locked for 10 minutes
- After 6 attempts : account locked for 20 minutes
- After 9 attempts : account locked for 60 minutes (1 heure)
- After 12 attempts : account locked for 1440 minutes (1 journée)
- After 15 attempts : account locked indefinitely (It is essential to request the administrator to unlock the account)

# Unlock accounts

The administrator has the ability to unlock a locked account.
- In the left Menu side, select Users 
- Then choose the section manage users
- Set in the search field the user's name then select him
- If the user's account is locked you'll see a button that allows you to unlock him

<img src="http://download.linshare.org/screenshots/4.0.0/04.unblock_user.png" alt="unlock_accounts_screeshot" width="600"/>
