//
//  DetailTaskSlide.m
//  SberbankAudit
//
//  Created by Артем Куликов on 28.02.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "DetailTaskSlide.h"
#import "TaskPlan.h"
#import "SberbankAuditAppDelegate.h"
#import "StackScrollViewController.h"
#import "RootViewController.h"
#import "MenuViewController.h"
#import "ControlList.h"
#import "Support.h"
#import "DataViewController.h"
#import "ODMobileMBO_getTasks.h"
#import "ODMobileMBO_getTaskStatuses.h"
#import "ODMobileObjField.h"
#import "ODMobileOdObject.h"
#import "ODMobileMBO_getTaskTypes.h"
#import "ODMobileMBOVisitTypes.h"
#import "ODMobileMBOTaskBlockMetrics.h"
#import "TaskBlockMetrickUtils.h"
#import "Metric.h"
#import "MetricsBlock.h"
#import "CheckListViewController.h"

#define VT_QUALITY_CHECKUP  @"VT_QUALITY_CHECKUP"
#define VT_QUALITY_CONTROL  @"VT_QUALITY_CONTROL"
#define VT_AUDIT            @"VT_AUDIT"
#define VT_GEMBA            @"VT_GEMBA"
#define VT_SELF             @"VT_SELF"

#define RESULT_KEY              @"M_RESULT"
#define DISPERSION_KEY          @"M_DISPERSION"
#define REDUCE_INDEX_KEY        @"M_REDUCE_INDEX"
#define DISPERSED_RESULT_KEY    @"M_DISPERSED_RESULT"


@implementation DetailTaskSlide

@synthesize taskData;
@synthesize cancelButton;
//@synthesize controlList;
@synthesize currentTaskID;
@synthesize detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(6+4, 329, 464-10, 154+30)];
        _scroll.showsVerticalScrollIndicator = YES;
        _scroll.scrollEnabled = YES;
        _scroll.userInteractionEnabled = YES;
        _scroll.contentSize = CGSizeMake(456, 900);
        _scroll.delegate = self;
//        [_scroll setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
        
        underNoteAnketaDesc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anketa_desc-02.png"]];
        [underNoteAnketaDesc setFrame:CGRectMake(6, 329, 464, 154+30)];

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init])
	{
        [self.view setFrame:frame];
        
        UIImageView *detailBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_space_back.png"]];
        [self.view addSubview:detailBack];
        [detailBack release];
        
        UIImageView *mainNoteTextHeader = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notetext_header.png"]];
        [mainNoteTextHeader setFrame:CGRectMake(6, 483+30, 464, 28)];
        [self.view addSubview:mainNoteTextHeader];
        [mainNoteTextHeader release];
        
        noteTextFooter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notetext_footer.png"]];
        [noteTextFooter setFrame:CGRectMake(6, self.view.frame.size.height-27, 464, 22)];
        [self.view addSubview:noteTextFooter];
    
        noteTextBody = [[UIView alloc] initWithFrame:CGRectMake(6, 511+30, 464, noteTextFooter.frame.origin.y-511-30)];
        [noteTextBody setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"notetext_body.png"]]];
        [self.view addSubview:noteTextBody];
        
        noteTextEditor = [[UITextView alloc] initWithFrame:CGRectMake(24, 511+30, 427, noteTextBody.frame.size.height - 40)];
        [noteTextEditor setBackgroundColor:[UIColor clearColor]];
        noteTextEditor.delegate = self;
//        [noteTextEditor setUserInteractionEnabled:NO];
        [self.view addSubview:noteTextEditor];
        
        saveButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
//        [saveButton setFrame:CGRectMake(192 - 15, noteTextEditor.frame.origin.y + noteTextEditor.frame.size.height + 5, 120, 30)];CGRectMake(355, taskTime.frame.origin.y - 35, 100, 25)
        [saveButton setFrame:CGRectMake(345 - 3, noteTextEditor.frame.origin.y + noteTextEditor.frame.size.height + 5 + 10, 100, 25)];
        [saveButton setTitle:@"Сохранить" forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(saveNotes) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:saveButton];

	}
    return self;
}

- (void)saveNotes
{
//    [saveButton setBackgroundColor:[UIColor redColor]];
    
    [[SberbankAuditAppDelegate instance] openActivityIndicatorViewWithName:@"Синхронизация данных"];
    
    NSLog(@"SaveTask method called");
    @try {
        SUPObjectList * fieldList = [SUPObjectList new];
        ODMobileMBO_getTasks * updateTask = [ODMobileMBO_getTasks findByPrimaryKey:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]]];
        
        
        //TASK_ID
        ODMobileObjField * field1 = [ODMobileObjField new];
        [field1 setNm:@"TASK_ID"];
        [field1 setVl:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]]];
        [fieldList add:field1];
        NSLog(@"name = %@, value =%@",field1.nm, field1.vl);
        [field1 release];
        
        
        //TASK_DESC
        ODMobileObjField * field3 = [ODMobileObjField new];
        [field3 setNm:@"TASK_DESC"];
        [field3 setVl:noteTextEditor.text];
        [fieldList add:field3];
        NSLog(@"name = %@, value =%@",field3.nm, field3.vl);
        [field3 release];
        
        
        //USER_LOGIN
        ODMobileObjField * field9 = [ODMobileObjField new];
        [field9 setNm:@"USER_LOGIN"];
        [field9 setVl:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].newUserLogin]];
        [fieldList add:field9];
        NSLog(@"name = %@, value =%@",field9.nm, field9.vl);
        [field9 release];
        
        
        //CONNECTION_ID
        [[SUPApplication applicationSettings] connectionId];
        ODMobileObjField * field10 = [ODMobileObjField new];
        [field10 setNm:@"CONNECTION_ID"];
        [field10 setVl:[NSString stringWithFormat:@"%@",[[SUPApplication applicationSettings] connectionId]]];
        [fieldList add:field10];
        NSLog(@"name = %@, value =%@",field10.nm, field10.vl);
        [field10 release];
        
        
        //DEVICE_ID
        ODMobileObjField * field11 = [ODMobileObjField new];
        [field11 setNm:@"DEVICE_ID"];
        [field11 setVl:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].idName]];
        [fieldList add:field11];
        NSLog(@"name = %@, value =%@",field11.nm, field11.vl);
        [field11 release];
        
        
        //IP
        ODMobileObjField * field12 = [ODMobileObjField new];
        [field12 setNm:@"IP"];
        [field12 setVl:[SberbankAuditAppDelegate instance].IPAdress];
        [fieldList add:field12];
        NSLog(@"name = %@, value =%@",field12.nm, field12.vl);
        [field12 release];
        
        
        
        ODMobileOdObject * odObject = [ODMobileOdObject new];
        [odObject setFl:fieldList];
        [updateTask update:@"SUP_FCT_TASKS" withOdObject:odObject];
        [updateTask submitPending];
        
        
        [ODMobileODMobileDB synchronize:@"TasksSG"];
        
        [[SberbankAuditAppDelegate instance] closeActivityIndicator];
        
        
        [fieldList release];
        
        NSLog(@"At-Consulting: Application is saved");
        
    }
    @catch (SUPPersistenceException *exception)
    {
        [[SberbankAuditAppDelegate instance] closeActivityIndicator];
        
        NSLog(@"At-Consulting: Save error: %@ - %@",exception.name,exception.message);
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:@"Ошибка синхронизации" message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [alert1 show];
        [alert1 release];
    }
    
    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC updateData];
    [self updateData];

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)updateData
{
    NSString * ID = [NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]];
    NSLog(@"task id before update = %@",[taskData valueForKey:@"x.TASK_ID"]);
    NSLog(@"task_status_id before update = %@",[taskData valueForKey:@"x.TASK_STATUS_ID"]);
    NSLog(@"task_status_name before update = %@",[taskData valueForKey:@"b.TASK_STATUS_NAME"]);
    NSMutableArray * array = [SberbankAuditAppDelegate instance].rootViewController.mainDataVC.tweets;
    bool isComplete = false;
    for (int i = 0; i < array.count; i++) {
        for (int j = 0; j < [[[array objectAtIndex:i] valueForKey:@"content"] count]; j++) {
            if ([[NSString stringWithFormat:@"%@",[[[[array objectAtIndex:i] valueForKey:@"content"] objectAtIndex:j] valueForKey:@"x.TASK_ID"]] isEqualToString:ID]) {
//                taskData = [[[array objectAtIndex:i] objectAtIndex:j] valueForKey:@"x.TASK_ID"];
                taskData = [[[array objectAtIndex:i] valueForKey:@"content"] objectAtIndex:j];
                isComplete = true;
            }
        }
    }
    if (!isComplete) {
        NSString * status = nil;
        NSString * message = nil;
        if ([self.lastStatus isEqualToString:@"Отменена"]) {
            status = @"Задача отменена";
            message = @"Просмотреть задачу можно в списке 'Завершенные'";
        }
        if ([self.lastStatus isEqualToString:@"Выполнена"]) {
            status = @"Задача выполнена и перенесена в 'Завершенные'";
            message = @"Контрольный лист будет закрыт";
        }
        UIAlertView * completeAlert = [[UIAlertView alloc] initWithTitle:status message:message delegate:self cancelButtonTitle:@"Продолжить" otherButtonTitles:nil, nil];
        [completeAlert show];
        [completeAlert release];
        [controlList.view removeFromSuperview];
        [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController.view removeFromSuperview];
    }
    NSLog(@"task id after update = %@",[taskData valueForKey:@"x.TASK_ID"]);
    NSLog(@"task_status_id after update = %@",[taskData valueForKey:@"x.TASK_STATUS_ID"]);
    NSLog(@"task_status_name after update = %@",[taskData valueForKey:@"b.TASK_STATUS_NAME"]);
    [self viewWillAppear:YES];
}

