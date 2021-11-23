# Kinexon Coding Challenge

## About the application

The application contains 2 screens that can be navigated by the bottom navigation screen.
The first screen represents the drivers data in a table form, while the second screen displays
a map with a marker showing the live driver location. The driver could be selected using the
dropdown button at the bottom of the screen.

## What is new

- Automatic camera mode.
Auto mode on: The camera should automatically move and follow the location changes.
Auto mode off: another button appears and the user can use gestures (such as rotate the map,
one/two fingers tap, two finger pinch/stretch), and clicking that button moves the centralizes
the screen again to the driver location.

- Clicking on a driver's row in the Table Form Screen navigates to the drivers location in
Maps Screen.

## Project files

Dart code of Flutter projects is written mainly in /lib folder.

lib/main.dart: is the application entry point and here I configured the app and fetched data
from the servers then instantiated a periodic to fetch the updated data each 5 seconds.

/lib/models folder contains a dart file to represent each driver object and another file for
http error messages.

/lib/provider contains a dart file that is responsible for providing data for whatever widget
that might need the data anytime. Using 'provider' package, we could make tunnels between the
files to provide the data when needed and we could listen to changes in data.

/lib/screens contains the screens of the app as described above.

## How to run the code?

### Prerequisites

1. Run the backend. I am using windows so I managed to run the script using GIT Bash.

2. (IMPORTANT) Before running the flutter project please open file:
/lib/providers/data_provider.dart
and edit the field 'ipAddress' with the proper ip of the emulator or the device as follows:

Instead of using http://localhost please consider using:
    - Android emulator: http://10.0.2.2 or
    - iOS emulator: http://127.0.0.1 or
    - real device ip address

To get the current ip address you can run `ipconfig` on Windows or `ifconfig` on MacOS.
For more information please refer to this web article:
https://medium.com/@podcoder/connecting-flutter-application-to-localhost-a1022df63130

### Running the app

Select the emulator or connect a real device and run the app.
I have used a real Android device during the development.

Note: I think something is wrong with the location data of the json file as it's really very
large (`location[0]` and `location[1]` are strings of hundreds of element) and the format is kind
of non familiar. When I try to copy data manually from the json file and paste it in Google
Maps website I get an error telling that this is an invalid format. I didn't find any note
about that in the ReadME file and I did not want to send an email requiring about this spend
the weekend  waiting for response, so as a workaround I simulated the location changes by
manipulating the latitude and longitude every 5 seconds. Please let me know if the location
strings in the json file are correct and should be read in a certain way or any other point
that  I may have not understand as expected and surely I will be happy to make the necessary
changes again.
