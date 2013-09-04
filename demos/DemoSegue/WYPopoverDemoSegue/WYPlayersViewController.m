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
#import "WYTestViewController.h"

@interface WYPlayersViewController () <WYPlayerDetailsViewControllerDelegate, WYPopoverControllerDelegate, UIPopoverControllerDelegate>
{
    id popoverController;
}

- (UIImage *)imageForRating:(int)rating;

- (NSString*)colorToHexString:(UIColor*)color;

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
        playerDetailsViewController.contentSizeForViewInPopover = CGSizeMake(280, 200);
		playerDetailsViewController.delegate = self;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            WYStoryboardPopoverSegue* popoverSegue = (WYStoryboardPopoverSegue*)segue;
            
            popoverController = [popoverSegue popoverControllerWithSender:sender
                                                 permittedArrowDirections:WYPopoverArrowDirectionAny
                                                                 animated:YES];
            ((WYPopoverController *)popoverController).delegate = self;
        }
        else
        {
            UIStoryboardPopoverSegue* popoverSegue = (UIStoryboardPopoverSegue*)segue;
            popoverController = [popoverSegue popoverController];
            ((UIPopoverController *)popoverController).delegate = self;
        }
	}
}

#pragma mark - WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismiss:(WYPopoverController *)aPopoverController
{
    return YES;
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

- (NSString*)colorToHexString:(UIColor*)color
{
    CGFloat rFloat, gFloat, bFloat, aFloat;
    int r, g, b, a;
    [color getRed:&rFloat green:&gFloat blue:&bFloat alpha:&aFloat];
    
    r = (int)(255.0 * rFloat);
    g = (int)(255.0 * gFloat);
    b = (int)(255.0 * bFloat);
    a = (int)(255.0 * aFloat);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x",r,g,b,a];
}

#pragma mark - selectors

- (IBAction)showTest:(id)sender
{
    WYTestViewController* contentViewController = [[WYTestViewController alloc] init];
    contentViewController.contentSizeForViewInPopover = CGSizeMake(280, 280);
    contentViewController.title = @"Test";
    
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:contentViewController];
    
    popoverController = [[WYPopoverController alloc] initWithContentViewController:navigationController];
    ((WYPopoverController *)popoverController).delegate = self;
    
    [((WYPopoverController *)popoverController) presentPopoverFromBarButtonItem:sender permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
    
    /*
    WYTestView* testView = [[WYTestView alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    testView.hidden = YES;
    testView.alpha = 0;
    [self.tableView.window.rootViewController.view addSubview:testView];
    
    testView.hidden = NO;
    [UIView animateWithDuration:.2f animations:^{
        testView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    */
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
    [popoverController setDelegate:nil];
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
