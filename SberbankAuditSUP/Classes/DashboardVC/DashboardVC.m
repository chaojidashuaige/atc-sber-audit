//
//  DashboardVC.m
//  SberbankAudit
//
//  Created by Артем Куликов on 11.04.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "DashboardVC.h"
#import "Support.h"
#import "SberbankAuditAppDelegate.h"
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

#import <ifaddrs.h>
#import <arpa/inet.h>

#define expiredAndClosedTaskDef CGRectMake(66,229,237,187)
#define todayTaskDef CGRectMake(392,158,237,187)
#define inPlanTaskDef CGRectMake(722,228,237,187)
#define lastTaskPlaneDef CGRectMake(301,462,428,189)
#define labelsFont 32.0f
#define lastTaskFont 14.0f


@interface DashboardVC ()

@end

@implementation DashboardVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    if (self = [super init])
	{
        //connect to SUP
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dashboardBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ipad_sber_dashboard_1024x768.png"]];
    [self.view addSubview:dashboardBackground];
//    [dashboardBackground release];
    
    mainMapButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"sberLogo.png"];
    [mainMapButton setImage:image forState:UIControlStateNormal];
    [mainMapButton addTarget:self action:@selector(openDashboardMap) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:mainMapButton];
    
    [self filterTasks];
    [self drawLastTask];
    
    ODMobileMBO_getEmployees * currentEmployee = [ODMobileMBO_getEmployees findByPrimaryKey:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].EMPLOYEE_ID]];
    NSLog(@"employeeID = %@",[SberbankAuditAppDelegate instance].EMPLOYEE_ID);
    
    UILabel * user = [[UILabel alloc] initWithFrame:CGRectMake(600, 20, 400, 30)];
    [user setTextAlignment:UITextAlignmentRight];
    [user setText:[NSString stringWithFormat:@"%@ %@ %@",[currentEmployee LAST_NAME],[currentEmployee FIRST_NAME],[currentEmployee PATRONYMIC]]];
    [user setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:user];
    [user release];
    NSLog(@"%@",user.text);

    

}

- (NSString *)GetOurIpAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [dashboardBackground setFrame:CGRectMake(0, 0, 1024, 768)];
//    [mainMapButton setFrame:CGRectMake(65, 655, 55, 55)];
}

- (void) drawLastTask
{
    //Переменные для определения текущего времени в милликсекундах, начиная с 01.01.1970
    NSDate * nowDate = [[NSDate alloc] init];
    long long numberOfSecondsFrom1970 = [nowDate timeIntervalSince1970];
    long long numberOfMillisecsFrom1970 = numberOfSecondsFrom1970 * 1000;
    NSString * str = [NSString stringWithFormat:@"%lld",numberOfMillisecsFrom1970];



    SUPQueryResultSet * currentTask = [ODMobileMBO_getTasks getCurrentTask:str];
    NSLog(@"currentTaskCount = %i",currentTask.size);
    tasksForLastTaskDate = [[NSMutableArray alloc] init];

    if (currentTask.size != 0) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        for (int j = 0; j < currentTask.columnNames.size; j++) {
            if ([[currentTask objectAtIndex:0] objectAtIndex:j] == nil) {
                [dict setObject:@"" forKey:[[currentTask columnNames] objectAtIndex:j]];
            }
            else
            {
                [dict setObject:[[currentTask objectAtIndex:0] objectAtIndex:j] forKey:[[currentTask columnNames] objectAtIndex:j]];
            }
        }
        [dict setObject:@"TASK" forKey:@"TASK_OR_ACTIVITY"];

        [tasksForLastTaskDate addObject:dict];
        [dict release];

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
//        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        
        NSString * strDate = [NSString stringWithFormat:@"%@",[[tasksForLastTaskDate objectAtIndex:0] valueForKey:@"x.PLAN_START_DTTM"]];
        double DOUBLE = [strDate doubleValue]/1000;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
        strDate = [dateFormatter stringFromDate:date];
        
        [dateFormatter release];
        
        planStartDttm = strDate;
        subbranchName = [NSString stringWithFormat:@"%@",[[tasksForLastTaskDate objectAtIndex:0] valueForKey:@"f.SUBBRANCH_NAME"]];
        //    NSLog(@"%@", subbranchName);
        subbranchAddress = [NSString stringWithFormat:@"%@",[[tasksForLastTaskDate objectAtIndex:0] valueForKey:@"f.ADDRESS"]];

    }

    if (planStartDttm == nil) {
        planStartDttm = @"";
    }
    if (subbranchAddress == nil) {
        subbranchAddress = @"";
    }
    if (subbranchName == nil) {
        subbranchName = @"";
    }
    
    
    [currentTask close];
    
    [nowDate release];
    
    UILabel *taskName = [[UILabel alloc] initWithFrame:CGRectMake(320,490,400,30)];
    [taskName setTextAlignment:UITextAlignmentLeft];
    [taskName setFont:[UIFont boldSystemFontOfSize:lastTaskFont]];
    [taskName setText:[NSString stringWithFormat:@"Начало: %@",planStartDttm]];
    [taskName setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:taskName];
    [taskName release];
    
    UILabel *taskAddress = [[UILabel alloc] initWithFrame:CGRectMake(320,510,400,30)];
    [taskAddress setTextAlignment:UITextAlignmentLeft];
    [taskAddress setFont:[UIFont boldSystemFontOfSize:lastTaskFont]];
    [taskAddress setText:[NSString stringWithFormat:@"Адрес: %@",subbranchAddress]];
    [taskAddress setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:taskAddress];
    [taskAddress release];
    
    UILabel *taskContact = [[UILabel alloc] initWithFrame:CGRectMake(320,530,400,30)];
    [taskContact setTextAlignment:UITextAlignmentLeft];
    [taskContact setFont:[UIFont boldSystemFontOfSize:lastTaskFont]];
    [taskContact setText:[NSString stringWithFormat:@"Контакт: %@",subbranchName]];
    [taskContact setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:taskContact];
    [taskContact release];
}

