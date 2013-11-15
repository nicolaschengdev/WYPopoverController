//
//  WYModalViewController.m
//  WYPopoverDemo
//
//  Created by Nicolas CHENG on 14/11/13.
//  Copyright (c) 2013 Nicolas CHENG. All rights reserved.
//

#import "WYModalViewController.h"

#import "WYSettingsViewController.h"

@interface WYModalViewController () <WYPopoverControllerDelegate>
{
    WYPopoverController *settingsPopoverController;
}

- (IBAction)showpopover:(id)sender;

@end

@implementation WYModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)showpopover:(id)sender
{
    if (settingsPopoverController == nil)
    {
        UIView* btn = (UIView*)sender;
        
        WYSettingsViewController *settingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WYSettingsViewController"];
        
        if ([settingsViewController respondsToSelector:@selector(setPreferredContentSize:)]) {
            settingsViewController.preferredContentSize = CGSizeMake(280, 200);             // iOS 7
        }
        else {
            settingsViewController.contentSizeForViewInPopover = CGSizeMake(280, 200);      // iOS < 7
        }
        
        settingsViewController.title = @"Settings";
        [settingsViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)]];
        
        settingsViewController.modalInPopover = NO;
        
        UINavigationController* contentViewController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
        
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
        [self done:nil];
    }
}

#pragma mark - Selectors

- (void)done:(id)sender
{
    [settingsPopoverController dismissPopoverAnimated:YES];
    settingsPopoverController.delegate = nil;
    settingsPopoverController = nil;
}

#pragma mark - WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    if (controller == settingsPopoverController)
    {
        settingsPopoverController.delegate = nil;
        settingsPopoverController = nil;
    }
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
