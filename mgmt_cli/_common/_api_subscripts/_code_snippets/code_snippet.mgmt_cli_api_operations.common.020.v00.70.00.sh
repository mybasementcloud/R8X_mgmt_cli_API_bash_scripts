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
# SCRIPTS Code Snippet API Subscripts - management CLI API operations Handler operations
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


exit /b

\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/


# -------------------------------------------------------------------------------------------------
# Configure location for api subscripts
# -------------------------------------------------------------------------------------------------

# ADDED 2020-09-09 -
# Configure basic location for api subscripts
export api_subscripts_default_root=..
export api_subscripts_default_folder=_api_subscripts
export api_subscripts_checkfile=api_subscripts_version.${APISubscriptsLevel}.v${APISubscriptsVersion}.version

#
# Check for whether the subscripts are present where expected, if not hard EXIT
#
if [ -r "${api_subscripts_default_root}/${api_subscripts_default_folder}/${api_subscripts_checkfile}" ]; then
    # OK, found the api subscripts in the default root
    export api_subscripts_root=${api_subscripts_default_root}
elif [ -r "./${api_subscripts_default_folder}/${api_subscripts_checkfile}" ]; then
    # OK, didn't find the api subscripts in the default root, instead found them in the working folder
    export api_subscripts_root=.
else
    # OK, didn't find the api subscripts where we expect to find them, so this is bad!
    echo `${dtzs}`${dtzsep}
    echo `${dtzs}`${dtzsep} 'Missing critical api subscript files that are expected in the one of the following locations:'
    echo `${dtzs}`${dtzsep} ' PREFERRED Location :  '"${api_subscripts_default_root}/${api_subscripts_default_folder}/${api_subscripts_checkfile}"
    echo `${dtzs}`${dtzsep} ' ALTERNATE Location :  '"./${api_subscripts_default_folder}/${api_subscripts_checkfile}"
    echo `${dtzs}`${dtzsep}
    echo `${dtzs}`${dtzsep} 'Unable to continue without these api subscript files, so exiting!!!'
    echo `${dtzs}`${dtzsep}
    exit 1
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -
# Configure basic information for formation of file path for basic script setup API Scripts handler script
#
# mgmt_cli_API_operations_handler_root - root path to basic script setup API Scripts handler script. Period (".") indicates root of script source folder
# mgmt_cli_API_operations_handler_folder - folder for under root path to basic script setup API Scripts handler script
# mgmt_cli_API_operations_handler_file - filename, without path, for basic script setup API Scripts handler script
#

# MODIFIED 2020-11-16 -
export mgmt_cli_API_operations_handler_root=..
export mgmt_cli_API_operations_handler_folder=_api_subscripts
export mgmt_cli_API_operations_handler_file=mgmt_cli_api_operations.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/


# =================================================================================================
# =================================================================================================
# START:  Management CLI API Operations Handling
# =================================================================================================




# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-08:01 - 

# -------------------------------------------------------------------------------------------------
# mgmt_cli keep alive configuration parameters
# -------------------------------------------------------------------------------------------------

#
# mgmtclikeepalivelast       : Very First or Last time CheckAPIKeepAlive was checked, using ${SECONDS}
# mgmtclikeepalivenow        : Current time for check versus last, using ${SECONDS}
# mgmtclikeepaliveelapsed    : The calculated seconds between the current check and last time CheckAPIKeepAlive was checked
# mgmtclikeepaliveinterval   : Interval between executions of CheckAPIKeepAlive desired, with default at 60 seconds
#
# Need to add CLI configuration parameter for this value ${mgmtclikeepaliveinterval} in the future to tweak
#

