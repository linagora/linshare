# Theming linshare-ui-user

## Introduction
You will find in the folder `app/styles` all the files used for managing the styles and colors in the application.

The css rules are splited in different files like in `pages/common` or `pages/specific`.

A theme is based on a primary color. Every alternatives colors depends of that primary color using color channel functions like *darken*, *lighten*, *desaturate*, etc...

## How to create a new theme
As a theme is based on a single main color, creating a new theme is super easy.

Go to the folder `app/styles`, create a new theme file (ex:`theme.mine.scss`) as below and adjust the **primary-color** :

file `theme.mine.scss`
```
$primary-color: #B10DC9; // PURPLE
@import "_main.scss";
```

## Advanced theming
You will find in the file `_colors.scss` all the colors used for theming the application. Pick those you want to override and copy them to you theme file. Only the variables suffixed by *!default* could be overrided.

If you want to unlink colors to the primary color, you need to define new entries in your file `theme.mine.scss`. The new lines must be included before the `@import` instruction.

You can add after the `@import` instruction, any css overrides

## Debuging
Debuging the theme is possible in live using docker-images
```
$ grunt serve
```
You can see the modifications in your browser using the url : http://127.0.0.1:20081/

## Deploying 

### Packaging
If your theme is ready to be deployed you can package your version.
```
$ cd linshare-ui-user/
$ mvn clean package
```
That will generate an archive `target/linshare-ui-user.tar.bz2`

### Deployement

Extract the archive 
```
$ cd path_to_your_webserver/files_to_serve/linshare
$ cd tar -xjvf linshare-ui-user.tar.bz2
```

### Run

Refer to your webserver documentation
