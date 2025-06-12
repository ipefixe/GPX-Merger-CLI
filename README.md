# GPX-Merger-CLI

My need was to merge commuting's activities (velotaf in french), to have a cleaner Strava account and to spam the feed less.

Note: Specifically for Strava, it doesn't correctly take into account activities that are discontinuous in time and space. In time, it's not particularly problematic, the information is still detectable in the activity. But for the discontinuous in space, it will connect (in a straight line) the different segments and it counts this additional connection.

So it's worth merging activities that have identical (or very close) start and finish points, otherwise it becomes misleading and false.

## 💻 Usage

`gpx-merger <paths> ... [--output <output>]`

ARGUMENTS:

- `<paths>` Paths to GPX files to merge

OPTIONS:

- `-o, --output <output>` Path to output GPX file
- `-h, --help` Show help information.

## 📝 Additional information

You can merge as many files as you like.

There is no need to check that you are adding them in chronological order. They will be reordered by the script.

## 👀 Example

```
swift run GPXMergerCLI ~/Desktop/marche-3.gpx ~/Desktop/marche-2.gpx ~/Desktop/marche-4.gpx ~/Desktop/marche-1.gpx -o ~/Desktop/ma_marche.gpx

   ____   ____   __  __    __  __
  / ___| |  _ \  \ \/ /   |  \/  |   ___   _ __    __ _    ___   _ __
 | |  _  | |_) |  \  /    | |\/| |  / _ \ | '__|  / _` |  / _ \ | '__|
 | |_| | |  __/   /  \    | |  | | |  __/ | |    | (_| | |  __/ | |
  \____| |_|     /_/\_\   |_|  |_|  \___| |_|     \__, |  \___| |_|
                                                  |___/
Read data from GPX files...
Parse GPX data...
Parse GPX data...
Parse GPX data...
Parse GPX data...
Merge GPX documents...
Write merged GPX to file /Users/ipefixe/Desktop/ma_marche.gpx...
✅ FINISHED
```

## ✅ TODO

🔲 Implement the entire GPX (not only what's needed for Strava)

## ⚖️ License

Copyright 2025, Kevin Boulala

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
