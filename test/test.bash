#!/bin/bash

validateSolutionArg(){
    declare -r solname="$1" # scopes this variable locally
    
    if [[ "$solname" =~ [^a-zA-Z0-9] ]];
    then
        echo "Solution name should be an alphanumeric string. Received : [$solname]" 1>&2;
        exit 1; 
    fi

    if [ "$solname" == "" ];
    then
        echo "Solution argument is always required as that forms the basis of the root directory for the solution." 1>&2;
        exit 1; 
    fi
}

test_options(){

      # receive and define arguments
    local OPTIND
    
    declare solutionName="";

    #note: first : for the option, second : after letter to implie option requires an argument...
    while getopts :s: option
    do
        case $option
        in
            s) solutionName="$OPTARG";;
        esac
    done
    
    validateSolutionArg $solutionName;

}
