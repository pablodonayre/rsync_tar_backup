#!/bin/bash

function verify(){

    if [ "$environment" == "PABLO" ]
    then

        local_path=$pablo_local_path

    elif [ "$environment" == "KIMY" ]
    then

        local_path=$kimy_local_path

    fi

echo $environment $local_path

}