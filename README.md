# BYOD-Watchface
---------

## What is it?
A watchface for Garmin Connect IQ: [BYOD Watchface](https://apps.garmin.com/en-US/apps/c3b56d09-2a43-4d3e-b732-dc7e5f149df9 "BYOD Watchface on Connect IQ store")

This is a fully customisable digital (and partially analog) watchface that tries to cover the needs of all different digital watchfaces. The screen is divided into 6 different watchfields, and each of those fields is freely assignable, with 13(+1) different possibilities:

* Digital Hour
* Digital Minute
* Large Digital Hour (spanning 4 fields instead of 1)
* Large Digital Minute (also spanning 4 fields)
* Analog Clock
* Large Analog Clock (spanning 4 fields)
* Large Analog Clock with additional info (Steps, goal, battery%, spanning 4 fields)
* Steps-Move Graph
* Date
* Device Info
* Date-Device info
* Battery Gauge
* Sunrise-Sunset Times
* Empty

This makes for **11.390.625** different configurations (though a lot of these configurations are pretty useless, take a watch with 6 empty fields for example).
Some examples of different configurations:

![](https://services.garmin.com/appsLibraryBusinessServices_v0/rest/apps/7ca664c7-92a1-47a8-8f04-bbde5746d863/screenshots/7e769ec7-7406-43ed-acd4-22a6ce244bfd) ![](https://services.garmin.com/appsLibraryBusinessServices_v0/rest/apps/7ca664c7-92a1-47a8-8f04-bbde5746d863/screenshots/546a2d33-1217-43e0-9926-2d82b7798166) ![](https://services.garmin.com/appsLibraryBusinessServices_v0/rest/apps/7ca664c7-92a1-47a8-8f04-bbde5746d863/screenshots/dc17616f-11d4-41bc-ab62-9213c5afea26)


## What is Connect IQ?

[Connect IQ](https://apps.garmin.com/nl-NL/ "Garmin Connect IQ App Store") is a platform developed by [Garmin](http://www.garmin.com/en-US "Garmin") to work on its range of wearable devices.
There's a possibility to create apps, widgets, datafields and watchfaces for it, of which this is the latter.

## Who's it for?

Anyone interested in how to create a Connect IQ watchface, or just want to use it.
This watchface incorporates quite a lot of different aspects, e.g.

* Time and Date (luckily, for a watchface)
* Steps Info
* Device Info (battery, notifications, alarm)
* Sunrise and Sunset times (location based)
* Properties
* Settings

## How to use it?
-----------

### Setting it up
If you want to use the watchface, go to [The Connect IQ app store](https://apps.garmin.com/en-US/apps/c3b56d09-2a43-4d3e-b732-dc7e5f149df9 "BYOD Watchface on Connect IQ store") to download. It will automatically be set as the new default watchface as soon as your watch has synced with the phone or PC app (this can take a while, so be patient). To set it up, open the settings of the watchface in the app and set the fields to whatever you'd like, play around with it until you've found the watchface of your liking.

Have a request for an additional field, a modification or just some tips on how to improve it? Just go to the [appropriate thread](https://THREADURL "BYOD Watchface on ConnectIQ forum") on the ConnectIQ forum. *Please **do not** use this thread for questions on how to get started or any other general question, use either the [existing thread](https://forums.garmin.com/showthread.php?339891-New-Developer-FAQ "New Developer FAQ"), or [make one yourself](https://forums.garmin.com/forumdisplay.php?479-Connect-IQ "ConnectIQ forum") instead.*


### Source code 
The source is split into different parts to keep a clear structure.

* 'BYODApp.mc' - Starting point of the watchface
* 'BYODView.mc' - Includes all main routines
* 'Settings.mc' - Contains all general settings and variables of the watchface

And then there's the 'Fields' folder, containing all different watchfield classes and (if applicable) their accompanying data classes.

### Building
To compile the source code to a working watchface yourself, you'll need Eclipse and the ConnectIQ SDK.
If you're not familiar with any these, follow [this guide](http://developer.garmin.com/connect-iq/getting-started/ "Getting Started") to get started!
Any question about the source code, requests for additional fields etc. can be posted in the [appropriate thread](https://THREADURL "BYOD Watchface on ConnectIQ forum") on the ConnectIQ forum. *Please **do not** use this thread for questions on how to get started or any other general question, use either the [existing thread](https://forums.garmin.com/showthread.php?339891-New-Developer-FAQ "New Developer FAQ"), or [make one yourself](https://forums.garmin.com/forumdisplay.php?479-Connect-IQ "ConnectIQ forum") instead.
If you'd like to support the BYOD Watchface, go to http://www.paypal.me/NickSteen/1

### Getting the watchface
As stated above, the watch can be found in the ConnectIQ store: [BYOD Watchface](https://apps.garmin.com/en-US/apps/c3b56d09-2a43-4d3e-b732-dc7e5f149df9 "BYOD Watchface on ConnectIQ store")

## BYOD Watchface?
Build Your Own Digital Watchface, it's that simple.
