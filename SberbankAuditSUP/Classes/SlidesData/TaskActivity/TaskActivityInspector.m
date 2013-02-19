//
//  TaskActivityInspector.m
//  SberbankAudit
//
//  Created by Павел on 02.11.12.
//
//

#import "TaskActivityInspector.h"

@interface TaskActivityInspector ()

@end

@implementation TaskActivityInspector


@synthesize taClass;
@synthesize tbClass;
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
    [tbClass release];
    [arraySubType release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
    //        return YES;
    //    }
    //    return NO;
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
//}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
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
    
//    [cell.textLabel setText:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"]];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@ %@",[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"],[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"FIRST_NAME"],[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"PATRONYMIC"]]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (taClass != nil) {
        [taClass.aInspectorButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"],
                                            [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"FIRST_NAME"],
                                            [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"PATRONYMIC"]] forState:UIControlStateNormal];
        [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"EMPLOYEE_ID"] forKey:@"h.EMPLOYEE_ID"];
        [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"] forKey:@"h.LAST_NAME"];
        [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"FIRST_NAME"] forKey:@"h.FIRST_NAME"];
        [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"PATRONYMIC"] forKey:@"h.PATRONYMIC"];
        [taClass dismissPopover];
    }
    if (tbClass != nil) {
        [tbClass.aInspectorButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"],
                                            [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"FIRST_NAME"],
                                            [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"PATRONYMIC"]] forState:UIControlStateNormal];
        [tbClass.arraySelectActivity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"EMPLOYEE_ID"] forKey:@"h.EMPLOYEE_ID"];
        [tbClass.arraySelectActivity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"] forKey:@"h.LAST_NAME"];
        [tbClass.arraySelectActivity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"FIRST_NAME"] forKey:@"h.FIRST_NAME"];
        [tbClass.arraySelectActivity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"PATRONYMIC"] forKey:@"h.PATRONYMIC"];
        tbClass.INSPECTOR_ID = [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"EMPLOYEE_ID"];

        [tbClass dismissPopover];
    }
}

@end
