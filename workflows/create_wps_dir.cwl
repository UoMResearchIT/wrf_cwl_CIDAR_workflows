cwlVersion: v1.2
class: CommandLineTool

baseCommand: [/bin/bash, '-c']

doc: |
  This command-line script will extract, and tidy up, the run directory
  for WPS from the WRF docker container. It takes 2 inputs, a simple boolean
  which fulfils CWL's input requirements, and an optional string for replacing
  the copy command, if required.
  
  The purpose of this script is to enable the use of the run-time input files which
  are bundled with the WRF source code. If you need to modify any of these then we
  recommend extracting the directory using:
      cwltool cwl/create_wps_dir.cwl --generate_wpsdir
  then modifying the files as needed, and providing the directory as an input 
  to your main workflow. 
hints:
  DockerRequirement:
    dockerPull: oliverwoolland/wrf_wps:latest


inputs:
  generate_wpsdir:
    type: boolean
  
  script:
    type: string?
    default: |
      mkdir ./WPS-src
      mkdir ./WPS-src/geogrid
      mkdir ./WPS-src/metgrid
      mkdir ./WPS-src/ungrib
      cp /WRF-SOURCES/WPS/WPS-src/geogrid/GEOGRID* WPS-src/geogrid/
      cp /WRF-SOURCES/WPS/WPS-src/metgrid/METGRID* WPS-src/metgrid/
      cp /WRF-SOURCES/WPS/WPS-src/metgrid/gribmap.txt WPS-src/metgrid/
      cp /WRF-SOURCES/WPS/WPS-src/geogrid/gribmap.txt WPS-src/geogrid/
      cp -r /WRF-SOURCES/WPS/WPS-src/ungrib/Variable_Tables WPS-src/ungrib/
    inputBinding:
      position: 1

outputs:
  wpsdir:
    type: Directory
    outputBinding:
      glob: "WPS-src"