- (void)openTP
{
//    TaskPlan *detailViewController = [[TaskPlan alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
//    NSNumber * branch = [NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.SUBBRANCH_ID"] ] integerValue]];
//    detailViewController.branchId = branch;
//    NSNumber * union_ID = [NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",[taskData valueForKey:@"unions.UNION_ID"] ] integerValue]];
//    detailViewController.unionID = union_ID;
//    NSLog(@"1union = %@",union_ID);
//    NSLog(@"1branch = %@",branch);
//    NSString * taskID = [NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]];
//    detailViewController.taskID = taskID;
//    NSString * employeeID = [NSString stringWithFormat:@"%@",[taskData valueForKey:@"e.EMPLOYEE_ID"]];
//    detailViewController.employee_ID = employeeID;
//	[[SberbankAuditAppDelegate instance].rootViewController.stackScrollViewController addViewInSlider:detailViewController drawShadow:YES invokeByController:self isStackStartView:NO];
//    //[detailViewController release];

    TaskPlan *tmpTaskPlan = [[TaskPlan alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
    self.detailViewController = tmpTaskPlan;
    [tmpTaskPlan release];
    NSNumber * branch = [NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.SUBBRANCH_ID"] ] integerValue]];
    self.detailViewController.branchId = branch;
    NSNumber * union_ID = [NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",[taskData valueForKey:@"unions.UNION_ID"] ] integerValue]];
    self.detailViewController.unionID = union_ID;
    NSLog(@"1union = %@",union_ID);
    NSLog(@"1branch = %@",branch);
    NSString * taskID = [NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]];
    self.detailViewController.taskID = taskID;
    NSString * employeeID = [NSString stringWithFormat:@"%@",[taskData valueForKey:@"e.EMPLOYEE_ID"]];
    self.detailViewController.employee_ID = employeeID;
	[[SberbankAuditAppDelegate instance].rootViewController.stackScrollViewController addViewInSlider:self.detailViewController drawShadow:YES invokeByController:self isStackStartView:NO];
    //[detailViewController release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == alert) {
        if (buttonIndex == 0) {
            controlList.varForLoadCL = @"true";
            [controlList lookCL];//скрыть кнопки Sava и Done
            NSLog(@"Status will stay the same");
        }
        if (buttonIndex == 1) {
            controlList.varForLoadCL = @"false";
            [controlList performSelector:@selector(loadCL) withObject:nil afterDelay:0.2];
//            [controlList loadCL];
            NSLog(@"Status should be changed");
        }
    }
    if (alertView == cancelTaskAlert) {
        if (buttonIndex == 0) {
            NSLog(@"Task status should not be changed");
        }
        if (buttonIndex == 1) {
            [self performSelector:@selector(cancelTask) withObject:nil afterDelay:0.2];
//            [self cancelTask];
            NSLog(@"Task status should be changed");
        }
    }
    if (alertView == errorAlert) {
        if (buttonIndex == 0) {
            [ODMobileODMobileDB synchronize:@"TasksSG"];
            @try {
                [ODMobileODMobileDB synchronize:@"TasksSG"];
                NSLog(@"CreateNewTaskController's message: Синхронизация прошла успешно");
            }
            @catch (SUPPersistenceException *exception) {
                NSLog(@"CreateNewTaskController's error: Ошибка синхронизации данных - %@, %@", exception.name,exception.message);
                UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:@"Ошибка синхронизации" message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
                [alert1 show];
                [alert1 release];
            }

        }
    }
}

- (void) openCL
{
//    ControlList * controlList = nil;
//    if(controlList != nil)
//        return;
    
    controlList = [[ControlList alloc] initWithFrame:CGRectMake(0, 0, 954, self.view.frame.size.height) andTaskInfo:taskData];
    controlList.frameRect = CGRectMake(0, 0, 954, self.view.frame.size.height);
    [SberbankAuditAppDelegate instance].currentControlList = controlList;
    NSString * taskID = [NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]];
    NSLog(@"TASK_ID, который передается в КЛ = %@",taskID);
    NSLog(@"TASK_NAME = %@",[taskData valueForKey:@"b.TASK_STATUS_NAME"]);
    controlList.taskID = taskID;

    if ([[NSString stringWithFormat:@"%@",[taskData valueForKey:@"b.TASK_STATUS_NAME"]] isEqualToString:@"Назначена"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Контрольный лист" message:@"Начать выполнение задачи или только просмотреть?" delegate:self cancelButtonTitle:@"Просмотреть" otherButtonTitles: @"Начать", nil];
        [alert show];
    } else if ([[NSString stringWithFormat:@"%@",[taskData valueForKey:@"b.TASK_STATUS_NAME"]] isEqualToString:@"В работе"])
    {
        controlList.varForLoadCL = @"false";
        [controlList loadWebView];
        [controlList timerStart];
    }
    else
    {
        controlList.varForLoadCL = @"true";
        [controlList loadWebView];
    }
    
	[[SberbankAuditAppDelegate instance].rootViewController.stackScrollViewController addViewInSlider:controlList drawShadow:YES invokeByController:self isStackStartView:NO];
    
//    [controlList release];
}

- (void) openCheckList
{
    CheckListViewController * checkList = [[CheckListViewController alloc] initWithFrame:CGRectMake(0, 0, 954, self.view.frame.size.height)];
	[[SberbankAuditAppDelegate instance].rootViewController.stackScrollViewController addViewInSlider:checkList drawShadow:YES invokeByController:self isStackStartView:NO];
    [checkList release];
}

- (void) viewWillAppear:(BOOL)animated
{
    if (screen == FALSE) {
        NSLog(@"TASK_ID from detail = %@",[taskData valueForKey:@"x.TASK_ID"]);
        
        [noteTextEditor setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_DESC"]]];
        
        UIImageView *topDetailPart = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"task_cell_back.png"]];
        [topDetailPart setFrame:CGRectMake(6, 5, 464, 124)];
        [self.view addSubview:topDetailPart];
        
        UILabel *taskTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 400, 20)];
        [taskTitle setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [taskTitle setBackgroundColor:[UIColor clearColor]];
        //    [taskTitle setText:[NSString stringWithFormat:@"%@ %@",[taskData valueForKey:@"y.TASK_TYPE_NAME"],[taskData valueForKey:@"f.SUBBRANCH_NAME"]]];
        [taskTitle setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"y.TASK_TYPE_NAME"]]];
        [topDetailPart addSubview:taskTitle];
        
        int indicatorr = 0;//зеленый
        long MIN_3_DAYS = 3 * 24 * 60;
        long minLeftToStart = ([[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.PLAN_START_DTTM"]] longLongValue] - [[NSDate date] timeIntervalSince1970] * 1000) / (1000 * 60) ;
        //    NSLog(@"minLeft = %ld", minLeftToStart);
        if ([[NSString stringWithFormat:@"%@",[taskData valueForKey:@"b.TASK_STATUS_NAME"]] isEqualToString: @"Выполнена"]) {
            indicatorr = 0;
        } else if ([[NSString stringWithFormat:@"%@",[taskData valueForKey:@"b.TASK_STATUS_NAME"]] isEqualToString: @"Не состоялась"]) {
            indicatorr = 1;
        } else if (minLeftToStart < 0) {
            indicatorr = 2;
        } else if ((minLeftToStart < MIN_3_DAYS) && (minLeftToStart > 0)) {
            indicatorr = 1;
        }
        else if (minLeftToStart > MIN_3_DAYS)
        {
            indicatorr = 0;
        }
        
        UIImageView *topIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"indicator_%i.png", indicatorr]]];
        [topIndicator setFrame:CGRectMake(12, 9, 25, 25)];
        [topDetailPart addSubview:topIndicator];
        
        UILabel *taskStatus = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 110, 20)];
        [taskStatus setFont:[UIFont systemFontOfSize:14.0f]];
        [taskStatus setTextAlignment:UITextAlignmentLeft];
        [taskStatus setBackgroundColor:[UIColor clearColor]];
        [taskStatus setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"b.TASK_STATUS_NAME"]]];
        [topDetailPart addSubview:taskStatus];
        
        UILabel *taskDate = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, 230, 20)];
        [taskDate setFont:[UIFont systemFontOfSize:14.0f]];
        [taskDate setBackgroundColor:[UIColor clearColor]];
        
        NSDate * date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        //    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
        //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        NSString * str = [NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.PLAN_START_DTTM"]];
        double DOUBLE = [str doubleValue]/1000;
        date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
        str = [dateFormatter stringFromDate:date];
        [dateFormatter release];
        [taskDate setText:str];
        [topDetailPart addSubview:taskDate];
        
        UILabel *taskDayOfWeek = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 100, 20)];
        [taskDayOfWeek setFont:[UIFont systemFontOfSize:14.0f]];
        [taskDayOfWeek setBackgroundColor:[UIColor clearColor]];
        [taskDayOfWeek setText:@"Понедельник"];
        
        UILabel *taskTime = [[UILabel alloc] initWithFrame:CGRectMake(270, 80, 180, 20)];
        [taskTime setFont:[UIFont systemFontOfSize:14.0f]];
        [taskTime setBackgroundColor:[UIColor clearColor]];
        [taskTime setTextAlignment:UITextAlignmentRight];
        long duration = [[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_DURATION"]] integerValue] / 60;
        //    [taskTime setText:[NSString stringWithFormat:@"Длительность: %@ мин.",[taskData valueForKey:@"x.TASK_DURATION"]]];
        [taskTime setText:[NSString stringWithFormat:@"Длительность: %ld мин.",duration]];
        [topDetailPart addSubview:taskTime];
        
        //    cancelButton = [[UIButton alloc] init];
        cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelButton.frame = CGRectMake(355, taskTime.frame.origin.y - 35, 100, 25);
        [cancelButton setTitle:@"Отмена" forState:UIControlStateNormal];
//        [cancelButton setAlpha:0.5];
        [cancelButton addTarget:self action:@selector(cancelAlertCall) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cancelButton];
        
        [taskTime release];
        [topIndicator release];
        [taskStatus release];
        [taskDate release];
        [taskDayOfWeek release];
        
        [topDetailPart release];
        [taskTitle release];
        
        UIView *descHeaderView = [[UIView alloc] initWithFrame:CGRectMake(6, 139, 464, 190)];
        [self.view addSubview:descHeaderView];
        
        UIImageView *mainNoteDescHeader = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"description_header.png"]];
        [mainNoteDescHeader setFrame:CGRectMake(0, 0, 464, 190)];
        [descHeaderView addSubview:mainNoteDescHeader];
        
