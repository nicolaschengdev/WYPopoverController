//
//  WYSettingsViewController.m
//
//  Created by Nicolas CHENG on 02/08/13.
//  Copyright (c) 2013 WHYERS. All rights reserved.
//

#import "WYSettingsViewController.h"

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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"WYSettingsTableViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
    return @"Size of pictures";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [aTableView dequeueReusableCellWithIdentifier:@"WYSettingsTableViewCell" forIndexPath:indexPath];
    
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

#pragma mark - Private

- (void)updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    NSString* pdfPhotoSize = [[NSUserDefaults standardUserDefaults] stringForKey:@"PDF_PHOTO_SIZE"];
    
    cell.textLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"Medium - 100%";
        if ([pdfPhotoSize isEqualToString:@"large"])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"Small - 50%";
        if ([pdfPhotoSize isEqualToString:@"half"])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
}

@end
