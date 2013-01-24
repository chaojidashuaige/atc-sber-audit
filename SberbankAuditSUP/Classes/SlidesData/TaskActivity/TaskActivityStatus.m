//
//  TaskActivityStatusViewController.m
//  SberbankAudit
//
//  Created by pnefedov on 16.11.12.
//
//

#import "TaskActivityStatus.h"

@interface TaskActivityStatus ()

@end

@implementation TaskActivityStatus

@synthesize taClass;
@synthesize arraySubType;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.arraySubType = [[NSMutableArray alloc] init];
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

- (void)dealloc
{
    [taClass release];
    [self.arraySubType release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arraySubType count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[[self.arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_STATUS_NAME"]];
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [taClass.aNotesArea setText:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_NAME"]];
    [taClass.aStatusButton setTitle:[NSString stringWithFormat:@"%@",[[self.arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_STATUS_NAME"]] forState:UIControlStateNormal];
    [taClass.arraySelectActivity setObject:[NSString stringWithFormat:@"%@",[[self.arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_STATUS_NAME"]] forKey:@"i.ACTIVITY_STATUS_NAME"];
    taClass.currentStatus =  [[self.arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_STATUS_ID"];
    [taClass.calendarPopover dismissPopoverAnimated:YES];
    [taClass mainLogic];
}

@end
