WYPopoverController
===================

WYPopoverController is for the presentation of content in popover on iPhone / iPad devices. Very customizable.

### Screenshots

---

![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/wypopover_screenshot_1.png) ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/wypopover_screenshot_2.png) 

### Features

---

* UIAppearance support
* Works like UIPopoverController
* Works also with blocks
* Animation options
* Automatic orientation support
* UIStoryboard support
* Keyboard show / hide support
* iOS 6 & 7 support
* UIAccessibility support
* Theme support

### UIAppearance support

---

| Property                      | Type           | Default value (iOS 6)  | Default value (iOS 7)  |
| ----------------------------- | -------------- | ---------------------: | ---------------------: |
| tintColor                     | `UIColor`      |                  *nil* |                  *nil* |
| arrowBase                     | `CGFloat`      |                     42 |                     25 |
| arrowHeight                   | `CGFloat`      |                     18 |                     13 |
| borderWidth                   | `CGFloat`      |                      6 |                      0 |
| outerCornerRadius             | `CGFloat`      |                      8 |                      5 |
| innerCornerRadius             | `CGFloat`      |                      6 |                      0 |
| viewContentInsets             | `UIEdgeInsets` |         { 3, 0, 0, 0 } |       UIEdgeInsetsZero |
| fillTopColor                  | `UIColor`      | 	            #373f47ff | 	         #f4f4f4ff |
| fillBottomColor               | `UIColor`      |              #3b434cff |              #f4f4f4ff |
| glossShadowColor              | `UIColor`      |              #c3c5c77f |           #transparent |
| glossShadowBlurRadius         | `CGFloat`      |                      0 |                      0 |
| glossShadowOffset             | `CGSize`       |             { 0, 1.5 } |             CGSizeZero |
| outerShadowColor              | `UIColor`      |              #000000bf |           #transparent |
| outerShadowBlurRadius         | `CGFloat`      |                      8 |                      0 |
| outerShadowOffset             | `CGSize`       |               { 0, 2 } |             CGSizeZero |
| innerShadowColor              | `UIColor`      | 			    #000000bf | 		  #transparent |
| innerShadowBlurRadius         | `CGFloat`      |                      2 |                      0 |
| innerShadowOffset             | `CGSize`       |               { 0, 1 } |             CGSizeZero |
| minOuterCornerRadius          | `CGFloat`      |  		            0 |  		             0 |
| innerStrokeColor              | `UIColor`      |              #262c31ff |           #transparent |
| outerStrokeColor              | `UIColor`      |              #262c31ff |           #transparent |

##### Arrow & Border

![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_arrowbase.png "arrowBase: 42") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_arrowheight.png "arrowHeight: 18") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_borderwidth.png "borderWidth: 6")

##### Corner radius & View content insets

![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_outercornerradius_0.png "outerCornerRadius: 0") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_innercornerradius_14.png "innerCornerRadius: 14") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_viewcontentinsets_4-4-4-4.png "viewContentInsets: {4, 4, 4, 4}")

##### Stroke & Fill

![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_innerstrokecolor.png "innerStrokeColor: #c3045e") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_outerstrokecolor.png "outerStrokeColor: #c3045e") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_filltopcolor.png "fillTopColor: #c3045e") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_fillbottomcolor.png "fillBottomColor: #c3045e")

##### Gloss

![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_glossshadowcolor.png "glossShadowColor: #c3045e, glossShadowOffset: {0, 1.5}, glossShadowBlurRadius: 0") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_glossshadowblurradius_2.png "glossShadowColor: #c3045e, glossShadowOffset: {0, 1.5}, glossShadowBlurRadius: 2") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_glossshadowoffset_0-3.png "glossShadowColor: #c3045e, glossShadowOffset: {0, 3}, glossShadowBlurRadius: 0")

##### Outer

