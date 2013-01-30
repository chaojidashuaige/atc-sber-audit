//
//  TaskActivityPriority.m
//  SberbankAudit
//
//  Created by Артем Куликов on 16.05.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "TaskActivityPriority.h"

@interface TaskActivityPriority ()

@end

@implementation TaskActivityPriority

@synthesize tbClass;
@synthesize taClass;
@synthesize arrayWithData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        arrayWithData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) dealloc
{
    [taClass release];
    [tbClass release];
    [arrayWithData release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [arrayWithData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:[[arrayWithData objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_PRIORITY_NAME"]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tbClass != nil) {
        [tbClass.aPriorityButton setTitle:[[arrayWithData objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_PRIORITY_NAME"] forState:UIControlStateNormal];
        [tbClass.activity setObject:[[arrayWithData objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_PRIORITY_NAME"] forKey:@"a.ACTIVITY_PRIORITY_NAME"];
        [tbClass dismissPopover];
    }
    if (taClass != nil) {
        [taClass.aPriorityButton setTitle:[[arrayWithData objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_PRIORITY_NAME"] forState:UIControlStateNormal];
        [taClass.arraySelectActivity setObject:[[arrayWithData objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_PRIORITY_NAME"] forKey:@"a.ACTIVITY_PRIORITY_NAME"];
        [taClass dismissPopover];
    }
}

@end