//        UILabel *taskBranch = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 400, 20)];
        UILabel *taskBranch = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 400, 20)];
        [taskBranch setFont:[UIFont systemFontOfSize:12.0f]];
        [taskBranch setBackgroundColor:[UIColor clearColor]];
        [taskBranch setText:[NSString stringWithFormat:@"Подразделение: %@",[taskData valueForKey:@"f.SUBBRANCH_NAME"]]];
        if (![[NSString stringWithFormat:@"%@",[taskData valueForKey:@"unions.UNION_NAME"]] isEqualToString:@""]) {
            [taskBranch setText:[NSString stringWithFormat:@"Подразделение: %@",[taskData valueForKey:@"unions.UNION_NAME"]]];
        }
        //    [taskBranch setText:[NSString stringWithFormat:@"Подразделение: %@",[taskData valueForKey:@"f.SUBBRANCH_NAME"]]];
        [mainNoteDescHeader addSubview:taskBranch];
        [taskBranch release];
        
//        UILabel *taskAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 400, 20)];
        UILabel *taskAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, 400, 20)];
        [taskAddress setFont:[UIFont systemFontOfSize:12.0f]];
        [taskAddress setBackgroundColor:[UIColor clearColor]];
        [taskAddress setText:[NSString stringWithFormat:@"Адрес: %@",[taskData valueForKey:@"f.ADDRESS"]]];
        [mainNoteDescHeader addSubview:taskAddress];
        [taskAddress release];
        
//        UILabel *taskBranchHead = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, 400, 20)];
        UILabel *taskBranchHead = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, 400, 20)];
        [taskBranchHead setFont:[UIFont systemFontOfSize:12.0f]];
        [taskBranchHead setBackgroundColor:[UIColor clearColor]];
//        [taskBranchHead setText:[NSString stringWithFormat:@"ФИО Руководителя: %@ %@ %@",[taskData valueForKey:@"e.LAST_NAME"],[taskData valueForKey:@"e.FIRST_NAME"],[taskData valueForKey:@"e.PATRONYMIC"]]];
        [taskBranchHead setText:[NSString stringWithFormat:@"ФИО Руководителя:"]];
        [mainNoteDescHeader addSubview:taskBranchHead];
        [taskBranchHead release];

        UILabel *taskBranchHeadNew = [[UILabel alloc] initWithFrame:CGRectMake(15, 65, 400, 20)];
        [taskBranchHeadNew setFont:[UIFont systemFontOfSize:12.0f]];
        [taskBranchHeadNew setBackgroundColor:[UIColor clearColor]];
        NSString * fio = [NSString stringWithFormat:@"%@ %@ %@",[taskData valueForKey:@"e.LAST_NAME"],[taskData valueForKey:@"e.FIRST_NAME"],[taskData valueForKey:@"e.PATRONYMIC"]];
        [taskBranchHeadNew setText:fio];
        if ([fio isEqualToString:@"  "]) {
            [taskBranchHeadNew setText:@"Руководитель не назначен"];
        }
        [mainNoteDescHeader addSubview:taskBranchHeadNew];
        [taskBranchHeadNew release];

        UILabel *taskSelfResponsible = [[UILabel alloc] initWithFrame:CGRectMake(15, 85, 400, 20)];
        [taskSelfResponsible setFont:[UIFont systemFontOfSize:12.0f]];
        [taskSelfResponsible setBackgroundColor:[UIColor clearColor]];
