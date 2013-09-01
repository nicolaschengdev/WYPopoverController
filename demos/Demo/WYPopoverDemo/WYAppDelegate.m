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
    /*
    {
        WYPopoverBackgroundView* appearance = [WYPopoverBackgroundView appearance];
        [appearance setTintColor:[UIColor whiteColor]];
        
        [appearance setOuterCornerRadius:5];
        [appearance setOuterShadowBlurRadius:6];
        [appearance setOuterShadowColor:[UIColor colorWithWhite:0 alpha:0.65]];
        [appearance setOuterShadowOffset:CGSizeMake(0, 2)];
        
        [appearance setGlossShadowColor:[UIColor lightGrayColor]];
        [appearance setGlossShadowOffset:CGSizeMake(0, 1)];
        
        [appearance setBorderWidth:5];
        [appearance setArrowHeight:20];
        [appearance setArrowBase:42];
        
        [appearance setInnerCornerRadius:4];
        [appearance setInnerShadowBlurRadius:3];
        [appearance setInnerShadowColor:[UIColor colorWithWhite:0 alpha:0.75]];
        [appearance setInnerShadowOffset:CGSizeMake(0, 1)];
    }
    {
        UINavigationBar* appearance = [UINavigationBar appearanceWhenContainedIn:[WYPopoverBackgroundView class], [UINavigationController class], nil];
        [appearance setTitleTextAttributes:@{
                    UITextAttributeTextColor : [UIColor darkGrayColor],
                    UITextAttributeTextShadowColor: [UIColor whiteColor],
                    UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)]
         }];
    }
    */
    
    //Appearance 2 (orange popover)
    //
    /*
    {
        WYPopoverBackgroundView* appearance = [WYPopoverBackgroundView appearance];
        [appearance setTintColor:[UIColor orangeColor]];
    }
    */
    
    //Appearance 3 (flat green popover)
    //
    /*
    {
        WYPopoverBackgroundView* appearance = [WYPopoverBackgroundView appearance];
        
        [appearance setOuterCornerRadius:4];
        [appearance setOuterShadowBlurRadius:0];
        [appearance setOuterShadowColor:[UIColor clearColor]];
        [appearance setOuterShadowOffset:CGSizeMake(0, 0)];
        
        [appearance setGlossShadowColor:[UIColor clearColor]];
        [appearance setGlossShadowOffset:CGSizeMake(0, 0)];
        
        [appearance setBorderWidth:8];
        [appearance setArrowHeight:10];
        [appearance setArrowBase:20];
        
        [appearance setInnerCornerRadius:4];
        [appearance setInnerShadowBlurRadius:0];
        [appearance setInnerShadowColor:[UIColor clearColor]];
        [appearance setInnerShadowOffset:CGSizeMake(0, 0)];
        
        UIColor* greenColor = [UIColor colorWithRed:26.f/255.f green:188.f/255.f blue:156.f/255.f alpha:1];
        
        [appearance setFillTopColor:greenColor];
        [appearance setFillBottomColor:greenColor];
        [appearance setStrokeColor:greenColor];
    }
    {
        UINavigationBar* appearance = [UINavigationBar appearanceWhenContainedIn:[WYPopoverBackgroundView class], [UINavigationController class], nil];
        [appearance setTitleTextAttributes:@{
                  UITextAttributeTextColor : [UIColor whiteColor],
             UITextAttributeTextShadowColor: [UIColor clearColor],
            UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)]
         }];
    }
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
