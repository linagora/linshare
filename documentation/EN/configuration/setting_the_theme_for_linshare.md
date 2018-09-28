# Theming linshare-ui-user

# Introduction

To create your theme refere to dedicated documentation under development folder: (../development/creating_a_theme_for_linshare.md)

## How to change the theme
LinShare contains a list of preformatted themes :
* default : a blue theme
* darkgreen
* red

If you want to change the theme of your LinShare you can :
* Edit the file `index.html` in your folder `dist` and replace the name of the theme file by the one of you choice. The theme files are minified and have a unique name to deal with navigator caching (ex: *theme.default.a4d8f567.css*)
* Or, set a rule in your web server configuration to rewrite the access of the `theme.default.<cacheId>.css` to your theme file.
