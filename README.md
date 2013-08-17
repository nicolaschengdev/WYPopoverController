WYPopoverController
===================

WYPopoverController is used for the presentation of content in popover on iPhone / iPad devices.

## Screenshots

![Potrait Screenshot](https://raw.github.com/nicolaschengdev/WYPopoverController/master/README/wypopover_screenshots.png)

## Features

* UIAppearance support (see [Appearance](https://github.com/nicolaschengdev/WYPopover/wiki/Appearance))
* Works like UIPopoverController
* Automatic orientation
* ARC support

## Appearance

* tintColor
* strokeColor
* fillTopColor
* fillBottomColor
* glossShadowColor
* glossShadowOffset
* glossShadowBlurRadius
* borderWidth
* arrowBase
* arrowHeight
* outerShadowColor
* outerShadowBlurRadius
* outerShadowOffset
* outerCornerRadius
* innerShadowColor
* innerShadowBlurRadius
* innerShadowOffset
* innerCornerRadius
* viewContentInsets

## Works like UIPopoverController 

* passthroughViews
* wantsDefaultContentAppearance
* popoverLayoutMargins

## Installation

Add the files `WYPopoverController.h` and `WYPopoverController.m` to your project.

## Examples

Simple

```objective-c
WYPopoverController* popoverController = [[WYPopoverController alloc] initWithContentViewController:controller];
popoverController.delegate = self;
[popoverController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
```

Appearance (Tint Color)

```objective-c
WYPopoverBackgroundView* appearance = [WYPopoverBackgroundView appearance];
[appearance setTintColor:[UIColor orangeColor]];
```

Appearance (Flat Popover)

```objective-c
WYPopoverBackgroundView* appearance = [WYPopoverBackgroundView appearance];
        
[appearance setOuterCornerRadius:4];
[appearance setOuterShadowBlurRadius:0];
[appearance setOuterShadowColor:[UIColor clearColor]];
[appearance setOuterShadowOffset:CGSizeMake(0, 0)];
        
[appearance setGlossShadowColor:[UIColor clearColor]];
[appearance setGlossShadowOffset:CGSizeMake(0, 0)];
        
[appearance setBorderWidth:8];
[appearance setArrowHeight:10];
[appearance setArrowBase:20];
        
[appearance setInnerCornerRadius:4];
[appearance setInnerShadowBlurRadius:0];
[appearance setInnerShadowColor:[UIColor clearColor]];
[appearance setInnerShadowOffset:CGSizeMake(0, 0)];
        
UIColor* greenColor = [UIColor colorWithRed:26.f/255.f green:188.f/255.f blue:156.f/255.f alpha:1];
        
[appearance setFillTopColor:greenColor];
[appearance setFillBottomColor:greenColor];
[appearance setStrokeColor:greenColor];
        
UINavigationBar* appearance2 = [UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil];
[appearance2 setTitleTextAttributes:@{
                  UITextAttributeTextColor : [UIColor whiteColor],
             UITextAttributeTextShadowColor: [UIColor clearColor],
            UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)]}];
```