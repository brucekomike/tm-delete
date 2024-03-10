#!/bin/bash
# Purpose: Delete old apple timemachine backups 
# before a specific time
# Usage: ./tm-delete.sh <cutoff_time> <volume_name>

# Get the cutoff time from the command line arguments
cutoff_time=$1

# Convert the cutoff time to seconds since the Unix epoch
cutoff_time_seconds=$(date -j -f "%Y-%m-%d" "$cutoff_time" "+%s")

# Assuming backups is a newline-separated list of backup names
backups=$(sudo tmutil listbackups) # replace this with the actual command to get the list of backups

# Read the backups line by line
while IFS= read -r backup; do
    echo "Processing backup: $backup"
    # Extract the timestamp from the backup name
    timestamp=$(basename "$backup" | cut -d'.' -f1)
    echo "Extracted timestamp: $timestamp"
    # Convert the backup timestamp to seconds since the Unix epoch
    backup_time_seconds=$(date -j -f "%Y-%m-%d-%H%M%S" "$timestamp" "+%s")
    # If the backup time is not newer than the cutoff time, delete the backup
    if (( backup_time_seconds <= cutoff_time_seconds )); then
        echo "Deleting backup: $backup"
        # Uncomment the next line to actually delete the backups
        sudo tmutil delete -d $2 -t "$timestamp"
    fi
done <<< "$backups"