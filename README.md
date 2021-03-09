# macOS File Provider Example

I created this example project as part of [a question on Stack Overflow: How to debug the exclamation mark in front of a macOS pluginkit listing?](https://stackoverflow.com/q/66546696/769502)

This project consists 99% of the templates provided by Xcode. I created a macOS app project in Xcode 12.5 Beta 3 with Swift and Storyboards. Then I added a file provider extension target from the Xcode templates. In the end I just set up a common app group and a lower deployment target.

The availability of the file provider extension template is the reason for using Xcode 12.5 Beta 3. It was not available in previous versions and a workaround barely to find.
