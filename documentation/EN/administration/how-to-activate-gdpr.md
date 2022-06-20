##  How to activate GDPR on LinShare

#### 1) Introduction

The General Data Protection Regulation (GDPR) is a regulation in EU law on data protection and privacy in the European Union (EU) and the European Economic Area (EEA).  
Hence, data such as **first name**, **last name**, **mail** will be anonymized after one year of inactivity in LinShare.  

Part concerned are:  
- any first name, last name or email used by the sharing feature or the upload request features (actors, owners, senders, recipients, ...) stored in the audit
- any first name, last name or email used by the sharing feature or the upload request features collected and store for favorite recipients or auto complete purpose.

#### 2) How to activate

This feature is disable by default, you will have to edit the file `linshare.properties`:

```
# Batches are launched every days at 4a.m
# This cron is responsible of :
#   - executing task populating gdpr garbage collector
job.gdpr.cron.expression=0 0 4 * * ?
linshare.gdpr.enable=true
```

where:  
- `linshare.gdpr.enable` is a boolean in order to activate or deactivate the feature
- `job.gdpr.cron.expression` is the cron expression in order to trigger the 3 jobs doing the anonymization