//        [taskSelfResponsible setText:[NSString stringWithFormat:@"ФИО ответственного за аудит:"]];
        [taskSelfResponsible setText:[NSString stringWithFormat:@"Автор:"]];
        [mainNoteDescHeader addSubview:taskSelfResponsible];
        [taskSelfResponsible release];

        
        UILabel *taskSelfResponsibleNew = [[UILabel alloc] initWithFrame:CGRectMake(15, 105, 400, 20)];
        [taskSelfResponsibleNew setFont:[UIFont systemFontOfSize:12.0f]];
        [taskSelfResponsibleNew setBackgroundColor:[UIColor clearColor]];
        
        NSString *fullAuthorName = [NSString stringWithFormat:@"%@%@%@",[taskData valueForKey:@"c.LAST_NAME"],[taskData valueForKey:@"c.FIRST_NAME"],[taskData valueForKey:@"c.PATRONYMIC"]];
                
        fullAuthorName = [fullAuthorName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (fullAuthorName.length == 0) {
            [taskSelfResponsibleNew setText:@"Запланировано системой"];
        }
        else
        {
            [taskSelfResponsibleNew setText:[NSString stringWithFormat:@"%@ %@ %@",[taskData valueForKey:@"c.LAST_NAME"],[taskData valueForKey:@"c.FIRST_NAME"],[taskData valueForKey:@"c.PATRONYMIC"]]];
        }
        
        [mainNoteDescHeader addSubview:taskSelfResponsibleNew];
        [taskSelfResponsibleNew release];

        
        UIButton *controlB = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [controlB setBackgroundImage:[UIImage imageNamed:@"control_list_still.png"] forState:UIControlStateNormal];
        [controlB setBackgroundImage:[UIImage imageNamed:@"control_list_active.png"] forState:UIControlStateHighlighted];
//        [controlB setFrame:CGRectMake(12, 113, 216, 57)];
        [controlB setFrame:CGRectMake(12, 113+20, 216, 57)];
        [controlB addTarget:self action:@selector(openCL) forControlEvents:UIControlEventTouchUpInside];
        //    [controlB addTarget:self action:@selector(openCheckList) forControlEvents:UIControlEventTouchUpInside];
        [descHeaderView addSubview:controlB];
        
        UIButton *planB = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [planB setBackgroundImage:[UIImage imageNamed:@"plan_still.png"] forState:UIControlStateNormal];
        [planB setBackgroundImage:[UIImage imageNamed:@"plan_active.png"] forState:UIControlStateHighlighted];
//        [planB setFrame:CGRectMake(controlB.frame.size.width+17, 113, 216, 57)];
        [planB setFrame:CGRectMake(controlB.frame.size.width+17, 113 + 20, 216, 57)];
        [planB addTarget:self action:@selector(openTP) forControlEvents:UIControlEventTouchUpInside];
        [descHeaderView addSubview:planB];
        
        [mainNoteDescHeader release];
        [descHeaderView release];
        [controlB release];
        [planB release];
        
//        mainNoteAnketaDesc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anketa_desc.png"]];
        mainNoteAnketaDesc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anketa_desc-01.png"]];
//        [mainNoteAnketaDesc setFrame:CGRectMake(6+4, 329, 464-8, 154+30)];
        [mainNoteAnketaDesc setFrame:CGRectMake(6, 329, 464, 154+30)];
        [self.view addSubview:mainNoteAnketaDesc];
        
        
        //Заполнение данных таблицы
        //Первый столбец
        UILabel * taskFIO = [[UILabel alloc] initWithFrame:CGRectMake(26, 26, 150, 20)];
        [taskFIO setFont:[UIFont systemFontOfSize:12.0f]];
        [taskFIO setTextAlignment:UITextAlignmentLeft];
        [taskFIO setBackgroundColor:[UIColor clearColor]];
        [taskFIO setText:@"ФИО исполнителя:"];
        [mainNoteAnketaDesc addSubview:taskFIO];
        [taskFIO release];
        
        UILabel * taskLastAudit = [[UILabel alloc] initWithFrame:CGRectMake(26, 50, 150, 20)];
        [taskLastAudit setFont:[UIFont systemFontOfSize:12.0f]];
        [taskLastAudit setTextAlignment:UITextAlignmentLeft];
        [taskLastAudit setBackgroundColor:[UIColor clearColor]];
        [taskLastAudit setText:@"Последняя проверка:"];
        [mainNoteAnketaDesc addSubview:taskLastAudit];
        [taskLastAudit release];
        
        UILabel * taskMark = [[UILabel alloc] initWithFrame:CGRectMake(26, 75, 150, 20)];
        [taskMark setFont:[UIFont systemFontOfSize:12.0f]];
        [taskMark setTextAlignment:UITextAlignmentLeft];
        [taskMark setBackgroundColor:[UIColor clearColor]];
        [taskMark setText:@"Балл:"];
        [mainNoteAnketaDesc addSubview:taskMark];
        [taskMark release];
        
        
        UILabel * taskDispersion = [[UILabel alloc] initWithFrame:CGRectMake(26, 100, 150, 20)];
        [taskDispersion setFont:[UIFont systemFontOfSize:12.0f]];
        [taskDispersion setTextAlignment:UITextAlignmentLeft];
        [taskDispersion setBackgroundColor:[UIColor clearColor]];
        [taskDispersion setText:@"Дисперсия:"];
        [mainNoteAnketaDesc addSubview:taskDispersion];
        [taskDispersion release];
        
        
        UILabel * taskLessCoeff = [[UILabel alloc] initWithFrame:CGRectMake(26, 125, 150, 20)];
        [taskLessCoeff setFont:[UIFont systemFontOfSize:12.0f]];
        [taskLessCoeff setTextAlignment:UITextAlignmentLeft];
        [taskLessCoeff setBackgroundColor:[UIColor clearColor]];
        [taskLessCoeff setText:@"Пониж. коэффициент:"];
        [mainNoteAnketaDesc addSubview:taskLessCoeff];
        [taskLessCoeff release];
        
        
        UILabel * taskTotal = [[UILabel alloc] initWithFrame:CGRectMake(26, 150, 150, 20)];
        [taskTotal setFont:[UIFont systemFontOfSize:12.0f]];
        [taskTotal setTextAlignment:UITextAlignmentLeft];
        [taskTotal setBackgroundColor:[UIColor clearColor]];
        [taskTotal setText:@"Итог аудита:"];
        [mainNoteAnketaDesc addSubview:taskTotal];
        [taskTotal release];
        
        
        //Второй столбец (SELF)
        
        taskSelfMark = [[UILabel alloc] initWithFrame:CGRectMake(183, 2, 127, 20)];
        [taskSelfMark setFont:[UIFont systemFontOfSize:12.0f]];
        [taskSelfMark setTextAlignment:UITextAlignmentCenter];
        [taskSelfMark setBackgroundColor:[UIColor clearColor]];
        [taskSelfMark setText:@"Самооценка"];
        [mainNoteAnketaDesc addSubview:taskSelfMark];
        
        taskField1 = [[UILabel alloc] initWithFrame:CGRectMake(183, 26, 127, 20)];
        [taskField1 setFont:[UIFont systemFontOfSize:12.0f]];
        [taskField1 setTextAlignment:UITextAlignmentCenter];
        [taskField1 setBackgroundColor:[UIColor clearColor]];
        //    [taskField1 setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.SELF_CHECK_RESOURCE_FIO"]]];
        [taskField1 setText:@""];
        [mainNoteAnketaDesc addSubview:taskField1];
        
        //    NSDate * date1;
        //    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        //    [dateFormatter1 setDateFormat:@"yyyy.MM.dd HH:mm"];
        //    [dateFormatter1 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        //
        //    NSString * str1 = [NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.SELF_CHECK_FACT_END_DTTM"]];
        //    NSLog(@"str1 = %@",str1);
        //    if (![str1 isEqualToString:@""]) {
        //        double DOUBLE1 = [str1 doubleValue]/1000;
        //        date1 = [NSDate dateWithTimeIntervalSince1970:DOUBLE1];
        //        str1 = [dateFormatter1 stringFromDate:date1];
        //    }
        //    else
        //    {
        //        str1 = @"-";
        //    }
        
        taskField2 = [[UILabel alloc] initWithFrame:CGRectMake(183, 50, 127, 20)];
        [taskField2 setFont:[UIFont systemFontOfSize:12.0f]];
        [taskField2 setTextAlignment:UITextAlignmentCenter];
        [taskField2 setBackgroundColor:[UIColor clearColor]];
        //    [taskField2 setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.SELF_CHECK_FACT_END_DTTM"]]];
        [taskField2 setText:@""];
        [mainNoteAnketaDesc addSubview:taskField2];
        
        taskField3 = [[UILabel alloc] initWithFrame:CGRectMake(183, 75, 127, 20)];
        [taskField3 setFont:[UIFont systemFontOfSize:12.0f]];
        [taskField3 setTextAlignment:UITextAlignmentCenter];
        [taskField3 setBackgroundColor:[UIColor clearColor]];
        //    [taskField3 setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.SELF_POINTS"]]];
        [taskField3 setText:@""];
        [mainNoteAnketaDesc addSubview:taskField3];
        
        taskField4 = [[UILabel alloc] initWithFrame:CGRectMake(183, 100, 127, 20)];
        [taskField4 setFont:[UIFont systemFontOfSize:12.0f]];
        [taskField4 setTextAlignment:UITextAlignmentCenter];
        [taskField4 setBackgroundColor:[UIColor clearColor]];
        //    [taskField4 setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.SELF_DISPERSION"]]];
        [taskField4 setText:@""];
        [mainNoteAnketaDesc addSubview:taskField4];
        
        taskField5 = [[UILabel alloc] initWithFrame:CGRectMake(183, 125, 127, 20)];
        [taskField5 setFont:[UIFont systemFontOfSize:12.0f]];
        [taskField5 setTextAlignment:UITextAlignmentCenter];
        [taskField5 setBackgroundColor:[UIColor clearColor]];
        //    [taskField5 setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.SELF_REDUCE_INDEX"]]];
        [taskField5 setText:@""];
        [mainNoteAnketaDesc addSubview:taskField5];
        
        taskField6 = [[UILabel alloc] initWithFrame:CGRectMake(183, 150, 127, 20)];
        [taskField6 setFont:[UIFont systemFontOfSize:12.0f]];
        [taskField6 setTextAlignment:UITextAlignmentCenter];
        [taskField6 setBackgroundColor:[UIColor clearColor]];
        //    [taskField6 setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.SELF_CHECK_RESULT"]]];
        [taskField6 setText:@""];
        [mainNoteAnketaDesc addSubview:taskField6];
        
        
        //Третий столбец (OTHER)
        
        taskAudit = [[UILabel alloc] initWithFrame:CGRectMake(310, 2, 137, 20)];
        [taskAudit setFont:[UIFont systemFontOfSize:12.0f]];
        [taskAudit setTextAlignment:UITextAlignmentCenter];
        [taskAudit setBackgroundColor:[UIColor clearColor]];
        [taskAudit setText:@"Аудит"];
        [mainNoteAnketaDesc addSubview:taskAudit];
        
        
        taskPole1 = [[UILabel alloc] initWithFrame:CGRectMake(310, 26, 137, 20)];
        [taskPole1 setFont:[UIFont systemFontOfSize:12.0f]];
        [taskPole1 setTextAlignment:UITextAlignmentCenter];
        [taskPole1 setBackgroundColor:[UIColor clearColor]];
        //    [taskPole1 setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.OTHER_CHECK_RESOURCE_FIO"]]];
        [taskPole1 setText:@""];
        [mainNoteAnketaDesc addSubview:taskPole1];
        
        //    NSDate * date2;
        //    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        //    [dateFormatter2 setDateFormat:@"yyyy.MM.dd HH:mm"];
        //    [dateFormatter2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        //
        //    NSString * str2 = [NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.OTHER_CHECK_FACT_END_DTTM"]];
        //    NSLog(@"str2 = %@", str2);
        //    if (![str2 isEqualToString:@""]) {
        //        double DOUBLE2 = [str2 doubleValue]/1000;
        //        date2 = [NSDate dateWithTimeIntervalSince1970:DOUBLE2];
        //        str2 = [dateFormatter2 stringFromDate:date2];
        //    }
        //    else
        //    {
        //        str2 = @"-";
        //    }
        
        taskPole2 = [[UILabel alloc] initWithFrame:CGRectMake(310, 50, 137, 20)];
        [taskPole2 setFont:[UIFont systemFontOfSize:12.0f]];
        [taskPole2 setTextAlignment:UITextAlignmentCenter];
        [taskPole2 setBackgroundColor:[UIColor clearColor]];
        [taskPole2 setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.OTHER_CHECK_FACT_END_DTTM"]]];
        [taskPole2 setText:@""];
        [mainNoteAnketaDesc addSubview:taskPole2];
        
        taskPole3 = [[UILabel alloc] initWithFrame:CGRectMake(310, 75, 137, 20)];
        [taskPole3 setFont:[UIFont systemFontOfSize:12.0f]];
        [taskPole3 setTextAlignment:UITextAlignmentCenter];
        [taskPole3 setBackgroundColor:[UIColor clearColor]];
        [taskPole3 setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.OTHER_POINTS"]]];
        [taskPole3 setText:@""];
        [mainNoteAnketaDesc addSubview:taskPole3];
        
        taskPole4 = [[UILabel alloc] initWithFrame:CGRectMake(310, 100, 137, 20)];
        [taskPole4 setFont:[UIFont systemFontOfSize:12.0f]];
        [taskPole4 setTextAlignment:UITextAlignmentCenter];
        [taskPole4 setBackgroundColor:[UIColor clearColor]];
        [taskPole4 setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.OTHER_DISPERSION"]]];
        [taskPole4 setText:@""];
        [mainNoteAnketaDesc addSubview:taskPole4];
        
        taskPole5 = [[UILabel alloc] initWithFrame:CGRectMake(310, 125, 137, 20)];
        [taskPole5 setFont:[UIFont systemFontOfSize:12.0f]];
        [taskPole5 setTextAlignment:UITextAlignmentCenter];
        [taskPole5 setBackgroundColor:[UIColor clearColor]];
        [taskPole5 setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.OTHER_REDUCE_INDEX"]]];
        [taskPole5 setText:@""];
        [mainNoteAnketaDesc addSubview:taskPole5];
        
        taskPole6 = [[UILabel alloc] initWithFrame:CGRectMake(310, 150, 137, 20)];
        [taskPole6 setFont:[UIFont systemFontOfSize:12.0f]];
        [taskPole6 setTextAlignment:UITextAlignmentCenter];
        [taskPole6 setBackgroundColor:[UIColor clearColor]];
        [taskPole6 setText:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.OTHER_CHECK_RESULT"]]];
        [taskPole6 setText:@""];
        [mainNoteAnketaDesc addSubview:taskPole6];
        
//        [mainNoteAnketaDesc release];
        [self cancelMethod];
        [self findAllMetrics];
        
        screen = TRUE;
    }
}

- (void)cancelMethod
{
//    bool canCancelTask;
    
    NSLog(@"TASK_ID from CancelMethod: %@",[taskData valueForKey:@"x.TASK_ID"]);
    ODMobileMBO_getTasks * currentTask = [ODMobileMBO_getTasks findByPrimaryKey:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]]];
    
    if ([[NSString stringWithFormat:@"%@",[taskData valueForKey:@"b.TASK_STATUS_NAME"]] isEqualToString:@"Назначена"] || [[NSString stringWithFormat:@"%@",[taskData valueForKey:@"b.TASK_STATUS_NAME"]] isEqualToString:@"В работе"]){
//        canCancelTask = true;
    }
    
    NSString * employeeID = [NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].EMPLOYEE_ID];
    NSString * creatorEmployeeID = [NSString stringWithFormat:@"%@",[currentTask CREATOR_EMPLOYEE_ID]];
    NSString * resourseEmployeeID = [NSString stringWithFormat:@"%@",[currentTask RESOURCE_EMPLOYEE_ID]];
    
    bool canCancelFromRole = false;
    
    if ([[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_STATUS_ID"]] isEqualToString:@"8"] && [employeeID isEqualToString:creatorEmployeeID]) {
        canCancelFromRole =true;
    }
    if ([[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_STATUS_ID"]] isEqualToString:@"4"] && [employeeID isEqualToString:resourseEmployeeID]) {
        canCancelFromRole =true;
    }
    
    if (!canCancelFromRole) {
        cancelButton.enabled = NO;
        cancelButton.alpha = 0.5;
        return ;
    }
}

- (void)cancelAlertCall
{
    cancelTaskAlert = [[UIAlertView alloc] initWithTitle:@"Отмена задачи." message:@"Вы действительно хотите отменить задачу?" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil];
    [cancelTaskAlert show];
}

- (void)cancelTask
{
    
    [[SberbankAuditAppDelegate instance] openActivityIndicatorViewWithName:@"Синхронизация данных"];

    NSLog(@"CancelTask method called");
    @try {
        SUPObjectList * fieldList = [SUPObjectList new];
        ODMobileMBO_getTasks * updateTask = [ODMobileMBO_getTasks findByPrimaryKey:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]]];
        
        
        //TASK_ID
        ODMobileObjField * field1 = [ODMobileObjField new];
        [field1 setNm:@"TASK_ID"];
        [field1 setVl:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]]];
        [fieldList add:field1];
        NSLog(@"name = %@, value =%@",field1.nm, field1.vl);
        [field1 release];
        
        
        //TASK_STATUS_ID
        [updateTask setTASK_STATUS_ID:@"3"];
        ODMobileObjField * field3 = [ODMobileObjField new];
        [field3 setNm:@"TASK_STATUS_ID"];
        [field3 setVl:@"3"];
        [fieldList add:field3];
        NSLog(@"name = %@, value =%@",field3.nm, field3.vl);
        [field3 release];
        self.lastStatus = @"Отменена";
        
        
        //USER_LOGIN
        ODMobileObjField * field9 = [ODMobileObjField new];
        [field9 setNm:@"USER_LOGIN"];
        [field9 setVl:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].newUserLogin]];
        [fieldList add:field9];
        NSLog(@"name = %@, value =%@",field9.nm, field9.vl);
        [field9 release];
        
        
        //CONNECTION_ID
        [[SUPApplication applicationSettings] connectionId];
        ODMobileObjField * field10 = [ODMobileObjField new];
        [field10 setNm:@"CONNECTION_ID"];
        [field10 setVl:[NSString stringWithFormat:@"%@",[[SUPApplication applicationSettings] connectionId]]];
        [fieldList add:field10];
        NSLog(@"name = %@, value =%@",field10.nm, field10.vl);
        [field10 release];
        
        
        //DEVICE_ID
        ODMobileObjField * field11 = [ODMobileObjField new];
        [field11 setNm:@"DEVICE_ID"];
        [field11 setVl:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].idName]];
        [fieldList add:field11];
        NSLog(@"name = %@, value =%@",field11.nm, field11.vl);
        [field11 release];
        
        
        //IP
        ODMobileObjField * field12 = [ODMobileObjField new];
        [field12 setNm:@"IP"];
        [field12 setVl:[SberbankAuditAppDelegate instance].IPAdress];
        [fieldList add:field12];
        NSLog(@"name = %@, value =%@",field12.nm, field12.vl);
        [field12 release];

        
        
        ODMobileOdObject * odObject = [ODMobileOdObject new];
        [odObject setFl:fieldList];
        [updateTask update:@"SUP_FCT_TASKS" withOdObject:odObject];
        [updateTask submitPending];
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [ODMobileODMobileDB synchronize:@"TasksSG"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC updateData];
//                [self updateData];
//            });
//        });

        [ODMobileODMobileDB synchronize:@"TasksSG"];
        
        [[SberbankAuditAppDelegate instance] closeActivityIndicator];

        
        ODMobileMBO_getTasks * task = [ODMobileMBO_getTasks findByPrimaryKey:[NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]]];
        NSLog(@"New after sync task statusID = %@",[task TASK_STATUS_ID]);
        if (![[NSString stringWithFormat:@"%@",[task TASK_STATUS_ID]] isEqualToString:@"3"]) {
            [[SberbankAuditAppDelegate instance] closeActivityIndicator];

            errorAlert = [[UIAlertView alloc] initWithTitle:@"Произошла ошибка синхронизации" message:@"Необходимо провести синхронизацию еще раз" delegate:self cancelButtonTitle:@"Выполнить синхронизацию" otherButtonTitles:nil, nil];
            [errorAlert show];
        }

        
        [fieldList release];
        
        NSLog(@"At-Consulting: Application is saved");
        
    }
    @catch (SUPPersistenceException *exception)
    {
        [[SberbankAuditAppDelegate instance] closeActivityIndicator];
        
        NSLog(@"At-Consulting: Save error: %@ - %@",exception.name,exception.message);
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:@"Ошибка синхронизации" message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [alert1 show];
        [alert1 release];
    }
    
