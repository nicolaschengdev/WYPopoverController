WYPopoverController
===================

WYPopoverController is used for the presentation of content in popover on iPhone / iPad devices.

## Screenshots

![Potrait Screenshot](https://raw.github.com/nicolaschengdev/WYPopoverController/master/README/wypopover_screenshots.png)

## Installation

Simply add the files `WYPopoverController.h` and `WYPopoverController.m` to your project.

## Examples

Simple

```objective-c
WYPopoverController* popoverController = [[WYPopoverController alloc] initWithContentViewController:controller];
popoverController.delegate = self;
[popoverController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
```

