[toc]

# HikingCompanion Mobile Application

## Purpose
Purpose of this app is to have a companion program suitable for showing tracks and additional information about those tracks. It is the intention to get those tracks from other app installations or from your own recorded tracks and added pictures and notes. So this program would become an all purpose vehicle for displaying external tracks. While its name would suggest that long walks are intended, a city walk showing the hot items of that place would equally be possible.

At first use, not much can be done with the program. Another app must be installed too. This is a specially designed app holding track data and extra information such as notes and photos. Then, when such an app is installed, the app can be referred to by using some sort of name from this HikingCompanion application.

When the HikingCompanion is not installed yet, the installation process of a tracking app should also install the HikingCompanion app.

A tracking app should hold any or all of the following data
* The route of the walk.
* Notes about interesting features along the route in several languages.
* Pictures showing the environment of points on the route.
* Map tiles and feature cache information.
* Places to eat and/or stay and web addresses to make reservations.
* Color palette and other makeup for this particular route.

## History
This mobile app is a re-try of the previously developed SufiTrail app where I stumbled upon problems using the methods at hand. After some searches and some good suggestions from a good friend of mine, a new setup is tried with `Qt` using the tool `qtcreator`.

I am still working through some series of acceptance tests but it looks hopeful. Below, a series of acceptance tests needed for this app and also the development for the implementation of the app is shown.

## License
Something public domain and risk free (for me that is ;-)

## Installing
This app will be placed in the app store when ready.


## Acceptance tests for this project
Below, there are a series of tests which is also used as the progress in the learning curve I have to go through. The most important device to work for are android devices. Ios devices would be nice but is a later problem.

<progress max=45 value="28" />

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
    * [x] Scroll and wrap text
    * [x] Toolbar and normal buttons and processing
    * [ ] Radio buttons and show result
    * [ ] Check buttons and show result
    * [x] Make use of javascript for processing of events
    * [ ] Showing lists
    * [ ] Generating a list
    * [ ] Tables

  * Navigation. There are several implementations possible
    * [x] Show a menu. This is done using a `Column` component wherein `Button` components are placed.
    * [x] Multipages. Pages are created in separate files using a simple `Rectangle` component.
    * [x] Selecting pages from the menu.

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
  * [x] Show a map
  * [x] Move, rotate and zoom the map
  * [x] Tilting a map

* Accessing device sensors
  * [ ] Example test for GPS location

* Miscellaneous
  * [ ] Language switching using QLocale. See also Resources.
  * [ ] Android manifest
  * [ ] Desktop icon
  * [ ] Desktop widget


# Progress of the application
Next, the developing progress is shown here. Several entries are also in the acceptance tests to see if those things are possible because the purpose of the acceptance tests are to find out what Qt and the qtcreator tool is capable of.

## Events and devices to listen to
<progress value="0" max="7" />

There are several events which occur upon changing conditions in a device. These events must be captured for further actions.
* [ ] Battery condition to warn user of battery low state. App might dim display or perform other actions to save energy.
* [ ] Gps information to get current location.
* [ ] Network on and off line mode to update map and feature cache as well as send user data to a server
* [ ] Device compass to show map correctly pointing the map-north to the real north.
* [ ] Resize events to change from portrait to landscape mode and back. Responsive. Needed to display everything in proper sizes.
* [ ] Camera to add a picture as a point on the map when saved.
* [ ] Time and clock.

## Caching

Caching of data is needed for those moments that there is no network available.

<progress value='0' max='4' />

* [ ] At start up and network is on and a track is installed, caching must start. Caching must be inhibited when network is off or very slow.
* [ ] Store data (like date and time) to check for revisiting the caching process.
* Tile caching.
  * [ ] Make caching process visible when done for the first time. This can be a long process. Low resolution tiles are cached for places such as the current location when it is off track. Make use of the cache information provided by the installed track app.
* Feature caching.
    * [ ] Cache features using the information provided by the installed track app.
* Try to get weather forecast and cache (short term) this information too.

## The Menu
<progress value="2" max="4" />

* [x] Pressing the menu button `☰` shown on the map or other pages, will open a pane from the side to show a menu of options. A click on an entry will show another page. When selecting an entry, the menu is closed and a page will appear.
* [ ] Each page may have a button `🏠` to the map page. Pressing that will return to the map page

* [x] Layout of menu.
* [ ] Layout of all pages must be coherent and matching the pages and colors from the book.

## The pages of the application
A series of screen descriptions the application can show.

### Display on tablet screen
<progress value="0" max="2" />

* [ ] An icon must be designed
* [ ] A widget showing small part of a chart?

### Splash screen
<progress value="0" max="4" />

When starting the program, the app must show a splash screen with a nice hiking picture on it while the program gets ready in the background. When it is, the splash screen is removed.

  * [ ] Show a screen with a nice picture. Keep this displayed until everything is initialized. This provides for a better user experience.
  * [ ] Show a progress bar.
  * [ ] Show text displaying the task it is executing
  * [ ] Image must be made complete with some text

