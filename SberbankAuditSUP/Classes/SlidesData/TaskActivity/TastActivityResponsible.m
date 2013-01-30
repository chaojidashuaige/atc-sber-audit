//
//  TastActivityResponsible.m
//  SberbankAudit
//
//  Created by Павел on 02.11.12.
//
//

#import "TastActivityResponsible.h"

@interface TastActivityResponsible ()

@end

@implementation TastActivityResponsible


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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
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
        [taClass.aResponsibleButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"],
                                              [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"FIRST_NAME"],
                                              [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"PATRONYMIC"]] forState:UIControlStateNormal];
        [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"EMPLOYEE_ID"] forKey:@"d.EMPLOYEE_ID"];
        [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"] forKey:@"d.LAST_NAME"];
        [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"FIRST_NAME"] forKey:@"d.FIRST_NAME"];
        [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"PATRONYMIC"] forKey:@"d.PATRONYMIC"];
        [taClass dismissPopover];
//        aResponsibleButton.enabled = NO;
//        [aResponsibleButton setAlpha:0.5];

        [taClass.aInspectorButton setEnabled:YES];
        [taClass.aInspectorButton setAlpha:1.0];
    }
    if (tbClass != nil) {
        [tbClass.aResponsibleButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"],
                                              [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"FIRST_NAME"],
                                              [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"PATRONYMIC"]] forState:UIControlStateNormal];
        [tbClass.arraySelectActivity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"EMPLOYEE_ID"] forKey:@"d.EMPLOYEE_ID"];
        [tbClass.arraySelectActivity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"] forKey:@"d.LAST_NAME"];
        [tbClass.arraySelectActivity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"FIRST_NAME"] forKey:@"d.FIRST_NAME"];
        [tbClass.arraySelectActivity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"PATRONYMIC"] forKey:@"d.PATRONYMIC"];
        [tbClass dismissPopover];
        tbClass.RESPONSER_ID = [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"EMPLOYEE_ID"];
//        [tbClass.RESPONSER_ID retain];
    }
}

@end
