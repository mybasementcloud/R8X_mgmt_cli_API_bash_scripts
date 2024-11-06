# DEVOPS Standards for Versioning and Version Control operations for R8X API DEVOPS

| Document Information | Datum |
|:---:|:---|
|Echelon|MyBasementCloud R8X API DEVOPS|
|Managed By|@MyBasementCloud|
|Document Version|v00.70.00.000|
|Document Status|Draft|
|Created|2023-03-13|
|Modified|2023-03-13|

## Purpose for Standards for Versioning and Version Control

Establishment of a stadard for Versioning and Version Control is necesary to aid in code/script development operations and reduce confusion by ad-hoc release numbering approaches, applying to the MyBasementCloud organization R8X API DEVOPS environment and solutions.

## Version Structure Utilization and Purpose

The standard approach to Versioning is based on a three (3) to five (5) element version number that either has a character "v" prefix in upper or lower case, which are hierarchical in their meaning and sorting.

### Version Structure {Version Prefix}{Major Version}{dot}{Minor Version}{dot}{Revision}[{(dot)|(colon)}{Subrevision}[{(dot)|(colon)}{Tweak}]]

```[{v|V}]{MM}{.}{mm}{.}{RR}[{.|:}{sss}[{.|:}{ttt}]]```

```{Version Prefix}{Major Version}{dot}{Minor Version}{dot}{Revision}[{(dot)|(colon)}{Subrevision}[{(dot)|(colon)}{Tweak}]]```

Version Structure Elements overview:

- Optional {v|V} Version prefix, normally lowercase
- Required {MM} Major Version - two (2) digit number Major Version
- Required {.(dot)} period separator
- Required {mm} Minor Version - two (2) digit number Minor Version
- Required {.(dot)} period separator
- Required {RR} Revision - two (2) digit number Revision (adjustment inside of Major.Minor version)
- Required for Subrevision {.(dot)|:(colon)} period separator
  - Optional {sss} Subrevision - three (3) digit number Subrevision (adjustment inside of Revision)
  - Required for Tweak {.(dot)|:(colon)} period separator,
    - Optional {ttt} Tweak - three (3) digit number tweak (adjustment inside of Subrevision)

#### Examples

- Default representations
  - v00.70.00
  - v00.70.00.000
  - v00.70.00.000.000
- Alternatives
  - v00.70.00:000
  - v00.70.00.000:000

#### Version Hierarchy Example

Highest (latest) to Lowest (oldest,earliest)

- v08.01.00
- v08.00.00.250.500
- v08.00.00.100.500
- v08.00.00.000
- v00.70.00.000.000
- v00.60.12.100.500
- v00.09.00.000

### Version Structure Table

Based on the following versioning standard:

```[{v|V}]{MM}{.}{mm}{.}{RR}[{.|:}{sss}[{.|:}{ttt}]]```

| Version Level | Required or Optional | Symbol | Separator to Next | Digit Count | Purpose |
|:---:|:---:|:---:|:---:|:---:|:---|
| 0 | Optional | v or V  | none | 1 | Version prefix, normally lowercase |
| 1 | Required | MM | .(dot) | 2 | Major Version |
| 2 | Required | mm | .(dot) | 2 | Minor Version |
| 3 | Required | RR | .(dot) or :(colon) | 2 | Revision (adjustment inside of Major.Minor version) |
| 4 | Optional | sss | .(dot) or :(colon) | 3 | Subrevision (adjustment inside of Revision) |
| 5 | Optional | ttt | n/a | 3 | tweak (adjustment inside of Subrevision) |

### Version Element Prefix (Level 0):  {Version Prefix}

Optional prefix character "V" in either lowercase or uppercase, with default approach including a lower case "v".

### Version Element Level 1:  {Major Version}

The Major Version {MM} is a two (2) digit numeric value that indicates the major version of the release.

A Major Version change is required when there is a major change in the operation of the versioned element, that indicates important differences to earlier Major Version releases, and resets all lower level elements to zero (00) or (000) depending on level.

When Major Version is shown as Zero (00) then that indicates that the versioned item is in a pure development versioning approach or an initial research activity.

### Version Element Level 2:  {dot}{Minor Version}

The Minor Version {mm} is a two (2) digit numeric value that indicates the minor version of the release offset from the Major Version by a dot {.}, that dot "." is required to separate the Major and Minor version elements.

A Minor Version change is required when there is a minor change in the operation of the versioned element, that indicates important differences to earlier Minor Version releases, and resets all lower level elements to zero (00) or (000) depending on level.

### Version Element Level 3:  {dot}{Revision}

The Revision {RR} is a two (2) digit numeric value that indicates the revision of the release offset from the Minor Version by a dot {.}, that dot "." is required to separate the Minor version and Revision elements.

A Revision change is required when there is a change in the operation of the versioned element, that indicates important differences to earlier Revision releases, and resets all lower level elements to zero (00) or (000) depending on level.

### Optional Version Element Levels

The Optional Version Element Levels are used during release development indicate a package of source files that are different from a previous versioned package of source files with a greater level of granularity.

#### Version Element Level 4:  [{(dot)|(colon)}{Subrevision}]

The Subrevision {sss} is an optional version element with a three (3) digit numeric value that indicates the subrevision of the release offset from the Revision by a dot {.} or colon {:}, that dot "." or colon {:} is required to separate the Revision and Subrevision elements.

A Subrevision change is used when there is a change in the operation of the versioned element, like:  bug, error, or cosmetic issue; that indicates differences to earlier Subrevision releases, and resets all lower level elements to zero (00) or (000) depending on level.

#### Version Element Level 5:  [{(dot)|(colon)}{Tweak}]

The Tweak {ttt} is an optional version element with a three (3) digit numeric value that indicates the tweak of the release offset from the Subrevision by a dot {.} or colon {:}, that dot "." or colon {:} is required to separate the Subrevision and Tweak elements.

A Tweak change is used when there is a small change in the operation of the versioned element, like:  bug, error, or cosmetic issue; that indicates important differences to earlier Tweak releases

This is currenlty the lowest level of versioning and version control.
