#!/bin/bash

# text color handling
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
bold=`tput bold`

# constants
ERR_MESSAGE_MISSING_TESTED_PROJ_ARG="missing argument -p : Tested Project. e.g. {cmd} -p ./abc.csproj";
ERR_MESSAGE_MISSING_SOURCE_DIR_ARG="missing argument -d : source directory. e.g. {cmd} -d .";
ERR_MESSAGE_MISSING_NAMESPACE_ARG="missing argument -n : library namespace. e.g. {cmd} -n abc.do";

# >&2 redirects echo output to stderr rather stdout. 
# good practice for e.g. on logging, preventing logging 
# to be output into a file.
exit_info () {
    echo >&2 "$@"
    exit 1
}
info(){
    echo >&2 "$@"
}
cog_help(){
  echo >&2 "This command requires following arguments:"
  echo >&2 "--------------------------------------------------"
  echo >&2 ""
  echo >&2 "-d : source directory."
  echo >&2 "-n : library namespace."
  echo >&2 "-s : related solution (optional)."
  echo >&2 "-f : force re-creating the project (defaults false)."
  echo >&2 ""
  echo >&2 "--------------------------------------------------" 
}

# to recursively run all bats files on a directory and subdirectories
cog_run_bats()
{
  DIRECTORY=$1

  if [ "$DIRECTORY" = "" ]; then 
    exit_info "directory argument not passed! > cog_run_bats {directory}.";
  fi

  [ -d "$DIRECTORY" ] || exit_info "required directory = [$DIRECTORY] does not exist."

  for file in $DIRECTORY/*.bats
  do
    cog_out_heading $file;
    bats -t -r "$file"
    
  done
}

cog_out_heading(){
    echo ""
    echo "${green}-------------------------------------------------------------"
    echo "${green}|  $1"
    echo "${green}-------------------------------------------------------------${reset}"
}

cog_mkdir(){
  dir=$1;
  mkdir $dir &> /dev/null;
  ret=$?;
  
  # note that spaces count while parsing bash conditions!!! :) many times cauth by that...
  if [ $ret -eq 0 ]; then
    info "directory:$dir created.";
  else
    exit_info "unable to create directory:$dir";
  fi
}

cog_ubuntu_version(){
   lsb_release -a
}

validateReferencedProjectArg(){
  if [ "$1" == "" ]; then
    exit_info "$ERR_MESSAGE_MISSING_TESTED_PROJ_ARG";
  else
    [ -f "$1" ] || exit_info "required referencing project = [$1] does not exist."
  fi
}

validateDirectoryArg(){
  if [ "$1" == "" ]; then
    exit_info "$ERR_MESSAGE_MISSING_SOURCE_DIR_ARG";
  else
    [ -d "$1" ] || exit_info "required directory = [$1] does not exist."
  fi
}
validateNamespaceArg(){
  if [ "$1" == "" ]; then
    exit_info "$ERR_MESSAGE_MISSING_NAMESPACE_ARG";
  fi
}

validateProjectOverwriteForceArg(){
  # verify if the directory for the project has been previously created.
  # if forced or dir does not exist, then create new dir
  # note: use single = for boolean values in the condition.
  if [ "$1" = true ]; then
    if [ -d "$2" ]; then
      rm -rf "$2" &> /dev/null;
    fi
  else
    [ ! -d "$2" ] || exit_info "project $2 already exist. use -f to (force : defaults true) overwrite.";
  fi
}

validateDotNetCoreInstalled(){
    eval dotnet --version;
  [ $? -eq 0 ] || exit_info "dotnet core does not seem to be installed on your system, please check https://www.microsoft.com/net/download/linux-package-manager/ubuntu18-04/sdk-current .";
}