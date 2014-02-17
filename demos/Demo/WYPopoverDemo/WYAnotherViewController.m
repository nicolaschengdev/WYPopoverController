//
//  WYAnotherViewController.m
//  WYPopoverDemo
//
//  Created by Nicolas CHENG on 27/08/13.
//  Copyright (c) 2013 Nicolas CHENG. All rights reserved.
//

#import "WYAnotherViewController.h"

@interface WYAnotherViewController ()

@end

@implementation WYAnotherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)resizeme:(id)sender
{
    self.preferredContentSize = CGSizeMake(360, 220);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title = @"Another view";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //NSLog(@"%@", NSStringFromCGRect(self.view.frame));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
