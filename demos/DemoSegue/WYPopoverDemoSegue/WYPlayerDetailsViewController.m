//
//  WYPlayerDetailsViewController.m
//  WYPopoverDemoSegue
//
//  Created by Nicolas CHENG on 29/08/13.
//  Copyright (c) 2013 Nicolas CHENG. All rights reserved.
//

#import "WYPlayerDetailsViewController.h"


@interface WYPlayerDetailsViewController ()

@end

@implementation WYPlayerDetailsViewController

@synthesize delegate;

@synthesize nameTextField;
@synthesize detailLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)cancel:(id)sender
{
	[self.delegate playerDetailsViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
    WYPlayer *player = [[WYPlayer alloc] init];
	player.name = self.nameTextField.text;
	player.game = @"Chess";
	player.rating = 1;
	[self.delegate playerDetailsViewController:self didAddPlayer:player];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	if (indexPath.section == 0)
        [self.nameTextField becomeFirstResponder];
}

@end
