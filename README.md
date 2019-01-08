[toc]

---
# HikingCompanion Mobile Application

## Purpose
Purpose of this app is to have a companion program suitable for showing tracks and additional information about those tracks. It is the intention to get those tracks from other app installations or from your own recorded tracks and added pictures and notes. So this program would become an all purpose vehicle for displaying external tracks. While its name would suggest that long walks are intended, a city walk showing the hot items of that place would equally be possible.

At first use, not much can be done with the program except recording your own routes. Another app must be installed too. This is a specially designed app holding track data and extra information such as notes and photos. Then, when such an app is installed and run, that particular app places its data in the HikingCompanion applications environment. The next time the HikingCompanion app is started, it will notice the new data and will insert the data in the hike database. When the HikingCompanion is not installed yet the program will not install the data.

A tracking app should hold any or all of the following data
* Several tracks showing the hike.
* Notes about interesting features along the route in several languages.
* Pictures showing the environment of points on the route.
* Map tiles and feature cache information?
* Places to eat and/or stay and web addresses to make reservations.
* Color palette and other makeup for this particular hike.

## History
This mobile app is a re-try of the previously developed SufiTrail app where I stumbled upon problems using the methods at hand. After some searches and some suggestions from a good friend of mine, a new setup is tried with `Qt` using the tool `qtcreator`.

## License
Something public domain and risk free (for me that is ;-)

## Installing
This app will be placed in the app store when ready.

---
# Progress of the application
Next, the developing progress is shown here. Several entries are also in the acceptance tests to see if those things are possible because the purpose of the acceptance tests are to find out what Qt and the qtcreator tool is capable of.

## Events and devices to listen to
<progress value="1" max="7"></progress>

There are several events which occur upon changing conditions in a device. These events must be captured for further actions.
* [ ] Battery condition to warn user of battery low state. App might dim display or perform other actions to save energy.
* [x] Gps information to get current location.
* [ ] Network on and off line mode to update map and feature cache as well as send user data to a server
* [ ] Device compass to show map correctly pointing the map-north to the real north.
* [ ] Resize events to change from portrait to landscape mode and back. Responsive. Needed to display everything in proper sizes.
* [ ] Camera to add a picture as a point on the map when saved.
* [ ] Time and clock.

## Caching

Caching of data is needed for those moments that there is no network available.

<progress value='0' max='4'></progress>

* [ ] At start up and network is on and a track is installed, caching must start. Caching must be inhibited when network is off or very slow.
* [ ] Store data (like date and time) to check for revisiting the caching process.
* Tile caching.
  * [ ] Make caching process visible when done for the first time. This can be a long process. Low resolution tiles are cached for places such as the current location when it is off track. Make use of the cache information provided by the installed track app.
* Feature caching.
    * [ ] Cache features using the information provided by the installed track app.
* Try to get weather forecast and cache (short term) this information too.

## The Menu
<progress value="5" max="5"></progress>

* [x] Added module for variables and styling
* [x] Pressing the menu button <button>☰</button> shown on the map or other pages, will open a pane from the side to show a menu of options. A click on an entry will show another page. When selecting an entry, the menu is closed and a page will appear.
* [x] Each page, other than the map page, must have a <button>🌍</button> button, to go to the map page.
* [x] Layout of menu.
* [x] Layout of all pages must be coherent.

## The pages of the application
A series of screen descriptions the application can show.

### Display on tablet screen
<progress value="0" max="2"></progress>

* [ ] An icon must be designed
* [ ] A widget showing small part of a chart?

### Splash screen
<progress value="0" max="4"></progress>

When starting the program, the app must show a splash screen with a nice hiking picture on it while the program gets ready in the background. When it is, the splash screen is removed.

  * [ ] Show a screen with a nice picture. Keep this displayed until everything is initialized. This provides for a better user experience.
  * [ ] Show a progress bar.
  * [ ] Show text displaying the task it is executing
  * [ ] Image must be made complete with some text

####  The pages to select from the menu

<progress value="5" max="8"></progress>

