#!/bin/bash
#
# (C) 2016-2026+ Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8X_mgmt_cli_API_bash_scripts
#
# ALL SCRIPTS ARE PROVIDED AS IS WITHOUT EXPRESS OR IMPLIED WARRANTY OF FUNCTION OR POTENTIAL FOR 
# DAMAGE Or ABUSE.  AUTHOR DOES NOT ACCEPT ANY RESPONSIBILITY FOR THE USE OF THESE SCRIPTS OR THE 
# RESULTS OF USING THESE SCRIPTS.  USING THESE SCRIPTS STIPULATES A CLEAR UNDERSTANDING OF RESPECTIVE
# TECHNOLOGIES AND UNDERLYING PROGRAMMING CONCEPTS AND STRUCTURES AND IMPLIES CORRECT IMPLEMENTATION
# OF RESPECTIVE BASELINE TECHNOLOGIES FOR PLATFORM UTILIZING THE SCRIPTS.  THIRD PARTY LIMITATIONS
# APPLY WITHIN THE SPECIFICS THEIR RESPECTIVE UTILIZATION AGREEMENTS AND LICENSES.  AUTHOR DOES NOT
# AUTHORIZE RESALE, LEASE, OR CHARGE FOR UTILIZATION OF THESE SCRIPTS BY ANY THIRD PARTY.
#
# AUTHOR REQUIRES ALL UTILIZATION FOR TRAINING OF AI OF ANY TYPE TO BE REQUESTED IN WRITING AND
# APPROVED IN WRITING VERIFIABLY BEFORE ANY SUCH AI TRAINING SHALL COMMENCE.
#
#
# -#- Start Making Changes Here -#- 
#
# SCRIPTS - Collect Cluster Interface Details
#
#
ScriptVersion=00.10.00
ScriptRevision=000
ScriptSubRevision=600
ScriptDate=2026-09-01
TemplateVersion=00.00.00
APISubscriptsLevel=000
APISubscriptsVersion=00.00.00
APISubscriptsRevision=000


#

# -#- Start Making Changes Here -#- 
#
export MainObjectUC=Cluster
export MainObjectLC=cluster
export MainObjectsUC=Clusters
export MainObjectsLC=clusters

export APIScriptVersion=v${ScriptVersion}
export APIScriptTemplateVersion=v${TemplateVersion}

