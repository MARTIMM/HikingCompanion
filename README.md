# HikingCompanion

## Purpose
Purpose of this app is to have a companion program suitable for showing tracks and additional information about those tracks. It is the intention to get those tracks from other app installations or from your own recorded tracks and added pictures and notes. So this program would become an all purpose vehicle for displaying external tracks. While its name would suggest that long walks are intended, a city walk showing the hot items of that place would equally be possible.

This mobile app is a re-try of the previously developed SufiTrail app where I stumbled upon problems using the methods at hand. After some searches and some good suggestions from a good friend of mine, a new setup is tried with `Qt` using the tool `qtcreator`.

I am still working through some series of acceptance tests but it looks hopeful. Below, a series of acceptance tests needed for this app and also the development for the implementation of the app is shown.

## License
Something public domain and risk free (for me that is ;-)

## Installing
This app will be placed in the app store when ready.


## Acceptance tests for this project
Below, there are a series of tests which is also used as the progress in the learning curve I have to go through. The most important device to work for are android devices. Ios devices would be nice but is a later problem.

<progress max=47 value="20" />

* [x] Android SDK, NDK and OpenJDK installation using Android Studio and linux installation tools.
* [ ] Xcode for ios
* [x] Configuration of qtcreator.
* [x] Setup devices for android
* [x] Setup devices for ios
* Run a few examples
  * [x] Build and run an example for the desktop
  * [x] Build, upload and run an example for an android device
  * [ ] Build, upload and run an example for an ios device

* QML Gui
  * [x] Create some GUI with fields and change things
  * [x] Build, upload and run this GUI on android device
  * [ ] Build, upload and run this GUI on ios device

  * Input processing
    * [x] Text input and show input
    * [x] Html or Rich text
    * [x] Buttons and action
    * [ ] Radio buttons and show result
    * [ ] Check buttons and show result
    * [ ] Make use of javascript for processing
    * [ ] Showing lists
    * [ ] Generating a list
    * [ ] Tables

  * Navigation. There are several implementations possible
    * [x] Show a menu. This is done using a `Column` class wherein `ToolButton`s are placed.
    * [x] Multipages. Pages are created in separate files using the `Page` class.
    * [x] Select pages.

* Integration of QML and C++. See for info [here][qtc-c++].
  * [x] Create a class with some variables and methods using <QObject> and other external modules
  * [x] Use the class in a QML description
  * [x] Debugging using qDebug() and using <QDebug>


* [x] Go into an existing directory using QDir
* [x] Open, read, write and create a file using QFile
* [ ] Create, test and delete a directory using QDir
* [ ] Build a directory tree using QDir

* XML processing to read and write qpx data and configuration files.
  * [x] Read and process an XML file. See also [this doc][qtc-xml].
  * [ ] Create an XML DOM tree
  * [ ] Save XML from DOM tree

* Map processing
  * [ ] Show a map
  * [ ] Move and zoom the map
  * Add information to map
    * [ ] Add a track using lines
    * [ ] Add features using icons
    * [ ] Make features clickable

* Device sensors
  * [ ] Location
  * [ ] Compass
  * [ ] Orientation
  * [ ] Battery
  * [ ] network device, online/offline

* Miscellaneous
  * [ ] Language switching using QLocale. See also Resources.
  * [ ] Android manifest
  * [ ] Desktop icon
  * [ ] Desktop widget


# Progress of application
Next, the progress is shown here. Several entries are also in the acceptance tests to see if those things are possible. The acceptance tests are also directly connected to what the app must be capable of.

## Events and devices to listen to
<progress value="3" max="7" />

There are several events which occur upon changing conditions in a device. These events must be captured for further actions.
* [ ] Battery condition to warn user of battery low state. App might dim display or other options to save energy.
* [x] Gps information to get current location.
* [x] Network on and off line mode to update map and feature cache as well as send user data to a server
* [ ] Device compass to show map correctly pointing the map-north to the real north.
* [x] Resize events to change from portrait to landscape mode and back. Responsive. Needed to display everything in proper sizes.
* [ ] Camera to add a picture as a point on the map when saved.
* [ ] Time and clock.

## Caching

Caching of data is needed for those moments that there is no network available.

<progress value='4' max='6' />

* [x] At start up and network is on, caching must start. Caching must be inhibited when network is off or very slow.
* [ ] Store data to check for revisiting the caching process.
* Tile caching.
  * [ ] Make caching process visible.
  * [x] Make a list of tile coordinates needed to cache at several zoom levels. Make estimation of total size.
  * [x] The program `mkCacheTileArray.pl6` generates a module in the file `SufiCacheData.js` wherein the information is stored.
  * [x] Another module in `SufiCache.js` inherits the data and uses it to create the directory tree for the tile images and downloads the tile images into these.
