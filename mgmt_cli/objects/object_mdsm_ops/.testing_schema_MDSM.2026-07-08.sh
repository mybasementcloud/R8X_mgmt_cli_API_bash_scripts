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
# Testing schema for MDSM MDS with domain "EXAMPLE-DEMO"
#
#
ScriptVersion=00.70.00
ScriptRevision=000
ScriptSubRevision=450
ScriptDate=2026-08-19
TemplateVersion=00.70.00
APISubscriptsLevel=020
APISubscriptsVersion=00.70.00
APISubscriptsRevision=000

#

#
# These script calls should be executed manually
#
exit 0

#"System Data"
#"Global"
#"EXAMPLE-DEMO"


# Export, Import, Set-Update, Delete specific testing

./cli_api_import_objects_from_csv.sh -v -r --NOWAIT --RESULTS -d "EXAMPLE-DEMO" -i "/var/log/__customer/devops.dev/export_import.wip/test/import.csv"

./cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS -d "EXAMPLE-DEMO" --NSO --10-TAGS --CSVERR

./cli_api_set_update_objects_from_csv.sh -v -r --NOWAIT --RESULTS -d "EXAMPLE-DEMO" -i "/var/log/__customer/devops.dev/export_import.wip/test/set_update.csv"

./cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS -d "EXAMPLE-DEMO" --NSO --10-TAGS --CSVERR

./cli_api_delete_objects_using_csv.sh -v -r --NOWAIT --RESULTS -d "EXAMPLE-DEMO" -k "/var/log/__customer/devops.dev/export_import.wip/test/delete.csv"

./cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS -d "EXAMPLE-DEMO" --NSO --10-TAGS --CSVERR

# Export specific testing

./cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVALL --NO-CPI
./cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format all --KEEPCSVWIP --NSO --10-TAGS --CSVERR --NO-CPI
./cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format all --KEEPCSVWIP --OSO --10-TAGS --CSVALL --NO-CPI

./cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO
./cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO
./cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO

./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVALL
./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR
./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --OSO --10-TAGS --CSVALL

./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t "name-only"
./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t "name-and-uid"
./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t "uid-only"
./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t "rename-to-new-name"
./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO -t 'name-for-delete'

./cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --NSO --10-TAGS --CSVERR -d "Global"

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# ADDED 2021-11-09 - MODIFIED 2025-12-12:01 -
#
# Presumptive folder structure for R8X mgmt_cli API bash scripts Template based scripts
#
# <root_home_folder> is the folder containing the script set, generally /var/log/__customer
# <script_home_folder> is the folder containing the script set, generally /var/log/__customer[/_testing/]mgmt_cli
# DEPRECATED:  <script_home_folder> is the folder containing the script set, Legacy /var/log/__customer/devops|devops.dev|devops.dev.test
# DEPRECATED:  [.wip] named folders are for development operations
#
# ...<root_home_folder>/devops.my_data                     ## my_data folder for all scripts, folder for all customer provided csv folders
# ...<root_home_folder>/devops.results                     ## results folder for all scripts, default home of ${script_json_repo_folder}
# ...<root_home_folder>/tools                              ## tools folder for all scripts with additional tools not assumed on system
# ...<root_home_folder>/mgmt_cli                           ## root folder for all mgmt_cli scripts and templates
# ...<root_home_folder>/_testing/mgmt_cli                  ## root folder for all mgmt_cli testing of scripts and templates
#
# ...<root_home_folder>/mgmt_cli = <script_home_folder>    ## for normal operations
# ...<root_home_folder>/_testing/mgmt_cli = <script_home_folder>  ## for testing operations
#
# ...<script_home_folder>/                                 ## root folder for all mgmt_cli scripts and templates
# ...<script_home_folder>/_common/                         ## _common root folder for all common scripts and templates
# ...<script_home_folder>/_common/_api_subscripts          ## _api_subscripts folder for all api subscripts scripts
# ...<script_home_folder>/_common/_templates               ## _templates folder for all script templates
# ...<script_home_folder>/logs                             ## logs root folder for logs focused scripts (future development)
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
#    /var/log/__customer/mgmt_cli/logs
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
#    /var/log/__customer/_testing/mgmt_cli/logs
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


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")

