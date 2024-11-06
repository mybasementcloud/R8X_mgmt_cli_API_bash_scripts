# R8X-API-scripts-4-policy-import-export

## Check Point R8X API scripts for policy import, export, modification

### Threat Prevention policy and layer related scripts

These are very rough scripts for handling policy and layer related operations for Check Point Software Technologies SmartManagement versions R8X utilizing the Management API.

This folder handles the Threat Prevention policy and layer related scripts

- Threat Prevention Policy
  - List Threat Prevention Layers
    - Provide a selection list of all Threat Prevention rules layers in the active Management Host or MDSM Domain [future], on selection that layer will be output to json via the show threat-layer command
  - List Threat Prevention Layers from Policy Packages
    - Provide a selection list of Threat Prevention rules layers as provided in the policy packages in the active Management Host or MDSM Domain [future], on selection that layer will be output to json via the show threat-layer command -- essentially dump the ordered layers of the policy as used in policies
  - Threat Prevention Profiles (Export/Import)
    - Generate an export CSV files for the Threat Prevention Profiles
    - Export Threat Prevention Profiles to FOR_REFERENCE_ONLY CSV with additional details about the profile that are useful for other operations or research
    - Export Threat Prevention Profiles to EXPORT CSV that should import the profiles to a different Management Host or MDSM Domain with the appropriate mgmt_cli command utilizing --batch filename option
    - Export Threat Prevention Profiles to EXPORT CSV with IPS extended attributes for [de-]activate for initial reference and testing of approach to actually import with the extended attributes.
    - Import Threat Prevention Profiles from CSV based on selection of CSV file with EXPORT naming convention from files found in subfolder _import.csv
    - Import command RAW:  
    ```mgmt_cli -r true add threat-profile --batch ./zz.threat_profiles.export.HOST.DTGSZ.csv details-level full --ignore-errors true -f json | tee -a import_threat_profiles_${HOSTNAME}_`date +%Y-%m-%d-%H%M%S%Z`.json```
  - Threat Prevention Rulebase (Export/Import)
    - Provides selection of target Threat Prevention layer to export
    - Generate an export CSV files for the Threat Prevention Rulebase for the selected layer
    - Export Threat Prevention Rulebase to FOR_REFERENCE_ONLY CSV with additional details about the rulebase for the selected layer that are useful for other operations or research
    - Export Threat Prevention Rulebase to EXPORT CSV that should import the profiles to a different Management Host or MDSM Domain with the appropriate mgmt_cli command utilizing --batch filename option
    - Import Threat Prevention Rulebase from CSV based on selection of CSV file with EXPORT naming convention from files found in subfolder _import.csv
    - *NOTE!*  Import may required modification of the first CSV column to reflect the target Threat Prevention layer to which the rulebase should be applied, which may not be the same as the exported layer, which is named in the first column.
    - Import command RAW:  
    ```mgmt_cli -r true add threat-rule --batch ./z.threat_rulebase.LAYER.export.HOSTNAME.DTGSZ.csv details-level full --ignore-errors true -f json | tee -a import_threat_rules_${HOSTNAME}_`date +%Y-%m-%d-%H%M%S%Z`.json```
  - Threat Prevention Rulebase Exceptions - Global Exceptions (Export/Import)
    - Provides selection of target Threat Prevention layer to export.  NOTE:  for the Global Exceptions, ANY layer choice will work as needed
    - Generate an export CSV files for the Threat Prevention Rule Exceptions Global Exceptions
    - Export Threat Prevention Rule Exceptions Global Exceptions to FOR_REFERENCE_ONLY CSV with additional details about the profile that are useful for other operations or research
    - Export Threat Prevention Rule Exceptions Global Exceptions to EXPORT CSV that should import the profiles to a different Management Host or MDSM Domain with the appropriate mgmt_cli command utilizing --batch filename option
    - Import Threat Prevention Rule Exceptions from CSV based on selection of CSV file with EXPORT naming convention from files found in subfolder _import.csv
    - Import command RAW:  
    ```mgmt_cli -r true add threat-exception --batch ./zz.threat_rule_exception_rulebase.Global_Exceptions.export.HOST.DTGSZ.csv details-level full --ignore-errors true -f json | tee -a import_global_threat_exceptions_${HOSTNAME}_`date +%Y-%m-%d-%H%M%S%Z`.json```
  - more pending

As these are explicitly different policy data sets.

## Environment and Version Assumptions/Requirements

Rough scripts have been built using an environment built on API version 1.7, so R81, but may work on earlier versions.  API version handling is currently not included in the rough scripts.

## Operation and API Authentication

The scripts are R8X Gaia bash scripts to operate at the expert CLI and will require either appropriate rights for the administrator using them or an ability to modify the scripts to change the authentication approach, currently defaulting to '-r true'.  Script variable 'MgmtCLI_Authentication' handles the API User Administrator's authentication.

## Management host web SSL port handling

Basic handling in the scripts accounts for the local SSL Web port such that it will adjust to enduser changes to the Management host's Gaia Web UI web SSL port automatically.

## Logging and Output

Detail controls for logging and output are not yet set, and aside from screen output, and the files for working operations and final results, log files are currently generated.  The current scripts create files for exported content, operations output and logging, show operation json output, and will utilize an import folder where import CSV files are expected.

Standard Folders added to each Policy type folder:
- _export.csv -- this folder is where usable export files are exported by the export operations
- _export.csv.FOR_REFERENCE_ONLY -- this folder is where "For Reference Only" files are generated by the export operations for reference
- _import.csv -- this folder is where the import operations will look for relevant files (as generated by export operation) to list for import
- _output -- this folder is for logging and results operations generated by import and delete operations that have a json output
- _output.json -- this folder is for show operation json files used for export operations or generated in list layer operations and available post partum

## MDSM - Multi-Domain Security Management Support

The scripts are currently not MDSM aware by nature, but script modification of the variable 'MgmtCLI_Authentication' will make MDSM operation possible, by adding correct and valid domain target.

## Caveats and Identified Limitations

The CAVEATS_AND_LIMITATIONS_Threat_Prevention_Policy.md file will address caveats and identified limitations for the Threat Prevention scripts

## Future

Depending on the 4th dimension resourse availability (time), these scripts may be:

- integrated into the existing script template approach from <https://github.com/mybasementcloud/R8x-export-import-api-scripts>, thus expanding some of the extensive controls available for the script operation, API authentication, MDSM operation, logging, and other controls.
- Expanded to handle more key value sets for a specific script target output
- Edited to address updates in the API beyond version 1.7
- Edited to address support of back versions of the API, not earlier than R80.10
- Other policy elements from the existing technologies if available to the API
- Provide delete operations to help clean-up some imported elements, since that will aid with testing
