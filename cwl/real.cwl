cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpirun

doc: |
  Note: *Must* be run with the option --relax-path-checks. Otherwise WRF file naming
  conventions (e.g. met_em.d01.2017-12-25_00:00:00.nc) will trigger warnings about 
  illegal characters.

hints:
  DockerRequirement:
    dockerPull: oliverwoolland/wrf-docker:latest
    
requirements:
  NetworkAccess:
    networkAccess: True
  LoadListingRequirement:
    loadListing: shallow_listing
  InitialWorkDirRequirement:
    listing:
      - $(inputs.rundir.listing)
      - entry: $(inputs.namelist)
        entryname: namelist.input
      - $(inputs.metdir.listing)

arguments: 
  - valueFrom: "/usr/local/WRF/main/real.exe"
    position: 2

inputs:

  rundir:
    type: Directory

  namelist:
    type: File

  metdir:
    type: Directory

  cores:
    type: int
    inputBinding:
      prefix: "-np"
      position: 1
    default: 4

outputs:
  output_logs:
    type:
      type: array
      items: File
    outputBinding:
      glob: "rsl.*"
  output_wrfinput:
    type:
      type: array
      items: File
    outputBinding:
      glob: "wrfinput_d*"
  output_wrfbdy:
    type: 
      type: array
      items: File
    outputBinding:
      glob: "wrfbdy_d*"
  output_wrflowinput:
    type: 
      type: array
      items: File
    outputBinding:
      glob: "wrflowinput_d*"