![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_outershadowcolor.png "outerShadowColor: #c3045e, outerShadowOffset: {0, 2}, outerShadowBlurRadius: 8") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_outershadowblurradius_2.png "outerShadowColor: #c3045e, outerShadowOffset: {0, 2}, outerShadowBlurRadius: 2") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_outershadowoffset_0--2.png "outerShadowColor: #c3045e, outerShadowOffset: {0, -2}, outerShadowBlurRadius: 2")

##### Inner

![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_innershadowcolor.png "innerShadowColor: #c3045e, innerShadowOffset: {0, 1}, innerShadowBlurRadius: 2") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_innershadowoffset_0--1.png "innerShadowColor: #c3045e, innerShadowOffset: {0, -1}, innerShadowBlurRadius: 2") , ![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/appearance/small/wypopover_innershadowblurradius_0.png "innerShadowColor: #c3045e, innerShadowOffset: {0, 1}, innerShadowBlurRadius: 0")

### Works like UIPopoverController

---

#### passthroughViews

An array of views that the user can interact with while the popover is visible.

#### wantsDefaultContentAppearance

![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/wypopover_wantsdefaultcontentappearance.png "")

Determines whether the default content appearance should be used for the popover.

#### popoverLayoutMargins

![](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/wypopover_popoverlayoutmargins.png "")

The margins that define the portion of the screen in which it is permissible to display the popover.

### Works also with blocks

---

A block object can be executed when animation sequences ends. This parameter may be `nil`.

**Important :** If a block object is defined then correspondent delegate methods is not called.

#### Example

```objective-c

popover = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
[popover presentPopoverAsDialogAnimated:YES
                             completion:^{
                                 // Code executed after popover presentation animation sequence ends
                             }];
```

### Animation options

---

There are 3 styles of animation :
* Fade *(by default)*
* Scale
* Fade with Scale

#### Example

```objective-c

popover = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
[popover presentPopoverFromRect:btn.bounds
                         inView:btn
       permittedArrowDirections:WYPopoverArrowDirectionAny
                       animated:YES
                        options:WYPopoverAnimationOptionFadeWithScale];
```

### ARC

---

WYPopoverController uses ARC.

### Installation

---

~~iOS SDK 7.0 (with Xcode 5) is required.~~

#### Cocoapods

Add this line `pod 'WYPopoverController', '~> 0.2.0'` to your PodFile.

Your PodFile should look like :

```Ruby
platform :ios, '6.0'
pod 'WYPopoverController', '~> 0.2.2'
```

To use the `master` branch of the repo :

```Ruby
platform :ios, '6.0'
pod 'WYPopoverController', :git => 'https://github.com/nicolaschengdev/WYPopoverController.git'
```

#### Manually

Add these files to your project : 
* `WYPopoverController.h` and `WYPopoverController.m`
* `WYStoryboardPopoverSegue.h` and `WYStoryboardPopoverSegue.m` 

And link `QuartzCore.framework` library in the *Build Phases* of your project targets.

### Examples

---

##### Simple

In the implementation of your view controller

```objective-c
// YourViewController.m

@interface YourViewController () <WYPopoverControllerDelegate>
{
    WYPopoverController* popoverController;
}

- (IBAction)showPopover:(id)sender;

@end

@implementation YourViewController

- (IBAction)showPopover:(id)sender
{
	popoverController = [[WYPopoverController alloc] initWithContentViewController:controller];
    popoverController.delegate = self;
    [popoverController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    popoverController = nil;
}

@end
```

##### Appearance (Tint Color)

```objective-c
WYPopoverBackgroundView* appearance = [WYPopoverBackgroundView appearance];
[appearance setTintColor:[UIColor orangeColor]];
```

##### Appearance (Flat Popover)

