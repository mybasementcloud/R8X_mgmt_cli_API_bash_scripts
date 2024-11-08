#!/bin/bash
#
# (C) 2016-2021 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
#
# ALL SCRIPTS ARE PROVIDED AS IS WITHOUT EXPRESS OR IMPLIED WARRANTY OF FUNCTION OR POTENTIAL FOR
# DAMAGE Or ABUSE.  AUTHOR DOES NOT ACCEPT ANY RESPONSIBILITY FOR THE USE OF THESE SCRIPTS OR THE
# RESULTS OF USING THESE SCRIPTS.  USING THESE SCRIPTS STIPULATES A CLEAR UNDERSTANDING OF RESPECTIVE
# TECHNOLOGIES AND UNDERLYING PROGRAMMING CONCEPTS AND STRUCTURES AND IMPLIES CORRECT IMPLEMENTATION
# OF RESPECTIVE BASELINE TECHNOLOGIES FOR PLATFORM UTILIZING THE SCRIPTS.  THIRD PARTY LIMITATIONS
# APPLY WITHIN THE SPECIFICS THEIR RESPECTIVE UTILIZATION AGREEMENTS AND LICENSES.  AUTHOR DOES NOT
# AUTHORIZE RESALE, LEASE, OR CHARGE FOR UTILIZATION OF THESE SCRIPTS BY ANY THIRD PARTY.
#
# Test Export Execution collection - test environment
#
#
ScriptVersion=00.70.00
ScriptRevision=000
ScriptSubRevision=100
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

ScriptName=test_exports_with_some_do_cpi
export APIScriptFileNameRoot=test_exports_with_some_do_cpi
export APIScriptShortName=test_exports_some_do_cpi
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Test Export Execution collection"

# =================================================================================================
# =================================================================================================
# START script
# =================================================================================================
# =================================================================================================


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START Initial Script Setup
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# =================================================================================================
# START:  Setup Root Parameters
# =================================================================================================


export DATE=`date +%Y-%m-%d-%H%M%Z`
export DATEDTG=`date +%Y-%m-%d-%H%M%Z`
export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
export dtgs_script_start_utc=`date -u +%F-%T-%Z`
export dtgs_script_start=`date +%F-%T-%Z`

#
# rootsafeworkpath     :  This is the path where it is safe to store scripts, to survive upgrades and patching
# customerpathroot     :  Path to the customer work environment, should be under ${rootsafeworkpath}
# scriptspathroot      :  Path to the folder with bash 4 Check Point scripts installation (b4CP)
#

export rootsafeworkpath=/var/log
export customerpathroot=${rootsafeworkpath}/__customer
export scriptspathroot=${customerpathroot}/upgrade_export/scripts

export rootscriptconfigfile=__root_script_config.sh

export cexlogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log
export cextemplogfilepath=${cexlogfilepath}


# -------------------------------------------------------------------------------------------------


export cexdtzs='date -u +%Y%m%d-%T-%Z'
export cexdtzsep=' | '


# -------------------------------------------------------------------------------------------------


if [ -r "${customerpathroot}/devops.results" ] ; then
    export cexlogfolder=${customerpathroot}/devops.results/${DATEDTG}'_'${ScriptName}
    if [ ! -r ${cexlogfolder} ] ; then
        mkdir -p -v ${cexlogfolder} >> ${cexlogfilepath}
        chmod 775 ${cexlogfolder} >> ${cexlogfilepath}
    else
        chmod 775 ${cexlogfolder} >> ${cexlogfilepath}
    fi
    export cexlogfilepath=${cexlogfolder}/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log
fi

if [ "${cexlogfilepath}" != "${cextemplogfilepath}" ] ; then
    cat ${cextemplogfilepath} >> ${cexlogfilepath}
    rm ${cextemplogfilepath} >> ${cexlogfilepath}
