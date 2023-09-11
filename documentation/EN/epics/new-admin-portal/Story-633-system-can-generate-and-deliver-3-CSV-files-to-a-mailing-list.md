# Summary

* [Related EPIC](#related-epic)
* [Definition](#definition)
* [UI Design](#ui-design)
* [Misc](#misc)

## Related EPIC

* [New admin portal](./README.md)

## Definition

### Preconditions

### Description 

- As a system administrator, I want the application to automatically generate and deliver 3 CSV files to a list of users.
- This will be done through a cronjob.

### Postcondition 

- The application should provide a configuration option to specify the list of mailing list who will receive 3 CSV files. 
- The application should support scheduling the delivery of the CSV files via the cron job.
- The cron job should be configurable to execute at a specific time and frequency.
- The 3 CSV files should be sent as attachments to the designated users via email
- The email should include a clear and informative subject line and body text.
- The application should log the successful execution of the cron job, including details such as the delivery status and any errors encountered.
- In case of any errors during delivery, appropriate error messages should be logged to facilitate troubleshooting. 

Additional Considerations: The generated CSV files should contain columns accordingly:

- File1: Top receivers by shared file size 

   - Receiver's mail
   - Aggregated sizes of shared files

- File2: Top receivers by number of files share

  - Receiver's mail
  - Number of shared files 

- File3: The file should include all share operations during the day (one line per share operation with one sender and one receiver). The content of the file :

   - Sender's mail
   - Sender name 
   - Sender uid
   - Sender domain
   - Receiver's mail
   - Receiver type
   - Receiver name
   - Receiver uid
   - Receiver domain 
   - File name
   - File uid
   - Size of shared file
   - Date and time of share

See the csv example: ![File 3 CSV](./mockups/Model CSV.csv)

[Back to Summary](#summary)

## UI Design

### Mockups

### Final design

[Back to Summary](#summary)

## Misc

[Back to Summary](#summary)