The menu entries
  * [x] **🌍 Map**: Show map.
  * [ ] **ℹ Info**: Show route information
  * [x] **🚶 Tracks**: Select a track.
  * [ ] **⌘ Feature** Show history, or other info.
  * [x] **🛠 Config**: Configuration page.
  * [x] **📡 User Track Config**: Configuration of user hike and track data.
  * [x] **👥 About**: Show a page with version, people and contacts.
  * [x] **⏻ Exit**: Close the application. Character **■** on android because of missing character. Must check OS type.

## Map page
<progress value="10" max="19"></progress>

The map page is also the home page.

  * [x] Page created
  * Map. The map is displayed over the full width and height of the device.
    * [x] Map displayed, move around with swipe.
    * [x] Map, Menu and buttons must be adjusted when device is rotated.
    * [ ] Show features for starting scale of map.
    * [ ] Map overlay for height lines and/or shades.
    * [x] Show current location.
    * [x] Focus on that current location using a <button>🎯</button> button.
    * [x] Focus on current selected track using a <button>☡</button> button.
    * [x] A (dashed) line is shown from current location to closest point on the track to show that the hiker wanders off route.
    * [x] zooming by pinching (on mobile device).
  * Zoom buttons. The buttons are placed on the left side.
    * [ ] zooming with buttons.
    * [ ] Reveal more features when zooming in.
    * [ ] Remove features when zooming out.
  * [ ] North arrow button on the top right side. Click action aligns map to the north.
  * [ ] Reset tilt button on the top right side. Click action returns map in normal 2D view.
  * [ ] Camera button to make a picture which get locked to the current location.
  * [ ] Note button to make a note for the current location.
  * [x] Open menu button ☰. Button is placed just below the north arrow. Click action shows the menu on the right side of the page.
  * [x] Open street map attribute on the bottom right of the map.

## The info page
<progress value="0" max="2"></progress>

  The info page shows information of the currently selected track. There are 40 tracks to walk in 40 days so we need 40 pages of data. The info page is loaded from a file from a separately installed track app.

  * [ ] Page created
  * [ ] Fill the info page after selecting a track. Previous data must be removed.

## The Tracks page
<progress value="10" max="12"></progress>

  Show a list of tracks from which a selection can be made. This will only be visible when one or more hike apps are installed. Track list changes when another hike is selected.

  * [x] Page created
  * Generate the page from the tracks directory contents. Each track shows;
    * [x] the gpx track name found in the configuration file.
    * [x] Show length of the route. Calculated once when the route is processed.
    * [x] Show a bicycle or a walking person icon depending on the type of route.
  * [x] Refresh tracks list when another hike is selected on the config page
  * [x] Show map when a selection is made using a <button>Select</button>  button.
  * [x] The route is displayed.
  * [x] The route is centered on page. This depends if information is available in the user track.
  * [x] The route is zoomed so as to fit the page. This depends if information is available in the user track.
  * [x] Show (dashed) line from current location to closest point on the trail when off trail (further than, lets say, 1 kilometer).
  * [ ] Remove track button. Disabled for installed hikes, enabled for user recorded hikes.
  * [ ] Show dialog before removing hike

## The Features page
The Features page is filled when a feature is clicked. First a balloon is showed on the map pointing to the feature with text and a 'more ...' on the bottom. Again, only when a separate track app is installed.

<progress value="0" max="7"></progress>

  * [ ] Page created
  * Selection of features to show;
    * [ ] Restaurant - reservation information and facility
    * [ ] Hotel etc - booking information and facility
    * [ ] Mosque - historic background
    * [ ] City, village - historic background, city elders contact info, etc.
  * [ ] Show balloon with info
  * [ ] Show extra info on info page

## The Config page

Input fields can be checked
<progress value="9" max="12"></progress>

  * [x] Page created.
  * [ ] Text message about users consent of sending data to server.
  * [x] Username used to differentiate input from different users. This input can be things such as photos, notes and hikes.
  * [x] Email address.
  * [x] A combobox of installed hikes.
  * On save data
    * [x] Data is stored in configuration file.
    * [x] Tracks are shown on tracks page.
    * [x] Theme is changed
    * [x] About page is modified
  * [x] Remove hike button
  * [ ] Show dialog before removing hike
  * [ ] Export user recorded hike button

