//
//  TaskPlan.m
//  SberbankAudit
//
//  Created by Artem Koulikov on 29.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaskPlan.h"
#import "TaskPlanCell.h"
#import "TaskActivity.h"
#import "TaskSelectActivity.h"
#import "TaskPlanButtonCell.h"
#import "SUPApplication.h"
#import "SUPConnectionProfile.h"
//#import "SUPWrongDataTypeException.h"
//#import "SUPNoSuchOperationException.h"
//#import "SUPNoSuchAttributeException.h"
//#import "SUPTooManyResultsException.h"
//#import "SUPObjectNotFoundException.h"
//#import "SUPNoSuchClassException.h"
#import "ODMobileODMobileDB.h"
#import "ODMobileMBO_getTasks.h"
#import "ODMobileMBO_getSubbranches.h"
#import "ODMobileMBO_getChecklists.h"
#import "ODMobileMBO_getTasksSynchronizationParameters.h"
#import "ODMobileMBO_getActivities.h"
#import "ODMobileMBO_getActivitiesSynchronizationParameters.h"
#import "ODMobileMBO_getSubbranchesSynchronizationParameters.h"
#import "ODMobileMBOTaskTypesPriv.h"
#import "ODMobileMBOTaskTypesPrivSynchronizationParameters.h"
#import "ODMobileMBO_Logon.h"
#import "ODMobileMBO_getEmployees.h"
#import "SberbankAuditAppDelegate.h"
#import "RootViewController.h"
#import "DataViewController.h"
#import "WaitingViewController.h"

#define TABLE_Y_AXISS 46.0f
#define MIN_3_DAYS 3*24*60


@implementation TaskPlan

@synthesize branchId;
@synthesize tweets;
@synthesize allKeys;
@synthesize taskID;
@synthesize _tableView;
@synthesize employee_ID;
@synthesize unionID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init])
	{
        [self.view setFrame:frame];
        
        UIImageView *taskBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"task_list_back.png"]];
        [self.view addSubview:taskBack];
        [taskBack release];
        
        
        branchId = [[NSNumber alloc] init];
        unionID = [[NSNumber alloc] init];
        
        tweets = [[NSMutableArray alloc] init];

        tweetsSearch = [[NSMutableArray alloc] init];
        
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(6, TABLE_Y_AXISS, 464, self.view.frame.size.height - TABLE_Y_AXISS) style:UITableViewStylePlain];
		[_tableView setDelegate:self];
		[_tableView setDataSource:self];
		_tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		[self.view addSubview:_tableView];
        
        UISearchBar *parentTaskSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        for (UIView *subview in parentTaskSearchBar.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [subview removeFromSuperview];
                break;
            }
        }
        parentTaskSearchBar.delegate = self;
        [self.view addSubview:parentTaskSearchBar];
        [parentTaskSearchBar release];
        

	}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    if ([[NSString stringWithFormat:@"%@",branchId] isEqualToString:@"0"]) {
        NSLog(@"branch is not defined");
    }
    NSLog(@"union = %@", unionID);
    NSLog(@"branch = %@", branchId);
//    tweets = [[NSMutableArray alloc] init];
    
    [tweets release];
    tweets = [[NSMutableArray alloc] init];
    
    SUPQueryResultSet * activities = [ODMobileMBO_getActivities getActivitiesBySubbranchId:[NSString stringWithFormat:@"%@",branchId]];
    for (int i = 0; i < activities.size; i++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        for (int j = 0; j < activities.columnNames.size; j++) {
            if ([[activities objectAtIndex:i] objectAtIndex:j] == nil) {
                [dict setObject:@"" forKey:[[activities columnNames] objectAtIndex:j]];
            }
            else
            {
                [dict setObject:[[activities objectAtIndex:i] objectAtIndex:j] forKey:[[activities columnNames] objectAtIndex:j]];
            }
        }
        [dict setObject:@"ACTIVITY" forKey:@"TASK_OR_ACTIVITY"];
        
        [tweets addObject:dict];
        [dict release];
    }
    
    for (int i = 0; i < activities.columnNames.size; i++) {
        [allKeys addObject:[[activities columnNames] objectAtIndex:i]];
    }
    
//    NSLog(@"Number of activities = %i",[activities size]);
    [activities close];
    
    activities = [ODMobileMBO_getActivities getActivitiesBySubbranchId:[NSString stringWithFormat:@"%@",unionID]];
    for (int i = 0; i < activities.size; i++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        for (int j = 0; j < activities.columnNames.size; j++) {
            if ([[activities objectAtIndex:i] objectAtIndex:j] == nil) {
                [dict setObject:@"" forKey:[[activities columnNames] objectAtIndex:j]];
            }
            else
            {
                [dict setObject:[[activities objectAtIndex:i] objectAtIndex:j] forKey:[[activities columnNames] objectAtIndex:j]];
            }
        }
        [dict setObject:@"ACTIVITY" forKey:@"TASK_OR_ACTIVITY"];
        
        [tweets addObject:dict];
        [dict release];
    }
    
    NSLog(@"Number of activities = %i",tweets.count);
    [activities close];
//    [_tableView reloadData];

}

- (void) updateData
{
    [tweets release];
    tweets = [[NSMutableArray alloc] init];
    
    SUPQueryResultSet * activities = [ODMobileMBO_getActivities getActivitiesBySubbranchId:[NSString stringWithFormat:@"%@",branchId]];
    for (int i = 0; i < activities.size; i++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        for (int j = 0; j < activities.columnNames.size; j++) {
            if ([[activities objectAtIndex:i] objectAtIndex:j] == nil) {
                [dict setObject:@"" forKey:[[activities columnNames] objectAtIndex:j]];
            }
            else
            {
                [dict setObject:[[activities objectAtIndex:i] objectAtIndex:j] forKey:[[activities columnNames] objectAtIndex:j]];
            }
        }
        [dict setObject:@"ACTIVITY" forKey:@"TASK_OR_ACTIVITY"];
        
        [tweets addObject:dict];
        [dict release];
    }
    
    for (int i = 0; i < activities.columnNames.size; i++) {
        [allKeys addObject:[[activities columnNames] objectAtIndex:i]];
    }
    
//    NSLog(@"Number of activities = %i",[activities size]);
    [activities close];
    
    activities = [ODMobileMBO_getActivities getActivitiesBySubbranchId:[NSString stringWithFormat:@"%@",unionID]];
    for (int i = 0; i < activities.size; i++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        for (int j = 0; j < activities.columnNames.size; j++) {
            if ([[activities objectAtIndex:i] objectAtIndex:j] == nil) {
                [dict setObject:@"" forKey:[[activities columnNames] objectAtIndex:j]];
            }
            else
            {
                [dict setObject:[[activities objectAtIndex:i] objectAtIndex:j] forKey:[[activities columnNames] objectAtIndex:j]];
            }
        }
        [dict setObject:@"ACTIVITY" forKey:@"TASK_OR_ACTIVITY"];
        
        [tweets addObject:dict];
        [dict release];
    }
    
    for (int i = 0; i < activities.columnNames.size; i++) {
        [allKeys addObject:[[activities columnNames] objectAtIndex:i]];
    }
    
    NSLog(@"Number of activities = %i",tweets.count);
    [activities close];
    [_tableView reloadData];
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText 
{
    [tweetsSearch removeAllObjects];
    
    if([searchText length] > 0) 
    {
        isTaskSearch = YES;
        [self searchToTable:searchText];
    }
    else 
    {
        isTaskSearch = NO;
    }
    
    [_tableView reloadData];
}


- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar 
{
    [self searchToTable:theSearchBar.text];
}

- (void) searchToTable:(NSString*)sText 
{
    for(int counter = 0;counter<tweets.count;counter++)
    {
        NSMutableDictionary * dict = [tweets objectAtIndex:counter];
        
        NSDate * date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];
        
        NSString * str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"x.DUEDATE_DTTM"]];
        double DOUBLE = [str doubleValue]/1000;
        date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
        str = [dateFormatter stringFromDate:date];
        [dateFormatter release];
        NSRange searchByDate = [str rangeOfString:sText options:NSCaseInsensitiveSearch];

        
        NSRange searchByLastName = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"d.LAST_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
        NSRange searchByFirstName = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"d.FIRST_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
        NSRange searchByPatronymic = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"d.PATRONYMIC"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
        NSRange searchByActTypeCatName = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"b.CATEGORY_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
        NSRange searchByActTypename = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"z.ACTIVITY_TYPE_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
        NSRange searchByActStatusName = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"i.ACTIVITY_STATUS_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
        NSRange searchByActName = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"x.ACTIVITY_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
        
        if(searchByActTypeCatName.length > 0 || searchByActTypename.length > 0 || searchByActStatusName.length > 0 || searchByActName.length > 0 || searchByDate.length > 0 || searchByLastName.length > 0 || searchByFirstName.length > 0 || searchByPatronymic.length > 0)
        {
            [tweetsSearch addObject:dict];
        }
    }
    
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (isTaskSearch) ? [tweetsSearch count]+1 : [tweets count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//	return (indexPath.row == 0) ? 45.0f : 124.0f;
	return (indexPath.row == 0) ? 65.0f : 124.0f;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifierTakPaln.m";
    static NSString *ButtonIdentifier = @"ButtonIdentifierTakPaln.m";
    
    TaskPlanButtonCell * buttonCell;
    TaskPlanCell *cell;

    

    
    if (indexPath.row == 0) {
        buttonCell = (TaskPlanButtonCell *)[tableView dequeueReusableCellWithIdentifier:ButtonIdentifier];
        if (buttonCell == nil) {
            buttonCell = [[[TaskPlanButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ButtonIdentifier] autorelease];
        }
        [buttonCell.createTp addTarget:self action:@selector(openActivityEdit) forControlEvents:UIControlEventTouchUpInside];
        [buttonCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return buttonCell;
    } else {
        cell = (TaskPlanCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[TaskPlanCell alloc] initWithStyle:UITableViewCellStyleDefault isHeader:NO reuseIdentifier:CellIdentifier] autorelease];
        }
        
        NSMutableDictionary *planData = (isTaskSearch) ? [tweetsSearch objectAtIndex:indexPath.row-1] : [tweets objectAtIndex:indexPath.row-1];
        
        int indicator = 0;//зеленый
        minLeftToFinish = ([[NSString stringWithFormat:@"%@",[planData valueForKey:@"x.DUEDATE_DTTM"]] longLongValue] - [[NSDate date] timeIntervalSince1970] * 1000) / (1000 * 60) ;
        //        NSLog(@"minLeft = %ld", minLeftToFinish);
        NSString * status = [NSString stringWithFormat:@"%@",[planData valueForKey:@"b.TASK_STATUS_NAME"]];
        if (([status isEqualToString: @"Закрыто"]) || ([status isEqualToString: @"Исполнено"])){
            indicator = 0;
        } else if (([status isEqualToString: @"Назначено"]) && (minLeftToFinish < 0)) {
            indicator = 1;
        } else if (minLeftToFinish < 0) {
            indicator = 2;
        } else if ((minLeftToFinish < MIN_3_DAYS) && (minLeftToFinish > 0)) {
            indicator = 1;
        }
        else if (minLeftToFinish > MIN_3_DAYS)
        {
            indicator = 0;
        }
        
        [cell.taskTitle setText:[NSString stringWithFormat:@"%@,%@",[planData valueForKey:@"b.CATEGORY_NAME"],[planData valueForKey:@"z.ACTIVITY_TYPE_NAME"]]];
        cell.taskIndicator.image = [UIImage imageNamed:[NSString stringWithFormat:@"indicator_%i.png",indicator]];
        [cell.taskStatus setText:[NSString stringWithFormat:@"Статус: %@",[planData valueForKey:@"i.ACTIVITY_STATUS_NAME"]]];
        
        NSDate * date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];
        //        [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
        //        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        
        NSString * str = [NSString stringWithFormat:@"%@",[planData valueForKey:@"x.DUEDATE_DTTM"]];
        double DOUBLE = [str doubleValue]/1000;
        date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
        str = [dateFormatter stringFromDate:date];
        [dateFormatter release];
        
        [cell.taskDate setText:[NSString stringWithFormat:@"Выполнить до: %@",[NSString stringWithFormat:@"%@",str]]];
        
        [cell.taskDescription setText:[NSString stringWithFormat:@"%@",[planData valueForKey:@"x.ACTIVITY_NAME"]]];
        
        [cell.taskResponsible setText:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"Ответственный: %@ %@ %@",[planData valueForKey:@"d.LAST_NAME"],[planData valueForKey:@"d.FIRST_NAME"],[planData valueForKey:@"d.PATRONYMIC"]]]];
        return  cell;
    }
    
//    return (indexPath.row == 0) ? buttonCell : cell;
}


- (void) openActivityEdit
{
    if (tmpTaskActivity == nil) {
        TaskActivity *activity = [[TaskActivity alloc] initWithFrame:CGRectMake(0, 0, 704, 678)];
        //    activity.taskPlan = [self retain];//добавил для ввода нового мероприятия
        activity.taskPlan = self;
        activity.SUBBRANCH_ID = branchId;
        activity.UNION_ID = unionID;
        NSLog(@" branch %@",activity.SUBBRANCH_ID);
        
        //    [self openActivityIndicatorViewWithName:@"Идет выборка данных"];
        //    [activity createListOfResponsibles];
        //    [self closeActivityIndicator];
        
        activity.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentModalViewController:activity animated:YES];
        //    [[activity.view superview] setFrame:CGRectMake(roundf([activity.view superview].center.x-252), roundf([activity.view superview].center.y-339), 504, 678)];
        [[activity.view superview] setFrame:CGRectMake(roundf([activity.view superview].center.x-352), roundf([activity.view superview].center.y-339), 704, 678)];
        tmpTaskActivity = [activity retain];
        [activity release];
    } 
}

- (void) openCamera
{
    [self dismissModalViewControllerAnimated:NO];
    UIImagePickerController *photoCamera = [[UIImagePickerController alloc] init];
    //    CameraViewController *photoCamera = [[CameraViewController alloc] init];
    photoCamera.delegate = self;
    photoCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
    //    [self presentModalViewController:photoCamera animated:YES];
    [[SberbankAuditAppDelegate instance].rootViewController presentModalViewController:photoCamera animated:YES];
    [photoCamera release];
    //    [[photoCamera.view superview] setFrame:CGRectMake(roundf([photoCamera.view superview].center.x-512), roundf([photoCamera.view superview].center.y-384), 1024, 768)];
    
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:NO];
    [tmpTaskActivity saveButtonCameraAction:info];
    [self presentModalViewController:tmpTaskActivity animated:YES];
    [[tmpTaskActivity.view superview] setFrame:CGRectMake(roundf([tmpTaskActivity.view superview].center.x-352), roundf([tmpTaskActivity.view superview].center.y-339), 704, 678)];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:NO];
    [self presentModalViewController:tmpTaskActivity animated:YES];
    [[tmpTaskActivity.view superview] setFrame:CGRectMake(roundf([tmpTaskActivity.view superview].center.x-352), roundf([tmpTaskActivity.view superview].center.y-339), 704, 678)];
}

- (void)removeTmpTaskActivity
{
    if (tmpTaskActivity != nil) {
        [tmpTaskActivity release];
        tmpTaskActivity = nil;
    }
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) {
        TaskSelectActivity *selectActivity = [[TaskSelectActivity alloc] initWithFrame:CGRectMake(0, 0, 504+200, 678)];
        selectActivity.taskPlan = self;
        selectActivity.arraySelectActivity = (isTaskSearch) ? [tweetsSearch objectAtIndex:indexPath.row-1] : [tweets objectAtIndex:indexPath.row-1];
//        NSLog(@"Статус в tweets = %@",[[tweets objectAtIndex:indexPath.row-1] valueForKey:@"i.ACTIVITY_STATUS_NAME"]);
        NSLog(@"Activity_ID %@",[selectActivity.arraySelectActivity valueForKey:@"x.ACTIVITY_ID"]);
        selectActivity.modalPresentationStyle = UIModalPresentationFormSheet;
        [[SberbankAuditAppDelegate instance].rootViewController presentModalViewController:selectActivity animated:YES];
        [[selectActivity.view superview] setFrame:CGRectMake(roundf([selectActivity.view superview].center.x-352), roundf([selectActivity.view superview].center.y-339), 704, 678)];
//        [[selectActivity.view superview] setFrame:CGRectMake(roundf([selectActivity.view superview].center.x-252), roundf([selectActivity.view superview].center.y-339), 504, 678)];
        [selectActivity release];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }

}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) dealloc
{
    [tweets release];
    [_tableView release];
    [branchId release];
    [unionID release];
    [tweetsSearch release];
    [allKeys release];
    [taskID release];
    [employee_ID release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_tableView setFrame:CGRectMake(6, TABLE_Y_AXISS, 464, self.view.frame.size.height)];
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
//    return UIInterfaceOrientationMaskAll;
//}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

@end
