//
//  TaskActivityTemplate.m
//  SberbankAudit
//
//  Created by Павел on 01.11.12.
//
//

#import "TaskActivityTemplate.h"
#import "ODMobileMBO_getActivities.h"
#import "ODMobileMBO_getActivityPriorities.h"
#import "ODMobileMBO_getActivityTypes.h"
#import "ODMobileMBO_getActivityPriorities.h"


@interface TaskActivityTemplate ()

@end

@implementation TaskActivityTemplate

@synthesize taClass;
@synthesize tbClass;
@synthesize arraySubType;
//@synthesize createOrChange;

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
    [tbClass release];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_NAME"]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (taClass != nil) {
        [taClass.aNotesArea setText:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_NAME"]];
        [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_NAME"] forKey:@"x.ACTIVITY_NAME"];
        
        ODMobileMBO_getActivityPriorities * currentPriority = [ODMobileMBO_getActivityPriorities findByPrimaryKey:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_PRIORITY_ID"]];
        NSString * priority = [NSString stringWithFormat:@"%@",[currentPriority ACTIVITY_PRIORITY_NAME]];
        [taClass.activity setObject:priority forKey:@"a.ACTIVITY_PRIORITY_NAME"];
        [taClass.aPriorityButton setTitle:priority forState:UIControlStateNormal];
        
        
        NSString * numberOfDaysStr = [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"TIME_PERIOD"];
        NSLog(@"Number of days: %@",numberOfDaysStr);
        int numberOfDays = [numberOfDaysStr integerValue];
        
        NSDate * now = [NSDate date];
        long long date = [now timeIntervalSince1970];
        date = date + 172800/2*numberOfDays;
        NSLog(@"%lld",date);
        NSString * stringDate = [NSString stringWithFormat:@"%lld000",date];
        [taClass.activity setObject:stringDate forKey:@"x.DUEDATE_DTTM"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];

        NSDate * ddDate = [NSDate dateWithTimeIntervalSince1970:date];
        NSString * str = [dateFormatter stringFromDate:ddDate];
        
        [taClass.aEndDateButton setTitle:str forState:UIControlStateNormal];
        
        [taClass dismissPopover];
    }
    if (tbClass != nil) {
        [tbClass.aNotesText setText:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_NAME"]];
        [tbClass.arraySelectActivity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_NAME"] forKey:@"x.ACTIVITY_NAME"];
        
        ODMobileMBO_getActivityPriorities * currentPriority = [ODMobileMBO_getActivityPriorities findByPrimaryKey:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_PRIORITY_ID"]];
        NSString * priority = [NSString stringWithFormat:@"%@",[currentPriority ACTIVITY_PRIORITY_NAME]];
        [tbClass.arraySelectActivity setObject:priority forKey:@"a.ACTIVITY_PRIORITY_NAME"];
        [tbClass.aPriorityButton setTitle:priority forState:UIControlStateNormal];


        NSString * numberOfDaysStr = [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"TIME_PERIOD"];
        NSLog(@"Number of days: %@",numberOfDaysStr);
        int numberOfDays = [numberOfDaysStr integerValue];
        
        NSDate * now = [NSDate date];
        long long date = [now timeIntervalSince1970];
        date = date + 172800/2*numberOfDays;
        NSLog(@"%lld",date);
        NSString * stringDate = [NSString stringWithFormat:@"%lld000",date];
        [tbClass.arraySelectActivity setObject:stringDate forKey:@"x.DUEDATE_DTTM"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];
        
        NSDate * ddDate = [NSDate dateWithTimeIntervalSince1970:date];
        NSString * str = [dateFormatter stringFromDate:ddDate];
        
        [tbClass.aEndDateButton setTitle:str forState:UIControlStateNormal];

        
        [tbClass dismissPopover];
    }
}

@end