export APIScriptVersionX=v${ScriptVersion//./x}
export APIScriptTemplateVersionX=v${TemplateVersion//./x}

export APIExpectedActionScriptsVersion=v${ScriptVersion}
export APIExpectedAPISubscriptsVersion=v${APISubscriptsVersion}

export APIExpectedActionScriptsVersionX=v${ScriptVersion//./x}
export APIExpectedAPISubscriptsVersionX=v${APISubscriptsVersion//./x}

ScriptName=collect_${MainObjectsLC}_interface_details
export APIScriptFileNameRoot=collect_${MainObjectsLC}_interface_details
export APIScriptShortName=collect_${MainObjectsLC}_interface_details
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Collect ${MainObjectUC} Interface Details."

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
export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
export dtgs_script_start=`date -u +%F-%T-%Z`

export DTGSDATE=`date +%Y-%m-%d-%H%M%S%Z`
export _CPRELEASEVERSION=$(cat /etc/cp-release | cut -d " " -f 4)
export _versnnow=${_CPRELEASEVERSION}.${DTGSDATE}
export _namevnow=${HOSTNAME}.${_CPRELEASEVERSION}.${DTGSDATE}
export _vnamenow=${_CPRELEASEVERSION}.${HOSTNAME}.${DTGSDATE}
export _nowvname=${DTGSDATE}.${_CPRELEASEVERSION}.${HOSTNAME}

#
# rootsafeworkpath     :  This is the path where it is safe to store scripts, to survive upgrades and patching
# customerpathroot     :  Path to the customer work environment, should be under ${rootsafeworkpath}
# scriptspathroot      :  Path to the folder with bash 4 Check Point scripts installation (b4CP)
#

export rootsafeworkpath=/var/log
export customerpathroot=${rootsafeworkpath}/__customer
export scriptspathroot=${customerpathroot}/upgrade_export/scripts
export workingpathroot=${customerpathroot}/upgrade_export/WIP.API_work

export _work_folder=${workingpathroot}/${_nowvname}.${MainObjectsLC}
mkdir ${_work_folder}

export rootscriptconfigfile=__root_script_config.sh

export logfilepath=${_work_folder}/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log

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
# -------------------------------------------------------------------------------------------------
# START Subroutines...
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureJQLocation - Configure the value of JQ based on installation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2025-12-12 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# ConfigureJQLocation - Configure the value of JQ based on installation
#

# MODIFIED 2025-12-12 -
ConfigureJQLocation () {
    #
    # Configure JQ variable value for JSON parsing
    #
    # variable JQ points to where jq is installed
    #
    # Apparently MDM, MDS, and Domains don't agree on who sets CPDIR, so better to check!
    
    #export JQ=${CPDIR}/jq/jq
    
    
    # =============================================================================
    # JSON Query JQ and version specific JQ16 values
    # =============================================================================
    
    export JQNotFound=true
    export UseJSONJQ=false
    
    # As of template version v04.21.00 we also added jq version 1.6 to the mix and it lives in the customer path root /tools/JQ folder by default
    # As of template version v00.70.00.000.275 jq is in /tools/JQ as jq=linux64 and is version 1.8.1
    #export JQPATH=${customerpathroot}/_tools/JQ
    export JQPATH=${customerpathroot}/_tools/JQ
    export JQFILE=jq-linux64
    export JQFQFN=${JQPATH}/${JQFILE}
    
    # JQ points to where the default jq is installed, probably version 1.4
    if [ -r ${JQFQFN} ] ; then
        # OK we have the easy-button alternative
        export JQFILE=jq-linux64
        export JQ=${JQFQFN}
        export JQNotFound=false
        export UseJSONJQ=true
        export JQFQFN=${JQFQFN}
        echo `${dtzs}`${dtzsep} "jq-linux64 or jq, found as ${JQFQFN}" | tee -a -i ${logfilepath}
    elif [ -r "./_tools/JQ/${JQFILE}" ] ; then
        # OK we have the local folder alternative
        export JQFILE=jq-linux64
        export JQ=./_tools/JQ/${JQFILE}
        export JQNotFound=false
        export UseJSONJQ=true
        export JQFQFN=./_tools/JQ/${JQFILE}
        echo `${dtzs}`${dtzsep} "jq-linux64 or jq, found as ${JQFQFN}" | tee -a -i ${logfilepath}
    elif [ -r "../_tools/JQ/${JQFILE}" ] ; then
        # OK we have the parent folder alternative
        export JQFILE=jq-linux64
        export JQ=../_tools/JQ/${JQFILE}
        export JQNotFound=false
        export UseJSONJQ=true
        export JQFQFN=../_tools/JQ/${JQFILE}
        echo `${dtzs}`${dtzsep} "jq-linux64 or jq, found as ${JQFQFN}" | tee -a -i ${logfilepath}
    elif [ -r "../../_tools/JQ/${JQFILE}" ] ; then
        # OK we have the parent folder alternative
        export JQFILE=jq-linux64
        export JQ=../../_tools/JQ/${JQFILE}
        export JQNotFound=false
        export UseJSONJQ=true
        export JQFQFN=../../_tools/JQ/${JQFILE}
        echo `${dtzs}`${dtzsep} "jq-linux64 or jq, found as ${JQFQFN}" | tee -a -i ${logfilepath}
    elif [ -r ${CPDIR}/jq/jq ] ; then
        export JQFILE=jq
        #export JQ=${CPDIR}/jq/${JQFILE}
        export JQ=${CPDIR}/jq/jq
        export JQNotFound=false
        export UseJSONJQ=true
        export JQFQFN=${CPDIR}/jq/${JQFILE}
        echo `${dtzs}`${dtzsep} "jq-linux64 or jq, found as ${JQFQFN}" | tee -a -i ${logfilepath}
    elif [ -r ${CPDIR_PATH}/jq/jq ] ; then
        export JQFILE=jq
        #export JQ=${CPDIR_PATH}/jq/${JQFILE}
        export JQ=${CPDIR_PATH}/jq/jq
        export JQNotFound=false
        export UseJSONJQ=true
        export JQFQFN=${CPDIR_PATH}/jq/${JQFILE}
        echo `${dtzs}`${dtzsep} "jq-linux64 or jq, found as ${JQFQFN}" | tee -a -i ${logfilepath}
    elif [ -r ${MDS_CPDIR}/jq/jq ] ; then
        export JQFILE=jq
        #export JQ=${MDS_CPDIR}/jq/${JQFILE}
        export JQ=${MDS_CPDIR}/jq/jq
        export JQNotFound=false
        export UseJSONJQ=true
        export JQFQFN=${MDS_CPDIR}/jq/${JQFILE}
        echo `${dtzs}`${dtzsep} "jq-linux64 or jq, found as ${JQFQFN}" | tee -a -i ${logfilepath}
    else
        export JQFILE=jq
        export JQ=
        export JQNotFound=true
        export UseJSONJQ=false
        export JQFQFN=
        echo `${dtzs}`${dtzsep} "JQ NOT found!" | tee -a -i ${logfilepath}
    fi
    
    # JQ16 points to where jq 1.6 is installed, which is not generally part of Gaia, even R80.40EA (2020-01-20)
    export JQ16NotFound=true
    export UseJSONJQ16=false
    
    # As of template version v04.21.00 we also added jq version 1.6 to the mix and it lives in the customer path root /tools/JQ folder by default
    # As of template version v00.70.00.000.275 JQ 1.6 is in /tools/JQ_v01.06.00
    #export JQ16PATH=${customerpathroot}/_tools/JQ
    export JQ16PATH=${customerpathroot}/_tools/JQ_v01.06.00
    export JQ16FILE=jq-linux64
    export JQ16FQFN=${JQ16PATH}/${JQ16FILE}
    
    if [ -r ${JQ16FQFN} ] ; then
        # OK we have the easy-button alternative
        export JQ16=${JQ16FQFN}
        export JQ16NotFound=false
        export UseJSONJQ16=true
        export JQ16FQFN=${JQ16FQFN}
        echo `${dtzs}`${dtzsep} "JQ v 1.6 found as jq-linux64 or jq, at ${JQ16FQFN}" | tee -a -i ${logfilepath}
    elif [ -r "./_tools/JQ_v01.06.00/${JQ16FILE}" ] ; then
        # OK we have the local folder alternative
        export JQ16=./_tools/JQ_v01.06.00/${JQ16FILE}
        export JQ16NotFound=false
        export UseJSONJQ16=true
        export JQ16FQFN=./_tools/JQ_v01.06.00/${JQ16FILE}
        echo `${dtzs}`${dtzsep} "JQ v 1.6 found as jq-linux64 or jq, at ${JQ16FQFN}" | tee -a -i ${logfilepath}
    elif [ -r "../_tools/JQ_v01.06.00/${JQ16FILE}" ] ; then
        # OK we have the parent folder alternative
        export JQ16=../_tools/JQ_v01.06.00/${JQ16FILE}
        export JQ16NotFound=false
        export UseJSONJQ16=true
        export JQ16FQFN=../_tools/JQ_v01.06.00/${JQ16FILE}
        echo `${dtzs}`${dtzsep} "JQ v 1.6 found as jq-linux64 or jq, at ${JQ16FQFN}" | tee -a -i ${logfilepath}
    elif [ -r "../../_tools/JQ_v01.06.00/${JQ16FILE}" ] ; then
        # OK we have the parent folder alternative
        export JQ16=../../_tools/JQ_v01.06.00/${JQ16FILE}
        export JQ16NotFound=false
        export UseJSONJQ16=true
        export JQ16FQFN=../../_tools/JQ_v01.06.00/${JQ16FILE}
        echo `${dtzs}`${dtzsep} "JQ v 1.6 found as jq-linux64 or jq, at ${JQ16FQFN}" | tee -a -i ${logfilepath}
    else
        # nope, not part of the package, so clear the values
        export JQ16=
        export JQ16NotFound=true
        export UseJSONJQ16=false
        export JQ16FQFN=
        echo `${dtzs}`${dtzsep} "JQ v 1.6 NOT found!" | tee -a -i ${logfilepath}
    fi
    
    # ADDED 2025-12-12 -
    
    # JQ181 points to where jq 1.8.1 is installed, which is not generally part of Gaia, even R82
    export JQ181NotFound=true
    export UseJSONJQ181=false
    
    # As of template version v00.70.00.000.275 JQ 1.8.1 is in /tools/JQ_v01.08.01
    #export JQ181PATH=${customerpathroot}/_tools/JQ_v01.08.01
    export JQ181PATH=${customerpathroot}/_tools/JQ_v01.08.01
    export JQ181FILE=jq-linux64
    export JQ181FQFN=${JQ181PATH}/${JQ181FILE}
    
    if [ -r ${JQ181FQFN} ] ; then
        # OK we have the easy-button alternative
        export JQ181=${JQ181FQFN}
        export JQ181NotFound=false
        export UseJSONJQ181=true
        export JQ181FQFN=${JQ181FQFN}
        echo `${dtzs}`${dtzsep} "JQ v 1.8.1 found as jq-linux64 or jq, at ${JQ181FILE}" | tee -a -i ${logfilepath}
    elif [ -r "./_tools/JQ_v01.06.00/${JQ181FILE}" ] ; then
        # OK we have the local folder alternative
        export JQ181=./_tools/JQ_v01.06.00/${JQ181FILE}
        export JQ181NotFound=false
        export UseJSONJQ181=true
        export JQ181FQFN=./_tools/JQ_v01.06.00/${JQ181FILE}
        echo `${dtzs}`${dtzsep} "JQ v 1.8.1 found as jq-linux64 or jq, at ${JQ181FILE}" | tee -a -i ${logfilepath}
    elif [ -r "../_tools/JQ_v01.06.00/${JQ181FILE}" ] ; then
        # OK we have the parent folder alternative
        export JQ181=../_tools/JQ_v01.06.00/${JQ181FILE}
        export JQ181NotFound=false
        export UseJSONJQ181=true
        export JQ181FQFN=../_tools/JQ_v01.06.00/${JQ181FILE}
        echo `${dtzs}`${dtzsep} "JQ v 1.8.1 found as jq-linux64 or jq, at ${JQ181FILE}" | tee -a -i ${logfilepath}
    elif [ -r "../../_tools/JQ_v01.06.00/${JQ181FILE}" ] ; then
        # OK we have the parent folder alternative
        export JQ181=../../_tools/JQ_v01.06.00/${JQ181FILE}
        export JQ181NotFound=false
        export UseJSONJQ181=true
        export JQ181FQFN=../../_tools/JQ_v01.06.00/${JQ181FILE}
        echo `${dtzs}`${dtzsep} "JQ v 1.8.1 found as jq-linux64 or jq, at ${JQ181FILE}" | tee -a -i ${logfilepath}
    else
        # nope, not part of the package, so clear the values
        export JQ181=
        export JQ181NotFound=true
        export UseJSONJQ181=false
        export JQ181FQFN=
        echo `${dtzs}`${dtzsep} "JQ v 1.8.1 NOT found!" | tee -a -i ${logfilepath}
    fi
    
    if ${JQNotFound} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Missing jq-linux64 or jq, not found in ${JQPATH}, ${CPDIR}/jq, ${CPDIR_PATH}/jq, or ${MDS_CPDIR}/jq" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        exit 1
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2025-12-12


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# BuildJSONforOver500ObjectsTypes - Build JSON for Over 500 OjbectsTypes objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 20260901:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# BuildJSONforOver500ObjectsTypes - Build JSON for Over 500 OjbectsTypes objects
#

# MODIFIED 20260901:01 -
BuildJSONforOver500ObjectsTypes () {
    #
    # Build JSON for Over 500 OjbectsTypes objects
    #
    
    export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
    #export OUTPUTFOLDER=./${DATEDTGS}.${OBJECTSTYPES}'_1-json'
    export OUTPUTFOLDER=`pwd`/${DATEDTGS}.${OBJECTSTYPES}'_1-json'
    export OUTPUTFILEPREFIX=objects.${OBJECTSTYPES}.${DETAILSSET}
    
    echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    if [ ! -r ${OUTPUTFOLDER} ] ; then
        mkdir -p -v ${OUTPUTFOLDER} >> ${logfilepath} 2>&1
        echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    echo | tee -a -i ${logfilepath}
    
    echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    chmod 775 ${OUTPUTFOLDER} >> ${logfilepath} 2>&1
    echo | tee -a -i ${logfilepath}
    
    
    #Get Total number of items
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Running ${COMMAND}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    TOTAL=`${COMMAND} | ${JQ} '.total'`
    echo `${dtzs}`${dtzsep} "Total  ${OBJECTSTYPES} Elements = ${TOTAL}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    #Loop through and get the data
    while [ ${OFFSET} -lt ${TOTAL} ]; do
        OUTPUTFILE=${OUTPUTFOLDER}/${OUTPUTFILEPREFIX}.`printf "%05d" ${OFFSET}`.json
        
        echo `${dtzs}`${dtzsep} "Getting data with offset of ${OFFSET} to file ${OUTPUTFILE}" | tee -a -i ${logfilepath}
        
        GETDATA=`${COMMAND} limit ${LIMIT} offset ${OFFSET} details-level "${DETAILSSET}" | ${JQ} '.'`
        DATA=`echo ${GETDATA} | ${JQ} '.objects[]'`
        
        echo ${DATA} > ${OUTPUTFILE}
        
        OFFSET=`echo ${GETDATA} | ${JQ} '.to'`
    done
    
    echo `${dtzs}`${dtzsep} "Done getting data with ${OFFSET} objects to files in ${OUTPUTFOLDER}!" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
    export Slurpuglyfilefqpn=${OUTPUTFOLDER}/${OUTPUTFILEPREFIX}.ugly.json
    export Slurpstarfilefqpn=${OUTPUTFOLDER}/${OUTPUTFILEPREFIX}.*.json
    
    ls -alh ${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    ${JQ} -s '.' ${Slurpstarfilefqpn} > ${Slurpuglyfilefqpn}
    #rm -rf test*.json
    
    SLURP_TOTAL=`cat ${Slurpuglyfilefqpn} | ${JQ} '.[].uid' | sort -u | wc -l`
    echo `${dtzs}`${dtzsep} "Data output to total.ugly.json with ${SLURP_TOTAL} elements" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Total elements from first query is ${TOTAL} elements" | tee -a -i ${logfilepath}
    
    # Make it pretty again
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Make it pretty" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export OUTPUTFILETOTALPREFIX=total.${OBJECTSTYPES}.${DETAILSSET}
    
    export Slurpprettyfilefqpn=${OUTPUTFOLDER}/${OUTPUTFILETOTALPREFIX}.pretty.json
    
    echo '{ ' > ${Slurpprettyfilefqpn}
    echo -n '  "objects": ' >> ${Slurpprettyfilefqpn}
    
    # need a way to read lines and dump them out
    
    COUNTER=0
    
    while read -r line; do
        if [ ${COUNTER} -eq 0 ]; then
            # Line 0 first line we don't want to add a return yet
            echo -n 'Start:.'
        else
            # Lines 1+ are the data
            echo >> ${Slurpprettyfilefqpn}
            #echo -n '.'
        fi
        
        #Write the line, but not the carriage return
        echo -n "${line}" >> ${Slurpprettyfilefqpn}
        let COUNTER=COUNTER+1
    done < ${Slurpuglyfilefqpn}
    
    echo
    
    #Write the last comma after the original json file that is not pretty
    echo ',' >> ${Slurpprettyfilefqpn}
    echo '  "from": 0,' >> ${Slurpprettyfilefqpn}
    echo '  "to": '${SLURP_TOTAL}',' >> ${Slurpprettyfilefqpn}
    echo '  "total": '${SLURP_TOTAL} >> ${Slurpprettyfilefqpn}
    echo '}' >> ${Slurpprettyfilefqpn}
    
    #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    ##head -n 10 total.${OBJECTSTYPES}.${DETAILSSET}.pretty.json; echo '...'; tail -n 10 total.${OBJECTSTYPES}.${DETAILSSET}.pretty.json
    #head -n 10 ${Slurpprettyfilefqpn}
    #echo `${dtzs}`${dtzsep} '...' | tee -a -i ${logfilepath}
    #tail -n 10 ${Slurpprettyfilefqpn}
    #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Now make it really pretty" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export OUTPUTFILEREALLYPRETTY=${OUTPUTFOLDER}/${OUTPUTFILETOTALPREFIX}.reallypretty.json
    
    ${JQ} -s '.[]' ${Slurpprettyfilefqpn} > ${OUTPUTFILEREALLYPRETTY}
    
    #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    #head -n 10 ${OUTPUTFILEREALLYPRETTY}
    #echo `${dtzs}`${dtzsep} '...' | tee -a -i ${logfilepath}
    #tail -n 10 ${OUTPUTFILEREALLYPRETTY}
    #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export Finaljsonfileexport=${OUTPUTFOLDER}/${OUTPUTFILETOTALPREFIX}.json
    #export Finaljsonfileexport=./${OUTPUTFILETOTALPREFIX}.json
    
    cp ${OUTPUTFILEREALLYPRETTY} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 20260901:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# END Subroutines...
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


export JQ=${CPDIR_PATH}/jq/jq

ConfigureJQLocation


# -------------------------------------------------------------------------------------------------

pushd ${_work_folder}
echo `${dtzs}`${dtzsep} `pwd` | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------

#
# Specific Firewall Host, Interface and UID
#

#export csvheader0='"gateway-uid", "name"'
#export csvfields0=${_fwhost_uid}', .["name"]'
#echo `${dtzs}`${dtzsep} 'csvheader0 =' ${csvheader0} | tee -a -i ${logfilepath}
#echo `${dtzs}`${dtzsep} 'csvfields0 =' ${csvfields0} | tee -a -i ${logfilepath}
#echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------

#
# show interfaces
#

#{
#    "uid" : "d83db05d-8a85-46ba-9ea9-44d1d33722bf",
#    "name" : "bond0",
#    "type" : "interface",
#    "domain" : {
#      "uid" : "41e821a0-3720-11e3-aa6e-0800200c9fde",
#      "name" : "SMC User",
#      "domain-type" : "domain"
#    },
#    "comments" : "SENKAIMON",
#    "topology" : "Antispoofing-Network-SENKAIMON",
#    "ip-addresses" : "10.69.255.251/21",
#    "cluster-network-type" : "private",
#    "icon" : "NetworkObjects/network",
#    "color" : "dark gray"
#  }

export csvheader1='"uid"'
export csvheader1=${csvheader1}', "name"'
export csvheader1=${csvheader1}', "type"'
export csvheader1=${csvheader1}', "color"'
export csvheader1=${csvheader1}', "comments"'
export csvheader1=${csvheader1}', "topology"'
export csvheader1=${csvheader1}', "ip-addresses"'
export csvheader1=${csvheader1}', "cluster-network-type"'
export csvheader1=${csvheader1}', "icon"'
export csvheader1=${csvheader1}', "domain.uid"'
export csvheader1=${csvheader1}', "domain.name"'
export csvheader1=${csvheader1}', "domain.domain-type"'

export csvfields1='.["uid"]'
export csvfields1=${csvfields1}', .["name"]'
export csvfields1=${csvfields1}', .["type"]'
export csvfields1=${csvfields1}', .["color"]'
export csvfields1=${csvfields1}', .["comments"]'
export csvfields1=${csvfields1}', .["topology"]'
export csvfields1=${csvfields1}', .["ip-addresses"]'
export csvfields1=${csvfields1}', .["cluster-network-type"]'
export csvfields1=${csvfields1}', .["icon"]'
export csvfields1=${csvfields1}', .["domain"]["uid"]'
export csvfields1=${csvfields1}', .["domain"]["name"]'
export csvfields1=${csvfields1}', .["domain"]["domain-type"]'

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} Information for CSV collected from show interfaces command | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvheader1 =' ${csvheader1} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvfields1 =' ${csvfields1} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------

#
# set interface information from show interfaces
#

export csvheaderS1='"uid"'
#export csvheaderS1=${csvheaderS1}', "name"'
#export csvheaderS1=${csvheaderS1}', "gateway-uid"'
export csvheaderS1=${csvheaderS1}', "color"'
export csvheaderS1=${csvheaderS1}', "comments"'

export csvfieldsS1='.["uid"]'
#export csvfieldsS1=${csvfieldsS1}', .["name"]'
#export csvfieldsS1=${csvfieldsS1}', .["gateway-uid"]'
export csvfieldsS1=${csvfieldsS1}', .["color"]'
export csvfieldsS1=${csvfieldsS1}', .["comments"]'

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} Information for CSV to set information collected from show interfaces command | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvheaderS1 =' ${csvheaderS1} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvfieldsS1 =' ${csvfieldsS1} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------

#
# set interface by name information from show interfaces
#

# | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfieldsS3}"' ] | @csv' >> 
export csvheaderS3='"gateway-uid"'
#export csvheaderS3='"uid"'
#export csvheaderS3=${csvheaderS3}', "uid"'
#export csvheaderS3='"name"'
export csvheaderS3=${csvheaderS3}', "name"'
export csvheaderS3=${csvheaderS3}', "color"'
export csvheaderS3=${csvheaderS3}', "comments"'

# | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfieldsS3}"' ] | @csv' >> 
#export csvfieldsS3="${_fwhost_uid}"
#export csvfieldsS3='.["uid"]'
#export csvfieldsS3=${csvfieldsS3}',.["uid"]'
export csvfieldsS3='.["name"]'
#export csvfieldsS3=${csvfieldsS3}', .["name"]'
export csvfieldsS3=${csvfieldsS3}', .["color"]'
export csvfieldsS3=${csvfieldsS3}', .["comments"]'

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} Information for CSV to set information collected from show interface command | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvheaderS3 =' ${csvheaderS3} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvfieldsS3 = "${_fwhost_uid}", ' ${csvfieldsS3} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------

#
# show interface
#

#{
#  "uid" : "d83db05d-8a85-46ba-9ea9-44d1d33722bf",
#  "name" : "bond0",
#  "type" : "interface",
#  "domain" : {
#    "uid" : "41e821a0-3720-11e3-aa6e-0800200c9fde",
#    "name" : "SMC User",
#    "domain-type" : "domain"
#  },
#  "topology-settings-automatic" : {
#    "ip-address-behind-this-interface" : "network defined by the interface ip and net mask",
#    "interface-leads-to-dmz" : false
#  },
#  "topology-automatic" : "internal",
#  "topology-manual" : "internal",
#  "topology" : "internal",
#  "topology-settings-manual" : {
#    "specific-network-uid" : "1a52e85f-f085-4cff-8c55-eef2f180c54b",
#    "ip-address-behind-this-interface" : "specific",
#    "specific-network" : "Antispoofing-Network-SENKAIMON",
#    "interface-leads-to-dmz" : false
#  },
#  "topology-settings" : {
#    "specific-network-uid" : "1a52e85f-f085-4cff-8c55-eef2f180c54b",
#    "ip-address-behind-this-interface" : "specific",
#    "specific-network" : "Antispoofing-Network-SENKAIMON",
#    "interface-leads-to-dmz" : false
#  },
#  "anti-spoofing-settings" : {
#    "action" : "detect",
#    "exclude-packets" : false,
#    "spoof-tracking" : "log"
#  },
#  "network-interface-type" : "ethernet",
#  "security-zone-settings" : {
#    "auto-calculated-zone" : "InternalZone",
#    "auto-calculated-zone-uid" : "e8131db2-8388-42a5-924a-82de32db20f7",
#    "specific-zone-uid" : "c0348fcc-3f75-43b5-81cd-81153a1565ad",
#    "specific-security-zone-enabled" : true,
#    "auto-calculated" : false,
#    "specific-zone" : "zone_SENKAIMON"
#  },
#  "anti-spoofing" : true,
#  "ipv4-address" : "10.69.255.251",
#  "ipv4-mask-length" : 21,
#  "dynamic-ip" : false,
#  "gateway" : {
#    "type" : "simple-gateway",
#    "name" : "CORE-GW-SMCIAS-01",
#    "uid" : "4519655d-b021-4802-b49f-f86d039e3855"
#  },
#  "comments" : "",
#  "color" : "black",
#  "tags" : [ ],
#  "meta-info" : {
#    "lock" : "unlocked",
#    "validation-state" : "ok",
#    "last-modify-time" : {
#      "posix" : 1767225592248,
#      "iso-8601" : "2025-12-31T17:59-0600"
#    },
#    "last-modifier" : "System",
#    "creation-time" : {
#      "posix" : 1669699013547,
#      "iso-8601" : "2022-11-28T23:16-0600"
#    },
#    "creator" : "administrator"
#  },
#  "read-only" : false,
#  "available-actions" : {
#    "edit" : "true",
#    "delete" : "true",
#    "clone" : "false"
#  }
#}

export csvheader2='"uid"'
export csvheader2=${csvheader2}', "name"'
export csvheader2=${csvheader2}', "type"'
export csvheader2=${csvheader2}', "color"'
export csvheader2=${csvheader2}', "comments"'
export csvheader2=${csvheader2}', "topology-settings-automatic"."ip-address-behind-this-interface"'
export csvheader2=${csvheader2}', "topology-settings-automatic"."interface-leads-to-dmz"'
export csvheader2=${csvheader2}', "topology-automatic"'
export csvheader2=${csvheader2}', "topology-manual"'
export csvheader2=${csvheader2}', "topology"'
export csvheader2=${csvheader2}', "topology-settings-manual"."specific-network-uid"'
export csvheader2=${csvheader2}', "topology-settings-manual"."ip-address-behind-this-interface"'
export csvheader2=${csvheader2}', "topology-settings-manual"."specific-network"'
export csvheader2=${csvheader2}', "topology-settings-manual"."interface-leads-to-dmz"'
export csvheader2=${csvheader2}', "ipv4-address"'
export csvheader2=${csvheader2}', "ipv4-mask-length"'
export csvheader2=${csvheader2}', "ipv6-address"'
export csvheader2=${csvheader2}', "ipv6-mask-length"'
export csvheader2=${csvheader2}', "dynamic-ip"'
export csvheader2=${csvheader2}', "network-interface-type"'
export csvheader2=${csvheader2}', "security-zone-settings"."auto-calculated"'
export csvheader2=${csvheader2}', "security-zone-settings"."auto-calculated-zone"'
export csvheader2=${csvheader2}', "security-zone-settings"."auto-calculated-zone-uid"'
export csvheader2=${csvheader2}', "security-zone-settings"."specific-zone"'
export csvheader2=${csvheader2}', "security-zone-settings"."specific-zone-uid"'
export csvheader2=${csvheader2}', "security-zone-settings"."specific-security-zone-enabled"'
export csvheader2=${csvheader2}', "anti-spoofing"'
export csvheader2=${csvheader2}', "anti-spoofing-settings"."action"'
export csvheader2=${csvheader2}', "anti-spoofing-settings"."exclude-packets"'
export csvheader2=${csvheader2}', "anti-spoofing-settings"."excluded-network-name"'
export csvheader2=${csvheader2}', "anti-spoofing-settings"."excluded-network-uid"'
export csvheader2=${csvheader2}', "anti-spoofing-settings"."spoof-tracking"'
export csvheader2=${csvheader2}', "gateway.type"'
export csvheader2=${csvheader2}', "gateway.name"'
export csvheader2=${csvheader2}', "gateway.uid"'
export csvheader2=${csvheader2}', "tags.0"'
export csvheader2=${csvheader2}', "tags.1"'
export csvheader2=${csvheader2}', "tags.2"'
export csvheader2=${csvheader2}', "tags.3"'
export csvheader2=${csvheader2}', "tags.4"'
export csvheader2=${csvheader2}', "tags.5"'
export csvheader2=${csvheader2}', "tags.6"'
export csvheader2=${csvheader2}', "tags.7"'
export csvheader2=${csvheader2}', "tags.8"'
export csvheader2=${csvheader2}', "tags.9"'
export csvheader2=${csvheader2}', "domain.uid"'
export csvheader2=${csvheader2}', "domain.name"'
export csvheader2=${csvheader2}', "domain.domain-type"'

export csvfields2='.["uid"]'
export csvfields2=${csvfields2}', .["name"]'
export csvfields2=${csvfields2}', .["type"]'
export csvfields2=${csvfields2}', .["color"]'
export csvfields2=${csvfields2}', .["comments"]'
export csvfields2=${csvfields2}', .["topology-settings-automatic"]["ip-address-behind-this-interface"]'
export csvfields2=${csvfields2}', .["topology-settings-automatic"]["interface-leads-to-dmz"]'
export csvfields2=${csvfields2}', .["topology-automatic"]'
export csvfields2=${csvfields2}', .["topology-manual"]'
export csvfields2=${csvfields2}', .["topology"]'
export csvfields2=${csvfields2}', .["topology-settings-manual"]["specific-network-uid"]'
export csvfields2=${csvfields2}', .["topology-settings-manual"]["ip-address-behind-this-interface"]'
export csvfields2=${csvfields2}', .["topology-settings-manual"]["specific-network"]'
export csvfields2=${csvfields2}', .["topology-settings-manual"]["interface-leads-to-dmz"]'
export csvfields2=${csvfields2}', .["ipv4-address"]'
export csvfields2=${csvfields2}', .["ipv4-mask-length"]'
export csvfields2=${csvfields2}', .["ipv6-address"]'
export csvfields2=${csvfields2}', .["ipv6-mask-length"]'
export csvfields2=${csvfields2}', .["dynamic-ip"]'
export csvfields2=${csvfields2}', .["network-interface-type"]'
export csvfields2=${csvfields2}', .["security-zone-settings"]["auto-calculated"]'
export csvfields2=${csvfields2}', .["security-zone-settings"]["auto-calculated-zone"]'
export csvfields2=${csvfields2}', .["security-zone-settings"]["auto-calculated-zone-uid"]'
export csvfields2=${csvfields2}', .["security-zone-settings"]["specific-zone"]'
export csvfields2=${csvfields2}', .["security-zone-settings"]["specific-zone-uid"]'
export csvfields2=${csvfields2}', .["security-zone-settings"]["specific-security-zone-enabled"]'
export csvfields2=${csvfields2}', .["anti-spoofing"]'
export csvfields2=${csvfields2}', .["anti-spoofing-settings"]["action"]'
export csvfields2=${csvfields2}', .["anti-spoofing-settings"]["exclude-packets"]'
export csvfields2=${csvfields2}', .["anti-spoofing-settings"]["excluded-network-name"]'
export csvfields2=${csvfields2}', .["anti-spoofing-settings"]["excluded-network-uid"]'
export csvfields2=${csvfields2}', .["anti-spoofing-settings"]["spoof-tracking"]'
export csvfields2=${csvfields2}', .["gateway"]["type"]'
export csvfields2=${csvfields2}', .["gateway"]["name"]'
export csvfields2=${csvfields2}', .["gateway"]["uid"]'
export csvfields2=${csvfields2}', .["tags"][0]'
export csvfields2=${csvfields2}', .["tags"][1]'
export csvfields2=${csvfields2}', .["tags"][2]'
export csvfields2=${csvfields2}', .["tags"][3]'
export csvfields2=${csvfields2}', .["tags"][4]'
export csvfields2=${csvfields2}', .["tags"][5]'
export csvfields2=${csvfields2}', .["tags"][6]'
export csvfields2=${csvfields2}', .["tags"][7]'
export csvfields2=${csvfields2}', .["tags"][8]'
export csvfields2=${csvfields2}', .["tags"][9]'
export csvfields2=${csvfields2}', .["domain"]["uid"]'
export csvfields2=${csvfields2}', .["domain"]["name"]'
export csvfields2=${csvfields2}', .["domain"]["domain-type"]'

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} Information for CSV collected from show interface command | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvheader2 =' ${csvheader2} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvfields2 =' ${csvfields2} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------

#
# set interface information from show interface
#

export csvheaderS2='"uid"'
#export csvheaderS2=${csvheaderS2}', "name"'
#export csvheaderS2=${csvheaderS2}', "gateway-uid"'
export csvheaderS2=${csvheaderS2}', "color"'
export csvheaderS2=${csvheaderS2}', "comments"'

export csvfieldsS2='.["uid"]'
#export csvfieldsS2=${csvfieldsS2}', .["name"]'
#export csvfieldsS2=${csvfieldsS2}', .["gateway-uid"]'
export csvfieldsS2=${csvfieldsS2}', .["color"]'
export csvfieldsS2=${csvfieldsS2}', .["comments"]'

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} Information for CSV to set information collected from show interface command | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvheaderS2 =' ${csvheaderS2} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvfieldsS2 =' ${csvfieldsS2} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------

#
# set interface by name information from show interface
#

# | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfieldsS4}"' ] | @csv' >> 
export csvheaderS4='"gateway-uid"'
#export csvheaderS4='"uid"'
#export csvheaderS4=${csvheaderS4}', "uid"'
#export csvheaderS4='"name"'
export csvheaderS4=${csvheaderS4}', "name"'
export csvheaderS4=${csvheaderS4}', "color"'
export csvheaderS4=${csvheaderS4}', "comments"'

# | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfieldsS4}"' ] | @csv' >> 
#export csvfieldsS4="${_fwhost_uid}"
#export csvfieldsS4='.["uid"]'
#export csvfieldsS4=${csvfieldsS4}',.["uid"]'
export csvfieldsS4='.["name"]'
#export csvfieldsS4=${csvfieldsS4}', .["name"]'
export csvfieldsS4=${csvfieldsS4}', .["color"]'
export csvfieldsS4=${csvfieldsS4}', .["comments"]'

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} Information for CSV to set information collected from show interface command | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvheaderS4 =' ${csvheaderS4} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvfieldsS4 = "${_fwhost_uid}", ' ${csvfieldsS4} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------

#
# show simple-gateway to get interfaces
#

#{
#  "uid" : "4519655d-b021-4802-b49f-f86d039e3855",
#  "name" : "CORE-GW-SMCIAS-01",
#  "type" : "simple-gateway",
#  "domain" : {...},
#  "platform" : "open server",
#  "interfaces" : [ {
#      "uid" : "d83db05d-8a85-46ba-9ea9-44d1d33722bf",
#      "name" : "bond0",
#      "network-interface-type" : "ethernet",
#      "ipv4-address" : "10.69.255.251",
#      "ipv4-network-mask" : "255.255.248.0",
#      "ipv4-mask-length" : 21,
#      "ipv6-address" : "",
#      "dynamic-ip" : false,
#      "comments" : "SENKAIMON",
#      "color" : "dark gray",
#      "icon" : "NetworkObjects/network",
#      "topology" : "internal",
#      "topology-settings" : {
#        "ip-address-behind-this-interface" : "specific",
#        "specific-network" : "Antispoofing-Network-SENKAIMON",
#        "interface-leads-to-dmz" : false
#      },
#      "anti-spoofing" : true,
#      "anti-spoofing-settings" : {
#        "action" : "detect",
#        "exclude-packets" : false,
#        "spoof-tracking" : "log"
#      },
#      "security-zone" : true,
#      "security-zone-settings" : {
#        "auto-calculated" : false,
#        "specific-zone" : "zone_SENKAIMON"
#      }
#   }, {
#   ...
#   } ],
#  ...
#}

# | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfields5}"' ] | @csv' >> 
export csvheader5='"gateway-uid"'
#export csvheader5='"uid"'
export csvheader5=${csvheader5}', "uid"'
export csvheader5=${csvheader5}', "name"'
export csvheader5=${csvheader5}', "network-interface-type"'
export csvheader5=${csvheader5}', "color"'
export csvheader5=${csvheader5}', "comments"'
export csvheader5=${csvheader5}', "icon"'
export csvheader5=${csvheader5}', "ipv4-address"'
export csvheader5=${csvheader5}', "ipv4-network-mask"'
export csvheader5=${csvheader5}', "ipv4-mask-length"'
export csvheader5=${csvheader5}', "ipv6-address"'
export csvheader5=${csvheader5}', "dynamic-ip"'
export csvheader5=${csvheader5}', "topology"'
export csvheader5=${csvheader5}', "topology-settings.ip-address-behind-this-interface"'
export csvheader5=${csvheader5}', "topology-settings.specific-network"'
export csvheader5=${csvheader5}', "topology-settings.interface-leads-to-dmz"'
export csvheader5=${csvheader5}', "anti-spoofing"'
export csvheader5=${csvheader5}', "anti-spoofing-settings.action"'
export csvheader5=${csvheader5}', "anti-spoofing-settings.exclude-packets"'
export csvheader5=${csvheader5}', "anti-spoofing-settings.spoof-tracking"'
export csvheader5=${csvheader5}', "security-zone"'
export csvheader5=${csvheader5}', "security-zone-settings.auto-calculated"'
export csvheader5=${csvheader5}', "security-zone-settings.specific-zone"'

# | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfields5}"' ] | @csv' >> 
#export csvfields5="${_fwhost_uid}"
export csvfields5='.["uid"]'
#export csvfields5=${csvfields5}',.["uid"]'
export csvfields5=${csvfields5}', .["name"]'
export csvfields5=${csvfields5}', .["network-interface-type"]'
export csvfields5=${csvfields5}', .["color"]'
export csvfields5=${csvfields5}', .["comments"]'
export csvfields5=${csvfields5}', .["icon"]'
export csvfields5=${csvfields5}', .["ipv4-address"]'
export csvfields5=${csvfields5}', .["ipv4-network-mask"]'
export csvfields5=${csvfields5}', .["ipv4-mask-length"]'
export csvfields5=${csvfields5}', .["ipv6-address"]'
export csvfields5=${csvfields5}', .["dynamic-ip"]'
export csvfields5=${csvfields5}', .["topology"]'
export csvfields5=${csvfields5}', .["topology-settings"]["ip-address-behind-this-interface"]'
export csvfields5=${csvfields5}', .["topology-settings"]["specific-network"]'
export csvfields5=${csvfields5}', .["topology-settings"]["interface-leads-to-dmz"]'
export csvfields5=${csvfields5}', .["anti-spoofing"]'
export csvfields5=${csvfields5}', .["anti-spoofing-settings"]["action"]'
export csvfields5=${csvfields5}', .["anti-spoofing-settings"]["exclude-packets"]'
export csvfields5=${csvfields5}', .["anti-spoofing-settings"]["spoof-tracking"]'
export csvfields5=${csvfields5}', .["security-zone"]'
export csvfields5=${csvfields5}', .["security-zone-settings"]["auto-calculated"]'
export csvfields5=${csvfields5}', .["security-zone-settings"]["specific-zone"]'

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} Information for CSV collected from show interfaces command | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvheader5 =' ${csvheader5} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvfields5 =' ${csvfields5} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------

