//
//  WYPlayerCell.h
//  WYPopoverDemoSegue
//
//  Created by Nicolas CHENG on 29/08/13.
//  Copyright (c) 2013 Nicolas CHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYPlayerCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel      *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *gameLabel;
@property (nonatomic, strong) IBOutlet UIImageView  *ratingImageView;

@end