fi

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
    if [ "${readdtzs}" == null ] ; then
        export cexdtzs=${cexdtzs}
    elif [ x"${readdtzs}" != x"" ] ; then
        export cexdtzs=${readdtzs}
    else
        export cexdtzs=${cexdtzs}
    fi
    getdtzsep=`cat ${dot_enviroinfo_fqpn} | jq -r ."script_ui_config"."dtzsep"`
    readdtzsep=${getdtzsep}
    if [ "${readdtzsep}" == null ] ; then
        export cexdtzsep=${cexdtzsep}
    elif [ x"${readdtzsep}" != x"" ] ; then
        export cexdtzsep=${readdtzsep}
    else
        export cexdtzs=${cexdtzs}
    fi
fi


# -------------------------------------------------------------------------------------------------

export common_exports_dtgs_script_start_utc=${dtgs_script_start_utc}
export common_exports_dtgs_script_start=${dtgs_script_start}

# -------------------------------------------------------------------------------------------------
# Announce what we are starting here...
# -------------------------------------------------------------------------------------------------


echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} 'Script:  '${ScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} 'Script original call name :  '$0 | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# ADDED 2021-11-09 - MODIFIED 2024-05-09:01 -
#
# Presumptive folder structure for R8X mgmt_cli API bash scripts Template based scripts
#
# <root_home_folder> is the folder containing the script set, generally /var/log/__customer
# <script_home_folder> is the folder containing the script set, generally /var/log/__customer/[_testing/]mgmt_cli
# DEPRECATED:  <script_home_folder> is the folder containing the script set, Legacy /var/log/__customer/devops|devops.dev|devops.dev.test
# DEPRECATED:  [.wip] named folders are for development operations
#
# ...<root_home_folder>/devops.my_data                     ## my_data folder for all scripts, folder for all customer provided csv folders
# ...<root_home_folder>/devops.results                     ## results folder for all scripts, default home of ${script_json_repo_folder}
# ...<root_home_folder>/tools                              ## tools folder for all scripts with additional tools not assumed on system
# ...<script_home_folder>/_common/                         ## _common root folder for all common scripts and templates
# ...<script_home_folder>/_common/_api_subscripts          ## _api_subscripts folder for all api subscripts scripts
# ...<script_home_folder>/_common/_templates               ## _templates folder for all script templates
# ...<script_home_folder>/objects                          ## objects root folder for objects focused scripts
# ...<script_home_folder>/objects/object_csv_tools         ## object_csv_tools folder for csv file handling for objects focused scripts
# ...<script_home_folder>/objects/object_export_import     ## object_export_import folder for object export, import, set, rename, and delete operations focused scripts
# ...<script_home_folder>/objects/object_mdsm_export       ## object_mdsm_export folder for MDSM object operations and MDSM tools scripts
# ...<script_home_folder>/objects/object_mdsm_ops          ## object_mdsm_ops folder for objects operations and testing scripts for use on MDSM hosts
# ...<script_home_folder>/objects/object_research          ## object_research folder for objects operations research focused scripts
# ...<script_home_folder>/objects/object_sms_ops           ## object_sms_ops folder for objects operations and testing scripts for use on SMS or MDSM domains individually
# ...<script_home_folder>/objects/object_testing_data      ## object_testing_data folder for testing data for use with testing scripts
# ...<script_home_folder>/policy_layers                    ## policy_layers folder for policy and layers operations focused scripts
# ...<script_home_folder>/session_tasks_ops                ## session_tasks_ops folder for session cleanup and tasks operation focused scripts
#
# api_subscripts_default_root is defined with the assumption that scripts are running in a subfolder of the <script_home_folder>/_common folder
#
# Default expected folders for normal operations:
#
#    /var/log/__customer/devops.my_data
#    /var/log/__customer/devops.results
#    /var/log/__customer/devops.results/__json_objects_repository
#    /var/log/__customer/mgmt_cli
#    /var/log/__customer/mgmt_cli/_common
#    /var/log/__customer/mgmt_cli/_common/_api_subscripts
#    /var/log/__customer/mgmt_cli/_common/_templates
#    /var/log/__customer/mgmt_cli/objects
#    /var/log/__customer/mgmt_cli/objects/object_csv_tool
#    /var/log/__customer/mgmt_cli/objects/object_export_import
#    /var/log/__customer/mgmt_cli/objects/object_mdsm_export
#    /var/log/__customer/mgmt_cli/objects/object_mdsm_ops
#    /var/log/__customer/mgmt_cli/objects/object_research
#    /var/log/__customer/mgmt_cli/objects/object_sms_ops
#    /var/log/__customer/mgmt_cli/objects/object_testing_data
#    /var/log/__customer/mgmt_cli/policy_layers
#    /var/log/__customer/mgmt_cli/session_tasks_ops
#    /var/log/__customer/tools
#
# Default expected folders for testing operations:
#
#    /var/log/__customer/_testing/mgmt_cli
#    /var/log/__customer/_testing/mgmt_cli/_common
#    /var/log/__customer/_testing/mgmt_cli/_common/_api_subscripts
#    /var/log/__customer/_testing/mgmt_cli/_common/_templates
#    /var/log/__customer/_testing/mgmt_cli/objects
#    /var/log/__customer/_testing/mgmt_cli/objects/object_csv_tool
#    /var/log/__customer/_testing/mgmt_cli/objects/object_export_import
#    /var/log/__customer/_testing/mgmt_cli/objects/object_mdsm_export
#    /var/log/__customer/_testing/mgmt_cli/objects/object_mdsm_ops
#    /var/log/__customer/_testing/mgmt_cli/objects/object_research
#    /var/log/__customer/_testing/mgmt_cli/objects/object_sms_ops
#    /var/log/__customer/_testing/mgmt_cli/objects/object_testing_data
#    /var/log/__customer/_testing/mgmt_cli/policy_layers
#    /var/log/__customer/_testing/mgmt_cli/session_tasks_ops
#    /var/log/__customer/devops.my_data
#    /var/log/__customer/devops.results
#    /var/log/__customer/devops.results/__json_objects_repository
#    /var/log/__customer/tools
#
#


