word_tier = 1
phon_tier = 2
sentence_tier = 3

dir$ = "../data/swahili/swah1253"

results_header$ = "file,sentence,word,consonant,cog,duration,prev,foll"
results$ = "../data/swahili/fricatives.csv"
writeFileLine: results$, results_header$

dir_list = Create Strings as folder list: "dir_list", dir$
dir_n = Get number of strings

# Loop through speaker folders
for sp from 1 to dir_n
  selectObject: dir_list
  speaker$ = Get string: sp
  wav_list = Create Strings as file list: "wav_list", "'dir$'/'speaker$'/*.wav"
  wav_n = Get number of strings

  # Loop through speaker files
  for wav from 1 to wav_n
    selectObject: wav_list
    wav$ = Get string: wav
    wav_basename$ = wav$ - ".wav"
    this_wav = Read from file: "'dir$'/'speaker$'/'wav$'"
    this_tg = Read from file: "'dir$'/'speaker$'/'wav_basename$'.TextGrid"
    ph_n = Get number of intervals: phon_tier

    sent$ = Get label of interval: sentence_tier, 1

    # Loop through phones in TG
    for ph from 1 to ph_n
      selectObject: this_tg
      ph$ = Get label of interval: phon_tier, ph

      # Detect fricatives and exclude affricate /tʃ/ and <spn>
      if index_regex(ph$, "[fvθðszʃh]") > 0 and length(ph$) == 1
        ph_start = Get start time of interval: phon_tier, ph
        ph_end = Get end time of interval: phon_tier, ph
        ph_duration = ph_end - ph_start

        # Check that the current phone is not the first or the last interval

        if ph = 1
          prev_ph$ = "#"
          foll_ph$ = Get label of interval: phon_tier, ph + 1
        elsif ph = ph_n
          prev_ph$ = Get label of interval: phon_tier, ph - 1
          foll_ph$ = "#"
        else
          prev_ph$ = Get label of interval: phon_tier, ph - 1
          if prev_ph$ == ""
            prev_ph$ = "#"
          endif
          foll_ph$ = Get label of interval: phon_tier, ph + 1
          if foll_ph$ == ""
            foll_ph$ = "#"
          endif
        endif

        wd = Get interval at time: word_tier, ph_start
        wd$ = Get label of interval: word_tier, wd

        selectObject: this_wav
        ph_part = Extract part: ph_start, ph_end, "rectangular", 1, "no"
        ph_part_spec = To Spectrum: "no"
        ph_part_spec_smooth = Cepstral smoothing: 200
        cog = Get centre of gravity: 2
        
        # Output measurements
        results_line$ = "'wav_basename$','sent$','wd$','ph$','cog','ph_duration','prev_ph$','foll_ph$'"
        appendFileLine: results$, results_line$
      endif

    endfor

    
  endfor

endfor