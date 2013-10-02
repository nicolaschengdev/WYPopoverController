//
//  WYGesturesViewController.m
//  WYPopoverDemoSegue
//
//  Created by Nicolas CHENG on 03/09/13.
//  Copyright (c) 2013 Nicolas CHENG. All rights reserved.
//

#import "WYGesturesViewController.h"
#import "WYPopoverController.h"

@interface WYGesturesViewController () <WYPopoverControllerDelegate>
{
    WYPopoverController* popoverController;
}

@end

@implementation WYGesturesViewController

- (IBAction)buttonTap:(id)sender
{
    UIView* view = (UIView *)sender;

    UINavigationController* contentViewController = [[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"StadiumList"]];
    
    popoverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
    popoverController.delegate = self;
    
    [popoverController presentPopoverFromRect:view.bounds inView:view permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)aPopoverController
{
    return YES;
}

@end
