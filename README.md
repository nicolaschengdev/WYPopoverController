WYPopoverController
===================

WYPopoverController is for the presentation of content in popover on iPhone / iPad devices. Very customizable.

### Screenshots

---

![Potrait Screenshot](https://raw.github.com/nicolaschengdev/WYPopoverController/master/screenshots/wypopover_screenshots.png)

### Features

---

* Works like UIPopoverController
* UIAppearance support
* Automatic orientation
* UIStoryboard support

### Appearance

---

| Property              | Type           | Default value                                                                          |
| --------------------- | -------------- | -------------------------------------------------------------------------------------: |
| tintColor             | `UIColor`      |                                                                                  *nil* |
| arrowBase             | `CGFloat`      |                                                                                     42 |
| arrowHeight           | `CGFloat`      |                                                                                     18 |
| strokeColor           | `UIColor`      | #262c31ff <span style="width:30px;height:30px;background-color:#262c31;">&nbsp;</span> |
| fillTopColor          | `UIColor`      | #373f47ff <span style="width:30px;height:30px;background-color:#373f47;">&nbsp;</span> |
| fillBottomColor       | `UIColor`      | #3b434cff <span style="width:30px;height:30px;background-color:#3b434c;">&nbsp;</span> |
| glossShadowColor      | `UIColor`      | #c3c5c77f <span style="width:30px;height:30px;background-color:#c3c5c7;">&nbsp;</span> |
| glossShadowOffset     | `CGSize`       |                                                                             { 0, 1.5 } |
| glossShadowBlurRadius | `CGFloat`      |                                                                                      0 |
| outerShadowColor      | `UIColor`      | #000000bf <span style="width:30px;height:30px;background-color:#000000;">&nbsp;</span> |
| outerShadowBlurRadius | `CGFloat`      |                                                                                      8 |
| outerShadowOffset     | `CGSize`       |                                                                               { 0, 2 } |
| outerCornerRadius     | `CGFloat`      |                                                                                      8 |
| innerShadowColor      | `UIColor`      | #000000bf <span style="width:30px;height:30px;background-color:#000000;">&nbsp;</span> |
| innerShadowBlurRadius | `CGFloat`      |                                                                                      2 |
| innerShadowOffset     | `CGSize`       |                                                                               { 0, 1 } |
| innerCornerRadius     | `CGFloat`      |                                                                                      6 |
| viewContentInsets     | `UIEdgeInsets` |                                                                         { 3, 0, 0, 0 } |
| borderWidth           | `CGFloat`      |                                                                                      6 |

### Works like UIPopoverController

---

* passthroughViews
* wantsDefaultContentAppearance
* popoverLayoutMargins

### ARC

---

WYPopoverController uses ARC.

### Installation

---

Add this line `pod 'WYPopoverController', '~> 0.1.1'` to your PodFile or add manually these 4 files `WYPopoverController.h`, `WYPopoverController.m`, `WYStoryboardPopoverSegue.h`, `WYStoryboardPopoverSegue.m` to your project.

### Examples

---

#### Simple

```objective-c
WYPopoverController* popoverController = [[WYPopoverController alloc] initWithContentViewController:controller];
popoverController.delegate = self;
[popoverController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
```

#### Appearance (Tint Color)

```objective-c
WYPopoverBackgroundView* appearance = [WYPopoverBackgroundView appearance];
[appearance setTintColor:[UIColor orangeColor]];
```

#### Appearance (Flat Popover)

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

#### Storyboard

```objective-c
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddPlayer"])
	{
		WYStoryboardPopoverSegue* popoverSegue = (WYStoryboardPopoverSegue*)segue;

		UINavigationController *navigationController = popoverSegue.destinationViewController;
		WYPlayerDetailsViewController* playerDetailsViewController = [[navigationController viewControllers] objectAtIndex:0];
		playerDetailsViewController.delegate = self;

        popoverController = [popoverSegue popoverControllerWithSender:sender permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
        popoverController.delegate = self;
	}
}
```

### Change logs

---

A brief summary of each WYPopoverController release can be found on the [wiki](https://github.com/nicolaschengdev/WYPopoverController/wiki/Change-logs).

### Contact

---

* [@mikl_jeo](https://twitter.com/mikl_jeo) on Twitter
* [@nicolaschengdev](https://github.com/nicolaschengdev) on Github
* <a href="mailTo:nicolas.cheng.dev@gmail.com">nicolas.cheng.dev [at] gmail [dot] com</a>

### License

---

WYPopoverController is available under the MIT license.

Copyright © 2013 Nicolas CHENG

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
