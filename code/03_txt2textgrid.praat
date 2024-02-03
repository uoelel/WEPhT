derived$ = "../data/swahili/derived"

dirs = Create Strings as directory list: "dir_list", derived$
dirs_n = Get number of strings

# Loop through directories
for dir from 1 to dirs_n
  selectObject: dirs
  dir$ = Get string: dir

  createFolder: "'derived$'/'dir$'"

  files = Create Strings as file list: "file_list", "'derived$'/'dir$'/*.txt"
  files_n = Get number of strings

  # Loop through text files in each directory
  for file from 1 to files_n
    selectObject: files
    file$ = Get string: file
    file_name$ = file$ - ".txt"
    txt = Read Strings from raw text file: "'derived$'/'dir$'/'file$'"
    txt$ = Get string: 1
    wav = Read from file: "'derived$'/'dir$'/'file_name$'.wav"
    tg = To TextGrid: dir$, ""

    Set interval text: 1, 1, txt$
    Save as text file: "'derived$'/'dir$'/'file_name$'.TextGrid"


  endfor
endfor