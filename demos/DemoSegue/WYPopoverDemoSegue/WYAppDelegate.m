//
//  WYAppDelegate.m
//  WYPopoverDemoSegue
//
//  Created by Nicolas CHENG on 28/08/13.
//  Copyright (c) 2013 Nicolas CHENG. All rights reserved.
//

#import "WYAppDelegate.h"
#import "WYPlayer.h"
#import "WYPlayersViewController.h"
#import "WYPopoverController.h"

@implementation WYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    WYPopoverBackgroundView* popoverAppearance = [WYPopoverBackgroundView appearance];

    [popoverAppearance setTintColor:[UIColor colorWithRed:63./255. green:92./255. blue:128./255. alpha:1]];
    
    [popoverAppearance setOuterCornerRadius:6];
    [popoverAppearance setMinOuterCornerRadius:2];
    [popoverAppearance setInnerCornerRadius:4];
    
    [popoverAppearance setBorderWidth:6];
    [popoverAppearance setArrowBase:32];
    [popoverAppearance setArrowHeight:14];
    
    [popoverAppearance setGlossShadowColor:[UIColor colorWithWhite:1 alpha:0.5]];
    [popoverAppearance setGlossShadowBlurRadius:1];
    [popoverAppearance setGlossShadowOffset:CGSizeMake(0, 1.5)];
    
    [popoverAppearance setOuterShadowColor:[UIColor colorWithRed:16./255. green:50./255. blue:82./255. alpha:1]];
    [popoverAppearance setOuterShadowBlurRadius:8];
    [popoverAppearance setOuterShadowOffset:CGSizeMake(0, 2)];
    
    [popoverAppearance setInnerShadowColor:[UIColor colorWithWhite:0 alpha:1]];
    [popoverAppearance setInnerShadowBlurRadius:3];
    [popoverAppearance setInnerShadowOffset:CGSizeMake(0, 0.5)];
    
    UINavigationBar* navBarAppearance = [UINavigationBar appearanceWhenContainedIn:[UINavigationController class], [WYPopoverBackgroundView class], nil];
    [navBarAppearance setTitleTextAttributes:@{
                   UITextAttributeTextColor : [UIColor whiteColor],
              UITextAttributeTextShadowColor: [UIColor colorWithWhite:0 alpha:0.8],
             UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)]
    }];
    
    NSArray *temp = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"players" ofType:@"plist"]];
    
    players = [NSMutableArray arrayWithCapacity:[temp count]];
    
    [temp enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        WYPlayer *player = [[WYPlayer alloc] init];
        player.name = [obj objectForKey:@"name"];
        player.game = [obj objectForKey:@"game"];
        player.rating = [[obj objectForKey:@"rating"] intValue];
        [players addObject:player];
    }];
    
    UINavigationController *navigationController = nil;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        navigationController = [[tabBarController viewControllers] objectAtIndex:0];
    }
    else
    {
        navigationController = (UINavigationController *)self.window.rootViewController;
    }
    
    WYPlayersViewController *playersViewController = [[navigationController viewControllers] objectAtIndex:0];
    playersViewController.players = players;
    
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
