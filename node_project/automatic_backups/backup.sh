#!/bin/bash

source env_variables
source verify_environment.sh

# Return "env" and "local_path" from verify() function:
read env local_path < <(verify)
#echo Environment: $env




function bu(){

    backups_dirname=$local_dirname"_backups"
    mkdir -p "$local_path/$backups_dirname"

    timestamp=$(date +%s)
    
    echo "-- TAR ... Start: Init Local Backup"
    #cd $local_path
    #$(cd "$local_path"; tar "--exclude-from=$local_path/$local_dirname/automatic_backups/excludePatterns" -cvzf "$local_path/$backups_dirname/$timestamp.tar.gz" "$local_dirname")
    cd "$local_path"; 
    tar "--exclude-from=$local_path/$local_dirname/automatic_backups/excludePatterns" -cvzf "$local_path/$backups_dirname/$timestamp.tar.gz" "$local_dirname"
    
    #$(echo $tar_command)
    echo "-- TAR ... Finish: Local Backup file created"

}

function bu_remote(){

    backups_dirname=$server_dirname"_backups"
    timestamp=$(date +%s)

    all_excludes=$(read_file)
    #echo $all_excludes

    echo "-- TAR ... Start: Init Remote Backup"
    
    ssh $server_user@$server_ip "cd $server_path; mkdir -p $server_path/$backups_dirname; tar $all_excludes -cvzf $server_path/$backups_dirname/$timestamp.tar.gz $server_dirname"

    echo '-- TAR ... Finish: Remote Backup file created'


}

function read_file(){

    all_excludes=""

    mapfile -t my_array < $local_path/$local_dirname/automatic_backups/excludePatterns

    for line in "${my_array[@]}"; do
        # process the lines
        if [ "$line" != "" ]; then
            # avoid empty lines
            all_excludes+="--exclude=$line ";
        fi
    done

    #echo "$all_excludes"
    echo $all_excludes

}

#$(bu)
#echo "$(bu_remote)"
#echo "$(read_file)"

#bu_remote