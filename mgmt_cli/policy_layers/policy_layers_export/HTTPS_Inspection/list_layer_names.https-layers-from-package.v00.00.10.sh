#!/bin/bash
#
# (C) 2016-2021 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8X-API-scripts-4-policy-import-export
#
# ALL SCRIPTS ARE PROVIDED AS IS WITHOUT EXPRESS OR IMPLIED WARRANTY OF FUNCTION OR POTENTIAL FOR 
# DAMAGE Or ABUSE.  AUTHOR DOES NOT ACCEPT ANY RESPONSIBILITY FOR THE USE OF THESE SCRIPTS OR THE 
# RESULTS OF USING THESE SCRIPTS.  USING THESE SCRIPTS STIPULATES A CLEAR UNDERSTANDING OF RESPECTIVE
# TECHNOLOGIES AND UNDERLYING PROGRAMMING CONCEPTS AND STRUCTURES AND IMPLIES CORRECT IMPLEMENTATION
# OF RESPECTIVE BASELINE TECHNOLOGIES FOR PLATFORM UTILIZING THE SCRIPTS.  THIRD PARTY LIMITATIONS
# APPLY WITHIN THE SPECIFICS THEIR RESPECTIVE UTILIZATION AGREEMENTS AND LICENSES.  AUTHOR DOES NOT
# AUTHORIZE RESALE, LEASE, OR CHARGE FOR UTILIZATION OF THESE SCRIPTS BY ANY THIRD PARTY.
#
# SCRIPT Rough Example for generating a list of layers from package for selection of a specific layer for show output - HTTPS Inspection layers
#
#

ScriptVersion=00.00.10
ScriptRevision=000
ScriptSubRevision=000
ScriptDate=2022-01-17
TemplateVersion=@NA
APISubscriptsLevel=@NA
APISubscriptsVersion=@NA
APISubscriptsRevision=@NA

#


# -------------------------------------------------------------------------------------------------
# Setup root parameters ...
# -------------------------------------------------------------------------------------------------


