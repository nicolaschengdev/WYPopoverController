//
//  WYSettingsViewController.h
//
//  Created by Nicolas CHENG on 02/08/13.
//  Copyright (c) 2013 WHYERS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
}

@property (nonatomic, weak) IBOutlet UITableView* tableView;

@end
