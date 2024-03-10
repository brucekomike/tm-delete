# TM-Delete
this is a simple script for deleting time machine backups before a specific date

## usage
```bash
./tm-delete.sh <date> <volume>
```
where `<date>` is the date before which you want to delete the backups. The date should be in the format `YYYY-MM-DD`.
        
`<volume>` is the volume name of the time machine backup. You can find the volume name by running `tmutil destinationinfo` and looking for the `Name` field.

## ! Attention
This script will delete all backups before the specified date with no confirmation. Use with caution.