* Feature caching.
* Try to get weather forecast and cache this information too.

# What the application must do
* When starting the program, the app must show a splash screen with the sufitrail emblem on it while the program gets ready in the background. Let the splash screen be shown for at least 5 seconds or longer as needed.
* When the program is initialized it must show the map of the current location using the gps information of the device. One of the buttons shown on the screen can open a menu and direct the user to other pages of the program.

# The pages of the application
A series of screen descriptions the application can show.

## Display on tablet screen
<progress value="1" max="2" />

* [x] An icon of the sufitrail guy with green field in the back must be shown. Like **==>>** <img src="../Data/Images/AppLogo/logo-met-groen-klein-1.png" width="60px" height="60px"/>
* [ ] A widget showing small part of a chart?

## Splash screen
<progress value="1" max="4" />

A splash screen is always nice to display information in such a way that it makes a connection between the hiking and biking literature published by the Sufi trail group. The other purpose is that the application can start in the background and when it is ready, the splash screen is removed.

  * [x] Show a screen with a Sufi trail icon. Keep this displayed until everything is initialized. This provides for a better user experience.
  * [ ] Show a progress bar.
  * [ ] Show text displaying the task it is executing
  * [ ] Image must be made complete with some text

### The Menu
<progress value="0" max="2" />

Pressing the menu button ☰ shown on the map, will open a pane from the side to show a menu of options. A click on an entry will show a page. Each page may have a shortcut to the home page: **Map** next to a menu button. When selecting an entry, the menu is closed and a page will appear.

  * [ ] Layout of menu.
  * [ ] Layout of all pages must be coherent and matching the pages and colors from the book.

####  The pages to select from the menu

  * **Map**: Show map.
  * **Info**: Show route information
  * **Tracks**: Select a track.
  * **Feature** Show history, or other info.
  * **Start**: Record your track data.
  * **Config**: Configuration of user and program data.
  * **About**: Show a page with version, people and contacts.
  * **Exit**: Close the application.

## Start page
<progress value="10" max="14" />

The map page is the home page named **Map** below in the list of menu entries. On this page the following is shown;

  * Map. The map is displayed over the full width and height of the device.
    * [x] Map displayed, move around with swipe.
    * [x] Map should fill page automatically.
    * [x] Map, Menu and buttons must be adjusted when device is rotated.
    * [ ] Show features for starting scale of map.
    * [ ] Map layer for hightlines and/or shades
    * [x] Show current location.
    * [x] A dashed line is shown from urrent location to closest point on the track to show that the hiker wanders off route.
  * Zoom buttons. The buttons are placed on the left side.
    * [x] zooming with buttons.
    * [x] zooming by pinching (on mobile device).
    * [ ] Reveal more features when zooming in.
    * [ ] Remove features when zooming out.
  * North arrow button on the top right side.
    * [x] Click action aligns map to the north.
  * Open menu button ☰. Button is placed just below the north arrow.
    * [x] Click action shows the menu on the right side of the page.
  * Open street map attribute on the bottom right of the map.
    * [x] OSM attribution is displayed.

## The info page
<progress value="1" max="1" />

  The info page shows information of the currently selected track. There are 40 tracks to walk in 40 days so we need 40 pages of data. The info page is loaded from a file from the `www/info` directory when a track is selected.

  * [x] Fill the info page after selecting a track. Previous data must be removed.