- (void) filterTasks
{
//Завершенные задачи
    SUPQueryResultSet * previousTasks = [ODMobileMBO_getTasks getPreviousTasks];
    previousCount = [previousTasks size];
    closedAndExpiredTasks = [[NSMutableArray alloc] init];
    NSMutableArray * arrayWithSubbrenchesID = [[NSMutableArray alloc] init];
    NSLog(@"%@",previousTasks.columnNames);
//    for (int i = 0; i < previousTasks.size; i++) {
//        NSLog(@"%@\n\n",[previousTasks objectAtIndex:i]);
//    }
    
    if (previousTasks.size != 0) {
        for (int i = 0; i < previousTasks.size; i++) {
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
            for (int j = 0; j < previousTasks.columnNames.size; j++) {
                if ([[previousTasks objectAtIndex:i] objectAtIndex:j] == nil) {
                    [dict setObject:@"" forKey:[[previousTasks columnNames] objectAtIndex:j]];
                }
                else
                {
                    [dict setObject:[[previousTasks objectAtIndex:i] objectAtIndex:j] forKey:[[previousTasks columnNames] objectAtIndex:j]];
                }
            }
            [dict setObject:@"TASK" forKey:@"TASK_OR_ACTIVITY"];
            
            [closedAndExpiredTasks addObject:dict];
            [dict release];
        }

    }
    [previousTasks close];
    [arrayWithSubbrenchesID release];

    
    NSDate * nowDate = [[NSDate alloc] init];
    long long numberOfSecondsFrom1970 = [nowDate timeIntervalSince1970];
    long long numberOfMillisecsFrom1970 = numberOfSecondsFrom1970 * 1000;
    NSString * str = [NSString stringWithFormat:@"%lld",numberOfMillisecsFrom1970];
    NSLog(@"Current time = %@",str);
    
    @try
    {
        //Переменные для определения текущего времени в милликсекундах, начиная с 01.01.1970
//        NSDate * nowDate = [[NSDate alloc] init];
//        long long numberOfSecondsFrom1970 = [nowDate timeIntervalSince1970];
//        long long numberOfMillisecsFrom1970 = numberOfSecondsFrom1970 * 1000;
//        NSString * str = [NSString stringWithFormat:@"%lld",numberOfMillisecsFrom1970];
//        NSLog(@"Current time = %@",str);


        
        //Задачи на сегодня
        SUPQueryResultSet * tasksForToday = [ODMobileMBO_getTasks getTodayTasks:str];
        todayCount = [tasksForToday size];
        todayTasks = [[NSMutableArray alloc] init];
        arrayWithSubbrenchesID = [[NSMutableArray alloc] init];
        if (tasksForToday.size != 0) {
            for (int i = 0; i < tasksForToday.size; i++) {
                NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
                for (int j = 0; j < tasksForToday.columnNames.size; j++) {
                    if ([[tasksForToday objectAtIndex:i] objectAtIndex:j] == nil) {
                        [dict setObject:@"" forKey:[[tasksForToday columnNames] objectAtIndex:j]];
                    }
                    else
                    {
                        [dict setObject:[[tasksForToday objectAtIndex:i] objectAtIndex:j] forKey:[[tasksForToday columnNames] objectAtIndex:j]];
                    }
                }
                [dict setObject:@"TASK" forKey:@"TASK_OR_ACTIVITY"];
                
                [todayTasks addObject:dict];
                [dict release];
            }
            
            
        }
        
        [tasksForToday close];
        [arrayWithSubbrenchesID release];

        
        
        
        //Задачи на будущее
        SUPQueryResultSet * futureTasks = [ODMobileMBO_getTasks getFutureTasks:str];
        futureCount = [futureTasks size];
        inPlanTasks = [[NSMutableArray alloc] init];
        arrayWithSubbrenchesID = [[NSMutableArray alloc] init];
        if (futureTasks.size != 0) {
            for (int i = 0; i < futureTasks.size; i++) {
                NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
                for (int j = 0; j < futureTasks.columnNames.size; j++) {
                    if ([[futureTasks objectAtIndex:i] objectAtIndex:j] == nil) {
                        [dict setObject:@"" forKey:[[futureTasks columnNames] objectAtIndex:j]];
                    }
                    else
                    {
                        [dict setObject:[[futureTasks objectAtIndex:i] objectAtIndex:j] forKey:[[futureTasks columnNames] objectAtIndex:j]];
                    }
                }
                [dict setObject:@"TASK" forKey:@"TASK_OR_ACTIVITY"];
                
                [inPlanTasks addObject:dict];
                [dict release];
            }
            
        }
//        NSLog(@"number of actions = %i",inPlanTasks.count);
        [futureTasks close];
        [arrayWithSubbrenchesID release];
        
        
        NSLog(@"At-Consulting DevLog: TodayTasks finished successfull");
    }
    //exception.h
    @catch (SUPPersistenceException *exception)
    {
        NSLog(@"At-Consulting DevLog: TadayTasks's getting error: %@ - %@",exception.name,exception.message);
    }

    
    [nowDate release];
    
    
    
    UILabel *todayTaskLabel = [[UILabel alloc] initWithFrame:CGRectMake(425,190,160,125)];
    [todayTaskLabel setTextAlignment:UITextAlignmentCenter];
    [todayTaskLabel setFont:[UIFont boldSystemFontOfSize:labelsFont]];
    [todayTaskLabel setText:[NSString stringWithFormat:@"%i",todayCount]];
//    [todayTaskLabel setText:[NSString stringWithFormat:@"%i",previousCount]];
    [todayTaskLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:todayTaskLabel];
    [todayTaskLabel release];
    
    UILabel *inPlanTaskLabel = [[UILabel alloc] initWithFrame:CGRectMake(750,260,160,125)];
    [inPlanTaskLabel setTextAlignment:UITextAlignmentCenter];
    [inPlanTaskLabel setFont:[UIFont boldSystemFontOfSize:labelsFont]];
    [inPlanTaskLabel setText:[NSString stringWithFormat:@"%i",futureCount]];
//    [inPlanTaskLabel setText:[NSString stringWithFormat:@"%i",previousCount]];
    [inPlanTaskLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:inPlanTaskLabel];
    [inPlanTaskLabel release];
    
    UILabel *closedTaskLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,260,160,125)];
    [closedTaskLabel setTextAlignment:UITextAlignmentCenter];
    [closedTaskLabel setFont:[UIFont boldSystemFontOfSize:labelsFont]];
    [closedTaskLabel setText:[NSString stringWithFormat:@"%i",previousCount]];