#
# set interface information from show interfaces
#

# | ${JQ} -r '.interfaces[] | [ '"${csvfieldsS5}"' ] | @csv' >> 
export csvheaderS5='"uid"'
#export csvheaderS5=${csvheaderS5}', "name"'
#export csvheaderS5=${csvheaderS5}', "gateway-uid"'
export csvheaderS5=${csvheaderS5}', "color"'
export csvheaderS5=${csvheaderS5}', "comments"'

# | ${JQ} -r '.interfaces[] | [ '"${csvfieldsS5}"' ] | @csv' >> 
export csvfieldsS5='.["uid"]'
#export csvfieldsS5=${csvfieldsS5}', .["name"]'
#export csvfieldsS5=${csvfieldsS5}', .["gateway-uid"]'
export csvfieldsS5=${csvfieldsS5}', .["color"]'
export csvfieldsS5=${csvfieldsS5}', .["comments"]'

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} Information for CSV to set information collected from show simple-gateways command | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvheaderS5 =' ${csvheaderS5} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvfieldsS5 =' ${csvfieldsS5} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------

#
# set interface by name information from show interfaces
#

# | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfieldsS7}"' ] | @csv' >> 
export csvheaderS7='"gateway-uid"'
#export csvheaderS7='"uid"'
#export csvheaderS7=${csvheaderS7}', "uid"'
#export csvheaderS7='"name"'
export csvheaderS7=${csvheaderS7}', "name"'
export csvheaderS7=${csvheaderS7}', "color"'
export csvheaderS7=${csvheaderS7}', "comments"'

# | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfieldsS7}"' ] | @csv' >> 
#export csvfieldsS7="${_fwhost_uid}"
#export csvfieldsS7='.["uid"]'
#export csvfieldsS7=${csvfieldsS7}',.["uid"]'
export csvfieldsS7='.["name"]'
#export csvfieldsS7=${csvfieldsS7}', .["name"]'
export csvfieldsS7=${csvfieldsS7}', .["color"]'
export csvfieldsS7=${csvfieldsS7}', .["comments"]'

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} Information for CSV to set information collected from show simple-gateways command | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvheaderS7 =' ${csvheaderS7} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'csvfieldsS7 = "${_fwhost_uid}", ' ${csvfieldsS7} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

export mgmt_cli_auth='-r true'

if [ -z ${1} ] ; then
    # No parameter 1 passed
    export mgmt_cli_auth='-r true'
else
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Command line parameters : " | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Number parms :  '"$#" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Raw parms    : > '"$@"' <' | tee -a -i ${logfilepath}
    
    parmnum=0
    for k ; do
        echo -e `${dtzs}`${dtzsep}"${parmnum} \t ${k}" | tee -a -i ${logfilepath}
        parmnum=`expr ${parmnum} + 1`
    done
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CLI Parm 1:  ['${1}']' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo -n `${dtzs}`${dtzsep} 'Use CLI Parm 1 ['${1}'] for authentication to mgmt_cli? (yY for YES, qQ for QUIT any other for NO) ' | tee -a -i ${logfilepath}
    read -N 1 -p ":" anykey
    case ${anykey} in
        y | Y ) 
            export mgmt_cli_auth=${1}
            echo `${dtzs}`${dtzsep} 'Using CLI Parm 1 for mgmt_cli authentication.' | tee -a -i ${logfilepath}
            ;;
        q | Q ) 
            export mgmt_cli_auth=
            echo `${dtzs}`${dtzsep} 'QUITING!!!' | tee -a -i ${logfilepath}
            
            popd
            echo `${dtzs}`${dtzsep} `pwd`| tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            
            ls -l --color=auto ${_work_folder} | tee -a -i ${logfilepath}
            
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} Log File:  ${logfilepath} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo
            exit 254
            ;;
        * ) 
            echo `${dtzs}`${dtzsep} 'NOT using CLI Parm 1 for mgmt_cli authentication! Using default.' | tee -a -i ${logfilepath}
            ;;
    esac