#### The information pages for each track
<progress value="1" max="40" />

  The following pages must have some info
  * [x] 01 Istanbul City
  * [ ] 02 Yalova Gökçedere
  * [ ] 03 Gökçedere Güneyköy
  * [ ] 04 Güneyköy Orhangazi
  * [ ] 05 Orhangazi Çakırlı
  * [ ] 06 Çakırlı Mahmudiye
  * [ ] 07 Mahmudiyei İznik
  * [ ] 08 Iznik Bereket
  * [ ] 09 Bereket Osmaneli
  * [ ] 10 Osmaneli Vezirhan
  * [ ] 11 Vezirhan Bilecik
  * [ ] 12 Bilecik Küre
  * [ ] 13 Küre Sögüt
  * [ ] 14 Sögüt Yeşilyurt
  * [ ] 15 Yeşilyurt Alınca
  * [ ] 16 Alınca Eskişehir
  * [ ] 17 Eskişehir Süpüren
  * [ ] 18 Süpüren Sarayören
  * [ ] 19 Sarayören Seyitgazi
  * [ ] 20 Seyitgazi Sükranlı
  * [ ] 21 Sükranlı Ağlarca
  * [ ] 22 Ağlarca Muratkoru
  * [ ] 23 Muratkoru Gömü
  * [ ] 24 Gömü Emirdağ
  * [ ] 25 Emirdag Karacalar
  * [ ] 26 Karacalar Emirdede Tepesi
  * [ ] 27 Emirdede Tepesi Kemerkaya
  * [ ] 28 Kemerkaya Taşağıl
  * [ ] 29 Taşağıl Çay
  * [ ] 30 Çay Yakasenek
  * [ ] 31 Yakasenek Ulupinar
  * [ ] 32 Ulupinar Akşehir
  * [ ] 33 Akşehir Çakırlar
  * [ ] 34 Çakırlar Doganhisarn
  * [ ] 35 Doganhisar Aşağı Çığıl
  * [ ] 36 Aşağı Çığıl Derbent
  * [ ] 37 Derbent Salahattin
  * [ ] 38 Basarakavak Küçükmuhsine
  * [ ] 39 Küçükmuhsine Sille
  * [ ] 40 Sille Konya


## The Tracks page
<progress value="6" max="6" />

  * [x] Generate the page from the directory contents and the gpx track name found in those files.
  * [x] Show map when a selection is made.
  * [x] The route is displayed.
  * [x] The route is centered on page. This depends if information is available in the user track.
  * [x] The route is zoomed so as to fit the page. This depends if information is available in the user track.
  * [x] Show dashed line from current location to closest point on the trail when off trail (further than, lets say, 1 kilometer).

## The Features page
The Features page is filled when a feature is clicked. First a balloon is showed on the map pointing to the feature with text and a 'more ...' on the bottom.

<progress value="0" max="6" />

  * Selection of features to show;
    * [ ] Restaurant - reservation information and facility
    * [ ] Hotel etc - booking information and facility
    * [ ] Mosque - historic background
    * [ ] City, village - historic background, city elders contact info, etc.
  * [ ] Show balloon with info
  * [ ] Show extra info on info page

## The Config page

<progress value="0" max="4" />

  * [ ] Text message about users consent of sending data to server. Make rest of the questions available if user wants to provide personal data
  * [ ] Username
  * [ ] Email addresses
  * [ ] Where to save data; on local or external memory. Make gray or remove setting if there is no ecternal memory.

## The Start page
This is a page where a gps track can be started.

<progress value="5" max="8" />

* [x] Start tracking
* Stop and save tracking
  * [x] Convert coordinates into gpx XML text
  * [x] Save text into file
  * [ ] Display track in a list
  * [ ] Show track on screen
  * [ ] Keep on disk after reinstall/update
* [x] Postpone tracking
* [x] Continue tracking

## The About page
This is an overview of people involved and their tasks. Also other info can be shown such as a version number.

<progress value="2" max="3" />

  * [x] Show the members of the Sufi trail group.
  * [x] Show current version of the program.
  * [ ] Read version number from elsewhere, e.g. android manifest, and insert it when generating the html from sxml.

## The Exit page
This should show a dialog to ask the user if he/she really wants to quit the program.

<progress value="1" max="4" />

  * [ ] Show quit dialog
  * [ ] Recorded track must be saved if still unsaved.
  * [x] Exit program.
  * [ ] Keep program active in background.

# Other items or problems to think about

<progress value="0" max="8" />

  * [ ] Color mapping must match that of the maps printed on paper.
  * [ ] Add ability to choose other color maps for visual impaired or color blind people.
  * [ ] By what license should the project be protected
  * [ ] Privacy considerations

# Track data
The app uses gpx data from a file to read track information. It is shown and zoomed in on it when first loaded. These gpx files must be edited (by a separate program) to add some data in the `metadata` section of the gpx file.

<progress value="17" max="18" />