#
# JSON and CSV Exports, builds JSON Repository
#
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVALL")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --NSO --10-TAGS --CSVERR")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --OSO --10-TAGS --CSVALL")

#
# JSON only Exports, builds JSON Repository
#
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO")

#
# CSV only Exports
#
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVALL")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --OSO --10-TAGS --CSVALL")

#export TESTOPSARRAY+=("../object_export_import/cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --SO --10-TAGS --CSVALL -d 'Global'")
#export TESTOPSARRAY+=("../object_export_import/cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --NSO --10-TAGS --CSVERR -d 'Global'")
#export TESTOPSARRAY+=("../object_export_import/cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --OSO --10-TAGS --CSVALL -d 'Global'")

# --type-of-export <export_type> | --type-of-export=<export_type>
#  Supported <export_type> values for export to CSV :  <"standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name"|"name-for-delete">
#    "standard" {DEFAULT} :  Standard Export of all supported object key values
#    "name-only"          :  Export of just the name key value for object
#    "name-and-uid"       :  Export of name and uid key value for object
#    "uid-only"           :  Export of just the uid key value of objects
#    "rename-to-new-name" :  Export of name key value for object rename
#    "name-for-delete"    :  Export of name key value for object delete also sets other settings needed for clean delete control CSV
#    For an export for a delete operation via CSV, use "name-only"

#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-only'")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-and-uid'")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'uid-only'")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name'")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO -t 'name-for-delete'")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")

#
# JSON and CSV Exports, builds JSON Repository
#
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVALL --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --NSO --10-TAGS --CSVERR --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --OSO --10-TAGS --CSVALL --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")

#
# JSON only Exports, builds JSON Repository
#
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")

#
# CSV only Exports
#
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVALL --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --OSO --10-TAGS --CSVALL --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")

#export TESTOPSARRAY+=("cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --SO --10-TAGS --CSVALL -d 'Global' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
#export TESTOPSARRAY+=("cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --NSO --10-TAGS --CSVERR -d 'Global' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
#export TESTOPSARRAY+=("cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --OSO --10-TAGS --CSVALL -d 'Global' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")

# --type-of-export <export_type> | --type-of-export=<export_type>
#  Supported <export_type> values for export to CSV :  <"standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name"|"name-for-delete">
#    "standard" {DEFAULT} :  Standard Export of all supported object key values
#    "name-only"          :  Export of just the name key value for object
#    "name-and-uid"       :  Export of name and uid key value for object
#    "uid-only"           :  Export of just the uid key value of objects
#    "rename-to-new-name" :  Export of name key value for object rename
#    "name-for-delete"    :  Export of name key value for object delete also sets other settings needed for clean delete control CSV
#    For an export for a delete operation via CSV, use "name-only"

#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-only' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-and-uid' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'uid-only' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
#export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO -t 'name-for-delete' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------




# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#common_csv_exports_mdsm
#"Common Export Execution for MDSM collection"