####  The pages to select from the menu

  * **🗺 Map**: Show map.
  * **ℹ Info**: Show route information
  * **🚶 Tracks**: Select a track.
  * **⌘ Feature** Show history, or other info.
  * **📡 Gps**: Record your track data.
  * **🛠 Config**: Configuration of user and program data.
  * **👥 About**: Show a page with version, people and contacts.
  * **⏻ Exit**: Close the application.

## Map page
<progress value="7" max="16" />

The map page is also the home page.

  * [x] Page created
  * Map. The map is displayed over the full width and height of the device.
    * [x] Map displayed, move around with swipe.
    * [x] Map should fill page automatically.
    * [x] Map, Menu and buttons must be adjusted when device is rotated.
    * [ ] Show features for starting scale of map.
    * [ ] Map overlay for height lines and/or shades
    * [x] Show current location
    * [ ] Focus on that location using a button.
    * [ ] A dashed line is shown from current location to closest point on the track to show that the hiker wanders off route.
    * [x] zooming by pinching (on mobile device).
  * Zoom buttons. The buttons are placed on the left side.
    * [ ] zooming with buttons.
    * [ ] Reveal more features when zooming in.
    * [ ] Remove features when zooming out.
  * North arrow button on the top right side.
    * [ ] Click action aligns map to the north.
  * Open menu button ☰. Button is placed just below the north arrow.
    * [x] Click action shows the menu on the right side of the page.
  * Open street map attribute on the bottom right of the map.
    * [x] OSM attribution is displayed.

## The info page
<progress value="0" max="2" />

  The info page shows information of the currently selected track. There are 40 tracks to walk in 40 days so we need 40 pages of data. The info page is loaded from a file from a separately installed track app.

  * [ ] Page created
  * [ ] Fill the info page after selecting a track. Previous data must be removed.

## The Tracks page
<progress value="0" max="7" />

  Show a list of tracks from which a selection can be made. This will only be visible when a separate tracks app is installed.

  * [ ] Page created
  * [ ] Generate the page from the directory contents and the gpx track name found in those files.
  * [ ] Show map when a selection is made.
  * [ ] The route is displayed.
  * [ ] The route is centered on page. This depends if information is available in the user track.
  * [ ] The route is zoomed so as to fit the page. This depends if information is available in the user track.
  * [ ] Show dashed line from current location to closest point on the trail when off trail (further than, lets say, 1 kilometer).

## The Features page
The Features page is filled when a feature is clicked. First a balloon is showed on the map pointing to the feature with text and a 'more ...' on the bottom. Again, only when a separate track app is installed.

<progress value="0" max="7" />

  * [ ] Page created
  * Selection of features to show;
    * [ ] Restaurant - reservation information and facility
    * [ ] Hotel etc - booking information and facility
    * [ ] Mosque - historic background
    * [ ] City, village - historic background, city elders contact info, etc.
  * [ ] Show balloon with info
  * [ ] Show extra info on info page

## The Gps page
This is a page where a gps track can be started.

<progress value="0" max="9" />

  * [x] Page created
* [ ] Start tracking
* Stop and save tracking
  * [ ] Convert coordinates into gpx XML text
  * [ ] Save text into file
  * [ ] Display track in a list
  * [ ] Show track on screen
  * [ ] Keep on disk after reinstall/update
* [ ] Postpone tracking
* [ ] Continue tracking

## The Config page

<progress value="1" max="5" />

  * [x] Page created
  * [ ] Text message about users consent of sending data to server. Make rest of the questions available if user wants to provide personal data
  * [ ] Username
  * [ ] Email addresses
  * [ ] Where to save data; on local or external memory. Make gray or remove setting if there is no ecternal memory.

## The About page
This is an overview of people involved and their tasks. Also other info can be shown such as a version number.

<progress value="1" max="4" />

  * [x] Page created
  * [ ] Show the members of the Sufi trail group.
  * [ ] Show current version of the program.
  * [ ] Read version number from elsewhere, e.g. android manifest, and insert it when generating the html from sxml.

## The Exit page
This should show a dialog to ask the user if he/she really wants to quit the program.

<progress value="2" max="5" />

  * [x] Page created
  * [ ] Show quit dialog
  * [ ] Recorded track must be saved if still unsaved.
  * [x] Leave and stop program.
  * [ ] Keep program active in background and keep recording if started.

# Other items or problems to think about

<progress value="0" max="2" />

  * [ ] By what license should the project be protected
  * [ ] Privacy considerations

# To do

# Bugs

## Changes

* 0.6.0
  * Current location is shown(needs improvement).
  * Focus on current location. Must be done with button later.
* 0.5.0
  * Map page shows map.
* 0.4.0
  * Factoring out several items from main.qml
  * The exitPage shows some text which is scrollable and wraps on word boundaries.
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
