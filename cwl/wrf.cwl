cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpirun

doc: |
  Note: *Must* be run with the option --relax-path-checks. Otherwise WRF file naming
  conventions (e.g. met_em.d01.2017-12-25_00:00:00.nc) will trigger warnings about 
  illegal characters.


hints:
  DockerRequirement:
    dockerPull: oliverwoolland/wrf_wps:latest
    
requirements:
  NetworkAccess:
    networkAccess: True
  LoadListingRequirement:
    loadListing: shallow_listing
  InitialWorkDirRequirement:
    listing:
      - $(inputs.rundir.listing)
      - $(inputs.namelist)
      - $(inputs.wrfinputs)
      - $(inputs.wrfbdys)

arguments: 
  - valueFrom: "/usr/local/WRF/main/wrf.exe"
    position: 2

inputs:

  rundir:
    type: Directory

  namelist:
    type: File

  wrfinputs:
    type: 
      type: array
      items: File

  wrfbdys:
    type: 
      type: array
      items: File

  cores:
    type: int
    inputBinding:
      prefix: "-np"
      position: 1
    default: 8

outputs:
  output_logs:
    type:
      type: array
      items: File
    outputBinding:
      glob: "rsl.*"
  output_wrfout:
    type:
      type: array
      items: File
    outputBinding:
      glob: "wrfout_d*"