//    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC performSelector:@selector(updateData) withObject:nil afterDelay:0.5];
//    [self updateData];
    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC updateData];
    [self updateData];
}

- (void) findAllMetrics
{
    NSString * taskID = [NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]];
    ODMobileMBO_getTasks * currentTask = [ODMobileMBO_getTasks findByPrimaryKey:taskID];
    ODMobileMBO_getTaskTypes * taskType = [ODMobileMBO_getTaskTypes findByPrimaryKey:[NSString stringWithFormat:@"%@",[currentTask TASK_TYPE_ID]]];
    ODMobileMBOVisitTypes * taskVisitType = [ODMobileMBOVisitTypes findByPrimaryKey:[NSString stringWithFormat:@"%@",[taskType VISIT_TYPE_ID]]];
    NSString * visitType = [NSString stringWithFormat:@"%@",[taskVisitType VISIT_TYPE_KEY]];
    if ([visitType isEqualToString:VT_SELF] || [visitType isEqualToString:VT_AUDIT] || [visitType isEqualToString:VT_GEMBA]) {
        NSLog(@"Самооценка или аудит");
        [self setSelfMetrics];
        [self setAuditMetrics];
    }
    if ([visitType isEqualToString:VT_QUALITY_CHECKUP] || [visitType isEqualToString:VT_QUALITY_CONTROL]) {
        NSLog(@"Новый тип метрик");
        [self.view addSubview:underNoteAnketaDesc];
        [self.view addSubview:_scroll];
        NSLog(@"QUALITY_CONTROL_ID = %@",[currentTask QUALITY_CONTROL_ID]);
        [self setQualityMetricsWithTask:currentTask withTaskVisitType:taskVisitType];
    }
}

