//
//  WYViewController.h
//
//  Created by Nicolas CHENG on 14/08/13.
//  Copyright (c) 2013 WHYERS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WYPopoverController.h"

@interface WYAllDirectionsViewController : UIViewController
{
}

@property (nonatomic, weak) IBOutlet UIButton* topLeftButton;
@property (nonatomic, weak) IBOutlet UIButton* topButton;
@property (nonatomic, weak) IBOutlet UIButton* topRightButton;
@property (nonatomic, weak) IBOutlet UIButton* leftButton;
@property (nonatomic, weak) IBOutlet UIButton* centerButton;
@property (nonatomic, weak) IBOutlet UIButton* rightButton;
@property (nonatomic, weak) IBOutlet UIButton* bottomLeftButton;
@property (nonatomic, weak) IBOutlet UIButton* bottomButton;
@property (nonatomic, weak) IBOutlet UIButton* bottomRightButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *dialogButton;


@end
