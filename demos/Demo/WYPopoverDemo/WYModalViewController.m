//
//  WYModalViewController.m
//  WYPopoverDemo
//
//  Created by Nicolas CHENG on 13/09/13.
//  Copyright (c) 2013 Nicolas CHENG. All rights reserved.
//

#import "WYModalViewController.h"

@interface WYModalViewController () <WYPopoverControllerDelegate>
{
    WYPopoverController* popoverController;
}
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
    // Do any additional setup after loading the view from its nib.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PopoverSegue"])
    {
        WYStoryboardPopoverSegue* popoverSegue = (WYStoryboardPopoverSegue*)segue;
        
        UIViewController* destinationViewController = (UIViewController *)segue.destinationViewController;
        
        if ([destinationViewController respondsToSelector:@selector(setPreferredContentSize:)])
        {
            // iOS 7
            destinationViewController.preferredContentSize = CGSizeMake(280, 200);
        }
        else
        {
            // iOS < 7
            destinationViewController.contentSizeForViewInPopover = CGSizeMake(280, 200);
        }
        
        popoverController = [popoverSegue popoverControllerWithSender:sender permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
        
        popoverController.delegate = self;
    }
}

#pragma mark - WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismiss:(WYPopoverController *)popoverController
{
    return YES;
}

- (void)popoverControllerDidDismiss:(WYPopoverController *)popoverController
{
    
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