## The User Track Config page

Input fields can be checked
<progress value="11" max="11"></progress>

  * [x] Page created.
  * Input fields
    * [x] Hike key. Needed to using in the config
    * [x] Hike title. Shown in the hike list on the config page
    * [x] Hike description.
    * [x] Track title. Shown in track list on the tracks page
    * [x] Track description.

  * Recording buttons
    * [x] <button>Start</button>. Start recording. A line is visible on the map page.
    * [x] <button>Stop</button>. Stop and save recording. The tracks list is expanded with the new track. When track gpx file already exists, nothing is saved!
    * [x] <button>Pause</button>. Postpone recording when e.g. in a restaurant for a rest and having a nice meal.
    * [x] <button>Continue</button>. Continue when satisfied and rested.

  * [x] <button>Save</button>. Save the hike information.

## The About page
This is an overview of people involved and their tasks. Also other info can be shown such as a version numbers. This data should also come from the track app.

<progress value="4" max="4"></progress>

  * [x] Page created
  * [x] Show hike dependent text.
  * [x] Show current version of the program and hike data.
  * [x] Show operating system information

## The Exit page
This should show a dialog to ask the user if he/she really wants to quit the program.

<progress value="2" max="5"></progress>

  * [x] Page created
  * [ ] Show quit dialog
  * [ ] Recorded track must be saved if still unsaved.
  * [x] Leave and stop program.
  * [ ] Keep program active in background and keep recording if started.

---
# Languages used for the application

<progress value="2" max="4"></progress>

  * [x] All text is typed in English and is the fallback language by default.
  * [ ] Implementing the QT translation mechanism.
  * Supported Languages;
    * [x] English
    * [ ] Dutch

---
# Other items or problems to think about

<progress value="8" max="10"></progress>

  * [ ] By what license should the project be protected
  * [ ] Privacy considerations
  * Installing tracks and other information from other sources.
    * [x] Create directory tree
    * [x] Add or modify hike config tables
    * [x] Install or update comparing version information
    * [x] Refresh track data
    * [x] HikingCompanion app prepares a directory for the hike data container applications to use.
    * [x] Hike data container app checks for this dir to see if HikingCompanion app is installed.
    * [x] Hike data container app copies its data to the directory
    * [x] HikingCompanion app installs the data from the directory and cleans it afterwards.

### Licenses
#### Licenses Qt software
#### Licenses Android?
#### Licenses Ios?
#### License Symbola font
Unicode Fonts for Ancient Scripts
(UFAS)
 License Agreement
UFAS: refers to the set of all fonts and documents available on this site; are licensed under the conditions stated in this License Agreement.
Developer: refers to George Douros, Kolokotroni 3, Larissa, 41223, Greece; is the sole developer and exclusive owner of all UFAS material; retains all rights to previous, current and future versions of UFAS; does not warrant the performance or results User may obtain by using UFAS software; is in no event liable to User or anyone else for any consequential, incidental or special damages, or for any claim against User by any third party seeking such damages.
User: refers to anyone who downloads UFAS from this, or any other, site; may use UFAS for strictly personal and non-commercial purposes, without charge; is allowed a single installation and no network installation; agrees not to adapt, modify, alter, translate, convert, or otherwise change UFAS; may not license, sell, rent, lease, sub license, lend, or in any way distribute UFAS for profit.
Commercial or educational use of UFAS is not permitted. This and all UFAS licenses are exclusively issued by Developer.

Font also found on Linux fedora! No license mentioned!

#### License for the hike data.
There must be a license which must describe the application in such a way that the software is free but that the data for some hikes is to be paid for.

---
# To do
* The Plain qml page must have a status line at the bottom to show errors and other messages.
* The Map page could show zoom level, hike icon of current hike, length of selected track.
* 'Remove a track' must have a dialog window
* Refine themes for all hikes and HikingCompanion. No gradients.
* Info texts must have more space on the side. It is too close to the edge.
* Change color of route depending on type, walk (dark brown) or bike (blue).