# MODIFIED 2024-05-01:01 -

export test_script_work_folder=../object_export_import

if [ -r "cli_api_export_objects.sh" ] ; then
    # found the script in the local directory, use that
    #export test_script_work_folder=.
    export test_script_work_folder=`pwd`
else
    # DID NOT find the script in the local directory, use the standard assumption
    pushd ${test_script_work_folder} >> ${cexlogfilepath}
    errorreturn=$?
    
    if [ ${errorreturn} -ne 0 ] ; then
        # we apparently didn't start where expected, so dumping
        echo `${cexdtzs}`${cexdtzsep} 'Required target folder '"${test_script_work_folder}"' not found, exiting!' | tee -a -i ${cexlogfilepath}
        #popd >> ${cexlogfilepath}
        exit 254
    else
        #OK, so we are where we want to be relative to the script targets
        export test_script_work_folder=`pwd`
    fi
    
    # Return to the script operations folder
    popd >> ${cexlogfilepath}
fi

echo `${cexdtzs}`${cexdtzsep} 'test_script_work_folder = '"${test_script_work_folder}" | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")

#
# JSON and CSV Exports, builds JSON Repository
#
#export TESTOPSARRAY+=("cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVALL")
#export TESTOPSARRAY+=("cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --NSO --10-TAGS --CSVERR")
#export TESTOPSARRAY+=("cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --OSO --10-TAGS --CSVALL")

#
# JSON only Exports, builds JSON Repository
#
export TESTOPSARRAY+=("cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO --DO-CPI")
export TESTOPSARRAY+=("cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO --DO-CPI")
export TESTOPSARRAY+=("cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO --DO-CPI")

#
# CSV only Exports
#
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVALL")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR --DO-CPI")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --OSO --10-TAGS --CSVALL")