export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVALL")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR")
export TESTOPSARRAY+=("../object_export_import/cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --NSO --10-TAGS --CSVERR -d 'Global'")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name'")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#common_csv_exports_mdsm_100_max_limit
#"Common Export Execution for MDSM collection 100 object max limit"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVALL --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --NSO --10-TAGS --CSVERR -d 'Global' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#common_exports_mdsm
#"Common Export Execution for MDSM collection"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVALL")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR")
export TESTOPSARRAY+=("../object_export_import/cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --NSO --10-TAGS --CSVERR -d 'Global'")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name'")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#common_exports_mdsm_100_max_limit
#"Common Export Execution for MDSM collection 100 object max limit"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVALL --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_special_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --KEEPCSVWIP --NSO --10-TAGS --CSVERR -d 'Global' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#other_main_exports_mdsm
#"Other Main Exports Execution for MDSM collection"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --NSO --10-TAGS --CSVERR")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --OSO --10-TAGS --CSVALL")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#other_main_exports_mdsm_100_max_limit
#"Other Main Exports Execution for MDSM collection 100 object max limit"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --NSO --10-TAGS --CSVERR --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --OSO --10-TAGS --CSVALL --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#refresh_all_json_object_repositories_mdsm
#"Refresh ALL JSON Object Repositories [-SO, -NSO, -OSO] -  - MDSM"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#refresh_all_json_object_repositories_mdsm_100_max_limit
#"Refresh ALL JSON Object Repositories [-SO, -NSO, -OSO] -  - MDSM 100 object max limit"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#refresh_json_object_repository_mdsm
#"Refresh JSON Object Repository (-SO) - MDSM"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#refresh_json_object_repository_mdsm_100_max_limit
#"Refresh JSON Object Repository (-SO) - MDSM 100 object max limit"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#test_exports_csv_mdsm
#"Test Export to CSV Execution MDSM collection"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVALL")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --OSO --10-TAGS --CSVALL")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-only'")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-and-uid'")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'uid-only'")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name'")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO -t 'name-for-delete'")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#test_exports_csv_mdsm_100_max_limit
#"Test Export to CSV Execution MDSM collection 100 object max limit"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVALL --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --OSO --10-TAGS --CSVALL --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-only' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-and-uid' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'uid-only' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO -t 'name-for-delete' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#test_exports_json_mdsm
#"Test Export to JSON Execution MDSM collection"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#test_exports_json_mdsm_100_max_limit
#"Test Export to JSON Execution MDSM collection 100 object max limit"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#test_exports_mdsm
#"Test Export Execution MDSM collection"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVALL")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --NSO --10-TAGS --CSVERR")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --OSO --10-TAGS --CSVALL")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-only'")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-and-uid'")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'uid-only'")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name'")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO -t 'name-for-delete'")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#test_exports_mdsm_100_max_limit
#"Test Export Execution MDSM collection 100 object max limit"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVALL --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --NSO --10-TAGS --CSVERR --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --OSO --10-TAGS --CSVALL --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-only' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-and-uid' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'uid-only' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO -t 'name-for-delete' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#test_import_export_set_update_delete_mdsm
#"Test Import Export Set-Update Delete Execution collection - test environment - MDSM"


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_import_objects_from_csv.sh -v -r --NOWAIT --RESULTS -d "Global" -i '"${test_script_work_folder}"/test/import.csv'")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS -d "Global" --NSO --10-TAGS --CSVERR")
export TESTOPSARRAY+=("cli_api_set_update_objects_from_csv.sh -v -r --NOWAIT --RESULTS -d "Global" -i '"${test_script_work_folder}"/test/set_update.csv'")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS -d "Global" --NSO --10-TAGS --CSVERR")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS -d "Global" -t 'name-for-delete'")
export TESTOPSARRAY+=("cli_api_delete_objects_using_csv.sh -v -r --NOWAIT --RESULTS -d "Global" -k '"${test_script_work_folder}"/test/delete.csv'")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS -d "Global" --NSO --10-TAGS --CSVERR")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#test_import_export_set_update_delete_mdsm_100_max_limit
#"Test Import Export Set-Update Delete Execution collection - test environment 100 object max limit"

export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")
export TESTOPSARRAY+=("cli_api_import_objects_from_csv.sh -v -r --NOWAIT --RESULTS -d "Global" -i '"${test_script_work_folder}"/test/import.csv'")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS -d "Global" --NSO --10-TAGS --CSVERR --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_set_update_objects_from_csv.sh -v -r --NOWAIT --RESULTS -d "Global" -i '"${test_script_work_folder}"/test/set_update.csv'")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS -d "Global" --NSO --10-TAGS --CSVERR --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS -d "Global" -t 'name-for-delete' --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")
export TESTOPSARRAY+=("cli_api_delete_objects_using_csv.sh -v -r --NOWAIT --RESULTS -d "Global" -k '"${test_script_work_folder}"/test/delete.csv'")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS -d "Global" --NSO --10-TAGS --CSVERR --OVERRIDEMAXOBJECTS --MAXOBJECTS 100")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#