export mgmtclikeepalivelast=${SECONDS}
export mgmtclikeepalivenow=
export mgmtclikeepaliveelapsed=
export mgmtclikeepaliveinterval=60


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Check API Keep Alive Status - CheckAPIKeepAlive
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-08:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Check API Keep Alive Status.
#
CheckAPIKeepAlive () {
    #
    # Check API Keep Alive Status and on error try a login attempt
    #
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-08:01 - 
    
    #export mgmtclikeepalivelast=${SECONDS}
    #export mgmtclikeepalivenow=
    #export mgmtclikeepaliveinterval=60
    #export mgmtclikeepaliveelapsed=
    
    export mgmtclikeepalivenow=${SECONDS}
    export mgmtclikeepaliveelapsed=$(( ${mgmtclikeepalivenow} - ${mgmtclikeepalivelast} ))
    
    echo `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  last = '${mgmtclikeepalivelast}' current = '${mgmtclikeepalivenow}' elapsed = '${mgmtclikeepaliveelapsed} >> ${logfilepath}
    
    if [[ ${mgmtclikeepaliveelapsed} -gt ${mgmtclikeepaliveinterval} ]] ; then
        # Last check for keep alive was longer ago than the ${mgmtclikeepaliveinterval} so do the check
        
        # -------------------------------------------------------------------------------------------------
        
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        
        tempworklogfile=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.keepalivecheck.log
        
        if ${LoggedIntoMgmtCli} ; then
            #echo -n `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  ' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  Elapsed seoconds since last check = '${mgmtclikeepaliveelapsed}', which is greater than the interval = '${mgmtclikeepaliveinterval} >> ${tempworklogfile}
            echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${tempworklogfile}
            
            echo -n `${dtzs}`${dtzsep}' ' > ${tempworklogfile}
            if ${addversion2keepalive} ; then
                #mgmt_cli keepalive --version ${CurrentAPIVersion} -s ${APICLIsessionfile} >> ${logfilepath} 2>&1
                mgmt_cli keepalive --version ${CurrentAPIVersion} -s ${APICLIsessionfile} >> ${tempworklogfile} 2>&1
                export errorreturn=$?
            else
                #mgmt_cli keepalive -s ${APICLIsessionfile} >> ${logfilepath} 2>&1
                mgmt_cli keepalive -s ${APICLIsessionfile} >> ${tempworklogfile} 2>&1
                export errorreturn=$?
            fi
            
            echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${tempworklogfile}
            
            cat ${tempworklogfile} >> ${logfilepath}
            
            echo `${dtzs}`${dtzsep}' Remove temporary log file:  "'${tempworklogfile}'"' >> ${logfilepath}
            echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
            rm -v ${tempworklogfile} >> ${logfilepath} 2>&1
            
            echo `${dtzs}`${dtzsep} 'Keep Alive Check errorreturn = [ '${errorreturn}' ]' | tee -a -i ${logfilepath}
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Problem during mgmt_cli keepalive operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Lets see if we can login again' | tee -a -i ${logfilepath}
                
                export LoggedIntoMgmtCli=false
                
                . ${mgmt_cli_API_operations_handler} LOGIN "$@"
                LOGINEXITCODE=$?
                
                if [ ${LOGINEXITCODE} != 0 ] ; then
                    exit ${LOGINEXITCODE}
                else
                    export LoggedIntoMgmtCli=true
                    export errorreturn=0
                fi
            fi
        else
            # Uhhh what, this check should only happen if logged in
            echo `${dtzs}`${dtzsep} ' Executing mgmt_cli login instead of mgmt_cli keepalive check ?!?...  ' | tee -a -i ${logfilepath}
            
            export LoggedIntoMgmtCli=false
            
            . ${mgmt_cli_API_operations_handler} LOGIN "$@"
            LOGINEXITCODE=$?
            
            if [ ${LOGINEXITCODE} != 0 ] ; then
                exit ${LOGINEXITCODE}
            else
                export LoggedIntoMgmtCli=true
                export errorreturn=0
            fi
        fi
        
        echo `${dtzs}`${dtzsep} 'Keep Alive Check completed!' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        
        # -------------------------------------------------------------------------------------------------
        
    else
        # Last check for keep alive was more recent than the ${mgmtclikeepaliveinterval} so skip this one
        echo `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  Elapsed seoconds since last check = '${mgmtclikeepaliveelapsed}', which is within the interval = '${mgmtclikeepaliveinterval} >> ${logfilepath}
    fi
    export mgmtclikeepalivelast=${SECONDS}
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ - MODIFIED 2023-03-08:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckMgmtCLIAPIOperationsHandler - Management CLI API Operations Handler calling routine
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckMgmtCLIAPIOperationsHandler () {
    #
    # CheckMgmtCLIAPIOperationsHandler - Management CLI API Operations Handler calling routine
    #
    
    errorresult=0
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling external Management CLI API Operations Handler Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${mgmt_cli_API_operations_handler} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling external Management CLI API Operations Handler Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${mgmt_cli_API_operations_handler} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    . ${mgmt_cli_API_operations_handler} CHECK "$@"
    errorresult=$?
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Management CLI API Operations Handler Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Error Return Code = '${errorresult} | tee -a -i ${logfilepath}
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
        echo `${dtzs}`${dtzsep} "Returned from external Management CLI API Operations Handler Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Error Return Code = '${errorresult} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    return  ${errorresult}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-10-21

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Call Basic Script Setup for API Scripts Handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -

export configured_handler_root=${mgmt_cli_API_operations_handler_root}
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

export mgmt_cli_API_operations_handler_path=${actual_handler_root}/${mgmt_cli_API_operations_handler_folder}
export mgmt_cli_API_operations_handler=${mgmt_cli_API_operations_handler_path}/${mgmt_cli_API_operations_handler_file}

# Check that we can finde the Basic Script Setup for API Scripts Handler file
#
if [ ! -r ${mgmt_cli_API_operations_handler} ] ; then
    # no file found, that is a problem
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Basic script setup API Scripts handler script file missing' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  File not found : '${mgmt_cli_API_operations_handler} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Other parameter elements : ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Configured Root path    : '${configured_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Root of folder path : '${mgmt_cli_API_operations_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder in Root path : '${mgmt_cli_API_operations_handler_folder} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder Root path    : '${mgmt_cli_API_operations_handler_path} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Script Filename     : '${mgmt_cli_API_operations_handler_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit 251
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-10-21 -

# Commands to execute specific actions in this script:
# CHECK |INIT - Initialize the API operations with checks of wether API is running, get port, API minimum version
# SETUPLOGIN  - Execute setup of API login based on CLI parameters passed and processed previously
# LOGIN       - Execute API login based on CLI parameters passed and processed previously
# PUBLISH     - Execute API publish based on previous login and session file
# DISCARD     - Execute API discard based on previous login and session file
# LOGOUT      - Execute API logout based on previous login and session file
# APISTATUS   - Execute just the API Status check

SUBEXITCODE=0

CheckMgmtCLIAPIOperationsHandler "$@"
SUBEXITCODE=$?

if [ "${SUBEXITCODE}" != "0" ] ; then
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Terminating script..." | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Exitcode ${SUBEXITCODE}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit ${SUBEXITCODE}
else
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
fi


# =================================================================================================
# END:  Management CLI API Operations Handling
# =================================================================================================
# =================================================================================================


\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

