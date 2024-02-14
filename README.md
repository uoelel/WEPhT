# Processing overview

## Swahili

The Swahili recordings are in `data/swahili/swah1253_long`. Folders within that are individual speakers and each speaker has a single recording containing several utterances.

### Chunk long recordings

The first step is to extract individual sound files for each utterance in each speaker's long recording.

We can achieve this by first detecting voice activity in the recording and then extracting the detected parts as individual sound files using Praat.

✅ -- **Run the `code/01_vad.praat` script in Praat.**

This script outputs one TextGrid per long recording with intervals corresponding to detected voice activity. The TextGrids are saved in `data/swahili/swah1253_long`, in each speaker's folder, named after the recording file name.

Now we can fix the detected intervals (sometimes, noises are mistakenly interpreted as voice).

✅ -- **Fix each TextGrid and save them to a new file (don't overwrite the original TextGrids!). Name the fixed TextGrid with the same name as the original plus `-fixed`.**

Now that we have fixed the voice activity TextGrids, we can run the script `code/02_chunk.praat` to extract individual utterances.

✅ -- **Run `code/02_chunk.praat` in Praat.**

This script outputs sound files for each utterance (it extracts parts of the sound file corresponding to the intervals with label "sounding"). These files are saved in `data/swahili/swah1253`, in each speaker's folder. These sound files are named after the original long sound file plus `-ID` where "ID" is the interval number from the TextGrid.


### Get a transcript for each utterance sound file

We need now a trascript for each uttarance. We can use the [BAS web services](https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface). Specifically the [Automatic Speech Recognition](https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface/ASR) (ASR) service: <https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface/ASR>.

You will have to sign in with your university account to access this service.

Once logged in, drop the `.wav` files in the files drop area and click "Upload". The set the following:

- Language to `Swahili (Kenya)'.
- ASR service to `Google Speech Cloud ASR`.

Then accept the terms and click on "Run web service" to run the service.

✅ -- **Run the ASR BAS web service.**

Download the resulting files (they will be zipped) and then move the trascripts in each speaker's folder in `data/swahili/swah1253`. (With a lot of speakers and files, which should be the standard, you might want to script copying these files so you don't have to do it manually),

Ideally, you would also check and fix the trascripts if needed (we are not gonna do that now).

### Force-align trascripts to sound files.

We can finally force-align the trascripts to the sound files using the [Montreal Force Aligner](https://montreal-forced-aligner.readthedocs.io/en/latest/index.html).

Activate the conda environment.

```bash
conda activate mfa
```

✅ -- **Align the transcripts and segment words with MFA.**

```bash
mfa align --include_original_text --fine_tune data/swahili/swah1253 swahili_mfa swahili_mfa data/swahili/swah1253
```

The `--include_original_text` flag ensures the original utterance text is added in full in the aligned TextGrid.
The `--fine_tune` flag ensures alignment precision to be up to 1 ms (rather than the default 10 ms; this is useful for most research aims).

Now the `data/swahili/swah1253` has TextGrids with the word-by-word and segment-by-segment alignments!

### Extract vowel formants and f0 with FastTrack

Open any wav file in Praat. Select `Tools...` under `Fast Track` and then select `Extract vowels with TextGrids`. A new window will open.

✅ -- **Extract the vowels for each speaker separately using the `Extract vowels with TextGrids` tool.**

As the output folder, use `data/swahili/swah1253_vowels`. The script will extract vowel sounds into a `sounds` folder in each speaker's folder in `swah1253_vowels`.

Now we can track the formants. This has to be done speaker by speaker, using the `Track folder (lite)...` option.

✅ -- **Get formants for each speaker with `Track folder (lite)...`.**

The results are in `processed_data/aggregated_data.csv`, within each speaker's folder.

### Extract other phonetic measurements

We now move onto getting the Centre of Gravity (CoG) of fricatives.

✅ -- **Run `code/03_get_measures.praat`.**

A file `data/swahili/fricatives.csv` will be created.

## Mawayana

...