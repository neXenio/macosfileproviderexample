# macOS File Provider Example

I created this example project as part of [a question on Stack Overflow: How to debug the exclamation mark in front of a macOS pluginkit listing?](https://stackoverflow.com/q/66546696/769502)

## Status

The goal was to create a starting point for myself where I can debug a file provider extension on macOS. This has been achieved with the key hint in the Stack Overflow question mentioned above.

## Get Started

1. Open the Xcode project.
2. Run the app in Xcode. This triggers the build and also builds the depending extension target.
3. Ensure the "SomeProduct" extension is activated in the system preferences pane for extensions. It may take a moment after the first build to show up. Extensions are loaded by the system and the containing apps do not have control over that.
4. Finder should list "SomeProduct - SomeDomain" in the "Locations" section of the side bar. The latter likely needs to be enabled in the Finder preferences.
5. Selecting that location Finder should list the dummy item "a file".

From now on you can start working on your file provider and debug it by attaching to the extension process with the Xcode debugger.

## Technical Information

This project consists 99% of the templates provided by Xcode. I created a macOS app project in Xcode 12.5 Beta 3 with Swift and Storyboards. Then I added a file provider extension target from the Xcode templates. In the end I just set up a common app group and a lower deployment target.

The availability of the file provider extension template is the reason for using Xcode 12.5 Beta 3. It was not available in previous versions and a workaround barely to find. The project can be built with previous Xcode releases, too.