- (void)setQualityMetricsWithTask:(ODMobileMBO_getTasks *)task withTaskVisitType:(ODMobileMBOVisitTypes *)taskVisitType
{
    NSMutableArray * blocks = [[NSMutableArray alloc] init];
    ODMobileMBOVisitTypes * qualityCheckUp = [ODMobileMBOVisitTypes getByKey:VT_QUALITY_CHECKUP];
    
    if ([[NSString stringWithFormat:@"%@",[qualityCheckUp VISIT_TYPE_ID]] isEqualToString:[NSString stringWithFormat:@"%@",[taskVisitType VISIT_TYPE_ID]]]) {
        NSString * controlID = [NSString stringWithFormat:@"%@",[task QUALITY_CONTROL_ID]];
        NSLog(@"QUALITY_CONTROL_ID = %@",controlID);
        
        NSMutableArray * metricUtils = [[NSMutableArray alloc] init];
        if (controlID == nil || [controlID isEqualToString:@""]) {
            NSLog(@"Пустой quality_control_id");
        }
        
        SUPQueryResultSet * rss;
        NSMutableArray * rs = [[NSMutableArray alloc] init];

        
        @try {
            rss = [ODMobileMBOTaskBlockMetrics getByTaskId:controlID];
            NSLog(@"rss count = %i",rss.size);
            for (int i = 0; i < rss.size; i++) {
                NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
                for (int j = 0; j < rss.columnNames.size; j++) {
                    if ([[rss objectAtIndex:i] objectAtIndex:j] == nil) {
                        [dict setObject:@"" forKey:[[rss columnNames] objectAtIndex:j]];
                    }
                    else
                    {
                        [dict setObject:[[rss objectAtIndex:i] objectAtIndex:j] forKey:[[rss columnNames] objectAtIndex:j]];
                    }
                }
                
                [rs addObject:dict];
                [dict release];
            }
//            NSMutableArray * rsCopy = [[NSMutableArray alloc] init];
//            for (int i = 0; i < rs.count; i++) {
//                BOOL check = FALSE;
//                for (int j = 0; j < rsCopy.count; j++) {
//                    if ([[NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"b.QUESTION_BLOCK_ID"]] isEqualToString:[NSString stringWithFormat:@"%@",[[rsCopy objectAtIndex:j] valueForKey:@"b.QUESTION_BLOCK_ID"] ]]) {
//                        check = TRUE;
//                    }
//                }
//                if (!check) {
//                    [rsCopy addObject:[rs objectAtIndex:i]];
//                }
//            }
//            NSLog(@"count of copy = %i",rsCopy.count);
//            [rs removeAllObjects];
//            [rs addObjectsFromArray:rsCopy];
//            [rsCopy release];
            for(int i = 0; i < rs.count; i++) {
                TaskBlockMetrickUtils * metrica = [[TaskBlockMetrickUtils alloc] init];
                metrica.questionBlockID = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"b.QUESTION_BLOCK_ID"]];
                metrica.questionBlockName = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"b.QUESTION_BLOCK_NAME"]];
                metrica.metricKey = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"m.METRIC_KEY"]];
                metrica.metricName = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"m.METRIC_NAME"]];
                metrica.metricValue = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"bm.METRIC_VALUE"]];
                [metricUtils addObject:metrica];
                [metrica release];
            }
            for (int i = 0; i < metricUtils.count; i++) {
                NSLog(@"merticUtils: %@",[[metricUtils objectAtIndex:i] questionBlockName]);
                NSLog(@"merticUtils: %@",[[metricUtils objectAtIndex:i] questionBlockID]);
                NSLog(@"merticUtils: %@",[[metricUtils objectAtIndex:i] metricKey]);
                NSLog(@"merticUtils: %@",[[metricUtils objectAtIndex:i] metricName]);
                NSLog(@"merticUtils: %@",[[metricUtils objectAtIndex:i] metricValue]);
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception.name);
        }
        @finally {
            if (rss != nil) {
                [rss close];
            }
        }
        [rs release];
        
        NSMutableArray * blockIDs = [[NSMutableArray alloc] init];
        for (TaskBlockMetrickUtils * metric in metricUtils) {
            [blockIDs addObject:metric.questionBlockID];
        }
        
        for (NSString * blockID in blockIDs) {
            MetricsBlock * block = [[MetricsBlock alloc] init];
            for (TaskBlockMetrickUtils * metric  in metricUtils) {
                if ([metric.questionBlockID isEqualToString:blockID]) {
                    [block setName:metric.questionBlockName];
                }
            }
            NSMutableArray * blockMetrics = [[NSMutableArray alloc] init];
            for (TaskBlockMetrickUtils * metrica in metricUtils) {
                if ([metrica.questionBlockID isEqualToString:blockID]) {
                    Metric * metric = [[Metric alloc] initWithKey:metrica.metricKey withName:metrica.metricName withValue:metrica.metricValue];
                    [blockMetrics addObject:metric];
                    [metric release];
                }
            }
            [block setMetrics:blockMetrics];
            [blockMetrics release];
            
            [blocks addObject:block];
            [block release];
        }
        [blockIDs release];
        
        [metricUtils release];
    }
    
    
    
    ODMobileMBOVisitTypes * qualityControl = [ODMobileMBOVisitTypes getByKey:VT_QUALITY_CONTROL];
    if ([[NSString stringWithFormat:@"%@",[qualityControl VISIT_TYPE_ID]] isEqualToString:[NSString stringWithFormat:@"%@",[taskVisitType VISIT_TYPE_ID]]]) {
        NSString * controlID = [NSString stringWithFormat:@"%@",[task INSPECTOR_CONTROL_ID]];
        
        NSMutableArray * metricUtils = [[NSMutableArray alloc] init];
        if (controlID == nil || [controlID isEqualToString:@""]) {
            NSLog(@"Пустой inspector_control_id");
        }
        
        SUPQueryResultSet * rss;
        NSMutableArray * rs = [[NSMutableArray alloc] init];
        
        
        @try {
            rss = [ODMobileMBOTaskBlockMetrics getByTaskId:controlID];
            for (int i = 0; i < rss.size; i++) {
                NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
                for (int j = 0; j < rss.columnNames.size; j++) {
                    if ([[rss objectAtIndex:i] objectAtIndex:j] == nil) {
                        [dict setObject:@"" forKey:[[rss columnNames] objectAtIndex:j]];
                    }
                    else
                    {
                        [dict setObject:[[rss objectAtIndex:i] objectAtIndex:j] forKey:[[rss columnNames] objectAtIndex:j]];
                    }
                }
                
                [rs addObject:dict];
                [dict release];
            }
            
            for(int i = 0; i < rs.count; i++) {
                TaskBlockMetrickUtils * metrica = [[TaskBlockMetrickUtils alloc] init];
                metrica.questionBlockID = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"b.QUESTION_BLOCK_ID"]];
                metrica.questionBlockName = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"b.QUESTION_BLOCK_NAME"]];
                metrica.metricKey = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"m.METRIC_KEY"]];
                metrica.metricName = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"m.METRIC_NAME"]];
                metrica.metricValue = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"bm.METRIC_VALUE"]];
                [metricUtils addObject:metrica];
                [metrica release];
            }
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception.name);
        }
        @finally {
            if (rss != nil) {
                [rss close];
            }
        }
        [rs release];
        
        NSMutableArray * blockIDs = [[NSMutableArray alloc] init];
        for (TaskBlockMetrickUtils * metric in metricUtils) {
            [blockIDs addObject:metric.questionBlockID];
        }
        
        for (NSString * blockID in blockIDs) {
            MetricsBlock * block = [[MetricsBlock alloc] init];
            for (TaskBlockMetrickUtils * metric  in metricUtils) {
                if ([metric.questionBlockID isEqualToString:blockID]) {
                    [block setName:metric.questionBlockName];
                }
            }
            NSMutableArray * blockMetrics = [[NSMutableArray alloc] init];
            for (TaskBlockMetrickUtils * metrica in metricUtils) {
                if ([metrica.questionBlockID isEqualToString:blockID]) {
                    Metric * metric = [[Metric alloc] initWithKey:metrica.metricKey withName:metrica.metricName withValue:metrica.metricValue];
                    [blockMetrics addObject:metric];
                    [metric release];
                }
            }
            [block setMetrics:blockMetrics];
            [blockMetrics release];
            
            [blocks addObject:block];
            [block release];
        }
        [blockIDs release];
        
        [metricUtils release];
    }
    
    /******************************** удаление дубликатов **********************************/
    NSMutableArray * rsCopy = [[NSMutableArray alloc] init];
    for (int i = 0; i < blocks.count; i++) {
        BOOL check = FALSE;
        for (int j = 0; j < rsCopy.count; j++) {
            if ([[NSString stringWithFormat:@"%@",[[blocks objectAtIndex:i] name]] isEqualToString:[NSString stringWithFormat:@"%@",[[rsCopy objectAtIndex:j] name]]]) {
                check = TRUE;
            }
        }
        if (!check) {
            [rsCopy addObject:[blocks objectAtIndex:i]];
        }
    }
    NSLog(@"count of copy = %i",rsCopy.count);
    [blocks removeAllObjects];
    [blocks addObjectsFromArray:rsCopy];
    [rsCopy release];
    /***************************************************************************************/
    
    height = 5;
    
    NSLog(@"Count of blocks: %i",blocks.count);
    for (int i = 0; i < blocks.count; i++) {
        NSLog(@"BlockName: %@",[[blocks objectAtIndex:i] name]);
        
        UILabel * blockNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height, 446, 15)];
        [blockNameLabel setText:[[blocks objectAtIndex:i] name]];
        [blockNameLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [blockNameLabel setTextAlignment:UITextAlignmentLeft];
        [blockNameLabel setBackgroundColor:[UIColor clearColor]];
        [_scroll addSubview:blockNameLabel];
        [blockNameLabel release];
        
        height += 20;
        
        for (int j = 0; j < [[[blocks objectAtIndex:i] metrics] count]; j++) {
            NSString * name = [[[[blocks objectAtIndex:i] metrics] objectAtIndex:j] name];
            Metric *currentMetric = (Metric*)[[[blocks objectAtIndex:i] metrics] objectAtIndex:j];
            NSString * value = currentMetric.value;
            NSLog(@"name: %@",name);
            NSLog(@"value: %@",value);
            
            
            double valueDouble = [value doubleValue];
            valueDouble = valueDouble * 10000;
            NSLog(@"%f",valueDouble);
            
            valueDouble = round(valueDouble);
            NSLog(@"%f",valueDouble);
            
            valueDouble = valueDouble / 100;
            NSLog(@"%f",valueDouble);
            value = [NSString stringWithFormat:@"%f",valueDouble];
            
            
            NSString * separator = @".";
            NSRange pointRange = [value rangeOfString:separator];
            
            value = [value substringToIndex:pointRange.location + 1 + 2];
            
            
            UILabel * namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height, 335, 15)];
            [namelabel setText:name];
            [namelabel setFont:[UIFont systemFontOfSize:12.0f]];
            [namelabel setTextAlignment:UITextAlignmentLeft];
            [namelabel setBackgroundColor:[UIColor clearColor]];
            [_scroll addSubview:namelabel];
            [namelabel release];
            
            UILabel * valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, height, 90, 15)];
            [valueLabel setText:[NSString stringWithFormat:@"%@%@",value,@"%"]];
            [valueLabel setFont:[UIFont systemFontOfSize:12.0f]];
            [valueLabel setTextAlignment:UITextAlignmentLeft];
            [valueLabel setBackgroundColor:[UIColor clearColor]];
            [_scroll addSubview:valueLabel];
            [valueLabel release];

            height += 20;
        }
        
        height += 20;
    }
    
    _scroll.contentSize = CGSizeMake(456, height);
    
    [blocks release];
}