* [x] Program to make the calculations and store in gpx file: `gpx-edit.pl6`. It makes use of module Tracks.pm6.
* [x] Program `convert-all-tracks.pl6` to find all gpx files from `./Data/Tracks original` and call `gpx-edit.pl6` for each file found. The results are saved in `./www/tracks`.
* [x] The program `gpx-edit.pl6` calculates minimum and maximum of longitude and latitude and stores it in the xpath `/gpx/metadata/bounds`.
* The program also stores other data in the xpath `/gpx/metadata` of the gpx file.
  * [x] `name`; filename without '.gpx' and punctuation replaced by spaces.
  * [x] `desc`; **hiking routes from Istanbul to Konya**.
  * [x] `author`; **Sufi trail**.
  * [x] `copyright`; **Sufi trail**.
  * [x] `link` reference; **http://www.sufitrail.com/**. Its link text is **Sufi Trail Hike**.
  * [x] `time`; date and time of conversion.
  * [x] `keywords`; **hike**, **Konya**, **Istanbul** and some others taken from the filename.
  * [x] `bounds`; (mentioned above). It is set if it is not available. When found, it is not overwritten. This is how Garmin uses it!
  * `extensions` field is not used.

* [x] Remove all spaces between elements thereby making the gpx file smaller.
* Other wishes.
  * [x] Convert tracks one by one.
  * [ ] Compress the track to a smaller format to make the payload smaller.
  * [x] Sufi track is in one gpx file. Need to split them up to have a smaller footprint, especially when more features are put into the gpx as waypoints.
  * [x] Extract the waypoints from the sufi track gpx file into separate file.
  * [x] Extract separate tracks from the total sufi trail
  * [x] Adjust program to check for the Garmin way of storing boundaries and if not there use the same format.

# Todo
* Move buttons on other pages to the left side, same as where it is on map.
* A button on map to go to the current location when far from track.
* Use the same button to go back to the track when hiker is far from current location.

# Qt and qtcreator
* Big changes because JavaScript cannot do things the easy way. Time to look around for better development environments. For the moment I'm looking into Qt with the `qtcreator` program. It can handle several types of OS on desktop and mobile devices like linux, IOS, Android and Windows. Also the languages to work in are `C++`, `QML` and `JavaScript`. The rest is generated by the program.

## Acceptance tests for this project
Below there are a series of tests which is also used as the progress in the learning curve I have to go through. The most important device to work for are android devices. Ios devices would be nice but is a later problem.

<progress max=43 value="18" />

* [x] Android SDK, NDK and OpenJDK mapping
* [x] Devices
* Run a few examples
  * [x] Build and run an example for the desktop
  * [x] Build, upload and run an example for an android device
  * [ ] Build, upload and run an example for an ios device

* QML Gui
  * [x] Create some GUI with fields and change things
  * [x] Build, run and upload this GUI to android device
  * [ ] Build, upload and run this GUI ios device

  * Input processing
    * [x] text input and show input
    * [x] buttons and show reaction
    * [ ] radio buttons and show result
    * [ ] check buttons and show result
    * [ ] Make use of javascript for processing

  * Gui
    * [ ] Showing lists
    * [ ] Generating a list
    * [ ] Tables
    * [ ] Html or Rich text

  * Navigation. There are several implementations possible
    * [x] Show a menu. This is done using a `Column` class wherein `ToolButton`s are placed.
    * [x] Multipages. Pages are created in separate files using the `Page` class.
    * [x] Move between pages.

* Integration of QML and C++. See for info [here][qtc-c++].
  * [x] Create a class with some variables and methods using <QObject> and other external modules
  * [x] Use the class in QML description
  * [x] Debugging using qDebug() and included file <QDebug>


* [ ] Create, test and delete a directory using QDir
* [ ] Build a directory tree
* [x] Go into an existing directory
* [x] Open, read, write and create a file using QFile

* XML processing to read and write qpx data and configuration files.
  * [x] Read and process an XML file. See also [this doc][qtc-xml].
  * [ ] Create an XML DOM tree
  * [ ] Save XML from DOM tree

* Map processing
  * [ ] Show a map
  * [ ] Move and zoom the map
  * Add information to map
    * [ ] Add a track using lines
    * [ ] Add features using icons
    * [ ] Make features clickable

  * Caching
    * [ ] Download tiles
    * [ ] Use tiles for map when offline

* Device sensors
  * [ ] Location
  * [ ] Compass
  * [ ] Orientation
  * [ ] Battery
  * [ ] network device, online/offline

* Miscellaneous
  * [ ] Language switching using QLocale. See also Resources.
  * [ ] Android manifest
  * [ ] Desktop icon
  * [ ] Desktop widget

# Bugs



## Changes

* 0.3.0
  * Make a page framework
  * Loading text from file into a page
* 0.2.0
  * Menu with some entries
  * Fade in and out of menu
  * Made a few pages with a menu open button
  * Selecting an entry will show page and close menu
* 0.1.0
  * Building framework
* 0.0.1
  * Start project

# Contact

Developer: Marcel Timmerman
EMail: mt1957@gmail.com
