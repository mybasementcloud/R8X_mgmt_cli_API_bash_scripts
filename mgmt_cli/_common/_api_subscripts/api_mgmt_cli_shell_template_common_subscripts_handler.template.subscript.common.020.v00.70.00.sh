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
# SCRIPT Template API common action handling
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

export APISubscriptsScriptVersion=v${ScriptVersion}
export APISubscriptsScriptTemplateVersion=v${TemplateVersion}

export APISubscriptsScriptVersionX=v${ScriptVersion//./x}
export APISubscriptsScriptTemplateVersionX=v${TemplateVersion//./x}

APISubScriptName=api_mgmt_cli_shell_template_common_action_handler.template.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}
export APISubScriptFileNameRoot="X"
export APISubScriptShortName="X"
export APISubScriptnohupName=${APISubScriptShortName}
export APISubScriptDescription="Description"


# =================================================================================================
# =================================================================================================
# START subscript:  X
# =================================================================================================


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '===============================================================================' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'APISubScript Name:  '${APISubScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'APISubScript original call name :  '$0 | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'APISubScript initial parameters :  '"$@" | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '===============================================================================' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# =================================================================================================
# Validate Common Subscripts  Script version is correct for caller
# =================================================================================================


# MODIFIED 2021-10-21 -

if [ x"${APIExpectedAPISubscriptsVersion}" = x"${APISubscriptsScriptVersion}" ] ; then
    # Script and Common Subscripts Script versions match, go ahead
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Verify Common Subscripts Scripts Version - OK' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
else
    # Script and Subscripts Script versions don't match, ALL STOP!
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Raw Script name        : '$0 | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Subscript version name : '${APISubscriptsScriptVersion}' '${APISubScriptName} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Calling Script version : '${APIScriptVersion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Verify Common Subscripts Scripts Version - Missmatch' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Expected Common Subscripts Script version : '${APIExpectedAPISubscriptsVersion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Current  Common Subscripts Script version : '${APISubscriptsScriptVersion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit 250
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# Single Line entries
#printf 'variable :  %-25s = %s\n' "x" ${x} >> ${logfilepath}
#printf "%-35s$ : %s\n" "x" 'x' >> ${logfilepath}
# Two Line entries
#printf "%s\n" "x" >> ${logfilepath}
#printf "%-35s :: %s\n" " " 'x' >> ${logfilepath}


# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# START:  Local Variables
# =================================================================================================


export subscriptstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log


# =================================================================================================
# START Procedures:  Local Proceedures - 
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# SetupTempLogFile - Setup Temporary Log File and clear any debris
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupTempLogFile () {
    #
    # SetupTempLogFile - Setup Temporary Log File and clear any debris
    #
    
    if [ -z "$1" ]; then
        # No explicit name passed for action
        export subscriptstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log
    else
        # explicit name passed for action
        export subscriptstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'$1'_'${DATEDTGS}.log
    fi
    
    if [ -w ${subscriptstemplogfilepath} ] ; then
        echo -n `${dtzs}`${dtzsep} >> ${logfilepath}
        rm -v ${subscriptstemplogfilepath} >> ${logfilepath} 2>&1
    fi
    
    touch ${subscriptstemplogfilepath}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleShowTempLogFile - Handle Showing of Temporary Log File based on verbose setting
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleShowTempLogFile () {
    #
    # HandleShowTempLogFile - Handle Showing of Temporary Log File based on verbose setting
    #
    
    if ${APISCRIPTVERBOSE} ; then
        # verbose mode so show the logged results and copy to normal log file
        cat ${subscriptstemplogfilepath} | tee -a -i ${logfilepath}
    else
        # NOT verbose mode so push logged results to normal log file
        cat ${subscriptstemplogfilepath} >> ${logfilepath}
    fi
    
    echo -n `${dtzs}`${dtzsep} >> ${logfilepath}
    rm -v ${subscriptstemplogfilepath} >> ${logfilepath} 2>&1
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ForceShowTempLogFile () {
    #
    # ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
    #
    
    cat ${subscriptstemplogfilepath} | tee -a -i ${logfilepath}
    
    echo -n `${dtzs}`${dtzsep} >> ${logfilepath}
    rm -v ${subscriptstemplogfilepath} >> ${logfilepath} 2>&1
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ -  MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# procedure_name - procedure description
# -------------------------------------------------------------------------------------------------


procedure_name () {
    #
    # procedure description
    #
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# procedure_name - Procedure Call Example
# -------------------------------------------------------------------------------------------------

#procedure_name ${parameter1} ${parameter2}


# -------------------------------------------------------------------------------------------------
# END:  procedure_name - 
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END Procedures:  Local Proceedures - 
# =================================================================================================


# =================================================================================================
# START:  X
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  X
# =================================================================================================


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '===============================================================================' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'API Subscript Completed :  '${APISubScriptName} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '===============================================================================' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


return 0


# =================================================================================================
# END subscript:  X
# =================================================================================================
# =================================================================================================


