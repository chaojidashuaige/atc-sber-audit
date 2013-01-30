//
//  TaskActivitySubType.m
//  SberbankAudit
//
//  Created by Артем Куликов on 16.05.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "TaskActivitySubType.h"

@interface TaskActivitySubType ()

@end

@implementation TaskActivitySubType

@synthesize taClass;
@synthesize arraySubType;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        arraySubType = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
//    [activitySubType release];
    [taClass release];
    [arraySubType release];
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
    return [arraySubType count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
      [cell.textLabel setText:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_TYPE_NAME"]];
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [taClass.aTypeButton setTitle:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_TYPE_NAME"] forState:UIControlStateNormal];
    [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_TYPE_NAME"] forKey:@"z.ACTIVITY_TYPE_NAME"];
    [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_TYPE_ID"] forKey:@"z.ACTIVITY_TYPE_ID"];
    [taClass dismissPopover];
//    taClass.selectedActivityType = [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_TYPE_ID"];
}

@end
