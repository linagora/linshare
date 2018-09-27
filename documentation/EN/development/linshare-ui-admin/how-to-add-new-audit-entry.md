## How to add new audit entry to `ui-admin` :

To do this, you need to clone the `linshare-ui-admin` project.

Open the project and go to `linshare-ui-admin/app/i18n`, now you have to put your modifications in these files :

`audit-en.json` and `audit-fr.json`.

Add your entry type in the `TYPE` section. Variables names are defined in "auditDetails.js" and refer to resource.actor and resource.name audit json structure.

Now, go to `linshare-ui-admin/app/ng_components/auditv2/services/auditDetailsService.js`

You must add the description of your audit entry TYPE in these sections : 
  - `TYPE_ICONS` (icons v2.2 are available on [zmdi](http://zavoloklom.github.io/material-design-iconic-font/icons.html) website)
  - `TYPES_KEY`
