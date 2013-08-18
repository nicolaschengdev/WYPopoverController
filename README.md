WYPopoverController
===================

WYPopoverController is used for the presentation of content in popover on iPhone / iPad devices. Very customizable.

## Screenshots

![Potrait Screenshot](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/wypopover_screenshots.png)

## Features

* UIAppearance support (see [Appearance](https://github.com/nicolaschengdev/WYPopover/wiki/Appearance))
* Works like UIPopoverController
* Automatic orientation

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

## ARC

WYPopoverController uses ARC.

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

## Contact

* [@mikl_jeo](https://twitter.com/mikl_jeo) on Twitter
* [@nicolaschengdev](https://github.com/nicolaschengdev) on Github
* <a href="mailTo:nicolas.cheng.dev@gmail.com">nicolas.cheng.dev [at] gmail [dot] com</a>

## License

Version 0.1

WYPopoverController is available under the MIT license.

Copyright © 2013 Nicolas CHENG

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
