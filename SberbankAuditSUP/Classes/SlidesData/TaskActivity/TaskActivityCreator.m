//
//  TaskActivityCreator.m
//  SberbankAudit
//
//  Created by Павел on 01.11.12.
//
//

#import "TaskActivityCreator.h"

@interface TaskActivityCreator ()

@end

@implementation TaskActivityCreator

@synthesize taClass;
@synthesize arraySubType;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        arraySubType = [[NSMutableArray alloc] init];
        //        arraySubType = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:
        //
        //                        [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"id",@"Этапы продаж",@"title", nil],
        //                        [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"id",@"Проведение презентаций",@"title", nil],
        //                        [NSDictionary dictionaryWithObjectsAndKeys:@"3",@"id",@"Открытый семинар",@"title", nil],
        //                        [NSDictionary dictionaryWithObjectsAndKeys:@"4",@"id",@"Работа с жалобами",@"title", nil],
        //                        [NSDictionary dictionaryWithObjectsAndKeys:@"5",@"id",@"Размещение плакатов",@"title", nil],
        //                        [NSDictionary dictionaryWithObjectsAndKeys:@"6",@"id",@"Обучение персонала ТСТ",@"title", nil],
        //                        [NSDictionary dictionaryWithObjectsAndKeys:@"7",@"id",@"Решение проблем",@"title", nil],
        //                        [NSDictionary dictionaryWithObjectsAndKeys:@"8",@"id",@"Мотивация",@"title", nil],
        //                        [NSDictionary dictionaryWithObjectsAndKeys:@"9",@"id",@"Постановка целей",@"title", nil],nil]];
        
        //        NSLog(@"%@",arraySubType);
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"]];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [taClass.aNotesArea setText:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"ACTIVITY_NAME"]];
    [taClass.aCreatorButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"],
                                                                            [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"FIRST_NAME"],
                                                                            [[arraySubType objectAtIndex:indexPath.row] objectForKey:@"PATRONYMIC"]] forState:UIControlStateNormal];
    [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"LAST_NAME"] forKey:@"e.LAST_NAME"];
    [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"FIRST_NAME"] forKey:@"e.FIRST_NAME"];
    [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"PATRONYMIC"] forKey:@"e.PATRONYMIC"];
    [taClass.activity setObject:[[arraySubType objectAtIndex:indexPath.row] objectForKey:@"EMPLOYEE_ID"] forKey:@"e.EMPLOYEE_ID"];
    [taClass dismissPopover];
}


@end