- (void)setSelfMetrics
{
    NSString * taskID = [NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]];
    ODMobileMBO_getTasks * currentTask = [ODMobileMBO_getTasks findByPrimaryKey:taskID];
//    NSLog(@"current task: %@",currentTask);
    if ([currentTask SELF_CHECK_RESOURCE_FIO] != nil) {
        [taskField1 setText:[NSString stringWithFormat:@"%@",[currentTask SELF_CHECK_RESOURCE_FIO]]];
    }

    if ([currentTask SELF_CHECK_FACT_END_DTTM] != nil) {
        NSDate * date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];

        NSString * str = [NSString stringWithFormat:@"%@",[currentTask SELF_CHECK_FACT_END_DTTM]];
        NSLog(@"str = %@",str);
        if (![str isEqualToString:@""]) {
            double DOUBLE = [str doubleValue]/1000;
            date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
            str = [dateFormatter stringFromDate:date];
        }
        else
        {
            str = @"-";
        }
        [taskField2 setText:str];
    }
    
    NSString * selfCheckID = [NSString stringWithFormat:@"%@",[currentTask SELF_CHECK_ID]];
//    if (selfCheckID == nil || [selfCheckID isEqualToString:@""]) {
    if (selfCheckID == nil) {
        NSLog(@"SELF_CHECK_ID = nil");
    }
    else {
        SUPQueryResultSet * rss;
        
//        for (int i = 0; i < rs.size; i++) {
//            NSLog(@"%@",[rs objectAtIndex:i]);
//        }
        NSMutableArray * metrics = [[NSMutableArray alloc] init];
        NSMutableArray * rs = [[NSMutableArray alloc] init];
        @try {
            rss = [ODMobileMBOTaskBlockMetrics getByTaskId:selfCheckID];
            for (int i = 0; i < rss.size; i++) {
                NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
                for (int j = 0; j < rss.columnNames.size; j++) {
                    if ([[rss objectAtIndex:i] objectAtIndex:j] == nil) {
                        [dict setObject:@"" forKey:[[rss columnNames] objectAtIndex:j]];
                    }
                    else
                    {
                        [dict setObject:[[rss objectAtIndex:i] objectAtIndex:j] forKey:[[rss columnNames] objectAtIndex:j]];
                    }
                }
                
                [rs addObject:dict];
                [dict release];
            }

            for(int i = 0; i < rss.size; i++) {
                TaskBlockMetrickUtils * metrica = [[TaskBlockMetrickUtils alloc] init];
                metrica.questionBlockID = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"b.QUESTION_BLOCK_ID"]];
                metrica.questionBlockName = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"b.QUESTION_BLOCK_NAME"]];
                metrica.metricKey = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"m.METRIC_KEY"]];
                metrica.metricName = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"m.METRIC_NAME"]];
                metrica.metricValue = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"bm.METRIC_VALUE"]];
                [metrics addObject:metrica];
                [metrica release];
            }
        }
        @catch (SUPPersistenceException *exception)
        {
            NSLog(@"At-Consulting: DetailController error: %@ - %@",exception.name,exception.message);
        }
        @finally {
            if (rss != nil) {
                [rss close];
            }
        }
        [rs release];
       NSMutableArray * result = [[NSMutableArray alloc] init];
        for (TaskBlockMetrickUtils * metric in metrics) {
            if ([metric.metricKey isEqualToString:RESULT_KEY] || [metric.metricKey isEqualToString:DISPERSION_KEY]|| [metric.metricKey isEqualToString:REDUCE_INDEX_KEY]|| [metric.metricKey isEqualToString:DISPERSED_RESULT_KEY]) {
                Metric * m = [[Metric alloc] initWithKey:metric.metricKey withName:metric.metricName withValue:metric.metricValue];
                [result addObject:m];
                [m release];
            }
        }
        
        for (Metric * m in result) {
            if ([m.key isEqualToString:RESULT_KEY]) {
                [taskField3 setText:m.value];
            }
            if ([m.key isEqualToString:DISPERSION_KEY]) {
                [taskField4 setText:m.value];
            }
            if ([m.key isEqualToString:REDUCE_INDEX_KEY]) {
                [taskField5 setText:m.value];
            }
            if ([m.key isEqualToString:DISPERSED_RESULT_KEY]) {
                [taskField6 setText:m.value];
            }
        }
        
        [metrics release];
        [result release];
    }
    

}

