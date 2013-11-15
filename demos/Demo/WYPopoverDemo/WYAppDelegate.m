//
//  WYAppDelegate.m
//
//  Created by Nicolas CHENG on 14/08/13.
//  Copyright (c) 2013 WHYERS. All rights reserved.
//

#import "WYAppDelegate.h"

#import "WYPopoverController.h"
#import "WYSettingsViewController.h"
#import "WYAllDirectionsViewController.h"

@implementation WYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //UIPopoverController
    
    //Appearance 1 (white popover)
    //
    
    WYPopoverBackgroundView *popoverAppearance = [WYPopoverBackgroundView appearance];
    [popoverAppearance setFillTopColor:[UIColor blackColor]];
    
    /*
    [popoverAppearance setTintColor:[UIColor colorWithRed:235./255. green:235./255. blue:235./255. alpha:1]];
    [popoverAppearance setOuterStrokeColor:[UIColor darkGrayColor]];
    [popoverAppearance setInnerStrokeColor:[UIColor darkGrayColor]];
    [popoverAppearance setOuterCornerRadius:10];
    [popoverAppearance setMinOuterCornerRadius:10];
    
    [popoverAppearance setOuterShadowBlurRadius:6];
    [popoverAppearance setOuterShadowColor:[UIColor colorWithWhite:0 alpha:0.65]];
    [popoverAppearance setOuterShadowOffset:CGSizeMake(0, 2)];
    
    [popoverAppearance setGlossShadowColor:[UIColor lightGrayColor]];
    [popoverAppearance setGlossShadowOffset:CGSizeMake(0, 1)];
    
    [popoverAppearance setBorderWidth:5];
    [popoverAppearance setArrowHeight:20];
    [popoverAppearance setArrowBase:42];
    
    [popoverAppearance setInnerCornerRadius:10];
    [popoverAppearance setInnerShadowBlurRadius:3];
    [popoverAppearance setInnerShadowColor:[UIColor colorWithWhite:0 alpha:0.75]];
    [popoverAppearance setInnerShadowOffset:CGSizeMake(0, 1)];
    
    [popoverAppearance setViewContentInsets:UIEdgeInsetsMake(3, 0, 0, 0)];
    */
    UINavigationBar *navBarAppearance = [UINavigationBar appearanceWhenContainedIn:[UINavigationController class], [WYPopoverBackgroundView class], nil];
    [navBarAppearance setTitleTextAttributes:@{
                   UITextAttributeTextColor : [UIColor whiteColor],
              UITextAttributeTextShadowColor: [UIColor clearColor],
             UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)]
    }];
    
    //Appearance 2 (orange popover)
    //
    /*
    WYPopoverBackgroundView* popoverAppearance = [WYPopoverBackgroundView appearance];
    [popoverAppearance setMinOuterCornerRadius:8];
    [popoverAppearance setTintColor:[UIColor orangeColor]];
    */
    
    //Appearance 3 (flat green popover)
    //
    /*
    WYPopoverBackgroundView* popoverAppearance = [WYPopoverBackgroundView appearance];
    
    [popoverAppearance setOuterCornerRadius:4];
    [popoverAppearance setMinOuterCornerRadius:4];
    [popoverAppearance setOuterShadowBlurRadius:0];
    [popoverAppearance setOuterShadowColor:[UIColor clearColor]];
    [popoverAppearance setOuterShadowOffset:CGSizeMake(0, 0)];
    
    [popoverAppearance setGlossShadowColor:[UIColor clearColor]];
    [popoverAppearance setGlossShadowOffset:CGSizeMake(0, 0)];
    
    [popoverAppearance setBorderWidth:5];
    [popoverAppearance setArrowHeight:20];
    [popoverAppearance setArrowBase:42];
    
    [popoverAppearance setInnerCornerRadius:4];
    [popoverAppearance setInnerShadowBlurRadius:0];
    [popoverAppearance setInnerShadowColor:[UIColor clearColor]];
    [popoverAppearance setInnerShadowOffset:CGSizeMake(0, 0)];
    
    UIColor* greenColor = [UIColor colorWithRed:26.f/255.f green:188.f/255.f blue:156.f/255.f alpha:1];
    
    [popoverAppearance setFillTopColor:greenColor];
    [popoverAppearance setFillBottomColor:greenColor];
    [popoverAppearance setStrokeColor:greenColor];
    
    UINavigationBar* navBarAppearance = [UINavigationBar appearanceWhenContainedIn:[WYPopoverBackgroundView class], [UINavigationController class], nil];
    [navBarAppearance setTitleTextAttributes:@{
             UITextAttributeTextColor : [UIColor whiteColor],
        UITextAttributeTextShadowColor: [UIColor clearColor],
       UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)]
    }];
    */
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
