raw$ = "../data/swahili/raw"

dirs = Create Strings as directory list: "dir_list", raw$
dirs_n = Get number of strings

# Loop through directories
for dir from 1 to dirs_n
  selectObject: dirs
  dir$ = Get string: dir

  files = Create Strings as file list: "file_list", "'raw$'/'dir$'/*.wav"
  files_n = Get number of strings

  # Loop through files in each directory
  for file from 1 to files_n
    selectObject: files
    file$ = Get string: file
    file_name$ = file$ - ".wav"
    wav = Read from file: "'raw$'/'dir$'/'file$'"
    # Using -40 instead of -25 for silence threashold
    tg = To TextGrid (silences): 100, 0, -40, 0.1, 0.1, "silent", "sounding"
    Save as text file: "'raw$'/'dir$'/'file_name$'.TextGrid"
  endfor
endfor