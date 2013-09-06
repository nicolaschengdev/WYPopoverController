//
//  WYGesturesViewController.m
//  WYPopoverDemoSegue
//
//  Created by Nicolas CHENG on 03/09/13.
//  Copyright (c) 2013 Nicolas CHENG. All rights reserved.
//

#import "WYGesturesViewController.h"
#import "WYPopoverController.h"
#import "WYTestViewController.h"

@interface WYGesturesViewController () <WYPopoverControllerDelegate>
{
    WYPopoverController* popoverController;
}

@end

@implementation WYGesturesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)buttonTap:(id)sender
{
    UIView* view = (UIView*)sender;

    WYTestViewController* contentViewController = [[WYTestViewController alloc] init];
    contentViewController.contentSizeForViewInPopover = CGSizeMake(260, 200);
    
    popoverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
    popoverController.delegate = self;
    
    [((WYPopoverController *)popoverController) presentPopoverFromRect:view.bounds inView:view permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismiss:(WYPopoverController *)aPopoverController
{
    return YES;
}


@end
