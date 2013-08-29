//
//  WYPlayersViewController.m
//  WYPopoverDemoSegue
//
//  Created by Nicolas CHENG on 29/08/13.
//  Copyright (c) 2013 Nicolas CHENG. All rights reserved.
//

#import "WYPlayersViewController.h"
#import "WYPlayer.h"
#import "WYPlayerCell.h"
#import "WYPlayerDetailsViewController.h"
#import "WYStoryboardPopoverSegue.h"

@interface WYPlayersViewController () <WYPlayerDetailsViewControllerDelegate, WYPopoverControllerDelegate>
{
    WYPopoverController* popoverController;
}

- (UIImage *)imageForRating:(int)rating;

@end

////////////////////////////////////////////////////////////////////////////////////

@implementation WYPlayersViewController

@synthesize players;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddPlayer"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		WYPlayerDetailsViewController* playerDetailsViewController = [[navigationController viewControllers] objectAtIndex:0];
		playerDetailsViewController.delegate = self;
        //playerDetailsViewController.contentSizeForViewInPopover = CGSizeMake(280, 140);
        
        WYStoryboardPopoverSegue* popoverSegue = (WYStoryboardPopoverSegue*)segue;
        
        popoverController = [popoverSegue popoverControllerWithSender:sender permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
        popoverController.delegate = self;
	}
}

#pragma mark - private

- (UIImage *)imageForRating:(int)rating
{
    switch (rating)
    {
        case 1: return [UIImage imageNamed:@"1StarSmall.png"];
        case 2: return [UIImage imageNamed:@"2StarsSmall.png"];
        case 3: return [UIImage imageNamed:@"3StarsSmall.png"];
        case 4: return [UIImage imageNamed:@"4StarsSmall.png"];
        case 5: return [UIImage imageNamed:@"5StarsSmall.png"];
    }
    return nil;
}

#pragma mark - WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismiss:(WYPopoverController *)popoverController
{
    return NO;
}

#pragma mark - WYPlayerDetailsViewControllerDelegate

- (void)playerDetailsViewControllerDidCancel:(WYPlayerDetailsViewController *)controller
{
    [popoverController dismissPopoverAnimated:YES];
    popoverController = nil;
}

- (void)playerDetailsViewController:(WYPlayerDetailsViewController *)controller
                       didAddPlayer:(WYPlayer *)player
{
	[self.players addObject:player];
	NSIndexPath *indexPath =
	[NSIndexPath indexPathForRow:[self.players count] - 1 inSection:0];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];

    [popoverController dismissPopoverAnimated:YES];
    popoverController = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYPlayerCell *cell = (WYPlayerCell *)[tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    
    WYPlayer *player = [self.players objectAtIndex:indexPath.row];
    cell.nameLabel.text = player.name;
    cell.gameLabel.text = player.game;
    cell.ratingImageView.image = [self imageForRating:player.rating];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		[self.players removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

@end