- (void)setAuditMetrics
{
    NSString * taskID = [NSString stringWithFormat:@"%@",[taskData valueForKey:@"x.TASK_ID"]];
    ODMobileMBO_getTasks * currentTask = [ODMobileMBO_getTasks findByPrimaryKey:taskID];
    if ([currentTask OTHER_CHECK_RESOURCE_FIO] != nil) {
        [taskPole1 setText:[NSString stringWithFormat:@"%@",[currentTask OTHER_CHECK_RESOURCE_FIO]]];
    }
    
    if ([currentTask OTHER_CHECK_FACT_END_DTTM] != nil) {
        NSDate * date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        
        NSString * str = [NSString stringWithFormat:@"%@",[currentTask OTHER_CHECK_FACT_END_DTTM]];
        NSLog(@"str = %@",str);
        if (![str isEqualToString:@""]) {
            double DOUBLE = [str doubleValue]/1000;
            date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
            str = [dateFormatter stringFromDate:date];
        }
        else
        {
            str = @"-";
        }
        [taskPole2 setText:str];
    }
    
    NSString * otherCheckID = [NSString stringWithFormat:@"%@",[currentTask OTHER_CHECK_ID]];
    if (otherCheckID == nil || [otherCheckID isEqualToString:@""]) {
        NSLog(@"OTHER_CHECK_ID = nil");
    }
    else {
        SUPQueryResultSet * rss;
        NSMutableArray * metrics = [[NSMutableArray alloc] init];
        NSMutableArray * rs = [[NSMutableArray alloc] init];
        @try {
            rss = [ODMobileMBOTaskBlockMetrics getByTaskId:otherCheckID];
            for (int i = 0; i < rss.size; i++) {
                NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
                for (int j = 0; j < rss.columnNames.size; j++) {
                    if ([[rss objectAtIndex:i] objectAtIndex:j] == nil) {
                        [dict setObject:@"" forKey:[[rss columnNames] objectAtIndex:j]];
                    }
                    else
                    {
                        [dict setObject:[[rss objectAtIndex:i] objectAtIndex:j] forKey:[[rss columnNames] objectAtIndex:j]];
                    }
                }
                
                [rs addObject:dict];
                [dict release];
            }
            
            for(int i = 0; i < rss.size; i++) {
                TaskBlockMetrickUtils * metrica = [[TaskBlockMetrickUtils alloc] init];
                metrica.questionBlockID = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"b.QUESTION_BLOCK_ID"]];
                metrica.questionBlockName = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"b.QUESTION_BLOCK_NAME"]];
                metrica.metricKey = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"m.METRIC_KEY"]];
                metrica.metricName = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"m.METRIC_NAME"]];
                metrica.metricValue = [NSString stringWithFormat:@"%@",[[rs objectAtIndex:i] valueForKey:@"bm.METRIC_VALUE"]];
                [metrics addObject:metrica];
                [metrica release];
            }
        }
        @catch (SUPPersistenceException *exception)
        {
            NSLog(@"At-Consulting: DetailController error: %@ - %@",exception.name,exception.message);
        }
        @finally {
            if (rss != nil) {
                [rss close];
            }
        }
        [rs release];
        NSMutableArray * result = [[NSMutableArray alloc] init];
        for (TaskBlockMetrickUtils * metric in metrics) {
            if ([metric.metricKey isEqualToString:RESULT_KEY] || [metric.metricKey isEqualToString:DISPERSION_KEY]|| [metric.metricKey isEqualToString:REDUCE_INDEX_KEY]|| [metric.metricKey isEqualToString:DISPERSED_RESULT_KEY]) {
                Metric * m = [[Metric alloc] initWithKey:metric.metricKey withName:metric.metricName withValue:metric.metricValue];
                [result addObject:m];
                [m release];
            }
        }
        
        for (Metric * m in result) {
            if ([m.key isEqualToString:RESULT_KEY]) {
                [taskPole3 setText:m.value];
            }
            if ([m.key isEqualToString:DISPERSION_KEY]) {
        
                float roundedValue = [m.value floatValue]*100;
                NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                [formatter setMaximumFractionDigits:2];
                [formatter setRoundingMode: NSNumberFormatterRoundUp];
                
                NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
                [formatter release];
                
                [taskPole4 setText:[NSString stringWithFormat:@"%@%%",numberString]];
//                NSString * substr = [m.value substringToIndex:4];
//                [taskPole4 setText:substr];
            }
            if ([m.key isEqualToString:REDUCE_INDEX_KEY]) {
                [taskPole5 setText:m.value];
            }
            if ([m.key isEqualToString:DISPERSED_RESULT_KEY]) {
                
                float roundedValue = [m.value floatValue];
                NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                [formatter setMaximumFractionDigits:1];
                [formatter setRoundingMode: NSNumberFormatterRoundUp];
                
                NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
                [formatter release];
                
                
                [taskPole6 setText:numberString];
            }
        }
        
        [metrics release];
        [result release];
    }
    
    
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

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [noteTextFooter setFrame:CGRectMake(6, self.view.frame.size.height-27, 464, 22)];
    [noteTextBody setFrame:CGRectMake(6, 511+30, 464, noteTextFooter.frame.origin.y-511-30)];
    [noteTextEditor setFrame:CGRectMake(24, 511+30, 427, noteTextBody.frame.size.height)];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//	return YES;
//}
//
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

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    [self upShift:textView];
}

- (void) textViewDidEndEditing:(UITextView *)textView
{
    [self downShift:textView];
}

- (void) dealloc
{
    [super dealloc];
    
    [noteTextBody release];
    [noteTextFooter release];
    [noteTextEditor release];
//    [cancelButton release];
    [taskData release];
    [alert release];
    [cancelTaskAlert release];
    [errorAlert release];
    [_scroll release];
    [label release];
    [indicator release];
    [largeLabel release];
    [saveButton release];
    
    [mainNoteAnketaDesc release];
    [underNoteAnketaDesc release];
//    [controlList release];
}

- (void)upShift:(id)sender
{
    if(sender != noteTextEditor)
        return;
    
    NSLog(@"UIKeyboardDidShowNotification occures");
    [UIView beginAnimations:@"Shift" context:nil];
    [UIView setAnimationDuration:0.5];
    
    [self.view superview].frame = CGRectMake([self.view superview].frame.origin.x, [self.view superview].frame.origin.y - 354, [self.view superview].frame.size.width, [self.view superview].frame.size.height);
//    [[SberbankAuditAppDelegate instance].rootViewController.view superview].frame = CGRectMake([[SberbankAuditAppDelegate instance].rootViewController.view superview].frame.origin.x - 324, [[SberbankAuditAppDelegate instance].rootViewController.view superview].frame.origin.y, [[SberbankAuditAppDelegate instance].rootViewController.view superview].frame.size.width, [[SberbankAuditAppDelegate instance].rootViewController.view superview].frame.size.height);
    
    [UIView commitAnimations];
}

- (void)downShift:(id)sender
{
    if(sender != noteTextEditor)
        return;
    
    NSLog(@"UIKeyboardDidHideNotification occures");
    [UIView beginAnimations:@"BackShift" context:nil];
    [UIView setAnimationDuration:0.5];
    
    
    [self.view superview].frame = CGRectMake([self.view superview].frame.origin.x, [self.view superview].frame.origin.y + 354, [self.view superview].frame.size.width, [self.view superview].frame.size.height);
//    [[SberbankAuditAppDelegate instance].rootViewController.view superview].frame = CGRectMake([[SberbankAuditAppDelegate instance].rootViewController.view superview].frame.origin.x + 324, [[SberbankAuditAppDelegate instance].rootViewController.view superview].frame.origin.y, [[SberbankAuditAppDelegate instance].rootViewController.view superview].frame.size.width, [[SberbankAuditAppDelegate instance].rootViewController.view superview].frame.size.height);
    
    [UIView commitAnimations];
}


@end
