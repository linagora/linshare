# Theming linshare-ui-user

# Introduction

If you want to create your own theme, refere to the following documentation: [creating_a_theme_for_linshare](../development/linshare-ui-user/creating_a_theme_for_linshare.md)

## How to change the theme
LinShare contains a list of preformatted themes :
* default : a blue theme
* darkgreen
* red

If you want to change the theme of your LinShare you can :
* Edit the file `index.html` in your deployment folder and replace the name of the theme file by the one of you choice. The theme files are minified and have a unique name to deal with navigator caching (ex: *theme.default.a4d8f567.css*)
* For Docker images, there is an environment variable to set for overriding the theme: `LINSHARE_THEME`
    * This environment variable is used in the conf of Apache VHOST for linshare-ui-user.
    * Which will proceed as a Rewrite of the resource file asked, here the theme.css file chosen
    * For more information please refer to: [linshare-docker](https://github.com/linagora/linshare-docker)
* Or, set a rule in your web server configuration to rewrite the access of the `theme.default.<cacheId>.css` to your theme file.

## Advanced theming
In the config/config.js file, you also have the possibility to override some images:
```
// To override the application logo set the url of the image corresponding to the sizes (small 155x29 and big 500x192)
applicationLogo : {
small : 'images/common/linshare-logo-white.png',
      large : 'images/ls-logo-big.png'
},

  // To override the background image of the login screen set the url of the image
loginBackground : 'images/bg-linshare-desktop.png',

```
