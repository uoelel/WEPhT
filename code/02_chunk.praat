raw$ = "../data/swahili/raw"
derived$ = "../data/swahili/derived"
createFolder: derived$

dirs = Create Strings as directory list: "dir_list", raw$
dirs_n = Get number of strings

# Loop through directories
for dir from 1 to dirs_n
  selectObject: dirs
  dir$ = Get string: dir

  createFolder: "'derived$'/'dir$'"

  files = Create Strings as file list: "file_list", "'raw$'/'dir$'/*.wav"
  files_n = Get number of strings

  # Loop through files in each directory
  for file from 1 to files_n
    selectObject: files
    file$ = Get string: file
    file_name$ = file$ - ".wav"
    wav = Read from file: "'raw$'/'dir$'/'file$'"
    tg = Read from file: "'raw$'/'dir$'/'file_name$'-fixed.TextGrid"

    selectObject: tg
    int_n = Get number of intervals: 1

    for int from 1 to int_n
      selectObject: tg
      int$ = Get label of interval: 1, int

      if int$ == "sounding"
        int_start = Get start time of interval: 1, int
        int_end = Get end time of interval: 1, int

        selectObject: wav
        wav_part = Extract part: int_start - 0.1, int_end + 0.1, "rectangular", 1, "no"

        @zeroPadding: int, 3
        Save as WAV file: "'derived$'/'dir$'/'file_name$'-'zeroPadding.return$'.wav"
      endif
    endfor
  endfor
endfor


# Procedure to pad zeros in file names indeces
procedure zeroPadding: .num, .numZeros
  .highestVal = 10 ^ .numZeros

  .num$ = string$: .num
  .numLen = length: .num$

  .numToAdd = .numZeros - .numLen

  .zeroPrefix$ = ""
  if .numToAdd > 0
      for i from 1 to .numToAdd
          .zeroPrefix$ = .zeroPrefix$ + "0"
      endfor
  endif

  .return$ = .zeroPrefix$ + .num$
endproc