fi

echo `${dtzs}`${dtzsep} 'mgmt_cli authentication:  "'${mgmt_cli_auth}'"' | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# -#- Start Making Changes Here -#- 
#
export OBJECTNAME="cluster"
export OBJECTSNAME="clusters"
export OBJECTSTYPE="simple-cluster"
export OBJECTSTYPES="simple-clusters"

#-------------------------------------------------------------------------------

export DETAILSSET=full
export LIMIT="500"
export OFFSET="0"

export COMMANDPREFIX="mgmt_cli ${mgmt_cli_auth} -f json"
export COMMAND="${COMMANDPREFIX} show ${OBJECTSTYPES}"

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

export _objects_count=$(${COMMAND} | ${JQ} '. | .total')
echo `${dtzs}`${dtzsep} 'Objects of type :' ${OBJECTSTYPE}| tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '_objects_count =' ${_objects_count}| tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

export _fwhost_show_simple_firewallobjects_json=show_${OBJECTSTYPES}.${_vnamenow}.json

if [ ${_objects_count} -eq 0 ] ; then
    # There are no objects of type ${OBJECTSTYPE} so we don't need to execute the rest of this script
    
    popd
    echo `${dtzs}`${dtzsep} `pwd`| tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    ls -l --color=auto ${_work_folder}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} Log File:  ${logfilepath} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo
    exit 255
