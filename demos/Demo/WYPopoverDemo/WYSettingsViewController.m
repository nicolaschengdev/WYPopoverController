//
//  WYSettingsViewController.m
//
//  Created by Nicolas CHENG on 02/08/13.
//  Copyright (c) 2013 WHYERS. All rights reserved.
//

#import "WYSettingsViewController.h"
#import "WYAnotherViewController.h"

@interface WYSettingsViewController ()
{
}

- (void)updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;

@end

@implementation WYSettingsViewController

@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"WYSettingsTableViewCell"];
    
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithRed:195./255. green:4./255. blue:94./255. alpha:1.]];
}

- (void)viewWillAppear:(BOOL)animated
{
    //NSLog(@"view WILL appear");
}

- (void)viewDidAppear:(BOOL)animated
{
    //NSLog(@"view DID appear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    //NSLog(@"view WILL disappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    //NSLog(@"view DID disappear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
    NSString* sectionTitle = @"";
    
    if (section == 0)
    {
        sectionTitle = @"Size of pictures";
    }
    
    return sectionTitle;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 1;
    
    if (section == 0)
    {
        result = 12;
    }
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell* cell = [aTableView dequeueReusableCellWithIdentifier:@"WYSettingsTableViewCell" forIndexPath:indexPath];
    
    UITableViewCell* cell = [aTableView dequeueReusableCellWithIdentifier:@"WYSettingsTableViewCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WYSettingsTableViewCell"];
    }
    
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSString* pdfPhotoSize = (indexPath.row == 0) ? @"large" : @"half";
        [defaults setObject:pdfPhotoSize forKey:@"PDF_PHOTO_SIZE"];
        [defaults synchronize];
        
        UITableViewCell* cell;
        
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self updateCell:cell atIndexPath:indexPath];
        
        indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self updateCell:cell atIndexPath:indexPath];
    }
    else
    {
        WYAnotherViewController *anotherViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WYAnotherViewController"];
        anotherViewController.preferredContentSize = CGSizeMake(320, 420);
        [self.navigationController pushViewController:anotherViewController animated:YES];
    }
}

#pragma mark - Private

- (void)updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    NSString* pdfPhotoSize = [[NSUserDefaults standardUserDefaults] stringForKey:@"PDF_PHOTO_SIZE"];
    
    cell.textLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.section == 0)
    {
        if (indexPath.row % 2 == 0)
        {
            cell.textLabel.text = @"Medium - 100%";
            if ([pdfPhotoSize isEqualToString:@"large"])
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
        else if (indexPath.row % 2 == 1)
        {
            cell.textLabel.text = @"Small - 50%";
            if ([pdfPhotoSize isEqualToString:@"half"])
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
    else
    {
        cell.textLabel.text = @"Compression";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

@end
