#!/bin/bash
#
# (C) 2016-2024+ Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8X_mgmt_cli_API_bash_scripts
#
# ALL SCRIPTS ARE PROVIDED AS IS WITHOUT EXPRESS OR IMPLIED WARRANTY OF FUNCTION OR POTENTIAL FOR 
# DAMAGE Or ABUSE.  AUTHOR DOES NOT ACCEPT ANY RESPONSIBILITY FOR THE USE OF THESE SCRIPTS OR THE 
# RESULTS OF USING THESE SCRIPTS.  USING THESE SCRIPTS STIPULATES A CLEAR UNDERSTANDING OF RESPECTIVE
# TECHNOLOGIES AND UNDERLYING PROGRAMMING CONCEPTS AND STRUCTURES AND IMPLIES CORRECT IMPLEMENTATION
# OF RESPECTIVE BASELINE TECHNOLOGIES FOR PLATFORM UTILIZING THE SCRIPTS.  THIRD PARTY LIMITATIONS
# APPLY WITHIN THE SPECIFICS THEIR RESPECTIVE UTILIZATION AGREEMENTS AND LICENSES.  AUTHOR DOES NOT
# AUTHORIZE RESALE, LEASE, OR CHARGE FOR UTILIZATION OF THESE SCRIPTS BY ANY THIRD PARTY.
#
#
# -#- Start Making Changes Here -#- 
#
# SCRIPT Base Template testing script for automated execution of standard tests
#
#
ScriptVersion=00.70.00
ScriptRevision=000
ScriptSubRevision=000
ScriptDate=2024-05-30
TemplateVersion=00.70.00
APISubscriptsLevel=020
APISubscriptsVersion=00.70.00
APISubscriptsRevision=000


#

export APIScriptVersion=v${ScriptVersion}
export APIScriptTemplateVersion=v${TemplateVersion}

