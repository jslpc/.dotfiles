# Beets

![beets.io](https://user-images.githubusercontent.com/38687140/40558805-bcdb279a-607e-11e8-96f9-71b743e5cff6.png)

(_I am aware that this is an unofficial logo, but it looks fantastic. [Credit](https://github.com/beetbox/beets/pull/2935)_)

[beets.io](http://beets.io) - Beets is a simple music metadata inspection and modification tool for tons of audio file types.

* * *

My config is pretty straightforward. Right now, I import from a given directory to my external SSD where I store all of my FLAC, and write tags while doing so.

## Structure

My directory structure is setup like so:

```zsh
#/Volumes/Samsung T5/Music/Music Library/
├── !Compilations
│   └── The Hamilton Mixtape (2016) [FLAC 16]
├── #
│   ├── 2Pac
│   │   └── All Eyez on Me (1996) [FLAC 16]
│   ├── 50 Cent
│   │   └── Get Rich or Die Tryin (2003) [FLAC 16]
├── A
├── B
├── C
...
├── K
│   ├── Kllo
│   │   ├── Backwater (2017) [FLAC 16]
│   │   │   ├── 01 - Downfall.flac
│   │   │   ├── 02 - Still Motion.flac
│   │   │   ├── 03 - Virtue.flac
│   │   │   ├── 04 - Predicament.flac
│   │   │   ├── 05 - Last Yearn.flac
│   │   │   ├── 06 - Backwater.flac
│   │   │   ├── 07 - Dissolve.flac
│   │   │   ├── 08 - By Your Side.flac
│   │   │   ├── 09 - Making Distractions.flac
│   │   │   ├── 10 - Too Fast.flac
│   │   │   ├── 11 - Nylon.flac
│   │   │   ├── 12 - Not Like Them.flac
│   │   │   ├── Backwater.cue
│   │   │   ├── Backwater.log
│   │   │   └── cover.jpg
│   │   ├── Bushfire Fundraiser (2020) [FLAC 24]
│   │   ├── Candid (2018) [FLAC 24]
│   │   ├── Cusp (2014) [FLAC 16]
│   │   ├── Maybe We Could (2020) [FLAC 16]
│   │   └── Well Worn (2016) [FLAC 16]
├── J
...
└── Z
```

### Notes

-   Artists are sorted into folders labeled by the artists' first letter, not including any leading `The`, then given a single folder.
-   Albums are sorted alphabetically rather than by year, contrary to what many music collectors sort by. I prefer this method of organization, though this can easily be changed in `config.yaml`.
    -   Each album folder is named according to the structure `albumartist` (`original_year`) [`$format $bitdepth`]. If no tag for `original_year` is present, it falls back to `year`, as demonstrated in the config. All of my music is in FLAC at the time of writing, but in case that ever changes I have included the audio format. I include the bitdepth (either 16 or 24) to distinguish albums accordingly.
-   Album folders contain their respective tracks, but I also import any additional files such as ripping logs, cue's, m3u/m3u8 playlists, and extra folders containing any scans of artwork or foldouts.
-   `Various Artists` compilation albums are put in their own folder instead of within `V`, and are then sort by album title. This folder begins with a `!` to nest it outside of the alphabetically sorted folders to prevent it from being listed between `C` and `D`.
-   There is no separate `Singles` folder even though beets allows this in the configuration. I opt to place single releases, demos, and loose tracks in their own folders within the artist's directory for ease of access and consistency.
-   I expanded _Kllo_ because they recently dropped a beautiful album titled _Maybe We Could_, and they're my favorite musicians, so why not use them as an example?

## Plugins

-   `rewrite`: Configured to rewrite the directory names of artists that I specify in my config. I add as needed. Note that this plugin does not write metadata tags to files, it only changes folder names.
-   `fetchart`: Grabs art from different sources on the internet. I have it set to be cautious when matching to prevent errors while enforcing a 1:1 image ratio. Current config looks for images present within the directory before searching online, and prefers using images sourced from iTunes over other options.
-   `ftintitle`: Strips featured artists from the artist field and places them in the track title with the format `(feat. Artist)`.
-   `extrafiles`: Actively maintained alternative to the `copyartifacts` plugin. Not listed in the beets documentation, but can be found [here](https://github.com/Holzhaus/beets-extrafiles). As you might have guessed, it moves any specified extra files to the import location. I've configured it to move all extra files and folders to prevent a file not explicitely stated from being left behind and requiring manual transfer to the new post-import album directory.
-   `zero`: Completely clears any metadata tag fields that are specified. I've set mine to just `comments` and `bpm` as Bandcamp embeds comments containing links to the artists' page and the beats per minute is usually either blank or wildly inaccurate, and I don't use either field within my music player ([Swinsian for macOS](https://swinsian.com)).
-   `the`: Appends any leading "The" from an artist's name to the end of the folder title. Useful for sorting alphabetically to prevent the `T` folder from containing loads of irregularities. I've set mine to ignore "A" and "An" because it personally does not make sense to me to have _A Tribe Called Quest_ sorted in the `T` folder.
-   `embedart`: Self-explanitory. Embeds album art into files. Pairs well with `fetchart`.
-   `importadded`: For preserving the _last modification_ times which can be useful for personal recordkeeping.
-   `lyrics`: I've tried plenty of music organization programs and software, and this is the reason why I decided to try fixing my beets installation after leaving when it suddenly broke on me one day due to user error (read: installing python improperly multiple times). I use it to source from Genius first, and if no match is found it falls back on MusixMatch and then LyricWiki. The Genius community is incredibly quick to upload lyrics, especially in regards to the genre I listen to most, hiphop, so when I import a newly released album it hardly ever fails to retrieve accurate lyrics.
-   `scrub`: Currently disabled in my config, but it scrubs any non-empty tag fields in which beets does not write to, such as rogue custom tags that were filled with any other tagging software previously.
-   `lastgenre`: Used for fetching the top genres for imported albums from Last.fm. Took me awhile to properly configure this to suit my needs, but it works well right now. I've used the original dev's python script to fetch a full list of all genres from Wikipedia (the default one is a bit outdated at the time of writing), modified the genres-tree to more accurately nest hiphop subgenres, and accounted for a few missing genres from the new genres list.
    -   My configuration tags a maximum of 3 genres that pass the minimum weight I've set of 68. This number is pretty arbitrary; 65 worked well enough, and 70 was ever so slightly too strict, so I just went with 68 and it surprisingly gave me good results.
    -   Genres are subjective, and Last.fm allows users to make their own for any given piece of music, leading to some wildly innacurate tags or tags I simply don't agree with. I tend to change those tags manually within Swinsian, but could fix this minor issue by modifying `genres.txt` to whitelist less genres; though that can always lead to some albums not getting genre tags entirely due to not reaching the weight threshold.
    -   _This is in no way complete and needs a lot of work done to it. I only really focused on hiphop and made some minor edits to a few other top-level genres, but this is probably going to change often as I work on it more. If anyone knows of a better way to automate this instead of organize by hand, please let me know._

## Other Settings

-   `original_date`: Set to yes, which ensures the `year` field is set to the album's original release date. This is a bit redundant, but if I ever want to turn it off my path settings will remain intact.
-   `bell`: System notification alert for when beets requires user input, which is incredibly helpful for my weak attention span and when forgetting that I even started an import a few moments prior before switching windows and shifting my focus elsewhere.
