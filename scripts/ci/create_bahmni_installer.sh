#/bin/bash
TEMP_SCRIPT_DIR=`dirname -- "$0"`
SCRIPT_DIR=`cd $TEMP_SCRIPT_DIR; pwd`
export SCRIPT_DIR

export ARTIFACTS_DIRECTORY=$1
export INSTALLER_FILE_NAME=$2
export INSTALLER_LABEL=$3
export COMMAND=$4
export BAHMNI_INSTALLER_FILE=bahmni_deploy.sh
export INSTALLER_FILE=$ARTIFACTS_DIRECTORY/bahmni_deploy.sh

source $SCRIPT_DIR/installer_utils.sh

function usage {
	echo "Usage: create_installer.sh ARCHIVE_DIRECTORY FILE_NAME LABEL COMMAND"
}

if [ $# -ne 4 ]
then
	usage
	exit 1
fi

create_installer