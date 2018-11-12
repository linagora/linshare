# Adding new language in linshare-ui-user

## Introduction

To add a new language several are necessary:
 * Copy the file from `app/i18n/original/en-US`
 * Update the file to your language accordingly
 * Add a new folder containing you language in the app instance
 * Update the configuration for the app instance to load the language

## Template file

Under `app/i18n/original/en-US`, you will find multiple files containing the different `key` used by our
translation mechanism.

The first step will be to update those files accordingly to the language you wish to add.

**WARNING: Do not modify the name of the files.**

Notes:
> Some sentences reference other translation key, in order to avoid text duplication.
>
> Some sentences contain variable, please use them accordingly in your sentence.
> a variable look like this: `{{aVariable}}`


## Updating linshare application

### Adding translation file

After updating the different files to your language, you will need to add them in the application.

In the source file, under `app/i18n`, add a new folder.

The name of the folder will depend on your language, a code is defined for every language which is used by our system.

To find yours, you can go to [here](http://www.lingoes.net/en/translator/langcode.htm).

We use the full form, `language-country` form, like `en-US` for example.

### Updating configuration file

Now that your files are accesible by the system, you just have to set the configuration to use them.

In the source file, edit the file  `app/config/config.js`.

You will see a `key` name **languages** which should look like this by default:
```
languages: {
  fr: {
    key: 'fr',
    fullKey: 'fr-FR',
    country: 'France',
  },
  en: {
    key: 'us',
    fullKey: 'en-US',
    country: 'United States'
  },
  vi: {
    key: 'vn',
    fullKey: 'vi-VN',
    country: 'Tiếng Việt'
  }
}
```

Simply add a new key in this object for adding a new language, for example italian, the key would look like this:
```
it: {
  key: 'it',
  fullKey: 'it-IT',
  country: 'Italia'
}
```

Now our file should look like this:

```
languages: {
  fr: {
    key: 'fr',
    fullKey: 'fr-FR',
    country: 'France',
  },
  en: {
    key: 'us',
    fullKey: 'en-US',
    country: 'United States'
  },
  vi: {
    key: 'vn',
    fullKey: 'vi-VN',
    country: 'Tiếng Việt'
  },
  it: {
    key: 'it',
    fullKey: 'it-IT',
    country: 'Italia'
  }
}
```
