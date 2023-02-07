# Flutter Jobsity Test

 An App builded with TV Maze API

# To Run the App

 Clone the repository, run flutter pub get, and run on a device of your preference.

# Tested debugging on

- [x] Nexus 5 API 32 (ARM64 Emulator)
- [x] Iphone 14 Pro Max IOS 16.2 (Emulator)

# Dependecies used

 dio: ^4.0.6 - For Http Client
 dartz: ^0.10.1 - For Either result
 flutter_riverpod: ^2.1.3 - For state management and dependency injection
 google_nav_bar: ^5.0.6 - For Simple Custom Bottom Nav Bar
 google_fonts: ^4.0.3 - For Fonts Source
 cached_network_image: ^3.2.3 - For Caching Images
 lazy_load_scrollview: ^1.3.0 - For Paging the Lists
 hive: ^2.2.1 - For local storage
 hive_flutter: ^1.1.0 - For local storage

# Architecture

 I based on the Clean Architecture from Uncle Bob, but since its a small app, I did cutoff some layers like UseCase and Domain layers, to develop with speed but still have the layers uncoupled and clean.
# Features

 - List All Shows
 - Search for a show by name
 - See Show Details
 - See Show Seasons
 - See Episodes separated by Season
 - Favorite a Show
 - Unfavorite a Show
 - List of Favorite Shows with Sorting to A to Z and Z to A

# Screenshots

