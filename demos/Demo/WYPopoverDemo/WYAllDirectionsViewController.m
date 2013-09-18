//
//  WYViewController.m
//
//  Created by Nicolas CHENG on 14/08/13.
//  Copyright (c) 2013 WHYERS. All rights reserved.
//

#import "WYAllDirectionsViewController.h"
#import "WYSettingsViewController.h"
#import "WYAnotherViewController.h"

@interface WYAllDirectionsViewController () <WYPopoverControllerDelegate>
{
    WYPopoverController* popoverController;
}

- (IBAction)showPopover:(id)sender;

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
    
    UIImage* normal = [[UIImage imageNamed:@"button-normal"] stretchableImageWithLeftCapWidth:16 topCapHeight:0];
    UIImage* highlighted = [[UIImage imageNamed:@"button-highlighted"] stretchableImageWithLeftCapWidth:16 topCapHeight:0];
    
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

- (IBAction)showPopover:(id)sender
{
    if (popoverController == nil)
    {
        UIView* btn = (UIView*)sender;
        
        WYSettingsViewController* settingsViewController = [[WYSettingsViewController alloc] init];
        
        if ([settingsViewController respondsToSelector:@selector(setPreferredContentSize:)])
        {
            // iOS 7
            settingsViewController.preferredContentSize = CGSizeMake(280, 200);
        }
        else
        {
            // iOS < 7
            settingsViewController.contentSizeForViewInPopover = CGSizeMake(280, 200);
        }
        
        settingsViewController.title = @"Settings";
        [settingsViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)]];
        
        settingsViewController.modalInPopover = NO;
        
        UINavigationController* contentViewController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
        
        popoverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
        popoverController.delegate = self;
        popoverController.passthroughViews = @[btn];
        popoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
        popoverController.wantsDefaultContentAppearance = NO;
        [popoverController presentPopoverFromRect:btn.bounds inView:btn permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
        
    }
    else
    {
        [self done:nil];
    }
}

#pragma mark - Selectors

- (void)done:(id)sender
{
    [popoverController dismissPopoverAnimated:YES];
    popoverController.delegate = nil;
    popoverController = nil;
}

#pragma mark - WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismiss:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismiss:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    popoverController = nil;
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

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