elif [ ${_objects_count} -le ${LIMIT} ] ; then
    # There are less than or equal to ${LIMIT} objects of type ${OBJECTSTYPE} so we don't need to 
    # iterate, loop, and build a single JSON file
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    ${COMMAND} details-level full > ${_fwhost_show_simple_firewallobjects_json}
    
else
    # There are more than ${LIMIT} objects of type ${OBJECTSTYPE} so we do need to iterate, loop,
    # and build a single JSON file
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    BuildJSONforOver500ObjectsTypes
    
    cp ${Finaljsonfileexport} ${_fwhost_show_simple_firewallobjects_json} >> ${logfilepath} 2>&1
    
fi

echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} 'Objects of type :' ${OBJECTSTYPE}| tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '_fwhost_show_simple_firewallobjects_json=' ${_fwhost_show_simple_firewallobjects_json}| tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

ls -l --color=auto ${_fwhost_show_simple_firewallobjects_json} | tee -a -i ${logfilepath}

echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

export _fwhost_count=$(cat ${_fwhost_show_simple_firewallobjects_json} | ${JQ} '. | .total')
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '_fwhost_count =' ${_fwhost_count}| tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

for _fwhost_uid in $(cat ${_fwhost_show_simple_firewallobjects_json} | ${JQ} '.objects[] | .uid') ; do
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '_fwhost_uid =' ${_fwhost_uid} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    #export _fwhost_name=$(mgmt_cli ${mgmt_cli_auth} -f json show simple-cluster uid ${_fwhost_uid} details-level standard | ${JQ} -r '. | .name')
    #export _fwhost_name=$(mgmt_cli ${mgmt_cli_auth} -f json show simple-gateway uid ${_fwhost_uid} details-level standard | ${JQ} -r '. | .name')
    export _fwhost_name=$(mgmt_cli ${mgmt_cli_auth} -f json show ${OBJECTSTYPE} uid ${_fwhost_uid} details-level standard | ${JQ} -r '. | .name')
    echo `${dtzs}`${dtzsep} '_fwhost_name =' ${_fwhost_name} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    #export _fwhost_show_simple_gateway_json=${_fwhost_name}.show_simple_gateway.${_vnamenow}.json
    #export _fwhost_show_simple_cluster_json=${_fwhost_name}.showsimple_cluster.${_vnamenow}.json
    export _fwhost_show_firewallobject_json=${_fwhost_name}.show_${OBJECTSTYPE}.${_vnamenow}.json
    echo `${dtzs}`${dtzsep} '_fwhost_show_firewallobject_json=' ${_fwhost_show_firewallobject_json} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    mgmt_cli ${mgmt_cli_auth} -f json show ${OBJECTSTYPE} uid ${_fwhost_uid} details-level full > ${_fwhost_show_firewallobject_json}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export _fwhost_interfaces_from_firewallobject_json_file=${_fwhost_name}.interfaces.from_show_${OBJECTSTYPE}.${_versnnow}.csv
    echo `${dtzs}`${dtzsep} '_fwhost_interfaces_from_firewallobject_json_file =' ${_fwhost_interfaces_from_firewallobject_json_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo ${csvheader5} > ${_fwhost_interfaces_from_firewallobject_json_file}
    if [ x"${OBJECTSTYPE}" = x"simple-gateway" ] ; then
        # simple-gateway
        echo `${dtzs}`${dtzsep} 'Handle' ${OBJECTSTYPE} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Command for' ${OBJECTSTYPE} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '# cat ${_fwhost_show_firewallobject_json} | ${JQ} -r '\''.interfaces[] | [ '\''${_fwhost_uid}'\'', '\''"${csvfields5}"'\'' ] | @csv'\'' >> ${_fwhost_interfaces_from_firewallobject_json_file}' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '# cat '${_fwhost_show_firewallobject_json}' | '${JQ}' -r '\''.interfaces[] | [ '\'${_fwhost_uid}\'', '\''"'${csvfields5}'"'\'' ] | @csv'\'' >> '${_fwhost_interfaces_from_firewallobject_json_file} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        # | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfields5}"' ] | @csv' >> 
        cat ${_fwhost_show_firewallobject_json} | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfields5}"' ] | @csv' >> ${_fwhost_interfaces_from_firewallobject_json_file}
    elif [ x"${OBJECTSTYPE}" = x"simple-cluster" ] ; then
        # simple-cluster
        echo `${dtzs}`${dtzsep} 'Handle' ${OBJECTSTYPE} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Command for' ${OBJECTSTYPE} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '# cat ${_fwhost_show_firewallobject_json} | ${JQ} '\''. | .interfaces'\'' | ${JQ} -r '\''.objects[] | [ '\''${_fwhost_uid}'\'', '\''"${csvfields5}"'\'' ] | @csv'\'' >> ${_fwhost_interfaces_from_firewallobject_json_file}' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '# cat '${_fwhost_show_firewallobject_json}' | '${JQ}' '\''. | .interfaces'\'' | '${JQ}' -r '\''.objects[] | [ '\'${_fwhost_uid}\'', '\''"${csvfields5}"'\'' ] | @csv'\'' >> '${_fwhost_interfaces_from_firewallobject_json_file} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        # | ${JQ} '. | .interfaces' | ${JQ} -r '.objects[] | [ '${_fwhost_uid}', '"${csvfields5}"' ] | @csv' >> 
        cat ${_fwhost_show_firewallobject_json} | ${JQ} '. | .interfaces' | ${JQ} -r '.objects[] | [ '${_fwhost_uid}', '"${csvfields5}"' ] | @csv' >> ${_fwhost_interfaces_from_firewallobject_json_file}
    else
        # ????
        echo `${dtzs}`${dtzsep} 'Handle' ${OBJECTSTYPE} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Command for' ${OBJECTSTYPE} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '# cat ${_fwhost_show_firewallobject_json} | ${JQ} -r '\''.interfaces[] | [ '\''${_fwhost_uid}'\'', '\''"${csvfields5}"'\'' ] | @csv'\'' >> ${_fwhost_interfaces_from_firewallobject_json_file}' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '# cat '${_fwhost_show_firewallobject_json}' | '${JQ}' -r '\''.interfaces[] | [ '\'${_fwhost_uid}\'', '\''"'${csvfields5}'"'\'' ] | @csv'\'' >> '${_fwhost_interfaces_from_firewallobject_json_file} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        # | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfields5}"' ] | @csv' >> 
        cat ${_fwhost_show_firewallobject_json} | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfields5}"' ] | @csv' >> ${_fwhost_interfaces_from_firewallobject_json_file}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    cat ${_fwhost_interfaces_from_firewallobject_json_file} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export _fwhost_set_interface_from_firewallobject_json_file=${_fwhost_name}.set_interfaces.from_show_${OBJECTSTYPE}.${_versnnow}.csv
    echo `${dtzs}`${dtzsep} '_fwhost_set_interface_from_firewallobject_json_file =' ${_fwhost_set_interface_from_firewallobject_json_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo ${csvheaderS5} > ${_fwhost_set_interface_from_firewallobject_json_file}
    if [ x"${OBJECTSTYPE}" = x"simple-gateway" ] ; then
        # | ${JQ} -r '.interfaces[] | [ '"${csvfieldsS5}"' ] | @csv' >> 
        cat ${_fwhost_show_firewallobject_json} | ${JQ} -r '.interfaces[] | [ '"${csvfieldsS5}"' ] | @csv' >> ${_fwhost_set_interface_from_firewallobject_json_file}
    elif [ x"${OBJECTSTYPE}" = x"simple-cluster" ] ; then
        # | ${JQ} '. | .interfaces' | ${JQ} -r '.objects[] | [ '"${csvfieldsS5}"' ] | @csv' >> 
        cat ${_fwhost_show_firewallobject_json} | ${JQ} '. | .interfaces' | ${JQ} -r '.objects[] | [ '"${csvfieldsS5}"' ] | @csv' >> ${_fwhost_set_interface_from_firewallobject_json_file}
    else
        # | ${JQ} -r '.interfaces[] | [ '"${csvfieldsS5}"' ] | @csv' >> 
        cat ${_fwhost_show_firewallobject_json} | ${JQ} -r '.interfaces[] | [ '"${csvfieldsS5}"' ] | @csv' >> ${_fwhost_set_interface_from_firewallobject_json_file}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    cat ${_fwhost_set_interface_from_firewallobject_json_file} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export _fwhost_set_interface_from_firewallobject_json_file_2=${_fwhost_name}.set_interfaces_by_name.from_show_${OBJECTSTYPE}.${_versnnow}.csv
    echo `${dtzs}`${dtzsep} '_fwhost_set_interface_from_firewallobject_json_file_2 =' ${_fwhost_set_interface_from_firewallobject_json_file_2} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo ${csvheaderS7} > ${_fwhost_set_interface_from_firewallobject_json_file_2}
    if [ x"${OBJECTSTYPE}" = x"simple-gateway" ] ; then
        # | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfieldsS7}"' ] | @csv' >> 
        cat ${_fwhost_show_firewallobject_json} | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfieldsS7}"' ] | @csv' >> ${_fwhost_set_interface_from_firewallobject_json_file_2}
    elif [ x"${OBJECTSTYPE}" = x"simple-cluster" ] ; then
        # | ${JQ} '. | .interfaces' | ${JQ} -r '.objects[] | [ '${_fwhost_uid}', '"${csvfieldsS7}"' ] | @csv' >> 
        cat ${_fwhost_show_firewallobject_json} | ${JQ} '. | .interfaces' | ${JQ} -r '.objects[] | [ '${_fwhost_uid}', '"${csvfieldsS7}"' ] | @csv' >> ${_fwhost_set_interface_from_firewallobject_json_file_2}
    else
        # | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfieldsS7}"' ] | @csv' >> 
        cat ${_fwhost_show_firewallobject_json} | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfieldsS7}"' ] | @csv' >> ${_fwhost_set_interface_from_firewallobject_json_file_2}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    cat ${_fwhost_set_interface_from_firewallobject_json_file_2} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export _fwhost_show_interfaces_file=${_fwhost_name}.show_interfaces.${_versnnow}.csv
    echo `${dtzs}`${dtzsep} '_fwhost_show_interfaces_file =' ${_fwhost_show_interfaces_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo ${csvheader1} > ${_fwhost_show_interfaces_file}
    mgmt_cli ${mgmt_cli_auth} -f json show interfaces gateway-uid ${_fwhost_uid} details-level full | ${JQ} -r '.objects[] | [ '"${csvfields1}"' ] | @csv' >> ${_fwhost_show_interfaces_file}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    cat ${_fwhost_show_interfaces_file} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export _fwhost_set_interfaces_file=${_fwhost_name}.set_interfaces.from_show_interfaces.${_versnnow}.csv
    echo `${dtzs}`${dtzsep} '_fwhost_set_interfaces_file =' ${_fwhost_set_interfaces_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo ${csvheaderS1} > ${_fwhost_set_interfaces_file}
    mgmt_cli ${mgmt_cli_auth} -f json show interfaces gateway-uid ${_fwhost_uid} details-level full | ${JQ} -r '.objects[] | [ '"${csvfieldsS1}"' ] | @csv' >> ${_fwhost_set_interfaces_file}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    cat ${_fwhost_set_interfaces_file} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export _fwhost_set_interfaces_file_2=${_fwhost_name}.set_interfaces_by_name.from_show_interfaces.${_versnnow}.csv
    echo `${dtzs}`${dtzsep} '_fwhost_set_interfaces_file_2 =' ${_fwhost_set_interfaces_file_2} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfieldsS3}"' ] | @csv' >> 
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo ${csvheaderS3} > ${_fwhost_set_interfaces_file_2}
    mgmt_cli ${mgmt_cli_auth} -f json show interfaces gateway-uid ${_fwhost_uid} details-level full | ${JQ} -r '.objects[] | [ '${_fwhost_uid}', '"${csvfieldsS3}"' ] | @csv' >> ${_fwhost_set_interfaces_file_2}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    cat ${_fwhost_set_interfaces_file_2} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export _fwhost_show_interfaces_json=${_fwhost_name}.show_interfaces.${_vnamenow}.json
    echo `${dtzs}`${dtzsep} '_fwhost_show_interfaces_json=' ${_fwhost_show_interfaces_json} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    mgmt_cli ${mgmt_cli_auth} -f json show interfaces gateway-uid ${_fwhost_uid} details-level full > ${_fwhost_show_interfaces_json}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export _fwhost_uid_interfaces_names_file=${_fwhost_name}.gw_uid_interface_names.csv
    echo `${dtzs}`${dtzsep} '_fwhost_uid_interfaces_names_file =' ${_fwhost_uid_interfaces_names_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export csvheader0='"gateway-uid", "name"'
    export csvfields0=${_fwhost_uid}', .["name"]'
    echo `${dtzs}`${dtzsep} 'csvheader0 =' ${csvheader0} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'csvfields0 =' ${csvfields0} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo ${csvheader0} > ${_fwhost_uid_interfaces_names_file}
    mgmt_cli ${mgmt_cli_auth} -f json show interfaces gateway-uid ${_fwhost_uid} details-level full | ${JQ} -r '.objects[] | [ '"${csvfields0}"' ] | @csv' >> ${_fwhost_uid_interfaces_names_file}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    cat ${_fwhost_uid_interfaces_names_file} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export _fwhost_show_interface_json=${_fwhost_name}.show_interface.${_vnamenow}.json
    echo `${dtzs}`${dtzsep} '_fwhost_show_interface_json=' ${_fwhost_show_interface_json} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    mgmt_cli ${mgmt_cli_auth} -f json show interface --batch ${_fwhost_uid_interfaces_names_file} details-level full > ${_fwhost_show_interface_json}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export _fwhost_show_interface_file=${_fwhost_name}.show_interface.${_versnnow}.csv
    echo `${dtzs}`${dtzsep} '_fwhost_show_interface_file =' ${_fwhost_show_interface_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo ${csvheader2} > ${_fwhost_show_interface_file}
    mgmt_cli ${mgmt_cli_auth} -f json show interface --batch ${_fwhost_uid_interfaces_names_file} details-level full | ${JQ} -r '.response[] | [ '"${csvfields2}"' ] | @csv' >> ${_fwhost_show_interface_file}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    cat ${_fwhost_show_interface_file} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export _fwhost_set_interface_file=${_fwhost_name}.set_interfaces.from_show_interface.${_versnnow}.csv
    echo `${dtzs}`${dtzsep} '_fwhost_set_interface_file =' ${_fwhost_set_interface_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo ${csvheaderS2} > ${_fwhost_set_interface_file}
    mgmt_cli ${mgmt_cli_auth} -f json show interface --batch ${_fwhost_uid_interfaces_names_file} details-level full | ${JQ} -r '.response[] | [ '"${csvfieldsS2}"' ] | @csv' >> ${_fwhost_set_interface_file}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    cat ${_fwhost_set_interface_file} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export _fwhost_set_interface_file_2=${_fwhost_name}.set_interfaces_by_name.from_show_interface.${_versnnow}.csv
    echo `${dtzs}`${dtzsep} '_fwhost_set_interface_file_2 =' ${_fwhost_set_interface_file_2} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # | ${JQ} -r '.interfaces[] | [ '${_fwhost_uid}', '"${csvfieldsS4}"' ] | @csv' >> 
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo ${csvheaderS4} > ${_fwhost_set_interface_file_2}
    mgmt_cli ${mgmt_cli_auth} -f json show interface --batch ${_fwhost_uid_interfaces_names_file} details-level full | ${JQ} -r '.response[] | [ '${_fwhost_uid}', '"${csvfieldsS4}"' ] | @csv' >> ${_fwhost_set_interface_file_2}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    cat ${_fwhost_set_interface_file_2} | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
done

popd
echo `${dtzs}`${dtzsep} `pwd`| tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

ls -l --color=auto ${_work_folder} | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} Log File:  ${logfilepath} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo
