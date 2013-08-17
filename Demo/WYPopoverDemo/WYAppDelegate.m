//
//  WYAppDelegate.m
//
//  Created by Nicolas CHENG on 14/08/13.
//  Copyright (c) 2013 WHYERS. All rights reserved.
//

#import "WYAppDelegate.h"

#import "WYViewController.h"

#import "WYPopoverController.h"

@implementation WYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    //
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[WYViewController alloc] initWithNibName:@"WYViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[WYViewController alloc] initWithNibName:@"WYViewController_iPad" bundle:nil];
    }
    
    //UIPopoverController
        
    // Customize appearance 1
    //
    {
        WYPopoverBackgroundView* appearance = [WYPopoverBackgroundView appearance];
        [appearance setTintColor:[UIColor whiteColor]];
        
        //[appearance setStrokeColor:[UIColor greenColor]];
        
        [appearance setOuterCornerRadius:6];
        [appearance setOuterShadowBlurRadius:8];
        [appearance setOuterShadowColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [appearance setOuterShadowOffset:CGSizeMake(0, 4)];
        
        [appearance setGlossShadowColor:[UIColor lightGrayColor]];
        [appearance setGlossShadowOffset:CGSizeMake(0, 1)];
        
        [appearance setBorderWidth:6];
        [appearance setArrowHeight:22];
        [appearance setArrowBase:48];
        
        [appearance setInnerCornerRadius:4];
        [appearance setInnerShadowBlurRadius:3];
        [appearance setInnerShadowColor:[UIColor colorWithWhite:0 alpha:0.75]];
        [appearance setInnerShadowOffset:CGSizeMake(0, 0)];
    }
    {
        UINavigationBar* appearance = [UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil];
        [appearance setTitleTextAttributes:@{
                    UITextAttributeTextColor : [UIColor darkGrayColor],
                    UITextAttributeTextShadowColor: [UIColor whiteColor],
                    UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)]
         }];
    }
    
    // Customize appearance 2
    //
    /*
    {
        WYPopoverBackgroundView* appearance = [WYPopoverBackgroundView appearance];
        [appearance setTintColor:[UIColor orangeColor]];
        [appearance setStrokeColor:[UIColor darkGrayColor]];
        [appearance setGlossShadowOffset:CGSizeMake(0, 2.5)];
    }
    */
    
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
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
