raw$ = "../data/mawayana/mapi1252_long/yapoma"
derived$ = "../data/mawayana/mapi1252/yapoma"

txt = Read Strings from raw text file: "'raw$'/yapoma_iguana.txt"
files = Create Strings as file list: "file_list", derived$
files_n = Get number of strings

for file from 1 to files_n
  selectObject: files
  file$ = Get string: file
  file_name$ = file$ - ".wav"

  selectObject: txt
  txt_part = Extract part: file, file
  Save as raw text file: "'derived$'/'file_name$'.txt"
endfor