//    [closedTaskLabel setText:[NSString stringWithFormat:@"%i",previousCount]];
    [closedTaskLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:closedTaskLabel];
    [closedTaskLabel release];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *userTouch = [[event allTouches] anyObject];
    CGPoint touchLocation = [userTouch locationInView:self.view];
    
    if(CGRectContainsPoint(todayTaskDef, touchLocation))
    {
        [self.view removeFromSuperview];
        [[SberbankAuditAppDelegate instance] openTasksVC:todayTasks openTask:nil];
        NSString * typeOfTasks = [[NSString alloc] initWithString:@"TODAY"];
        [SberbankAuditAppDelegate instance].typeOfTasks = typeOfTasks;
        [typeOfTasks release];
    }
    else if(CGRectContainsPoint(inPlanTaskDef, touchLocation))
    {
        [self.view removeFromSuperview];
        [[SberbankAuditAppDelegate instance] openTasksVC:inPlanTasks openTask:nil];
        NSString * typeOfTasks = [[NSString alloc] initWithString:@"INPLAN"];
        [SberbankAuditAppDelegate instance].typeOfTasks = typeOfTasks;
        [typeOfTasks release];
    }
    else if(CGRectContainsPoint(expiredAndClosedTaskDef, touchLocation))
    {
        [self.view removeFromSuperview];
        [[SberbankAuditAppDelegate instance] openTasksVC:closedAndExpiredTasks openTask:nil];
        NSString * typeOfTasks = [[NSString alloc] initWithString:@"CLOSED"];
        [SberbankAuditAppDelegate instance].typeOfTasks = typeOfTasks;
        [typeOfTasks release];
    }
    else if(CGRectContainsPoint(lastTaskPlaneDef, touchLocation))
    {
        [self.view removeFromSuperview];
        [[SberbankAuditAppDelegate instance] openTasksVC:tasksForLastTaskDate openTask:nil];
        NSString * typeOfTasks = [[NSString alloc] initWithString:@"NOW"];
        [SberbankAuditAppDelegate instance].typeOfTasks = typeOfTasks;
        [typeOfTasks release];
    }
    
}

- (void) openDashboardMap
{
    [self.view removeFromSuperview];
    [[SberbankAuditAppDelegate instance] openMapVC];
}


- (void) dealloc
{
    [super dealloc];
    
//    [allTasks release];
    [todayTasks release];
    [inPlanTasks release];
    [closedAndExpiredTasks release];
    [tasksForLastTaskDate release];
    [lastTask release];
//    [mapView release];
    [dashboardBackground release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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

@end
