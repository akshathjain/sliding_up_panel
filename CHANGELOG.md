## [0.1.0] - March 31, 2019

This is the initial release of the sliding_up_panel package. This includes features such as
- A sliding up panel that responds to user gestures
- Customizing the look and feel of the sliding panel
- Manually controlling the sliding panel via the PanelController

## [0.1.1] - March 31, 2019

- Added a CHANGELOG file

## [0.1.2] - March 31, 2019

- Updated documentation to be more comprehensive

## [0.2.0] - April 1, 2019

Added the backdrop feature:
- Body darkens as the panel opens
- The backdrop color is customizable
- The backdrop opacity is also customizable
- Off by default

Other changes:
- Removed the README from the example app (pub will display the code on the website now)
- Specified Dart as the language in the README code snippets

## [0.2.1] - [TODO: Add Release Date]

Added callbacks to the `SlidingUpPanel`
- `onPanelSlide`
- `onPanelOpened`
- `onPanelCollapsed`

Added methods to the `PanelController`
- `setPanelPosition`
- `animatePanelToPosition`
- `getPanelPosition`
- `isPanelAnimating`
- `isPanelOpen`
- `isPanelCollapsed`
- `isPanelShown`

Updated documentation to reflect changes