export APIScriptVersionX=v${ScriptVersion//./x}
export APIScriptTemplateVersionX=v${TemplateVersion//./x}

export APIExpectedActionScriptsVersion=v${ScriptVersion}
export APIExpectedAPISubscriptsVersion=v${APISubscriptsVersion}

export APIExpectedActionScriptsVersionX=v${ScriptVersion//./x}
export APIExpectedAPISubscriptsVersionX=v${APISubscriptsVersion//./x}

ScriptName=test._templates.v${ScriptVersion}
export APIScriptFileNameRoot=test._templates
export APIScriptShortName=test._templates
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Base Template testing script for automated execution of standard tests"

# =================================================================================================
# =================================================================================================
# START script
# =================================================================================================
# =================================================================================================

# -------------------------------------------------------------------------------------------------
# =================================================================================================
# START:  Setup Root Parameters
# =================================================================================================


export DATE=`date +%Y-%m-%d-%H%M%Z`
export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
export dtgs_script_start=`date -u +%F-%T-%Z`

#
# rootsafeworkpath     :  This is the path where it is safe to store scripts, to survive upgrades and patching
# customerpathroot     :  Path to the customer work environment, should be under ${rootsafeworkpath}
# scriptspathroot      :  Path to the folder with bash 4 Check Point scripts installation (b4CP)
#

export rootsafeworkpath=/var/log
export customerpathroot=${rootsafeworkpath}/__customer
export scriptspathroot=${customerpathroot}/upgrade_export/scripts

export rootscriptconfigfile=__root_script_config.sh

export logfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log

export dtzs='date -u +%Y%m%d-%T-%Z'
export dtzsep=' | '


# -------------------------------------------------------------------------------------------------
# UI Display Prefix Parameters, check if user has set environment preferences
# -------------------------------------------------------------------------------------------------


export dot_enviroinfo_file='.environment_info.json'
export dot_enviroinfo_path=${customerpathroot}
export dot_enviroinfo_fqpn=
if [ -r "./${dot_enviroinfo}" ] ; then
    export dot_enviroinfo_path='.'
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
elif [ -r "../${dot_enviroinfo}" ] ; then
    export dot_enviroinfo_path='..'
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
elif [ -r "${scriptspathroot}/${dot_enviroinfo}" ] ; then
    export dot_enviroinfo_path=${scriptspathroot}
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
elif [ -r "${customerpathroot}/${dot_enviroinfo}" ] ; then
    export dot_enviroinfo_path=${customerpathroot}
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
else
    export dot_enviroinfo_path='.'
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
fi

if [ -r ${dot_enviroinfo_fqpn} ] ; then
    getdtzs=`cat ${dot_enviroinfo_fqpn} | jq -r ."script_ui_config"."dtzs"`
    readdtzs=${getdtzs}
    if [ x"${readdtzs}" != x"" ] ; then
        export dtzs=${readdtzs}
    fi
    getdtzsep=`cat ${dot_enviroinfo_fqpn} | jq -r ."script_ui_config"."dtzsep"`
    readdtzsep=${getdtzsep}
    if [ x"${readdtzsep}" != x"" ] ; then
        export dtzsep=${readdtzsep}
    fi
fi


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Announce what we are starting here...
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo `${dtzs}`${dtzsep} '_______________________________________________________________________________' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '===============================================================================' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script:  '${ScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script original call name :  '$0 | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script initial parameters :  '"$@" | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '===============================================================================' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Root script declarations
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetScriptSourceFolder - Get the actual source folder for the running script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetScriptSourceFolder () {
    #
    # Get the actual source folder for the running script
    #
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'GetScriptSourceFolder procedure Starting...' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    #printf "`${dtzs}`${dtzsep}"'variable :  %-20s = %s\n' 'X' "${X}" >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}"'variable :  %-20s = %s\n' 'X' "${X}" | tee -a -i ${logfilepath}
    
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "${SOURCE}" ]; do # resolve ${SOURCE} until the file is no longer a symlink
        TARGET="$(readlink "${SOURCE}")"
        if [[ ${TARGET} == /* ]]; then
            echo `${dtzs}`${dtzsep} "SOURCE '${SOURCE}' is an absolute symlink to '${TARGET}'" >> ${logfilepath}
            SOURCE="${TARGET}"
        else
            DIR="$( dirname "${SOURCE}" )"
            echo `${dtzs}`${dtzsep} "SOURCE '${SOURCE}' is a relative symlink to '${TARGET}' (relative to '${DIR}')" >> ${logfilepath}
            SOURCE="${DIR}/${TARGET}" # if ${SOURCE} was a relative symlink, we need to resolve it relative to the path where the symlink file was located
        fi
    done
    
    RDIR="$( dirname "${SOURCE}" )"
    DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"
    if [ "${DIR}" != "${RDIR}" ]; then
        echo `${dtzs}`${dtzsep} "DIR '${RDIR}' resolves to '${DIR}'" >> ${logfilepath}
    fi
    
    export ScriptSourceFolder=${DIR}
    
    printf "`${dtzs}`${dtzsep}"'variable :  %-20s = %s\n' 'SOURCE' "${SOURCE}" | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-20s = %s\n' 'DIR' "${DIR}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-20s = %s\n' 'ScriptSourceFolder' "${ScriptSourceFolder}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} 'GetScriptSourceFolder procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ - MODIFIED 2023-03-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# We need the Script's actual source folder to find subscripts
#
GetScriptSourceFolder


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# ADDED 2018-11-20 -

# Output folder is relative to local folder where script is started, e.g. ./dump
#
export OutputRelLocalPath=true


# If there are issues with running in /home/ subfolder set this to false
#
export IgnoreInHome=true


# Configure output file folder target
# One of these needs to be set to true, just one
#
export OutputToRoot=false
export OutputToDump=true
export OutputToChangeLog=false
export OutputToOther=false
#
# if OutputToOther is true, then this next value needs to be set
#
export OtherOutputFolder=Specify_The_Folder_Here

# if we are date-time stamping the output location as a subfolder of the 
# output folder set this to true,  otherwise it needs to be false
#
export OutputDATESubfolder=true
export OutputDTGSSubfolder=false
export OutputSubfolderScriptName=false
export OutputSubfolderScriptShortName=true

# MODIFIED 2021-02-13 -
export notthispath=/home/
export localdotpathroot=.

export localdotpath=`echo ${PWD}`
export currentlocalpath=${localdotpath}
export workingpath=$currentlocalpath

# MODIFIED 2021-02-13 -
export expandedpath=$(cd ${localdotpathroot} ; pwd)
export startpathroot=${expandedpath}

# -------------------------------------------------------------------------------------------------

# Set these to a starting state we know before we begin
#
export APISCRIPTVERBOSE=false


# MODIFIED 2022-02-15 -
# Set ABORTONERROR to true to force any error to exit, versus reporting or waiting, and then carrying on
#
export ABORTONERROR=true

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# ADDED 2018-05-03 -
# ================================================================================================
# NOTE:  
#   DefaultMgmtAdmin value is used to set the APICLIadmin value in the setup for logon.  This is
#   the default fall back value if the --user parameter is not used to set the actual management 
#   server admininstrator name.  This value should be set to the organizational standard to
#   simplify operation, since it is the default that is used for mgmt_cli login user, where the
#   password must still be entered
# ================================================================================================

#export DefaultMgmtAdmin=admin
export DefaultMgmtAdmin=administrator


# MODIFIED 2021-11-09 -

# Configure whether this script operates only on MDSM
export OpsModeMDSM=false

# Configure whether this script operates against all domains by default, which affects -d CLI parameter handling for authentication
export OpsModeMDSMAllDomains=false


# 2018-05-02 - script type - template - test it all

export script_use_publish=true

#
# Provide a primary operation mission for the script
#
#  other       : catch-all for non-specific scripts
#  export      : script exports data via Management API
#  import      : script imports data via Management API
#  set-update  : script sets or updates data via Management API
#  rename      : script renames data via Management API
#  delete      : script deletes data via Management API
#  process     : script processes other operation outputs
#
# script_main_operation is used to identify elements needed in help and other action control
#export script_main_operation='other|export|import|set-update|rename|delete|process'
# script_target_specail_objects boolean is used to identify if the script is targetting special objects to control execution

export script_main_operation='other'
export script_target_special_objects=false

export scriptpurposeexport=false
export scriptpurposeimport=false
export scriptpurposeupdate=false
export scriptpurposerename=false
export scriptpurposedelete=false
export scriptpurposeother=false
export scriptpurposeprocess=false

case "${script_main_operation}" in
    'other' )
        export scriptpurposeexport=true
        export scriptpurposeimport=true
        export scriptpurposeupdate=true
        export scriptpurposerename=true
        export scriptpurposedelete=true
        export scriptpurposeother=true
        ;;
    'export' )
        export scriptpurposeexport=true
        ;;
    'import' )
        export scriptpurposeimport=true
        ;;
    'set-update' )
        export scriptpurposeupdate=true
        ;;
    'rename' )
        export scriptpurposerename=true
        ;;
    'delete' )
        export scriptpurposedelete=true
        ;;
    'process' )
        export scriptpurposeprocess=true
        ;;
    # Anything unknown is recorded for later
    * )
        # MODIFIED 2022-04-22
        export scriptpurposeother=true
        export scriptpurposeprocess=true
        ;;
esac

export script_use_export=true
export script_use_import=true
export script_use_delete=true
export script_use_csvfile=true

export script_dump_csv=true
export script_dump_json=true
export script_dump_standard=true
export script_dump_full=true

export script_uses_wip=true
export script_uses_wip_json=true

export script_slurp_json=true
export script_slurp_json_full=true
export script_slurp_json_standard=true

export script_save_json_repo=true
export script_use_json_repo=true
export script_json_repo_detailslevel="full"
export script_json_repo_folder="__json_objects_repository"

# Wait time in seconds
export WAITTIME=15


# =================================================================================================
# END:  Setup Root Parameters
# =================================================================================================
# -------------------------------------------------------------------------------------------------

# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START Configure Testing root parameters
# -------------------------------------------------------------------------------------------------

export Testinglogfileroot=.
export Testinglogfilefolder=dump/testing/${DATE}
export Testinglogfilename=Testing_log_${ScriptName}.`date +%Y%m%d-%H%M%S%Z`.log

# -------------------------------------------------------------------------------------------------
# Root script declarations
# -------------------------------------------------------------------------------------------------

export Script2TestPath=.

# Removing dependency on clish to avoid collissions when database is locked
#
#export currentapisslport=$(clish -c "show web ssl-port" | cut -d " " -f 2)
#

if [ -r ${MDS_FWDIR}/Python/bin/python3 ] ; then
    # Working on R81.20 EA or later, where python3 replaces the regular python call
    #
    #export currentapisslport=$(clish -c "show web ssl-port" | cut -d " " -f 2)
    #
    export pythonpath=${MDS_FWDIR}/Python/bin
    export get_api_local_port=`${pythonpath}/python3 ${MDS_FWDIR}/scripts/api_get_port.py -f json | ${JQ} '. | .external_port'`
    export api_local_port=${get_api_local_port//\"/}
    export currentapisslport=${api_local_port}
else
    # Not working MaaS so will check locally for Gaia web SSL port setting
    # Removing dependency on clish to avoid collissions when database is locked
    #
    #export currentapisslport=$(clish -c "show web ssl-port" | cut -d " " -f 2)
    #
    export pythonpath=${MDS_FWDIR}/Python/bin
    export get_api_local_port=`${pythonpath}/python ${MDS_FWDIR}/scripts/api_get_port.py -f json | ${JQ} '. | .external_port'`
    export api_local_port=${get_api_local_port//\"/}
    export currentapisslport=${api_local_port}
fi

export TestSSLport=${currentapisslport}

# 2018-05-04 - script type - script testing 

export script_test_template=true
export script_test_export_import=false

export script_test_common=true


# -------------------------------------------------------------------------------------------------
# END Configure Testing root parameters
# -------------------------------------------------------------------------------------------------
# =================================================================================================

# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START common procedures
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# SetupTestingLogFile - Setup log file for testing operation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupTestingLogFile () {
    #
    # SetupTestingLogFile - Setup log file for testing operation
    #
    
    export Testinglogfilebase=${Testinglogfileroot}/${Testinglogfilefolder}
    export Testinglogfile=${Testinglogfilebase}/${Testinglogfilename}
    
    if [ ! -r ${Testinglogfilebase} ] ; then
        mkdir -p -v ${Testinglogfilebase} >>  ${Testinglogfile} 2>>  ${Testinglogfile}
    fi
    
    touch ${Testinglogfile}
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' | tee -a -i ${Testinglogfile}
    echo `${dtzs}`${dtzsep} | tee -a -i ${Testinglogfile}
    echo `${dtzs}`${dtzsep} 'Script:  '${ScriptName}'  Script Version: '${APIScriptVersion} | tee -a -i ${Testinglogfile}
    echo `${dtzs}`${dtzsep} | tee -a -i ${Testinglogfile}
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# FinishUpTesting - handle testing finish up operations and close out log file
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinishUpTesting () {
    #
    # handle testing finish up operations and close out log file
    #
    
    echo `${dtzs}`${dtzsep} 'Testing Operations Completed' | tee -a -i ${Testinglogfile}
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${Testinglogfile}
        #echo `${dtzs}`${dtzsep} "Files in >${Testinglogfileroot}<" | tee -a -i ${Testinglogfile}
        #ls -alh ${Testinglogfileroot} | tee -a -i ${Testinglogfile}
        #echo `${dtzs}`${dtzsep} | tee -a -i ${Testinglogfile}
        
        echo `${dtzs}`${dtzsep} "Files in >${Testinglogfilebase}<" | tee -a -i ${Testinglogfile}
        ls -alhR ${Testinglogfilebase} | tee -a -i ${Testinglogfile}
        echo `${dtzs}`${dtzsep} | tee -a -i ${Testinglogfile}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${Testinglogfile}
    echo `${dtzs}`${dtzsep} "Testing Results in directory ${Testinglogfilebase}" | tee -a -i ${Testinglogfile}
    echo `${dtzs}`${dtzsep} "Log output in file ${Testinglogfile}" | tee -a -i ${Testinglogfile}
    echo `${dtzs}`${dtzsep} | tee -a -i ${Testinglogfile}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' | tee -a -i ${Testinglogfile}
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# GetGaiaVersionAndInstallationType - Gaia version and installation type Handler calling routine
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetGaiaVersionAndInstallationType () {
    #
    # GetGaiaVersionAndInstallationType - Gaia version and installation type Handler calling routine
    #
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling external Gaia version and installation type Handling Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${gaia_version_handler} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling external Gaia version and installation type Handling Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${gaia_version_handler} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    . ${gaia_version_handler} "$@"
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Gaia version and installation type Handling Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Gaia version and installation type Handling Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi

}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-10-21

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Call Gaia version and installation type Handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export configured_handler_root=${gaia_version_handler_root}
export actual_handler_root=${configured_handler_root}

if [ "${configured_handler_root}" == "." ] ; then
    if [ ${ScriptSourceFolder} != ${localdotpath} ] ; then
        # Script is not running from it's source folder, might be linked, so since we expect the handler folder
        # to be relative to the script source folder, use the identified script source folder instead
        export actual_handler_root=${ScriptSourceFolder}
    else
        # Script is running from it's source folder
        export actual_handler_root=${configured_handler_root}
    fi
else
    # handler root path is not period (.), so stipulating fully qualified path
    export actual_handler_root=${configured_handler_root}
fi

export gaia_version_handler_path=${actual_handler_root}/${gaia_version_handler_folder}
export gaia_version_handler=${gaia_version_handler_path}/${gaia_version_handler_file}

# Check that we can finde the command line parameter handler file
#
if [ ! -r ${gaia_version_handler} ] ; then
    # no file found, that is a problem
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} ' Gaia version and installation type handler script file missing' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  File not found : '${gaia_version_handler} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Other parameter elements : ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Configured Root path    : '${configured_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Root of folder path : '${gaia_version_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder in Root path : '${gaia_version_handler_folder} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder Root path    : '${gaia_version_handler_path} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Script Filename     : '${gaia_version_handler_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit 251
fi

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-10-21

GetGaiaVersionAndInstallationType "$@"


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# END common procedures
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START testing procedures
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ResetExternalParameters - Reset Externally controllable parameters
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ResetExternalParameters () {
    #
    # Reset Externally controllable parameters
    #
    
    export APISCRIPTVERBOSE=
    export NOWAIT=
    export CLEANUPCSVWIP=
    export NODOMAINFOLDERS=
    export CSVADDEXPERRHANDLE=
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# HandleScriptTesting_CLIParms - repeated proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-03-2 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#


#
# Standard R8X API Scripts Command Line Parameters
#
# -? | --help
# -v | --verbose
# -P <web-ssl-port> | --port <web-ssl-port> | -P=<web-ssl-port> | --port=<web-ssl-port>
# -r | --root
# -u <admin_name> | --user <admin_name> | -u=<admin_name> | --user=<admin_name>
# -p <password> | --password <password> | -p=<password> | --password=<password>
# -m <server_IP> | --management <server_IP> | -m=<server_IP> | --management=<server_IP>
# --domain-System-Data | --dSD | --dsd
# --domain-Global | --dG | --dg
# -d <domain> | --domain <domain> | -d=<domain> | --domain=<domain>
# -s <session_file_filepath> | --session-file <session_file_filepath> | -s=<session_file_filepath> | --session-file=<session_file_filepath>
# -l <log_path> | --log-path <log_path> | -l=<log_path> | --log-path=<log_path>'
#
# -o <output_path> | --output <output_path> | -o=<output_path> | --output=<output_path> 
#
# -x <export_path> | --export-path <export_path> | -x=<export_path> | --export-path=<export_path> 
# -i <import_path> | --import-path <import_path> | -i=<import_path> | --import-path=<import_path>'
# -k <delete_path> | --delete-path <delete_path> | -k=<delete_path> | --delete-path=<delete_path>'
#
# -c <csv_path> | --csv <csv_path> | -c=<csv_path> | --csv=<csv_path>'
#
# --NOWAIT
#
# --NSO | --no-system-objects
# --SO | --system-objects
#
# --CSVERR | --CSVADDEXPERRHANDLE
#
# --KEEPCSVWIP | --CLEANUPCSVWIP
# --NODOMAINFOLDERS
#

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleScriptTesting_CLIParms () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    
    ResetExternalParameters
    
    . ${Script2TestFilepath} -?
    . ${Script2TestFilepath} --help
    
    
    if [ ${Check4MDS} -eq 1 ] ; then
        # MDM Tests
        echo `${dtzs}`${dtzsep} 'Multi-Domain Management stuff...' | tee -a -i ${Testinglogfile}
    
    elif [ ${Check4SMS} -eq 1 ] || [ $Check4EPM -eq 1 ] ; then
        # Just SMS Tests
        echo `${dtzs}`${dtzsep} 'Security Management Server stuff...' | tee -a -i ${Testinglogfile}
        if [ $Check4EPM -eq 1 ] ; then
            # EPM (not just SMS) Tests
            echo `${dtzs}`${dtzsep} 'Endpoint Security Management Server stuff...' | tee -a -i ${Testinglogfile}
        fi
        
        . ${Script2TestFilepath} --port ${TestSSLport} -r
        . ${Script2TestFilepath} --port ${TestSSLport} -v -r
        . ${Script2TestFilepath} --port ${TestSSLport} --verbose -r
        . ${Script2TestFilepath} --port ${TestSSLport} -v -u _apiadmin
        . ${Script2TestFilepath} --port ${TestSSLport} -v -u _apiadmin -p Cpwins1!
        
        ResetExternalParameters
        
        . ${Script2TestFilepath} --port ${TestSSLport} -v --NOWAIT -r
        . ${Script2TestFilepath} --port ${TestSSLport} -v --NOWAIT -u _apiadmin
        . ${Script2TestFilepath} --port ${TestSSLport} -v --NOWAIT -u _apiadmin -p Cpwins1!
        
        if ${script_test_template} ; then
            # testing templates, so work the full set of parameters
            
            . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -r --CLEANUPCSVWIP --NODOMAINFOLDERS --CSVADDEXPERRHANDLE
            . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -r --CLEANUPCSVWIP --NODOMAINFOLDERS --CSVADDEXPERRHANDLE --SO
            . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -r --CLEANUPCSVWIP --NODOMAINFOLDERS --CSVADDEXPERRHANDLE --NSO
            
            ResetExternalParameters
            
            . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -r -l ${Testinglogfilebase} -o ${Testinglogfilebase}/output -x ${Testinglogfilebase}/export -i /var/tmp/import.csv -k /var/tmp/delete.csv
            
            . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -r -l ${Testinglogfilebase} -c ${Testinglogfilebase}/example_csv.csv
            
            . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -u _apiadmin -p Cpwins1! --CLEANUPCSVWIP --NODOMAINFOLDERS --CSVADDEXPERRHANDLE
            . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -u _apiadmin -p Cpwins1! --CLEANUPCSVWIP --NODOMAINFOLDERS --CSVADDEXPERRHANDLE --SO
            
        fi
        
    elif [ ${Check4GW} -eq 1 ] ; then
        # GW Tests - when that has an API
        echo `${dtzs}`${dtzsep} 'Gateway stuff...' | tee -a -i ${Testinglogfile}
        
    else
        # and what is this????
        echo `${dtzs}`${dtzsep} 'and what is this????' | tee -a -i ${Testinglogfile}
        
    fi
    
    if [ ${Check4MDS} -eq 1 ] ; then
        # More MDM Tests
        echo `${dtzs}`${dtzsep} 'More Multi-Domain Management stuff...' | tee -a -i ${Testinglogfile}
        
        . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -d "System Data" -r
        . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -d "System Data" -u _apiadmin
        . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -d "System Data" -u _apiadmin -p Cpwins1!
        
        # This is a forced failure test
        . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -d "GLOBAL" -r
        
        . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -d "Global" -r
        . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -d "Global" -u _apiadmin
        . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -d "Global" -u _apiadmin -p Cpwins1!
        
        . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -d "EXAMPLE-DEMO" -r
        . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -d "EXAMPLE-DEMO" -u _apiadmin
        . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -d "EXAMPLE-DEMO" -u _apiadmin -p Cpwins1!
        
        if ${script_test_template} ; then
            # testing templates, so work the full set of parameters
            
            . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -d "Global" -r -l ${Testinglogfilebase} -o ${Testinglogfilebase}/output -x ${Testinglogfilebase}/export -i /var/tmp/import.csv -k /var/tmp/delete.csv
            . ${Script2TestFilepath} -v --port ${TestSSLport} --NOWAIT -d "System Data" -r -l ${Testinglogfilebase} -o ${Testinglogfilebase}/output -x ${Testinglogfilebase}/export -i /var/tmp/import.csv -k /var/tmp/delete.csv
            
        fi
        
    fi
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END testing procedures
# -------------------------------------------------------------------------------------------------
# =================================================================================================

SetupTestingLogFile

echo `${dtzs}`${dtzsep} | tee -a -i ${Testinglogfile}
echo `${dtzs}`${dtzsep} 'Script:  '${ScriptName}'  Script Version: '${APIScriptVersion} | tee -a -i ${Testinglogfile}


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START testing
# -------------------------------------------------------------------------------------------------

DetermineGaiaVersionAndInstallType "$@"

export TestSSLport=$(clish -c "show web ssl-port" | cut -d " " -f 2)
echo `${dtzs}`${dtzsep} 'Current Gaia web ssl-port : '${TestSSLport} | tee -a -i ${Testinglogfile}


export Script2TestName=api_mgmt_cli_shell_template_with_cmd_line_parameters.template.v${ScriptVersion}.sh

export Script2TestFilepath=${Script2TestPath}/${Script2TestName}

HandleScriptTesting_CLIParms "$@"


export Script2TestName=api_mgmt_cli_shell_template_with_cmd_line_parameters_script.template.v${ScriptVersion}.sh

export Script2TestFilepath=${Script2TestPath}/${Script2TestName}

HandleScriptTesting_CLIParms "$@"

# -------------------------------------------------------------------------------------------------
# END testing
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# =================================================================================================
# =================================================================================================
# END script
# =================================================================================================
# =================================================================================================

FinishUpTesting "$@"

# =================================================================================================
# =================================================================================================
# =================================================================================================
# =================================================================================================