---
# Bugs

* 2018-12-23
  * Colors are not changed on all objects when another hike is selected.
  * Selected font ignored on android.
* 2018-12-15
  * User track not visible in config combobox
  * User track not saved
  * User track meta data not saved
---
# Changes
* 2018-12-22, 0.14.3, 160001403
  * Styling of app is improved.
* 2018-12-15, 0.14.3, 160001402
  * Poi is working in principle.
* 2018-12-13, 0.14.2, 160001402
  * Bug fixed; On android, launcher icons are not displayed. Thrown out the old manifest and generated a new one. Had to manually add the ' android:icon="@drawable/icon"' to the application element.
* 2018-12-10, 0.14.1, 160001401
  * OpenSSL libs are properly added for linux as well as android. It is now possible to reach map tile servers over https. Also features using nominatim are also possible now.
  * Setting android version code as explained [here](https://medium.com/@maxirosson/versioning-android-apps-d6ec171cfd82) and [here](https://developer.android.com/google/play/publishing/multiple-apks#VersionCodes) above together with version on each change entry. It is like **MV S MJ MN PV** or minimum api version, screen size or 0, major version, minor version and patch version.
* 2018-11-13, 0.14.0
  * Coordinate generator is build on the map page to test track recording on the UserTrackInfoPage.
  * Adding new hike data and track information as well as recording a new track is created on the UserTrackInfoPage.
  * Bug fixed; font problem where choosen symbols where not always visible.
* 2018-11-11, 0.13.1
  Bug fixed; Keyboard of android tablet is shown in in uppercase. Each time the keyboard is set in lowercase it switches back to uppercase after typing a letter. Also numbers are not available. By turning `inputMethodHints` to `Qt.ImhNoAutoUppercase` it can be forced lowercase without any 'smart' actions.
* 2018-11-9, 0.13.0
  * Add current location button on map page.
  * Add current track button on map page.
* 2018-11-8, 0.12.2
  * Using Thunderforest tile map server using a personal api-key.
* 2018-11-2, 0.12.1
  * Config page enhancements
* 2018-11-1, 0.12.0
  * Show a line from current location to the nearest point on the track to show that the hiker is wandering of track.
  * On the track list, each track has additional information to show that the track is for walking or biking. Also the length of the track is shown in kilometers.

* 2018-10-24, 0.11.0
  * Theming mechanism in place. Themes can be dependent on selected hike.
  * About page filled with content. Also depending on selected hike.

* 2018-10-15, 0.10.0
  * App can install hike data given by data container app on Android.

* 2018-09-24, 0.9.1
  * App can install hike data given by data container app on Linux.
  * Bug fixed: Ini files must be read using utf8 encoding

* 2018-09-17, 0.9.0
  * Installing track information in app data directory
  * Create proper application config
  * Show hike list and select a hike
  * Show track list and select track. Show track and zoom in on track
  * When track is selected, bounds are calculated and now also stored in config
  * Several cleanup phases when lists are empty

* 2018-09-03, 0.8.1
  * Displayed track is now centered and zoomed

* 2018-09-03, 0.8.0
  * A list of tracks is shown on the tracks page.
  * A track is selectable after which the track is displayed on the map. Centering and zooming on the track must still be done.

* 2018-09-01, 0.7.1
  * Config/ConfigData simplified because of use of QSettings the variables do not need to be saved/cached in the object.

* 0.7.0 Tracks page added to show tracks and make a selection.

* 2018-08-22, 0.6.2
  * Singleton class ConfigData for storage added. Access via Config class.

* 0.6.1
  * Styling is under control.
* 0.6.0
  * Current location is shown(needs improvement).
  * Focus on current location. Must be done with button later.
  * Manifest file generated using qtcreator. Icons are set. Must be changed!
* 0.5.0
  * Map page shows map.

* 2018-07-29, 0.4.0
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

---
# Contact

Developer: Marcel Timmerman
EMail: mt1957@gmail.com
