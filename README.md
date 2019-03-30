# sliding_up_panel
[![pub package](https://img.shields.io/pub/v/sliding_up_panel.svg)](https://pub.dartlang.org/packages/sliding_up_panel)

A Flutter widget that makes implementing a Sliding Up Panel much easier!

## Installing
Add the following to your `pubspec.yaml` file:
```
dependencies:
  sliding_up_panel: ^1.0.0
```

## Simple Usage

## Custom Usage
There are several options that allow for more control:

| Properties| Description |
|-----------|-------------|
| `back` | The Widget that lies underneath the sliding panel. |
| `panelCollapsed` | The Widget displayed in the sliding panel when collapsed. |
| `panelOpen` | (required) The Widget displayed when the sliding panel is fully opened. |
| `panelHeightCollapsed` | The height of the sliding panel when fully collapsed. |
| `panelHeightOpen` | The height of the sliding panel when fully open. |
| `border` | A border to draw around the sliding panel sheet. |
| `borderRadius` | If non-null, the corners of the sliding panel sheet are rounded by this BorderRadius. |
| `boxShadow` | A list of shadows cast behind the sliding panel. |
| `color` | The color to fill the background of the sliding panel. |
| `padding` | The amount to inset the children of the sliding panel. |
| `margin` | Empty space surrounding the sliding panel. |
| `renderSheet` | Signals whether or not to render the sliding panel sheet. Setting this to false means that only [back], [panelCollapsed], and the [panelOpen] Widgets will be rendered. Set this to false if you want to achieve a floating effect or want more customization over how the sliding panel looks like. |

## Creating A Floating Effect