#export TESTOPSARRAY+=("cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --SO --10-TAGS --CSVALL")
export TESTOPSARRAY+=("cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --NSO --10-TAGS --CSVERR --DO-CPI")
#export TESTOPSARRAY+=("cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --OSO --10-TAGS --CSVALL")

# --type-of-export <export_type> | --type-of-export=<export_type>
#  Supported <export_type> values for export to CSV :  <"standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name"|"name-for-delete">
#    "standard" {DEFAULT} :  Standard Export of all supported object key values
#    "name-only"          :  Export of just the name key value for object
#    "name-and-uid"       :  Export of name and uid key value for object
#    "uid-only"           :  Export of just the uid key value of objects
#    "rename-to-new-name" :  Export of name key value for object rename
#    "name-for-delete"    :  Export of name key value for object delete also sets other settings needed for clean delete control CSV
#    For an export for a delete operation via CSV, use "name-only"

export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-only' --DO-CPI")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-and-uid' --DO-CPI")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'uid-only' --DO-CPI")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name' --DO-CPI")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO -t 'name-for-delete' --DO-CPI")

export TESTOPSARRAY+=("cli_api_export_objects.sh --domain-System-Data -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVALL")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh --domain-System-Data -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVERR")
export TESTOPSARRAY+=("cli_api_export_special_objects_to_csv.sh --domain-System-Data -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --SO --10-TAGS --CSVERR")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-01-06:01 -

echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} These test will be executed: | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}

for cjlocalop in "${TESTOPSARRAY[@]}" ; do
    
    #echo `${cexdtzs}`${cexdtzsep} "${cjlocalop}, ${cjlocalop//\'/}" | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} "${cjlocalop}" | tee -a -i ${cexlogfilepath}
    
done

echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${cexdtzs}`${cexdtzsep} 'Short nap to adjust for log files times...zzzz' | tee -a -i ${cexlogfilepath}
sleep 61

echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-01-10:01 - 

# Collect this scripts calling parameters into a variable

export cexdCLIParms=

for cexdparm in "$@"
do
    export cexdCLIParms="${cexdCLIParms} \"${cexdparm//\"/\\\"}\""
    #"
done
cexdparm=


echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} 'Starting Test Series:'| tee -a -i ${cexlogfilepath}

errorreturn=0

echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}

for clocalop in "${TESTOPSARRAY[@]}" ; do
    # Loop through array of testing or export operations
    
    errorreturn=0
    
    echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} 'Starting folder:      '`pwd` | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
    
    pushd ${test_script_work_folder} >>  ${cexlogfilepath}
    
    export cexcommand="${clocalop}"
    echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} 'Executing operation:  '"${clocalop}" | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} 'In folder:            '"${test_script_work_folder}" | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} 'Current folder:       '`pwd` | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
    
    #. ${cexcommand} "$@"
    . ${cexcommand} ${cexdCLIParms}
    #bash -li ${cexcommand} ${cexdCLIParms}
    errorreturn=$?
    
    popd >>  ${cexlogfilepath}
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${cexdtzs}`${cexdtzsep} 'Error '${errorreturn}' in operation:  '"${cexcommand}" | tee -a -i ${cexlogfilepath}
        echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
        exit ${errorreturn}
    fi
    
    echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
    
done


echo `${cexdtzs}`${cexdtzsep} 'Test Series Completed'| tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


export common_exports_dtgs_script_finish_utc=`date -u +%F-%T-%Z`
export common_exports_dtgs_script_finish=`date +%F-%T-%Z`

echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} 'Script execution START  :'"${common_exports_dtgs_script_start}"' UTC :  '"${common_exports_dtgs_script_start_utc}" | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} 'Script execution FINISH :'"${common_exports_dtgs_script_finish}"' UTC :  '"${common_exports_dtgs_script_finish_utc}" | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} 'Common Execution Log File :'"${cexlogfilepath}" | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo
