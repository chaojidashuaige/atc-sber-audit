
#import "DataViewController.h"
#import "SberbankAuditAppDelegate.h"
#import "RootViewController.h"
#import "StackScrollViewController.h"
#import "CheckListViewController.h"
#import "TaskTableViewCell.h"
#import "NSDate+Formatting.h"
#import "DetailTaskSlide.h"
#import "ControlList.h"
#import "Support.h"
#import "TaskPlanCell.h"
#import "TaskActivity.h"
#import "TaskSelectActivity.h"
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
#import "ODMobileMBO_getTaskStatuses.h"

#define TABLE_Y_AXISS 44.0f
#define NUMBER_OF_MILLISEC_IN_A_DAY 86400000
#define MIN_3_DAYS 3*24*60


@implementation DataViewController

@synthesize tweets;
@synthesize _tableView;
@synthesize detailViewController;
//@synthesize typeOfTasks;
//@synthesize SBOpenDetailSlide;
//@synthesize tweetsSUP;

#pragma mark -
#pragma mark View lifecycle

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init])
	{
		formatter = [[NSDateFormatter alloc] init];
		NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
		[formatter setLocale:usLocale]; 
		[usLocale release];
		[formatter setDateStyle:NSDateFormatterLongStyle];
		[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
		
		[formatter setDateFormat: @"EEE MMM dd HH:mm:ss +0000 yyyy"];
		
		[self.view setFrame:frame];
        
        UIImageView *taskBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"task_list_back.png"]];
        [self.view addSubview:taskBack];
        [taskBack release];
        
        tweetsSearch = [[NSMutableArray alloc] init];
        
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(6, TABLE_Y_AXISS, self.view.frame.size.width, self.view.frame.size.height - TABLE_Y_AXISS) style:UITableViewStylePlain];
		[_tableView setDelegate:self];
		[_tableView setDataSource:self];
		_tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		[self.view addSubview:_tableView];
        
        parentTaskSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        for (UIView *subview in parentTaskSearchBar.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [subview removeFromSuperview];
                break;
            }
        }
        parentTaskSearchBar.delegate = self;
        [self.view addSubview:parentTaskSearchBar];
        [parentTaskSearchBar release];
        
        self.tweets = [NSMutableArray arrayWithCapacity:0];
        
        
	}
    return self;
}

#pragma mark - UISearchBarDelegate

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

- (void) searchToTable:(NSString*)sText 
{
    NSMutableArray *firstLevelArray;
    for (int i = 0; i < tweets.count; i++) {
        firstLevelArray = [[self.tweets objectAtIndex:i] valueForKey:@"content"];
        
        for(int task = 0; task < [firstLevelArray count]; task++)
        {
            if ([[firstLevelArray objectAtIndex:task] valueForKey:@"TASK_OR_ACTIVITY"] == @"TASK")

            {
                NSMutableDictionary * dict = [firstLevelArray objectAtIndex:task];
                
                NSRange searchByTaskTypeName = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"y.TASK_TYPE_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
                NSRange searchBySubbranchName = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"f.SUBBRANCH_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
                NSRange searchBySubbranchAddress = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"x.SUBBRANCH_ID"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
                NSRange searchByTaskStatusName = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"b.TASK_STATUS_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
                NSRange searchByCreator = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"x.SELF_CHECK_RESOURCE_FIO"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
                if(searchByTaskTypeName.length > 0 || searchBySubbranchName.length > 0 || searchBySubbranchAddress.length > 0 || searchByTaskStatusName.length > 0 || searchByCreator.length > 0)
                {
                    [tweetsSearch addObject:dict];
                }
            }
            if ([[firstLevelArray objectAtIndex:task] valueForKey:@"TASK_OR_ACTIVITY"] == @"ACTIVITY")

            {
                NSMutableDictionary * dict = [firstLevelArray objectAtIndex:task];
                //                NSMutableDictionary * dict = [[[self.tweets objectAtIndex:date] valueForKey:@"content"] objectAtIndex:task];
                NSRange searchByTaskTypeName = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"b.CATEGORY_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
                NSRange searchBySubbranchName = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"z.ACTIVITY_TYPE_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
                NSRange searchBySubbranchAddress = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"i.ACTIVITY_STATUS_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
                NSRange searchByTaskStatusName = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"x.ACTIVITY_NAME"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
                NSRange searchByCreator = [[NSString stringWithFormat:@"%@",[dict valueForKey:@"x.RESPONSIBLE_DESC"]] rangeOfString:sText options:NSCaseInsensitiveSearch];
                if(searchByTaskTypeName.length > 0 || searchBySubbranchName.length > 0 || searchBySubbranchAddress.length > 0 || searchByTaskStatusName.length > 0 || searchByCreator.length > 0)
                {
                    [tweetsSearch addObject:dict];
                }
            }
        }
    }
    NSLog(@"Count of research = %i", tweetsSearch.count);
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

//    NSLog(@"Type task is %@",[SberbankAuditAppDelegate instance].typeOfTasks);
}

- (void) viewWillAppear:(BOOL)animated
{

    if(isPreviousOpen)
    {
        return;
    }
    else 
    {
        isPreviousOpen = YES;
    }

    [self groupTaskByDate];
//    NSLog(@"Type task is %@",[SberbankAuditAppDelegate instance].typeOfTasks);
//    NSString * str = [self findMaxTaskID];
}

- (void) groupTaskByDate
{
//    NSLog(@"%i",[[[self.tweets objectAtIndex:0] allKeys] count]);
//    NSLog(@"%@",[[self.tweets objectAtIndex:10] allKeys]);
//    NSLog(@"%i",tweets.count);
//    SUPObjectList * allStatuses = [ODMobileMBO_getTaskStatuses findAll];
//    NSLog(@"Статусы:\n%@",allStatuses);
    NSDate * date;
    NSString * str;
    
    NSMutableArray *arrayWithDictionaries = [[NSMutableArray alloc] init];
    NSMutableDictionary *tasksDictionary = [[NSMutableDictionary alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
//    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    
    
    
    for (int i = 0;i < tweets.count;i++)
    {
        
        if ([[self.tweets objectAtIndex:i] objectForKey:@"TASK_OR_ACTIVITY"] == @"TASK") {

            str = [NSString stringWithFormat:@"%@",[[self.tweets objectAtIndex:i] objectForKey:@"x.PLAN_START_DTTM"]];
        }
        else
        {
            str = [NSString stringWithFormat:@"%@",[[self.tweets objectAtIndex:i] objectForKey:@"x.DUEDATE_DTTM"]];
        }
        double DOUBLE = [str doubleValue]/1000;
        date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
        str = [dateFormatter stringFromDate:date];

        NSMutableArray *taskForDate = (NSMutableArray*)[tasksDictionary objectForKey:str];
        if(taskForDate == nil)
            taskForDate = [NSMutableArray arrayWithCapacity:0];
        
        [taskForDate addObject:[self.tweets objectAtIndex:i]];
        [tasksDictionary setObject:taskForDate forKey:str];
    }
    
    NSArray *sortedKeys = [[tasksDictionary allKeys] sortedArrayUsingSelector: @selector(compare:)];
    
    for (NSString *dictKey in sortedKeys)
    {
        [arrayWithDictionaries addObject:[NSDictionary dictionaryWithObjectsAndKeys:dictKey,@"title",[tasksDictionary objectForKey:dictKey],@"content", nil]];
    }
//    [self.tweets release];
    self.tweets = arrayWithDictionaries;

    [tasksDictionary release];
    [arrayWithDictionaries release];
    [dateFormatter release];
}

#pragma mark -
#pragma mark Table view data source

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *customPlane = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 478, 21)] autorelease];
    UILabel *planeTitle = [[UILabel alloc] initWithFrame:CGRectMake(28, 5, customPlane.frame.size.width-28, customPlane.frame.size.height-5)];
    [planeTitle setBackgroundColor:[UIColor clearColor]];
    [planeTitle setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [planeTitle setFrame:CGRectMake(15, 4, planeTitle.frame.size.width, planeTitle.frame.size.height)];
    [planeTitle setTextColor:[UIColor whiteColor]];
    
    [planeTitle setText:(isTaskSearch) ? @"" : [[self.tweets objectAtIndex:section] valueForKey:@"title"]];
    [customPlane addSubview:planeTitle];
    [planeTitle release];
    
    return customPlane;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (isTaskSearch) ? 1 : tweets.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (isTaskSearch) ? tweetsSearch.count : [[[self.tweets objectAtIndex:section] valueForKey:@"content"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id checkClass = (isTaskSearch) ? [tweetsSearch objectAtIndex:indexPath.row] : [[[self.tweets objectAtIndex:indexPath.section] valueForKey:@"content"] objectAtIndex:indexPath.row];
    return  ([checkClass valueForKey:@"TASK_OR_ACTIVITY"] == @"TASK") ? 105.0f : 124.0f;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierActivity = @"ActivityCell";
    static NSString *CellIdentifierTask = @"TaskCell";
    
    id checkClass = (isTaskSearch) ? [tweetsSearch objectAtIndex:indexPath.row] : [[[self.tweets objectAtIndex:indexPath.section] valueForKey:@"content"] objectAtIndex:indexPath.row];
    
    TaskTableViewCell *taskCell;
    TaskPlanCell *activityCell;
    
    if ([checkClass valueForKey:@"TASK_OR_ACTIVITY"] == @"TASK") {
        taskCell = (TaskTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierTask];
        
        if (taskCell == nil) {
            taskCell = [[[TaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierTask] autorelease];
        }

        int indicator = 0;//зеленый
        minLeftToStart = ([[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"x.PLAN_START_DTTM"]] longLongValue] - [[NSDate date] timeIntervalSince1970] * 1000) / (1000 * 60) ;
//        NSLog(@"minLeft = %ld", minLeftToStart);
        if ([[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"b.TASK_STATUS_NAME"]] isEqualToString: @"Выполнена"]) {
            indicator = 0;
        } else if ([[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"b.TASK_STATUS_NAME"]] isEqualToString: @"Не состоялась"]) {
            indicator = 1;
        } else if (minLeftToStart < 0) {
            indicator = 2;
        } else if ((minLeftToStart < MIN_3_DAYS) && (minLeftToStart > 0)) {
            indicator = 1;
        }
        else if (minLeftToStart > MIN_3_DAYS)
        {
            indicator = 0;
        }
        taskCell.taskIndicator.image = [UIImage imageNamed:[NSString stringWithFormat:@"indicator_%i.png",indicator]];
//        [TaskCell.taskTitle setText:[NSString stringWithFormat:@"%@ %@",
//                                     [NSString stringWithFormat:@"%@",[checkClass valueForKey:@"y.TASK_TYPE_NAME"]],
//                                     [NSString stringWithFormat:@"%@",[checkClass valueForKey:@"f.SUBBRANCH_NAME"]]]];
        [taskCell.taskTitle setText:[NSString stringWithFormat:@"%@",
                                     [NSString stringWithFormat:@"%@",[checkClass valueForKey:@"y.TASK_TYPE_NAME"]]]];
//        [TaskCell.taskDescription setText:[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"f.ADDRESS"]]];
        [taskCell.taskDescription setText:[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"f.SUBBRANCH_NAME"]]];
        if (![[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"unions.UNION_NAME"]] isEqualToString:@""]) {
            [taskCell.taskDescription setText:[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"unions.UNION_NAME"]]];
        }
//        [TaskCell.taskDescription setText:[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"f.ADDRESS"]]];
        [taskCell.taskStatus setText:[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"b.TASK_STATUS_NAME"]]];
        
        NSLog(@"%@", NSStringFromClass([[checkClass valueForKey:@"c.LAST_NAME"] class]));
//        id tmp = [checkClass valueForKey:@"c.LAST_NAME"]];
        NSString *fullAuthorName = [NSString stringWithFormat:@"%@%@%@",[checkClass valueForKey:@"c.LAST_NAME"],[checkClass valueForKey:@"c.FIRST_NAME"],[checkClass valueForKey:@"c.PATRONYMIC"]];
//        NSMutableString *fullAuthorName = [[NSMutableString alloc] initWithString:tmpFullAuthorName];
//        [fullAuthorName appendString:[checkClass valueForKey:@"c.LAST_NAME"]];
//        [fullAuthorName appendString:[checkClass valueForKey:@"c.FIRST_NAME"]];
//        [fullAuthorName appendString:[checkClass valueForKey:@"c.PATRONYMIC"]];
        
        fullAuthorName = [fullAuthorName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if(fullAuthorName.length == 0)
        {
            [taskCell.taskInspector setText:@"Запланировано системой"];
        }
        else
        {
            [taskCell.taskInspector setText:[NSString stringWithFormat:@"%@ %@ %@",[checkClass valueForKey:@"c.LAST_NAME"],[checkClass valueForKey:@"c.FIRST_NAME"],[checkClass valueForKey:@"c.PATRONYMIC"]]];
        }
        
        
//        [fullAuthorName release];
//        NSLog(@"%@",[checkClass valueForKey:@"b.TASK_STATUS_NAME"]);
        
        NSDate * date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        NSString * str = [NSString stringWithFormat:@"%@",[checkClass valueForKey:@"x.PLAN_START_DTTM"]];
        double DOUBLE = [str doubleValue]/1000;
        date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
        str = [dateFormatter stringFromDate:date];
        
        [dateFormatter release];
        
        [taskCell.taskTime setText:str];
        return taskCell;
    }
//    else if ([checkClass valueForKey:@"TASK_OR_ACTIVITY"] == @"ACTIVITY") {
    else {
    
        activityCell = (TaskPlanCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActivity];
        if (activityCell == nil) {
            activityCell = [[[TaskPlanCell alloc] initWithStyle:UITableViewCellStyleDefault isHeader:NO reuseIdentifier:CellIdentifierActivity] autorelease];
        }
//        [activityCell setFrameWithHeader:NO];
        
        int indicator = 0;//зеленый
        minLeftToFinish = ([[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"x.DUEDATE_DTTM"]] longLongValue] - [[NSDate date] timeIntervalSince1970] * 1000) / (1000 * 60) ;
//        NSLog(@"minLeft = %ld", minLeftToFinish);
        NSString * status = [NSString stringWithFormat:@"%@",[checkClass valueForKey:@"b.TASK_STATUS_NAME"]];
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
        
        [activityCell.taskTitle setText:[NSString stringWithFormat:@"%@,%@",[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"b.CATEGORY_NAME"]],[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"z.ACTIVITY_TYPE_NAME"]]]];
        activityCell.taskIndicator.image = [UIImage imageNamed:[NSString stringWithFormat:@"indicator_%i.png",indicator]];
        [activityCell.taskStatus setText:[NSString stringWithFormat:@"Статус: %@",[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"i.ACTIVITY_STATUS_NAME"]]]];
        
        NSDate * date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
        [dateFormatter setDateFormat:@"HH:mm"];
//        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];

        NSString * str = [NSString stringWithFormat:@"%@",[checkClass valueForKey:@"x.DUEDATE_DTTM"]];
        double DOUBLE = [str doubleValue]/1000;
        date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
        str = [dateFormatter stringFromDate:date];
        
        [dateFormatter release];

        [activityCell.taskDate setText:
         [NSString stringWithFormat:@"Выполнить до: %@",
          [NSString stringWithFormat:@"%@",str]]];
        [activityCell.taskDescription setText:[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"x.ACTIVITY_NAME"]]];
        [activityCell.taskResponsible setText:[NSString stringWithFormat:@"Ответственный: %@ %@ %@",[checkClass valueForKey:@"d.LAST_NAME"],[checkClass valueForKey:@"d.FIRST_NAME"],[checkClass valueForKey:@"d.PATRONYMIC"]]];
//        [activityCell.taskResponsible setText:[NSString stringWithFormat:@"Ответственный: %@",[NSString stringWithFormat:@"%@",[checkClass valueForKey:@"x.RESPONSIBLE_DESC"]]]];
        return activityCell;
    }
    
//    return ([checkClass valueForKey:@"TASK_OR_ACTIVITY"] == @"TASK") ? TaskCell : activityCell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 21;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *checkClass = (isTaskSearch) ? [tweetsSearch objectAtIndex:indexPath.row] : [[[self.tweets objectAtIndex:indexPath.section] valueForKey:@"content"] objectAtIndex:indexPath.row];
    
    NSMutableDictionary *dataArray = [[NSMutableDictionary alloc] initWithDictionary:checkClass];
    
    if([checkClass valueForKey:@"TASK_OR_ACTIVITY"] == @"TASK")
    {
//        CheckListViewController * checkList = [[CheckListViewController alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
//        [[SberbankAuditAppDelegate instance].rootViewController.stackScrollViewController addViewInSlider:checkList drawShadow:YES invokeByController:self isStackStartView:NO];
//        [checkList release];

        detailViewController = [[DetailTaskSlide alloc] initWithFrame:CGRectMake(0, 0, 477, 755)];
//        detailViewController = [[DetailTaskSlide alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
        detailViewController.taskData = checkClass;
        [[SberbankAuditAppDelegate instance].rootViewController.stackScrollViewController addViewInSlider:detailViewController drawShadow:YES invokeByController:self isStackStartView:NO];
        NSLog(@"TASK_ID_ = %@", [checkClass valueForKey:@"x.TASK_ID"]);

    }
//    else if([checkClass valueForKey:@"TASK_OR_ACTIVITY"] == @"ACTIVITY")
//    {
//        
//    }
    else if([checkClass valueForKey:@"TASK_OR_ACTIVITY"] == @"ACTIVITY")
    {
        TaskSelectActivity *selectActivity = [[TaskSelectActivity alloc] initWithFrame:CGRectMake(0, 0, 504, 678)];
//        selectActivity.taskPlan =  [self retain];
        selectActivity.taskPlan =  self;
        selectActivity.arraySelectActivity = checkClass;
        selectActivity.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentModalViewController:selectActivity animated:YES];
        [[selectActivity.view superview] setFrame:CGRectMake(roundf([selectActivity.view superview].center.x-252), roundf([selectActivity.view superview].center.y-339), 504, 678)];
        [selectActivity release];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    [dataArray release];

}

- (void) updateData
{
    NSLog(@"UpdateData function is called");
    NSDate * nowDate = [[NSDate alloc] init];
    long long numberOfSecondsFrom1970 = [nowDate timeIntervalSince1970];
    [nowDate release];
    long long numberOfMillisecsFrom1970 = (numberOfSecondsFrom1970 + 1) * 1000;
    NSString * str = [NSString stringWithFormat:@"%lld",numberOfMillisecsFrom1970];
//    NSLog(@"Current time = %@",str);

    NSLog(@"Type of tasks: %@",[SberbankAuditAppDelegate instance].typeOfTasks);
    
    SUPQueryResultSet * tasks = nil;
    if ([[SberbankAuditAppDelegate instance].typeOfTasks isEqualToString:@"TODAY"]) {
        tasks = [ODMobileMBO_getTasks getTodayTasks:str];
    } else if ([[SberbankAuditAppDelegate instance].typeOfTasks isEqualToString:@"INPLAN"]) {
        tasks = [ODMobileMBO_getTasks getFutureTasks:str];
    } else if ([[SberbankAuditAppDelegate instance].typeOfTasks isEqualToString:@"CLOSED"]){
        tasks = [ODMobileMBO_getTasks getPreviousTasks];
    } else if ([[SberbankAuditAppDelegate instance].typeOfTasks isEqualToString:@"NOW"]){
        tasks = [ODMobileMBO_getTasks getCurrentTask:str];
    }
    NSMutableArray * array = [[NSMutableArray alloc]  init];
    NSMutableArray * arrayWithSubbrenchesID = [[NSMutableArray alloc] init];
    if (tasks.size != 0) {
        for (int i = 0; i < tasks.size; i++) {
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
            for (int j = 0; j < tasks.columnNames.size; j++) {
                if ([[tasks objectAtIndex:i] objectAtIndex:j] == nil) {
                    [dict setObject:@"" forKey:[[tasks columnNames] objectAtIndex:j]];
                }
                else
                {
                    [dict setObject:[[tasks objectAtIndex:i] objectAtIndex:j] forKey:[[tasks columnNames] objectAtIndex:j]];
                }
            }
            [dict setObject:@"TASK" forKey:@"TASK_OR_ACTIVITY"];
            
            [array addObject:dict];
            [dict release];
        }
    }
    NSLog(@"number of actions = %i",array.count);
    [tasks close];
    [arrayWithSubbrenchesID release];
    NSLog(@"self.tweets count before save = %i",tweets.count);

    
    [self.tweets removeAllObjects];
    self.tweets = array;
    NSLog(@"number of actions = %i",tweets.count);
    [array release];
    
    [self groupTaskByDate];
    NSLog(@"self.tweets count after save = %i",tweets.count);
    
    [_tableView reloadData];
}

- (NSString*) findMaxTaskID
{
    NSLog(@"findMaxTaskID function is called");
    NSDate * nowDate = [[NSDate alloc] init];
    long long numberOfSecondsFrom1970 = [nowDate timeIntervalSince1970];
    [nowDate release];
    long long numberOfMillisecsFrom1970 = numberOfSecondsFrom1970 * 1000;
    NSString * str = [NSString stringWithFormat:@"%lld",numberOfMillisecsFrom1970];
    //    NSLog(@"Current time = %@",str);
    
    NSLog(@"Type of tasks: %@",[SberbankAuditAppDelegate instance].typeOfTasks);
    
    SUPQueryResultSet * tasks = nil;
    if ([[SberbankAuditAppDelegate instance].typeOfTasks isEqualToString:@"TODAY"]) {
        tasks = [ODMobileMBO_getTasks getTodayTasks:str];
    } else if ([[SberbankAuditAppDelegate instance].typeOfTasks isEqualToString:@"INPLAN"]) {
        tasks = [ODMobileMBO_getTasks getFutureTasks:str];
    } else if ([[SberbankAuditAppDelegate instance].typeOfTasks isEqualToString:@"CLOSED"]){
        tasks = [ODMobileMBO_getTasks getPreviousTasks];
    } else if ([[SberbankAuditAppDelegate instance].typeOfTasks isEqualToString:@"NOW"]){
        tasks = [ODMobileMBO_getTasks getCurrentTask:str];
    }
    NSString * lastTaskID = nil;
    if (tasks.size > 0) {
        lastTaskID = [NSString stringWithFormat:@"%@",[[tasks objectAtIndex:0] objectForKey:@"x.TASK_ID"]];
        NSLog(@"%@",lastTaskID);
        for (int i = 1; i < tasks.size; i++) {
            NSString * curTaskID = [NSString stringWithFormat:@"%@",[[tasks objectAtIndex:i] objectForKey:@"x.TASK_ID"]];
            NSLog(@"%@",curTaskID);
            if ([lastTaskID doubleValue] < [curTaskID doubleValue]) {
                lastTaskID = curTaskID;
            }
        }
    }

    return lastTaskID;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
	[formatter release];
	self.tweets = nil;
    [_tableView release];
//    [SBOpenDetailSlide release];
    [userActivities release];
    [activitiesDictionary release];
    [tweetsSearch release];
    [parentTaskSearchBar release];
    [detailViewController release];
//    [typeOfTasks release];
    [super dealloc];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return YES;
//}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    _tableView.frame = CGRectMake(6, TABLE_Y_AXISS, self.view.frame.size.width, self.view.frame.size.height - TABLE_Y_AXISS);
//    if (UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
//        detailViewController.view.frame =  CGRectMake(0, 0, 477, 768-40);
//    }
//
//    [detailViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    //    return UIInterfaceOrientationMaskAll;
//    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationLandscapeLeft;
//}



@end