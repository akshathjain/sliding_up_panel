## [0.3.6] - [September 25, 2019]

#### Fixes
- Fixed issues #54, #59 where panel listeners would be called before UI was rendered (related to `defaultPanelState`)

#### Documentation
- Updated the documentation to reflect fixes



## [0.3.5] - [August 31, 2019]

#### Features
- Added the `defaultPanelState` property that changes whether the panel is either open or closed by default (`PanelState.OPEN` or `PanelState.CLOSED`)

#### Documentation
- Updated the documentation to reflect new features



## [0.3.4] - [April 16, 2019]

#### Features
- Added the `slideDirection` property that changes how the panel slides open (either up or down)

#### Documentation
- Updated the documentation to reflect new features



## [0.3.3] - [April 6, 2019]

#### Features
- Added the `isDraggable` property that allows/prevents dragging of the panel

#### Documentation
- Updated the documentation to reflect new features



## [0.3.2] - [April 5, 2019]

#### Documentation
- Fixed problem where images would wrap on pub (instead of displaying on one line)


## [0.3.1] - [April 5, 2019]

#### Features
- Configuration options to `SlidingUpPanel`
    - `parallaxEnabled`
    - `parallaxOffset`

#### Documentation
- Created a new example app (Maps)
- Updated documentation to reflect new features



## [0.3.0] - April 2, 2019

#### Features
- Added ability to close the `panel` when the backdrop is tapped

- Added callbacks to the `SlidingUpPanel`
    - `onPanelSlide`
    - `onPanelOpened`
    - `onPanelClosed`

- Added methods to the `PanelController`
    - `setPanelPosition`
    - `animatePanelToPosition`
    - `getPanelPosition`
    - `isPanelAnimating`
    - `isPanelOpen`
    - `isPanelClosed`
    - `isPanelShown`

#### Bug Fixes
- Fixed issue where the `collapsed` widget would accept touch events even when invisible (i.e. even when the panel was fully open)

#### Documentation
- Updated documentation to reflect new features
- Added clarification on `PanelController` lifecycle
- Added an explanation about nesting the `Scaffold` when displaying a backdrop



## [0.2.0] - April 1, 2019

Added the backdrop feature:
- Body darkens as the panel opens
- The backdrop color is customizable
- The backdrop opacity is also customizable
- Off by default

Other changes:
- Removed the README from the example app (pub will display the code on the website now)
- Specified Dart as the language in the README code snippets



## [0.1.2] - March 31, 2019

- Updated documentation to be more comprehensive



## [0.1.1] - March 31, 2019

- Added a CHANGELOG file



## [0.1.0] - March 31, 2019

This is the initial release of the sliding_up_panel package. This includes features such as
- A sliding up panel that responds to user gestures
- Customizing the look and feel of the sliding panel
- Manually controlling the sliding panel via the PanelController