```objective-c
UIColor* greenColor = [UIColor colorWithRed:26.f/255.f green:188.f/255.f blue:156.f/255.f alpha:1];

WYPopoverBackgroundView* popoverAppearance = [WYPopoverBackgroundView appearance];
        
[popoverAppearance setOuterCornerRadius:4];
[popoverAppearance setOuterShadowBlurRadius:0];
[popoverAppearance setOuterShadowColor:[UIColor clearColor]];
[popoverAppearance setOuterShadowOffset:CGSizeMake(0, 0)];
        
[popoverAppearance setGlossShadowColor:[UIColor clearColor]];
[popoverAppearance setGlossShadowOffset:CGSizeMake(0, 0)];
        
[popoverAppearance setBorderWidth:8];
[popoverAppearance setArrowHeight:10];
[popoverAppearance setArrowBase:20];
        
[popoverAppearance setInnerCornerRadius:4];
[popoverAppearance setInnerShadowBlurRadius:0];
[popoverAppearance setInnerShadowColor:[UIColor clearColor]];
[popoverAppearance setInnerShadowOffset:CGSizeMake(0, 0)];
        
[popoverAppearance setFillTopColor:greenColor];
[popoverAppearance setFillBottomColor:greenColor];
[popoverAppearance setOuterStrokeColor:greenColor];
[popoverAppearance setInnerStrokeColor:greenColor];
        
UINavigationBar* navBarInPopoverAppearance = [UINavigationBar appearanceWhenContainedIn:[UINavigationController class], [WYPopoverController class], nil];
[navBarInPopoverAppearance setTitleTextAttributes: @{
                  UITextAttributeTextColor : [UIColor whiteColor],
            UITextAttributeTextShadowColor : [UIColor clearColor],
           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetMake(0, -1)]}];
```

##### Storyboard

```objective-c
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"[YOUR_SEGUE_IDENTIFIER]"])
	{
		WYStoryboardPopoverSegue* popoverSegue = (WYStoryboardPopoverSegue*)segue;

		UIViewController* destinationViewController = (UIViewController *)segue.destinationViewController;
        destinationViewController.contentSizeForViewInPopover = CGSizeMake(280, 280);		// Deprecated in iOS7. Use 'preferredContentSize' instead.

        popoverController = [popoverSegue popoverControllerWithSender:sender permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
        popoverController.delegate = self;
	}
}
```

##### Theme

Introduced in 0.2.1 release, you can change appearance of your popovers with themes.

```objective-c
- (void)changePopoverTheme
{
    popover.theme = [WYPopoverTheme themeForIOS6];  // you set a new theme

    // use beginThemeUpdates and endThemeUpdates methods if you have to change several values which compose your current theme
    
    [popover beginThemeUpdates];
        popover.theme.arrowHeight = 30;
        popover.theme.arrowBase = 40;
    [popover endThemeUpdates];
}
```

##### Keyboard

By default, when keyboard is shown, popover will be repositionned if it is (partially) hidden.
Introduced in 0.2.1 release, you can control value of y offset when keyboard is shown with the following `delegate` method :

```objective-c
- (void)popoverController:(WYPopoverController *)popoverController willTranslatePopoverWithYOffset:(CGFloat *)value
{
    *value = 0; // if value is setted to 0 then popover will not be translated
}
```

### Handling popover controllers during orientation changes

---

When showing a popover controller, there are times when you will need to handle how the popover controller appears after a change in device orientation.

Situations when handling is required:

* If the popover controller is presented from a target rectangle using the `-presentPopoverFromRect:inView:permittedArrowDirections:animated` method of WYPopoverController. You can use `-popoverController:willRepositionPopoverToRect:inView:` method introduced in the **0.1.6 release** .
* If the popover controller is presented from a bar button item that is removed after the rotation has finished .

### Change logs

---

A brief summary of each WYPopoverController release can be found on the [wiki](https://github.com/nicolaschengdev/WYPopoverController/wiki/Change-logs).

### Contact

---

* [@mikl_jeo](https://twitter.com/mikl_jeo) on Twitter
* [@nicolaschengdev](https://github.com/nicolaschengdev) on Github

### License

---

WYPopoverController is available under the MIT license.

Copyright © 2013 Nicolas CHENG

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
