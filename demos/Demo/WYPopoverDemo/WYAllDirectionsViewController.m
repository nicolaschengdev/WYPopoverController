//
//  WYViewController.m
//
//  Created by Nicolas CHENG on 14/08/13.
//  Copyright (c) 2013 WHYERS. All rights reserved.
//

#import "WYAllDirectionsViewController.h"
#import "WYSettingsViewController.h"
#import "WYAnotherViewController.h"
#import "WYModalViewController.h"

@interface WYAllDirectionsViewController () <WYPopoverControllerDelegate>
{
    WYPopoverController *anotherPopoverController;
    WYPopoverController *settingsPopoverController;
}

- (IBAction)open:(id)sender;
- (void)close:(id)sender;

@end

////////////////////////////////////////////////////////////////////////////

@implementation WYAllDirectionsViewController

@synthesize topLeftButton;
@synthesize topButton;
@synthesize topRightButton;
@synthesize leftButton;
@synthesize centerButton;
@synthesize rightButton;
@synthesize bottomLeftButton;
@synthesize bottomButton;
@synthesize bottomRightButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIImage *normal = [[UIImage imageNamed:@"button-normal"] stretchableImageWithLeftCapWidth:16 topCapHeight:0];
    UIImage *highlighted = [[UIImage imageNamed:@"button-highlighted"] stretchableImageWithLeftCapWidth:16 topCapHeight:0];
    
    [topLeftButton setBackgroundImage:normal forState:UIControlStateNormal]; [topLeftButton setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    [topButton setBackgroundImage:normal forState:UIControlStateNormal]; [topButton setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    [topRightButton setBackgroundImage:normal forState:UIControlStateNormal]; [topRightButton setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    [leftButton setBackgroundImage:normal forState:UIControlStateNormal]; [leftButton setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    [centerButton setBackgroundImage:normal forState:UIControlStateNormal]; [centerButton setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    [rightButton setBackgroundImage:normal forState:UIControlStateNormal]; [rightButton setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    [bottomLeftButton setBackgroundImage:normal forState:UIControlStateNormal]; [bottomLeftButton setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    [bottomButton setBackgroundImage:normal forState:UIControlStateNormal]; [bottomButton setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    [bottomRightButton setBackgroundImage:normal forState:UIControlStateNormal]; [bottomRightButton setBackgroundImage:highlighted forState:UIControlStateHighlighted];
}

- (IBAction)open:(id)sender
{
    [self showpopover:sender];
}

- (void)close:(id)sender
{
    [settingsPopoverController dismissPopoverAnimated:YES completion:^{
        [self popoverControllerDidDismissPopover:settingsPopoverController];
    }];
}

- (void)change:(id)sender
{
    // Change popover content size
    
    //[settingsPopoverController setPopoverContentSize:CGSizeMake(320, 480)];
    
    // Change complete theme
    
    //settingsPopoverController.theme = [WYPopoverTheme themeForIOS6];
    
    //
    
    [settingsPopoverController beginThemeUpdates];
        settingsPopoverController.theme.arrowHeight = 13;
        settingsPopoverController.theme.arrowBase = 25;
    [settingsPopoverController endThemeUpdates];
}

- (IBAction)showmodal:(id)sender
{
    WYModalViewController *modalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WYModalViewController"];
    
    modalViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:modalViewController animated:YES completion:NULL];
}

- (IBAction)showpopover:(id)sender
{
    if (settingsPopoverController == nil)
    {
        UIView *btn = (UIView *)sender;
        
        WYSettingsViewController *settingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WYSettingsViewController"];
        settingsViewController.preferredContentSize = CGSizeMake(320, 280);
        
        settingsViewController.title = @"Settings";
        
        [settingsViewController.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"change" style:UIBarButtonItemStylePlain target:self action:@selector(change:)]];
        
        [settingsViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(close:)]];
        
        settingsViewController.modalInPopover = NO;
        
        UINavigationController *contentViewController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
        
        settingsPopoverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
        settingsPopoverController.delegate = self;
        settingsPopoverController.passthroughViews = @[btn];
        settingsPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
        settingsPopoverController.wantsDefaultContentAppearance = NO;
        
        [settingsPopoverController presentPopoverFromRect:btn.bounds
                                                   inView:btn
                                 permittedArrowDirections:WYPopoverArrowDirectionAny
                                                 animated:YES
                                                  options:WYPopoverAnimationOptionFadeWithScale];
    }
    else
    {
        [self close:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AnotherPopoverSegue"])
    {
        WYStoryboardPopoverSegue *popoverSegue = (WYStoryboardPopoverSegue *)segue;
        anotherPopoverController = [popoverSegue popoverControllerWithSender:sender
                                                    permittedArrowDirections:WYPopoverArrowDirectionDown
                                                                    animated:YES
                                                                     options:WYPopoverAnimationOptionFadeWithScale];
        anotherPopoverController.delegate = self;
    }
}

#pragma mark - WYPopoverControllerDelegate

- (void)popoverControllerDidPresentPopover:(WYPopoverController *)controller
{
    NSLog(@"popoverControllerDidPresentPopover");
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    if (controller == anotherPopoverController)
    {
        anotherPopoverController.delegate = nil;
        anotherPopoverController = nil;
    }
    else if (controller == settingsPopoverController)
    {
        settingsPopoverController.delegate = nil;
        settingsPopoverController = nil;
    }
}

- (BOOL)popoverControllerShouldIgnoreKeyboardBounds:(WYPopoverController *)popoverController
{
    return YES;
}

- (void)popoverController:(WYPopoverController *)popoverController willTranslatePopoverWithYOffset:(float *)value
{
    // keyboard is shown and the popover will be moved up by 163 pixels for example ( *value = 163 )
    *value = 0; // set value to 0 if you want to avoid the popover to be moved
}

#pragma mark - UIViewControllerRotation

// Applications should use supportedInterfaceOrientations and/or shouldAutorotate..
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

// New Autorotation support.
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.bottomRightButton.frame;
        frame.origin.y = (UIInterfaceOrientationIsPortrait(toInterfaceOrientation) ? self.bottomLeftButton.frame.origin.y : frame.origin.y - frame.size.height * 1.25f);
        self.bottomRightButton.frame = frame;
    }];
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
