WYPopoverController
===================

WYPopoverController is used for the presentation of content in popover on iPhone / iPad devices.

Screenshots
---

![Potrait Screenshot](https://raw.github.com/nicolaschengdev/WYPopoverController/master/README/wypopover_portrait_screenshot.png)
![Landscape Screenshot](https://raw.github.com/nicolaschengdev/WYPopoverController/master/README/wypopover_landscape_screenshot.png)

How to use it
---  

Let's start with a simple example

```objective-c
- (IBAction)tapOnButton:(id)sender
{
    if (popoverController == nil)
    {
        UIView* btn = (UIView*)sender;
        
        WYSettingsViewController* settingsViewController = [[WYSettingsViewController alloc] init];
        settingsViewController.contentSizeForViewInPopover = CGSizeMake(280, 140);
        settingsViewController.title = @"PDF Settings";
        [settingsViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)]];
        
        UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
        
        UIViewController* contentViewController = navigationController;
        
        popoverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
        popoverController.delegate = self;
        popoverController.passthroughViews = @[btn];
        popoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
        popoverController.wantsDefaultContentAppearance = NO;
        [popoverController presentPopoverFromRect:btn.bounds inView:btn permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
    }
}
```