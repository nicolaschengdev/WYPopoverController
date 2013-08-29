//
//  WYPlayerDetailsViewController.h
//  WYPopoverDemoSegue
//
//  Created by Nicolas CHENG on 29/08/13.
//  Copyright (c) 2013 Nicolas CHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYPlayer.h"

@protocol WYPlayerDetailsViewControllerDelegate;

@interface WYPlayerDetailsViewController : UITableViewController
{
}

@property (nonatomic, weak) id <WYPlayerDetailsViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField*nameTextField;

@property (strong, nonatomic) IBOutlet UILabel*detailLabel;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end

@protocol WYPlayerDetailsViewControllerDelegate <NSObject>

@optional

- (void)playerDetailsViewControllerDidCancel:(WYPlayerDetailsViewController *)controller;

- (void)playerDetailsViewController:(WYPlayerDetailsViewController *)controller
                       didAddPlayer:(WYPlayer *)player;

@end