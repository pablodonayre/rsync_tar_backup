#!/bin/bash
# bash nombre_de_archivo.sh (yes/no)
source env_variables
source verify_environment.sh
source backup.sh

# Return "env" and "local_path" from verify() function:
read env local_path < <(verify)
echo Environment: $env
echo $'\n'




#  execute a previous backup
backup_action=$1

if [ "$backup_action" == "yes" ]
then
    bu

else
    echo "-- No backup action"

fi


# synchronization
origin=$server_user@$server_ip:$server_path"/"$server_dirname"/"
destination=$local_path"/"$local_dirname"/"

#echo $origin
#echo $destination

echo $'\n'
echo "-- RSYNC ...Start "
rsync -vahcizP --recursive --delete --exclude-from=$local_path"/"$local_dirname"/automatic_backups/excludePatterns"  $origin  $destination
echo "-- RSYNC ...Finish "