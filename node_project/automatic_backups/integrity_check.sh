#!/bin/bash

source env_variables
source verify_environment.sh
source backup.sh

# Return "env" and "local_path" from verify() function:
read env local_path < <(verify)
echo Environment: $env
echo $'\n'




all_excludes=$(read_file)
#echo $all_excludes


# Local HASH
echo "-- Local hash: "
local_hash=$(cd "$local_path"; tar --mtime='UTC 2019-01-01' --group=0 --owner=0 --numeric-owner --sort=name --exclude-from=$local_path/$local_dirname/automatic_backups/excludePatterns -czf - $local_dirname | sha256sum)
echo $local_hash


# Remote HASH
echo $'\n'
echo "-- Remote hash: "
remote_hash=$(ssh $server_user@$server_ip "cd $server_path; tar --mtime='UTC 2019-01-01' --group=0 --owner=0 --numeric-owner --sort=name $all_excludes -czf - $server_dirname | sha256sum")
echo $remote_hash


echo $'\n'

if test "$local_hash" = "$remote_hash"
then
    echo "--> IGUALES"
else
    echo "--> DIFERENTES"
fi

