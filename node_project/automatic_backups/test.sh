#!/bin/bash

source env_variables
source verify_environment.sh
source backup.sh

# Return "env" and "local_path" from verify() function:
read env local_path < <(verify)
echo Environment: $env




#  previous backup
#backup_command=$(/bin/bash $local_path"/automatic_backups/backup_remote.sh")
#backup_command=$($local_path"/automatic_backups/backup_remote.sh")


#echo "-- Init Backup"
#ssh $server_user@$server_ip "$backup_command"
#echo "-- Backup file created"

$(bu)