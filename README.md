# Flutter Jobsity Test

 An App builded with TV Maze API

# To Run the App

 Clone the repository, run flutter pub get, and run on a device of your preference.

# Tested debugging on

- [x] Nexus 5 API 32 (ARM64 Emulator)
- [x] Iphone 14 Pro Max IOS 16.2 (Emulator)

# Dependecies used

 **dio**: ^4.0.6 - For Http Client  
 **dartz**: ^0.10.1 - For Either result  
 **flutter_riverpod**: ^2.1.3 - For state management and dependency injection  
 **google_nav_bar**: ^5.0.6 - For Simple Custom Bottom Nav Bar  
 **google_fonts**: ^4.0.3 - For Fonts Source  
 **cached_network_image**: ^3.2.3 - For Caching Images  
 **lazy_load_scrollview**: ^1.3.0 - For Paging the Lists  
 **hive**: ^2.2.1 - For local storage  
 **hive_flutter**: ^1.1.0 - For local storage  

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

## Homepage
<img width="435" alt="Captura de Tela 2023-02-07 às 6 08 12 PM" src="https://user-images.githubusercontent.com/53882248/217365887-005d886d-2564-49cd-af10-521865ef27e4.png">

## Searching

<img width="439" alt="Captura de Tela 2023-02-07 às 6 09 19 PM" src="https://user-images.githubusercontent.com/53882248/217366076-49a32d1e-4b47-4898-ab94-691c58276459.png">

## Show Details Favorited

<img width="438" alt="Captura de Tela 2023-02-07 às 6 09 53 PM" src="https://user-images.githubusercontent.com/53882248/217366174-ac9af012-06ee-42cb-b312-8296ba63c5d1.png">

# List of Favorites

<img width="434" alt="Captura de Tela 2023-02-07 às 6 10 30 PM" src="https://user-images.githubusercontent.com/53882248/217366291-49cdc124-ba85-4d35-b697-66cc7f3112e1.png">







