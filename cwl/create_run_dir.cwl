cwlVersion: v1.2
class: CommandLineTool

baseCommand: [/bin/bash, '-c']

doc: |
  This command-line script will extract, and tidy up, the run directory
  for WRF from the WRF docker container. It takes 2 inputs, a simple boolean
  which fulfils CWL's input requirements, and an optional string for replacing
  the copy command, if required.
  
  The purpose of this script is to enable the use of the run-time input files which
  are bundled with the WRF source code. If you need to modify any of these then we
  recommend extracting the directory using:
      cwltool cwl/create_run_dir.cwl --generate_rundir
  then modifying the files as needed, and providing the directory as an input 
  to your main workflow. 
hints:
  DockerRequirement:
    dockerPull: oliverwoolland/wrf_wps:latest


inputs:
  generate_rundir:
    type: boolean
  
  script:
    type: string?
    default: |
      cp -a /usr/local/WRF/run . ; rm run/*exe ; rm run/namelist.input
    inputBinding:
      position: 1

outputs:
  rundir:
    type: Directory
    outputBinding:
      glob: "run"