export DATEDTG=`date +%Y-%m-%d-%H%M%Z`
export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`

export tcol01=25

export pythonpath=${MDS_FWDIR}/Python/bin/

export forreferenceonlytext=FOR_REFERENCE_ONLY
export outputpathroot=./_output
export exportpathroot=./_export
export importpathroot=./_import


# -------------------------------------------------------------------------------------------------
# Logging configuration
# -------------------------------------------------------------------------------------------------

#export logfilepath=${outputpathroot}/$(basename $0)'_'${ScriptVersion}'_'${DATEDTGS}.log
export logfilepath=${outputpathroot}/$(basename $0)'_'${DATEDTGS}.log

if [ ! -r ${outputpathroot} ] ; then
    mkdir -pv ${outputpathroot}
    chmod 775 ${outputpathroot}
else
    chmod 775 ${outputpathroot}
fi


# -------------------------------------------------------------------------------------------------
# Announce what we are starting here...
# -------------------------------------------------------------------------------------------------

echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Script:  '$(basename $0)'  Script Version: '${ScriptVersion}'  Revision:SubRevision: '${ScriptRevision}':'${ScriptSubRevision}'  Date: '${ScriptDate} | tee -a -i ${logfilepath}
echo 'Script original call name :  '$0 $@ | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# Get the local Check Point Release version of the current host...
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-01-17 -

export gaiaversion=
cpreleasefile=/etc/cp-release
if [ -r ${cpreleasefile} ] ; then
    # OK we have the easy-button alternative
    export gaiaversion=$(cat ${cpreleasefile} | cut -d " " -f 4)
else
    # OK that's not going to work without the file
    
    #get_platform_release=`${pythonpath}/python ${MDS_FWDIR}/scripts/get_platform.py -f json | ${CPDIR_PATH}/jq/jq '. | .release'`
    
    # Working on R81.20 EA or later, where python3 replaces the regular python call
    #
    if [ -r ${pythonpath}/python3 ] ; then
        # Working on R81.20 EA or later, where python3 replaces the regular python call
        #
        export get_platform_release=`${pythonpath}/python3 ${MDS_FWDIR}/scripts/get_platform.py -f json | ${CPDIR_PATH}/jq/jq '. | .release'`
        #if ${UseJSONJQ} ; then
            #export get_platform_release=`${pythonpath}/python3 ${MDS_FWDIR}/scripts/get_platform.py -f json | ${JQ} '. | .release'`
        #else
            #export get_platform_release=`${pythonpath}/python3 ${MDS_FWDIR}/scripts/get_platform.py -f json | ${CPDIR_PATH}/jq/jq '. | .release'`
        #fi
    else
        # Not working with python3 available, trying the regular python
        #
        export get_platform_release=`${pythonpath}/python ${MDS_FWDIR}/scripts/get_platform.py -f json | ${CPDIR_PATH}/jq/jq '. | .release'`
        #if ${UseJSONJQ} ; then
            #export get_platform_release=`${pythonpath}/python ${MDS_FWDIR}/scripts/get_platform.py -f json | ${JQ} '. | .release'`
        #else
            #export get_platform_release=`${pythonpath}/python ${MDS_FWDIR}/scripts/get_platform.py -f json | ${CPDIR_PATH}/jq/jq '. | .release'`
        #fi
    fi
    
    platform_release=${get_platform_release//\"/}
    get_platform_release_version=`echo ${platform_release} | cut -d " " -f 4`
    platform_release_version=${get_platform_release_version//\"/}
    
    export gaiaversion=${platform_release_version}
fi

#printf "%-${tcol01}s = %s\n" 'X' "${X}"  | tee -a -i ${logfilepath}
printf "%-${tcol01}s = %s\n" 'Gaia Release Version' "${gaiaversion}" | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# Get the local API SSL port which may not be the default 443...
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-01-17 -

# Working on R81.20 EA or later, where python3 replaces the regular python call
#

if [ -r ${pythonpath}/python3 ] ; then
    # Working on R81.20 EA or later, where python3 replaces the regular python call
    #
    #export currentapisslport=$(clish -c "show web ssl-port" | cut -d " " -f 2)
    #
    export get_api_local_port=`${pythonpath}/python3 ${MDS_FWDIR}/scripts/api_get_port.py -f json | ${JQ} '. | .external_port'`
    export api_local_port=${get_api_local_port//\"/}
else
    # Not working MaaS so will check locally for Gaia web SSL port setting
    # Removing dependency on clish to avoid collissions when database is locked
    #
    #export currentapisslport=$(clish -c "show web ssl-port" | cut -d " " -f 2)
    #
    export get_api_local_port=`${pythonpath}/python ${MDS_FWDIR}/scripts/api_get_port.py -f json | ${JQ} '. | .external_port'`
    export api_local_port=${get_api_local_port//\"/}
fi
export apisslport=${api_local_port}

#printf "%-${tcol01}s = %s\n" 'X' "${X}" | tee -a -i ${logfilepath}
printf "%-${tcol01}s = %s\n" 'API SSL Port' "${apisslport}" | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# Export output array controls
# -------------------------------------------------------------------------------------------------


export minarray=0
export maxarray=9
export maxtagsarray=9
export maxinstallarray=4

# Access Control Specific
export maxaccessarray=9

# Threat Prevention Specific
export maxoverridearray=9
export maxextattributesarray=9
export maxextattributesvaluesarray=4


# HTTPS Inspection Specific
export maxbladearray=7


# -------------------------------------------------------------------------------------------------
# Setup control variables
# -------------------------------------------------------------------------------------------------


#
# Policy Type configuration for script.  ONE of these needs to be true, all others false
# Options:  true | false
#
export policy_type_Access=false
export policy_type_Threat=false
export policy_type_HTTPSI=true

#
# Script Operation Type configuration for script.  ONE of these needs to be true, all others false
# Options:  export | import | list_layers
#
export script_operation=list_layers
#export script_operation=export
#export script_operation=export_only
#export script_operation=import

export api_show_command=
#export api_show_command='show access-layer'
#export api_show_command='show access-layers'
#export api_show_command='show access-rulebase'
export api_show_command='show https-layer'
#export api_show_command='show https-layers'
#export api_show_command='show https-rulebase'
#export api_show_command='show threat-layer'
#export api_show_command='show threat-rulebase'
#export api_show_command='show threat-rule-exception-rulebase'
#export api_show_command='show threat-profiles'

export api_add_command=
#export api_add_command='add https-layer'
#export api_add_command='add https-rule'
#export api_add_command='add threat-layer'
#export api_add_command='add threat-rule'
#export api_add_command='add threat-exception'
#export api_add_command='add threat-profile'

export commandfilename=${api_show_command// /_}
#export commandfilename=${api_add_command// /_}
export commandfilename=${commandfilename//-/_}

export apicommandtarget=${api_show_command#* }
#export apicommandtarget=${api_add_command#* }
export apicommandtarget=${apicommandtarget//-/_}

#
# Configure what we are using for the working files for show, export, import, and results
#
export use_showfile=false
export use_exportfile=false
export use_exportfile4ref=false
export use_importfile=false
export use_resultsfile=false

case "${script_operation}" in
    # list layers
    'list_layers' )
        export use_showfile=true
        export use_exportfile=false
        export use_exportfile4ref=false
        export use_importfile=false
        export use_resultsfile=false
        ;;
    # export
    'export' )
        export use_showfile=true
        export use_exportfile=true
        export use_exportfile4ref=true
        export use_importfile=false
        export use_resultsfile=false
        ;;
    # export_only
    'export_only' )
        export use_showfile=true
        export use_exportfile=true
        export use_exportfile4ref=false
        export use_importfile=false
        export use_resultsfile=false
        ;;
    # import
    'import' )
        export use_showfile=false
        export use_exportfile=false
        export use_exportfile4ref=false
        export use_importfile=true
        export use_resultsfile=true
        ;;
    # Anything unknown is recorded for later
    * )
        export policy_type_Access=false
        export policy_type_Threat=false
        export policy_type_HTTPSI=false
        
        export use_showfile=false
        export use_exportfile=false
        export use_exportfile4ref=false
        export use_importfile=false
        export use_resultsfile=false
        
        echo 'Script configuration error!  Missing valid script operation type configuration value!'
        printf "%-${tcol01}s = %s\n" 'script_operation' "${script_operation}"
        echo 'Exiting! ...'
        echo
        exit 1
        ;;
esac

printf "%-${tcol01}s = %s\n" 'policy_type_Access' "${policy_type_Access}" >> ${logfilepath}
printf "%-${tcol01}s = %s\n" 'policy_type_Threat' "${policy_type_Threat}" >> ${logfilepath}
printf "%-${tcol01}s = %s\n" 'policy_type_HTTPSI' "${policy_type_HTTPSI}" >> ${logfilepath}
printf "%-${tcol01}s = %s\n" 'script_operation' "${script_operation}" | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}
printf "%-${tcol01}s = %s\n" 'use_showfile' "${use_showfile}" >> ${logfilepath}
printf "%-${tcol01}s = %s\n" 'use_exportfile' "${use_exportfile}" >> ${logfilepath}
printf "%-${tcol01}s = %s\n" 'use_exportfile4ref' "${use_exportfile4ref}" >> ${logfilepath}
printf "%-${tcol01}s = %s\n" 'use_importfile' "${use_importfile}" >> ${logfilepath}
printf "%-${tcol01}s = %s\n" 'use_resultsfile' "${use_resultsfile}" >> ${logfilepath}
echo >> ${logfilepath}


# -------------------------------------------------------------------------------------------------
# Setup initial variables
# -------------------------------------------------------------------------------------------------


export localnamenow=${HOSTNAME}.${gaiaversion}.${DATEDTGS}
export localnametoday=${HOSTNAME}.${gaiaversion}.`date +%Y-%m-%d`

if ${policy_type_Access} ; then
    export package_layer='access-layers'
elif ${policy_type_Threat} ; then
    export package_layer='threat-layers'
elif ${policy_type_HTTPSI} ; then
    export package_layer='https-layers'
else
    # what?
    echo 'Script configuration error!  Missing valid policy type configuration boolean!'
    printf "%-${tcol01}s = %s\n" 'script_operation' "${script_operation}"
    printf "%-${tcol01}s = %s\n" 'policy_type_Access' "${policy_type_Access}"
    printf "%-${tcol01}s = %s\n" 'policy_type_Threat' "${policy_type_Threat}"
    printf "%-${tcol01}s = %s\n" 'policy_type_HTTPSI' "${policy_type_HTTPSI}"
    echo 'Exiting! ...'
    echo
    exit 1
fi

export showfileprefix=z.${commandfilename}
export showfileext=json
export showfilepath=${outputpathroot}.${showfileext}

export exportfileprefix=zz.${apicommandtarget}
export exportfileext=csv
export exportfilepath=${exportpathroot}.${exportfileext}
export exportfilepath4reference=${exportpathroot}.${exportfileext}.${forreferenceonlytext}

export importfileslistprefix=*${apicommandtarget}
export importfileprefix=zz.${apicommandtarget}
export importfileext=csv
export importfilepath=${importpathroot}.${importfileext}

export resultsfileprefix=zzz_Results.export.${commandfilename}
export resultsfileext=json
export resultsfilepath=${outputpathroot}

# -------------------------------------------------------------------------------------------------

#printf "%-40s = %s\n" 'X' "${X}" | tee -a -i ${logfilepath}
#printf "%-${tcol01}s = %s\n" 'X' "${X}" | tee -a -i ${logfilepath}

echo | tee -a -i ${logfilepath}

printf "%-${tcol01}s = %s\n" 'apicommandtarget' "${apicommandtarget}" | tee -a -i ${logfilepath}
if [ ! -z "${api_show_command}" ] ; then
    printf "%-${tcol01}s = %s\n" 'api_show_command' "${api_show_command}" | tee -a -i ${logfilepath}
fi
if [ ! -z "${api_add_command}" ] ; then
    printf "%-${tcol01}s = %s\n" 'api_add_command' "${api_add_command}" | tee -a -i ${logfilepath}
fi
printf "%-${tcol01}s = %s\n" 'commandfilename' "${commandfilename}" | tee -a -i ${logfilepath}
if ${use_showfile} ; then
    printf "%-${tcol01}s = %s\n" 'showfileprefix' "${showfileprefix}" | tee -a -i ${logfilepath}
    printf "%-${tcol01}s = %s\n" 'showfileext' "${showfileext}" | tee -a -i ${logfilepath}
    printf "%-${tcol01}s = %s\n" 'showfilepath' "${showfilepath}" | tee -a -i ${logfilepath}
fi
if ${use_exportfile} ; then
    printf "%-${tcol01}s = %s\n" 'exportfileprefix' "${exportfileprefix}" | tee -a -i ${logfilepath}
    printf "%-${tcol01}s = %s\n" 'exportfileext' "${exportfileext}" | tee -a -i ${logfilepath}
    printf "%-${tcol01}s = %s\n" 'exportfilepath' "${exportfilepath}" | tee -a -i ${logfilepath}
fi
if ${use_exportfile4ref} ; then
    printf "%-${tcol01}s = %s\n" 'exportfilepath4reference' "${exportfilepath4reference}" | tee -a -i ${logfilepath}
fi
if ${use_importfile} ; then
    printf "%-${tcol01}s = %s\n" 'importfileslistprefix' "${importfileslistprefix}" | tee -a -i ${logfilepath}
    printf "%-${tcol01}s = %s\n" 'importfileprefix' "${importfileprefix}" | tee -a -i ${logfilepath}
    printf "%-${tcol01}s = %s\n" 'importfileext' "${importfileext}" | tee -a -i ${logfilepath}
    printf "%-${tcol01}s = %s\n" 'importfilepath' "${importfilepath}" | tee -a -i ${logfilepath}
fi
if ${use_resultsfile} ; then
    printf "%-${tcol01}s = %s\n" 'resultsfileprefix' "${resultsfileprefix}" | tee -a -i ${logfilepath}
    printf "%-${tcol01}s = %s\n" 'resultsfileext' "${resultsfileext}" | tee -a -i ${logfilepath}
    printf "%-${tcol01}s = %s\n" 'resultsfilepath' "${resultsfilepath}" | tee -a -i ${logfilepath}
fi
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# Make sure working folders exist
# -------------------------------------------------------------------------------------------------


if ${use_showfile} ; then
    if [ ! -r ${showfilepath} ] ; then
        mkdir -pv ${showfilepath} | tee -a -i ${logfilepath}
        chmod 775 ${showfilepath} | tee -a -i ${logfilepath}
    else
        chmod 775 ${showfilepath} | tee -a -i ${logfilepath}
    fi
fi

if ${use_exportfile} ; then
    if [ ! -r ${exportfilepath} ] ; then
        mkdir -pv ${exportfilepath} | tee -a -i ${logfilepath}
        chmod 775 ${exportfilepath} | tee -a -i ${logfilepath}
    else
        chmod 775 ${exportfilepath} | tee -a -i ${logfilepath}
    fi
fi
if ${use_exportfile4ref} ; then
    if [ ! -r ${exportfilepath4reference} ] ; then
        mkdir -pv ${exportfilepath4reference} | tee -a -i ${logfilepath}
        chmod 775 ${exportfilepath4reference} | tee -a -i ${logfilepath}
    else
        chmod 775 ${exportfilepath4reference} | tee -a -i ${logfilepath}
    fi
fi

if ${use_importfile} ; then
    if [ ! -r ${resultsfilepath} ] ; then
        mkdir -pv ${resultsfilepath} | tee -a -i ${logfilepath}
        chmod 775 ${resultsfilepath} | tee -a -i ${logfilepath}
    else
        chmod 775 ${resultsfilepath} | tee -a -i ${logfilepath}
    fi
fi

if ${use_resultsfile} ; then
    if [ ! -r ${importfilepath} ] ; then
        mkdir -pv ${importfilepath} | tee -a -i ${logfilepath}
        chmod 775 ${importfilepath} | tee -a -i ${logfilepath}
    else
        chmod 775 ${importfilepath} | tee -a -i ${logfilepath}
    fi
fi


# -------------------------------------------------------------------------------------------------
# Configure Authentication
# -------------------------------------------------------------------------------------------------


#export MgmtCLI_Authentication='-s '${APICLIsessionfile}
export MgmtCLI_Authentication='-r true --port '${apisslport}


# -------------------------------------------------------------------------------------------------
# Get the Array of layers
# -------------------------------------------------------------------------------------------------


echo 'Generate Array of Layers...' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

export MgmtCLI_Base_OpParms='-f json'
export MgmtCLI_Show_OpParms='details-level full '${MgmtCLI_Base_OpParms}
export MgmtCLI_Show_OpParms='limit 50 offset 0 '${MgmtCLI_Show_OpParms}

if ${policy_type_HTTPSI} ; then
    # Currently HTTPS Inspection does not have the option for multiple layers in the package
    GETLAYERSBYNAME="`mgmt_cli ${MgmtCLI_Authentication} show packages ${MgmtCLI_Show_OpParms} | ${JQ} '.packages[]."https-inspection-layer".name'`"
else
    #if ${policy_type_Access} ; then
    #if ${policy_type_Threat} ; then
    GETLAYERSBYNAME="`mgmt_cli ${MgmtCLI_Authentication} show packages ${MgmtCLI_Show_OpParms} | ${JQ} '.packages[]."'${package_layer}'"[].name'`"
fi

LAYERSARRAY=()
arraylength=0

tcollayer=15

echo 'Layers ('${package_layer}') :  ' | tee -a -i ${logfilepath}
while read -r line; do
    
    #printf "%-${tcol01}s = %s\n" 'X' "${X}" | tee -a -i ${logfilepath}
    if [[ ! " ${LAYERSARRAY[@]} " =~ " ${line} " ]]; then
        # whatever you want to do when array doesn't contain value
        LAYERSARRAY+=("${line}")
        printf "%-${tcollayer}s - %s\n" '+ ADDING' "${line}" | tee -a -i ${logfilepath}
    else
        printf "%-${tcollayer}s - %s\n" '! SKIPPING' "${line}" | tee -a -i ${logfilepath}
    fi
    
    arraylength=${#LAYERSARRAY[@]}
    arrayelement=$((arraylength-1))
    
done <<< "${GETLAYERSBYNAME}"
echo

export arraylistsize=${arrayelement}


# -------------------------------------------------------------------------------------------------
# Document/show the current array of layers found and placed in the array
# -------------------------------------------------------------------------------------------------


echo 'Explicit Layers of type '${package_layer}' found: ' >> ${logfilepath}

export arraylistelement=-1

for j in "${LAYERSARRAY[@]}"
do
    export arraylistelement=$((arraylistelement+1))
    printf "%-5s : %s\n" ${arraylistelement} ${j} >> ${logfilepath}
done
echo >> ${logfilepath}


# -------------------------------------------------------------------------------------------------
# Handle selection of specific layer to process
# -------------------------------------------------------------------------------------------------


export arrayelementchoice=
export layername=

echo | tee -a -i ${logfilepath}
echo 'Select Layer of type '${package_layer}' for processing ( 0 for exit/quit ): ' | tee -a -i ${logfilepath}

select layername in "${LAYERSARRAY[@]}";
do
    echo You picked : ${layername} \(${REPLY}\) | tee -a -i ${logfilepath}
    
    if [ x"${layername}" == x"" ] ; then
        echo 'Not legal selection' | tee -a -i ${logfilepath}
        echo 'Exiting...' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        exit 1
    elif [ ${REPLY} -eq 0 ] ; then
        echo 'Exiting...' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        exit 0
    fi
    
    break;
done

echo 'Selection:  layername : ['${layername}'],  REPLY : ['${REPLY}']' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

export arrayelementchoice=$((REPLY-1))


# -------------------------------------------------------------------------------------------------
# Show what was selected and names of things
# -------------------------------------------------------------------------------------------------


export layerfilename=${layername// /_}
export layerfilename=${layerfilename//\"}

#printf "%-${tcol01}s = %s\n" 'X' "${X}" | tee -a -i ${logfilepath}

echo | tee -a -i ${logfilepath}
printf "%-${tcol01}s = %s\n" 'arraylistsize' "${arraylistsize}" | tee -a -i ${logfilepath}
printf "%-${tcol01}s = %s\n" 'arrayelementchoice' "${arrayelementchoice}" | tee -a -i ${logfilepath}
printf "%-${tcol01}s = %s\n" 'layername' "${layername}" | tee -a -i ${logfilepath}
printf "%-${tcol01}s = %s\n" 'layerfilename' "${layerfilename}" | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# Generate working json file of API output for future processing
# -------------------------------------------------------------------------------------------------


echo 'Generate working json file of API output for future processing...' | tee -a -i ${logfilepath}

#export detaillevelset=standard
export detaillevelset=full
export showfile=${showfilepath}/${showfileprefix}.${layerfilename}.${detaillevelset}.${localnamenow}.${showfileext}
#export showfile=${showfilepath}/${showfileprefix}.${detaillevelset}.${localnamenow}.${showfileext}

echo | tee -a -i ${logfilepath}
#printf "%-${tcol01}s = %s\n" 'showfile' "${showfile}" | tee -a -i ${logfilepath}
printf "%-${tcol01}s = %s\n" 'showfile : '${detaillevelset} "${showfile}" | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

export MgmtCLI_Base_OpParms='-f json'
export MgmtCLI_Show_OpParms='details-level full '${MgmtCLI_Base_OpParms}
#export MgmtCLI_Show_OpParms='details-level full use-object-dictionary false '${MgmtCLI_Base_OpParms}
#export MgmtCLI_Show_OpParms='limit 100 offset 0 '${MgmtCLI_Show_OpParms}

#mgmt_cli ${MgmtCLI_Authentication} ${api_show_command} ${MgmtCLI_Show_OpParms} > "${showfile}"
mgmt_cli ${MgmtCLI_Authentication} ${api_show_command} name "${layername}" ${MgmtCLI_Show_OpParms} > "${showfile}"
#mgmt_cli ${MgmtCLI_Authentication} ${api_show_command} name "${layername}" rule-number 1 ${MgmtCLI_Show_OpParms} > "${showfile}"

echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

ls -alh ${showfile} | tee -a -i ${logfilepath}

echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------------------------




# -------------------------------------------------------------------------------------------------
# Wrap Up
# -------------------------------------------------------------------------------------------------

echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


echo | tee -a -i ${logfilepath}
echo 'Operations completed!' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

if ${use_showfile} ; then
    ls -alh ${showfilepath}
    echo | tee -a -i ${logfilepath}
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
fi

if ${use_exportfile} ; then
    ls -alh ${exportfilepath}
    echo | tee -a -i ${logfilepath}
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
fi
if ${use_exportfile4ref} ; then
    ls -alh ${exportfilepath4reference}
    echo | tee -a -i ${logfilepath}
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
fi

if ${use_importfile} ; then
    ls -alh ${importfilepath}
    echo | tee -a -i ${logfilepath}
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
fi

if ${use_resultsfile} ; then
    ls -alh ${resultsfilepath}
    echo | tee -a -i ${logfilepath}
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
fi

echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}
echo 'Log output in file   : '"${logfilepath}" | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}
echo 'Script completed.' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

