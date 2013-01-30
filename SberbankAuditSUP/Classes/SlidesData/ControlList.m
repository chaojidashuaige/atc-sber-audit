//
//  ControlList.m
//  SberbankAudit
//
//  Created by Artem Koulikov on 29.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ControlList.h"
#import "Support.h"
#import "RootViewController.h"
#import "SberbankAuditAppDelegate.h"
#import "MenuViewController.h"
#import "Support.h"
#import "SUPApplication.h"
#import "SUPConnectionProfile.h"
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
#import "ODMobileObjField.h"
#import "ODMobileOdObject.h"
#import "ODMobileActivityStatusMBO.h"
#import "ODMobileMBO_getTaskStatuses.h"
#import "DataViewController.h"
#import "DetailTaskSlide.h"
#import "TaskActivity.h"
#import "TaskSelectActivity.h"

@implementation ControlList

bool look = false;

@synthesize frameRect,checkListTemplate;
@synthesize timer;
@synthesize varForLoadCL;
@synthesize taskID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTaskInfo:(NSDictionary*)info
{
    if (self = [super init])
	{
        taskInfo = [[NSMutableDictionary alloc] initWithDictionary:info];
//        taskInfo = [[NSMutableDictionary alloc] init];
        [self.view setFrame:frame];
        [self.view setBackgroundColor:[UIColor blackColor]];

        [SberbankAuditAppDelegate instance].finishTask = FALSE;
        
        varForLoadCL = @"true";
        timerCount = false;
        [[SberbankAuditAppDelegate instance].rootViewController.menuViewController animateCLSaveButton:self];
//        [[SberbankAuditAppDelegate instance].rootViewController.menuViewController animateCLSaveButton:[SberbankAuditAppDelegate instance].currentControlList];
	}
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
//    if(controlListHTML != nil)
//    {
//        return;
//    }
    NSLog(@"viewWillAppear: TASK_ID: %@",[taskInfo valueForKey:@"x.TASK_ID"]);
    [super viewWillAppear:animated];

    
    [SberbankAuditAppDelegate instance].currentTaskID = [NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]];
    NSLog(@"%@",[SberbankAuditAppDelegate instance].currentTaskID);

    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 0)
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
}

- (void) loadWebView
{
    controlListHTML = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    controlListHTML.delegate = self;
    controlListHTML.scrollView.delegate = self;
    controlListHTML.dataDetectorTypes = UIDataDetectorTypeLink;
    [self.view addSubview:controlListHTML];
    


    NSString *path;
	NSBundle *thisBundle = [NSBundle mainBundle];
	path = [thisBundle pathForResource:@"checklist" ofType:@"html"];
    
	NSURL *instructionsURL = [NSURL fileURLWithPath:path];
	[controlListHTML loadRequest:[NSURLRequest requestWithURL:instructionsURL]];
    controlListHTML.scalesPageToFit = YES ;
    
    [SberbankAuditAppDelegate instance].controlListHTML = controlListHTML;
}



- (void)getCheckList
{
    NSString * tamplateID = [NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.CHECKLIST_TEMPLATE_ID"]];
    ODMobileMBO_getChecklists * checkList = [ODMobileMBO_getChecklists findByPrimaryKey:tamplateID];
    NSMutableString * checkTemplate = [NSMutableString stringWithString:@""];
    if (checkList != nil) {
        SUPBigString * checkListBody = checkList.CHECKLIST_BODY;
        [checkListBody openForRead];
        int bufferLength = 16384;
        NSString * buf = [checkListBody read:bufferLength];
        while (buf != nil) {
            [checkTemplate appendString:buf];
            buf = [checkListBody read:bufferLength];
        }
        [checkListBody close];
    }
    checkListTemplate = checkTemplate;
    if (checkTemplate == nil) {
        NSLog(@"ChecklistTemplate is empty");
    }
}

- (void)getInitialData
{
    ODMobileMBO_getTasks * currentTask = [ODMobileMBO_getTasks findByPrimaryKey:[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]]];
    NSLog(@"TASK_ID getInitialData = %@",[taskInfo valueForKey:@"x.TASK_ID"]);
    NSString * initData = [NSString stringWithFormat:@"%@",currentTask.INITIAL_DATA];
    [taskInfo setObject:initData forKey:@"x.INITIAL_DATA"];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self getCheckList];
    [self getInitialData];
//     NSString *originalDBPath = [[NSBundle mainBundle] pathForResource:@"checklist" ofType:@"js"];
//    NSLog(@"%@", [NSBundle mainBundle]);
//    NSString * string = @"checklist.js";
//    NSString *stringFromData = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:string]];
//    NSData *stringFromData = [NSData dataWithContentsOfFile:string];
//    BOOL fb = [[NSFileManager defaultManager] fileExistsAtPath:originalDBPath];
    
    NSLog(@"Initial data: %@",[taskInfo valueForKey:@"x.INITIAL_DATA"]);
    NSLog(@"The second initial data: %s",[[taskInfo valueForKey:@"x.INITIAL_DATA"] UTF8String]);
//    NSLog(@"Checklist tenplate: %@",checkListTemplate);
    
    NSString * function;
    if ([varForLoadCL isEqualToString:@"false"]) {
        function = [[NSString alloc] initWithFormat: @"$(function() {xml = '%@';answers = '%@';LoadCL(xml,answers,false);});",[checkListTemplate stringByReplacingOccurrencesOfString:@"'" withString:@"&#39;"],[[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.INITIAL_DATA"]] stringByReplacingOccurrencesOfString:@"'" withString:@""]];
    }
    else
    {
        function = [[NSString alloc] initWithFormat: @"$(function() {xml = '%@';answers = '%@';LoadCL(xml,answers,true);});",[checkListTemplate stringByReplacingOccurrencesOfString:@"'" withString:@"&#39;"],[[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.INITIAL_DATA"]] stringByReplacingOccurrencesOfString:@"'" withString:@""]];
    }
 
	[webView stringByEvaluatingJavaScriptFromString:function];
	[function release];
    
    NSLog(@"TASK_ID viewDidFinish... = %@",[taskInfo valueForKey:@"x.TASK_ID"]);
    currentTaskID = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]]];
    
//    [self doneCL];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == errorAlert) {
        if (buttonIndex == 0) {
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
    if (alertView == finishTaskAlert) {
        if (buttonIndex == 0) {
            [SberbankAuditAppDelegate instance].finishTask = FALSE;
        }
        if (buttonIndex == 1) {
            [SberbankAuditAppDelegate instance].finishTask = TRUE;
            [self performSelector:@selector(doneCL) withObject:nil afterDelay:0.2];
//            [self doneCL];
        }
    }
}

- (void)loadCL
{
    [[SberbankAuditAppDelegate instance] openActivityIndicatorViewWithName:@"Синхронизация данных"];

    @try {
        SUPObjectList * fieldList = [SUPObjectList new];
        ODMobileMBO_getTasks * updateTask = [ODMobileMBO_getTasks findByPrimaryKey:[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]]];
        
        
        //TASK_ID
//        [updateTask setTASK_ID:[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]]];
        ODMobileObjField * field1 = [ODMobileObjField new];
        [field1 setNm:@"TASK_ID"];
        [field1 setVl:[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]]];
        [fieldList add:field1];
        NSLog(@"name = %@, value =%@",field1.nm, field1.vl);
        [field1 release];
        
        //FACT_START_DTTM
        NSDate * currentDate = [NSDate date];
        long long currentTime = [currentDate timeIntervalSince1970];
        currentTime = currentTime * 1000;
        NSNumber * numberTime = [NSNumber numberWithLongLong:currentTime];
        
        [updateTask setFACT_START_DTTM:[NSString stringWithFormat:@"%@",numberTime]];
        ODMobileObjField * field2 = [ODMobileObjField new];
        [field2 setNm:@"FACT_START_DTTM"];
        [field2 setVl:[NSString stringWithFormat:@"%@",numberTime]];
        [fieldList add:field2];
        NSLog(@"name = %@, value =%@",field2.nm, field2.vl);
        [field2 release];

        
        NSLog(@"Old task statusID = %@",[updateTask TASK_STATUS_ID]);

        //TASK_STATUS_ID
        [updateTask setTASK_STATUS_ID:@"4"];
        ODMobileObjField * field3 = [ODMobileObjField new];
        [field3 setNm:@"TASK_STATUS_ID"];
//        [field3 setVl:@"8"];
        [field3 setVl:@"4"];
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

        NSLog(@"new befor sync task statusID = %@",[updateTask TASK_STATUS_ID]);

        
        [ODMobileODMobileDB synchronize:@"TasksSG"];
        
        [[SberbankAuditAppDelegate instance] closeActivityIndicator];

        
        ODMobileMBO_getTasks * task = [ODMobileMBO_getTasks findByPrimaryKey:[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]]];
        NSLog(@"New after sync task statusID = %@",[task TASK_STATUS_ID]);
        if (![[NSString stringWithFormat:@"%@",[task TASK_STATUS_ID]] isEqualToString:@"4"]) {
            [[SberbankAuditAppDelegate instance] closeActivityIndicator];
            errorAlert = [[UIAlertView alloc] initWithTitle:@"Произошла ошибка синхронизации" message:@"Необходимо провести синхронизацию еще раз" delegate:self cancelButtonTitle:@"Выполнить синхронизацию" otherButtonTitles:nil, nil];
            [errorAlert show];
        }
        
        

//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [ODMobileODMobileDB synchronize:@"TasksSG"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC updateData];
//                [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController updateData];
//            });
//        });

        
        [fieldList release];
        
        NSLog(@"At-Consulting: Application is saved");
    }
    @catch (SUPPersistenceException *exception)
    {
        [[SberbankAuditAppDelegate instance] closeActivityIndicator];

        NSLog(@"At-Consulting: Save error: %@ - %@",exception.name,exception.message);
    }
    
    [self loadWebView];
    
//    [controlListHTML stopLoading];
//    [controlListHTML reload];
    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC updateData];
    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController updateData];
    
    [self timerStart];
}

- (void)lookCL
{
//    [[SberbankAuditAppDelegate instance].rootViewController.menuViewController animateCLSaveButton:self];
    [[SberbankAuditAppDelegate instance].rootViewController.menuViewController animateCLSaveButton:[SberbankAuditAppDelegate instance].currentControlList];
    look = !look;
    
    [self loadWebView];
}

- (void) saveCL
{
    NSLog(@"Save mothod called");
    
//    SUPObjectList * allStatuses = [ODMobileMBO_getTaskStatuses findAll];
//    for (int i = 0; i < allStatuses.size; i++) {
//        NSLog(@"%@", [allStatuses objectAtIndex:i]);
//    }
    
//    NSString * task_ID = [NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]];

//    ODMobileMBO_getTasks * task = [ODMobileMBO_getTasks findByPrimaryKey:self.taskID];
    ODMobileMBO_getTasks * task = [ODMobileMBO_getTasks findByPrimaryKey:[SberbankAuditAppDelegate instance].currentTaskID];
    
    NSString * taskStatus = [task TASK_STATUS_ID];
    NSLog(@"Task_ID = %@",[task TASK_ID]);
    if (![taskStatus isEqualToString:@"4"]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Невозможно сохранить данные" message:@"Задача не находится в статусе 'В работе'" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return ;
    }

    [[SberbankAuditAppDelegate instance] openActivityIndicatorViewWithName:@"Сохранение данных"];

//    NSString * result = [NSString stringWithFormat:@"%@",[controlListHTML stringByEvaluatingJavaScriptFromString:@"GetAnswers();"]];
    NSString * result = [NSString stringWithFormat:@"%@",[[SberbankAuditAppDelegate instance].controlListHTML stringByEvaluatingJavaScriptFromString:@"GetAnswers();"]];
    @try {
        SUPObjectList * fieldList = [SUPObjectList new];
//        ODMobileMBO_getTasks * updateTask = [ODMobileMBO_getTasks findByPrimaryKey:[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]]];
        ODMobileMBO_getTasks * updateTask = [ODMobileMBO_getTasks findByPrimaryKey:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].currentTaskID]];
        
        
        //TASK_ID
//        [updateTask setTASK_ID:[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]]];
//        [updateTask setTASK_ID:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].currentTaskID]];
        ODMobileObjField * field1 = [ODMobileObjField new];
        [field1 setNm:@"TASK_ID"];
        [field1 setVl:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].currentTaskID]];
        [fieldList add:field1];
        NSLog(@"name = %@, value =%@",field1.nm, field1.vl);
        [field1 release];
        
        //INITIAL_DATA
//        [updateTask setINITIAL_DATA:result];
        ODMobileObjField * field2 = [ODMobileObjField new];
        [field2 setNm:@"INITIAL_DATA"];
        [field2 setVl:result];
        [fieldList add:field2];
        NSLog(@"name = %@, value =%@",field2.nm, field2.vl);
        [field2 release];
        
        
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

//        //TASK_STATUS_ID
//        [updateTask setTASK_STATUS_ID:@"4"];
//        ODMobileObjField * field3 = [ODMobileObjField new];
//        [field3 setNm:@"TASK_STATUS_ID"];
//        [field3 setVl:@"4"];
////        [field3 setVl:[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_STATUS_ID"]]];
//        [fieldList add:field3];
//        NSLog(@"name = %@, value =%@",field3.nm, field3.vl);
//        [field3 release];

        ODMobileOdObject * odObject = [ODMobileOdObject new];
        [odObject setFl:fieldList];
        [updateTask update:@"SUP_FCT_TASKS" withOdObject:odObject];
        [updateTask submitPending];
        
//        [[SberbankAuditAppDelegate instance] openActivityIndicatorViewWithName:@"Сохранение данных"];

        
        [ODMobileODMobileDB synchronize:@"TasksSG"];
        
        
        [[SberbankAuditAppDelegate instance] closeActivityIndicator];
        

        [fieldList release];
        
        NSLog(@"At-Consulting: Application is saved");
    }
    @catch (SUPPersistenceException *exception)
    {
        [[SberbankAuditAppDelegate instance] closeActivityIndicator];
        NSLog(@"At-Consulting: Save error: %@ - %@",exception.name,exception.message);
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:@"Ошибка синхронизация" message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [alert1 show];
        [alert1 release];
    }
    @catch (NSExpression *exception)
    {
//        NSLog(@"At-Consulting: Save error: %@ - %@",exception.name,exception.message);
        [[SberbankAuditAppDelegate instance] closeActivityIndicator];
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:@"Ошибка синхронизации" message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [alert1 show];
        [alert1 release];
    }
    //кусочек кода для обновления данных по заявке
//    [controlListHTML stopLoading];
//    [controlListHTML reload];
    
    
//    [[SberbankAuditAppDelegate instance].controlListHTML stopLoading];
//    [[SberbankAuditAppDelegate instance].controlListHTML reload];
    
    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC updateData];
//    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController updateData];

}


- (void) doneCL
{
    NSLog(@"Done mothod called");
    NSLog(@"current Task: %@",currentTaskID);
    
//    NSString * task_ID = [NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]];
//    ODMobileMBO_getTasks * task = [ODMobileMBO_getTasks findByPrimaryKey:task_ID];
    
//    NSLog(@"task_id = %@",self.taskID);
//    NSLog(@"task_id = %@",[taskInfo valueForKey:@"x.TASK_ID"]);
//    ODMobileMBO_getTasks * task = [ODMobileMBO_getTasks findByPrimaryKey:self.taskID];
    ODMobileMBO_getTasks * task = [ODMobileMBO_getTasks findByPrimaryKey:[SberbankAuditAppDelegate instance].currentTaskID];
    NSLog(@"TASK_STATUS_ID = %@",[task TASK_STATUS_ID]);
    NSLog(@"TASK_ID = %@",[task TASK_ID]);

    
    NSString * taskStatus = [task TASK_STATUS_ID];
    if (![taskStatus isEqualToString:@"4"]) {
        if ([taskStatus isEqualToString:@"6"]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Невозможно сохранить данные" message:@"Задача Выполнена" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return ;
        }
        
        if (![taskStatus isEqualToString:@"3"]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Невозможно сохранить данные" message:@"Задача Отменена" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return ;
        }

        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Невозможно выполнить задачу" message:@"Задача должна находиться в статусе \"В работе\"" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return ;
    }
    
//    NSString * isValidate = [NSString stringWithFormat:@"%@",[controlListHTML stringByEvaluatingJavaScriptFromString:@"ValidateCL();"]];
    NSString * isValidate = [NSString stringWithFormat:@"%@",[[SberbankAuditAppDelegate instance].controlListHTML stringByEvaluatingJavaScriptFromString:@"ValidateCL();"]];
    NSLog(@"HTML = %@",[SberbankAuditAppDelegate instance].controlListHTML);
    NSLog(@"isValidate = %@",isValidate);
    if ([isValidate isEqualToString:@"false"]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка выполнения" message:@"Заполните все обязательные вопросы" delegate:self cancelButtonTitle:@"Вернуться к заполнению" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return ;
    }
    
    
    
    if (![SberbankAuditAppDelegate instance].finishTask) {
        finishTaskAlert = [[UIAlertView alloc] initWithTitle:@"Завершение задачи" message:@"Действительно завершить проверку?" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil];
        [finishTaskAlert show];
        return ;
    }
    
    
    

    [[SberbankAuditAppDelegate instance] openActivityIndicatorViewWithName:@"Сохранение данных"];

//    NSString * result = [NSString stringWithFormat:@"%@",[controlListHTML stringByEvaluatingJavaScriptFromString:@"GetAnswers();"]];
    NSString * result = [NSString stringWithFormat:@"%@",[[SberbankAuditAppDelegate instance].controlListHTML stringByEvaluatingJavaScriptFromString:@"GetAnswers();"]];

    @try {
        SUPObjectList * fieldList = [SUPObjectList new];
//        ODMobileMBO_getTasks * updateTask = [ODMobileMBO_getTasks findByPrimaryKey:[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]]];
        ODMobileMBO_getTasks * updateTask = [ODMobileMBO_getTasks findByPrimaryKey:[SberbankAuditAppDelegate instance].currentTaskID];
        
        
        //TASK_ID
        ODMobileObjField * field1 = [ODMobileObjField new];
        [field1 setNm:@"TASK_ID"];
//        [field1 setVl:[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.TASK_ID"]]];
        [field1 setVl:[NSString stringWithFormat:@"%@",[updateTask TASK_ID]]];
        [fieldList add:field1];
        NSLog(@"name = %@, value =%@",field1.nm, field1.vl);
        [field1 release];

        //TASK_STATUS_ID
        ODMobileObjField * field3 = [ODMobileObjField new];
        [field3 setNm:@"TASK_STATUS_ID"];
        [field3 setVl:@"6"];
        [fieldList add:field3];
        NSLog(@"name = %@, value =%@",field3.nm, field3.vl);
        [field3 release];
        [SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController.lastStatus = @"Выполнена";
        
        
        //INITIAL_DATA
        ODMobileObjField * field2 = [ODMobileObjField new];
        [field2 setNm:@"INITIAL_DATA"];
        [field2 setVl:result];
        [fieldList add:field2];
        NSLog(@"name = %@, value =%@",field2.nm, field2.vl);
        [field2 release];

        
        //FACT_END_DTTM
        NSDate * currentDate = [NSDate date];
        long long currentTime = [currentDate timeIntervalSince1970];
        currentTime = currentTime * 1000;
        NSNumber * numberTime = [NSNumber numberWithLongLong:currentTime];
        
        ODMobileObjField * field4 = [ODMobileObjField new];
        [field4 setNm:@"FACT_END_DTTM"];
        [field4 setVl:[NSString stringWithFormat:@"%@",numberTime]];
        [fieldList add:field4];
        NSLog(@"name = %@, value =%@",field4.nm, field4.vl);
        [field4 release];
        
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
//        [[SberbankAuditAppDelegate instance] openActivityIndicatorViewWithName:@"Сохранение данных"];
        [updateTask update:@"SUP_FCT_TASKS" withOdObject:odObject];
        [updateTask submitPending];
        
        
        [ODMobileODMobileDB synchronize:@"TasksSG"];
        [ODMobileODMobileDB synchronize:@"DIMSG"];
        [ODMobileODMobileDB synchronize:@"DIMSG_TASK_REL"];
        
        [SberbankAuditAppDelegate instance].finishTask = FALSE;
        
        
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
    
//    [controlListHTML stopLoading];
//    [controlListHTML reload];
    [[SberbankAuditAppDelegate instance].controlListHTML stopLoading];
    [[SberbankAuditAppDelegate instance].controlListHTML reload];
    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC updateData];
    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController updateData];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void) dealloc
{
    [controlListHTML release];
//    [taskInfo release]; 
    [checkListTemplate release];
    [timer release];
    [varForLoadCL release];
    [taskID release];
    [errorAlert release];
    [finishTaskAlert release];
    [super dealloc];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (look) {
//        [[SberbankAuditAppDelegate instance].rootViewController.menuViewController animateCLSaveButton:self];
        [[SberbankAuditAppDelegate instance].rootViewController.menuViewController animateCLSaveButton:[SberbankAuditAppDelegate instance].currentControlList];
        look = !look;
    }
//    [[SberbankAuditAppDelegate instance].rootViewController.menuViewController.CLSaveButton setAlpha:1.0];
//    [[SberbankAuditAppDelegate instance].rootViewController.menuViewController.CLDoneButton setAlpha:1.0];
//    [[SberbankAuditAppDelegate instance].rootViewController.menuViewController animateCLSaveButton:self];
    [[SberbankAuditAppDelegate instance].rootViewController.menuViewController animateCLSaveButton:[SberbankAuditAppDelegate instance].currentControlList];
    
    [self viewControllerWillClose];
    NSLog(@"viewWillDisappear called");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self timerStart];
//    });
    
    
//    [self timerStart];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    if ([timer isValid]) {
		[timer invalidate];
        [timer release];
	}
	timer = nil;
}

- (void)timerStart
{
    NSLog(@"timeStart called");
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkScriptFunc) userInfo:nil repeats:YES];
//    NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
//    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
//    [runLoop run];
}

- (void)checkScriptFunc
{
//    NSString * itemID = [NSString stringWithFormat:@"%@",[controlListHTML stringByEvaluatingJavaScriptFromString:@"ItemID();"]];
//    NSLog(@"itemID = %@",itemID);
//    NSString * questionID = [NSString stringWithFormat:@"%@",[controlListHTML stringByEvaluatingJavaScriptFromString:@"QuestionID();"]];
//    NSLog(@"questionID = %@",questionID);
//    NSString * textID = [NSString stringWithFormat:@"%@",[controlListHTML stringByEvaluatingJavaScriptFromString:@"myText();"]];
//    NSLog(@"myText = %@",textID);
    NSString * itemID = [NSString stringWithFormat:@"%@",[[SberbankAuditAppDelegate instance].controlListHTML stringByEvaluatingJavaScriptFromString:@"ItemID();"]];
    NSLog(@"itemID = %@",itemID);
    NSString * questionID = [NSString stringWithFormat:@"%@",[[SberbankAuditAppDelegate instance].controlListHTML stringByEvaluatingJavaScriptFromString:@"QuestionID();"]];
    NSLog(@"questionID = %@",questionID);
    NSString * activityID = [NSString stringWithFormat:@"%@",[[SberbankAuditAppDelegate instance].controlListHTML stringByEvaluatingJavaScriptFromString:@"ActivityID();"]];
    NSLog(@"activityID = %@",activityID);
    
    if (![activityID isEqualToString:@"activity"]) {
        currentActivityID = [[NSString alloc] initWithString:activityID];
        if (timer.isValid) {
            [timer invalidate];
        }
        timer = nil;
        [self openActivity];

        [NSString stringWithFormat:@"%@",[[SberbankAuditAppDelegate instance].controlListHTML stringByEvaluatingJavaScriptFromString:@"clear();"]];
        timerCount = true;
        
        [currentActivityID release];
    }
    
    if (![itemID isEqualToString:@"item"] && ![questionID isEqualToString:@"question"] ) {
        if (timer.isValid) {
            [timer invalidate];
        }
        timer = nil;
        [self createNewActivity];
//        [NSString stringWithFormat:@"%@",[controlListHTML stringByEvaluatingJavaScriptFromString:@"clear();"]];
        [NSString stringWithFormat:@"%@",[[SberbankAuditAppDelegate instance].controlListHTML stringByEvaluatingJavaScriptFromString:@"clear();"]];
        timerCount = true;
    }
    if (timerCount) {
        [self timerStart];
        timerCount = false;
    }
}

- (void)createNewActivity
{
    TaskActivity * newActivity = [[TaskActivity alloc] initWithFrame:CGRectMake(0, 0, 504 + 200, 678)];
    newActivity.taskPlan = self;
    
    NSNumber * branch = [NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"x.SUBBRANCH_ID"] ] integerValue]];
    NSNumber * union_ID = [NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",[taskInfo valueForKey:@"unions.UNION_ID"] ] integerValue]];

    newActivity.SUBBRANCH_ID = branch;
    newActivity.UNION_ID = union_ID;
    newActivity.questionID = [NSString stringWithFormat:@"%@",[[SberbankAuditAppDelegate instance].controlListHTML stringByEvaluatingJavaScriptFromString:@"QuestionID();"]];
    newActivity.answerID = [NSString stringWithFormat:@"%@",[[SberbankAuditAppDelegate instance].controlListHTML stringByEvaluatingJavaScriptFromString:@"ItemID();"]];
    NSLog(@"%@", newActivity.questionID);
    NSLog(@"%@", newActivity.answerID);

    newActivity.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:newActivity animated:YES];
    [[newActivity.view superview] setFrame:CGRectMake(roundf([newActivity.view superview].center.x-352), roundf([newActivity.view superview].center.y-339), 704, 678)];
    [newActivity release];

}

- (void)openActivity
{
    TaskSelectActivity *selectActivity = [[TaskSelectActivity alloc] initWithFrame:CGRectMake(0, 0, 504+200, 678)];
    selectActivity.taskPlan = self;
    selectActivity.arraySelectActivity = [self getActivity];
    NSLog(@"Activity_ID %@",[selectActivity.arraySelectActivity valueForKey:@"x.ACTIVITY_ID"]);
    selectActivity.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:selectActivity animated:YES];
    [[selectActivity.view superview] setFrame:CGRectMake(roundf([selectActivity.view superview].center.x-352), roundf([selectActivity.view superview].center.y-339), 704, 678)];
    [selectActivity release];
}

- (NSMutableDictionary*)getActivity
{
    NSMutableDictionary * theDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSLog(@"TASK_ID = %@",self.taskID);
    
    ODMobileMBO_getTasks * currentTask = [ODMobileMBO_getTasks findByPrimaryKey:self.taskID];
    NSString * unionID = [NSString stringWithFormat:@"%@",[currentTask UNION_ID]];
    NSString * branchId = [NSString stringWithFormat:@"%@",[currentTask SUBBRANCH_ID]];
    
    if ([branchId isEqualToString:@"0"]) {
        NSLog(@"branch is not defined");
    }
    NSLog(@"union = %@", unionID);
    NSLog(@"branch = %@", branchId);

    NSMutableArray * tweets = [[NSMutableArray alloc] init];

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

        if ([[NSString stringWithFormat:@"%@",[dict valueForKey:@"x.ACTIVITY_ID"]] isEqualToString:currentActivityID]) {
            NSLog(@"Current activity is defined");
            [tweets addObject:dict];
//            theDictionary = [[NSMutableDictionary alloc] initWithDictionary:dict];
            [theDictionary setDictionary:dict];
        }

        [dict release];
    }

//    for (int i = 0; i < activities.columnNames.size; i++) {
//        [allKeys addObject:[[activities columnNames] objectAtIndex:i]];
//    }
//
//    //    NSLog(@"Number of activities = %i",[activities size]);
//    [activities close];

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
        
        if ([[NSString stringWithFormat:@"%@",[dict valueForKey:@"x.ACTIVITY_ID"]] isEqualToString:currentActivityID]) {
            NSLog(@"Current activity is defined");
            [tweets addObject:dict];
        }

        [dict release];
    }
    
    NSLog(@"Number of activities = %i",tweets.count);
    [activities close];

    
    [tweets release];
    
    return theDictionary;
}

//- (void)getActivity
//{
//    if ([[NSString stringWithFormat:@"%@",branchId] isEqualToString:@"0"]) {
//        NSLog(@"branch is not defined");
//    }
//    NSLog(@"union = %@", unionID);
//    NSLog(@"branch = %@", branchId);
//    //    tweets = [[NSMutableArray alloc] init];
//    
//    [tweets release];
//    tweets = [[NSMutableArray alloc] init];
//    
//    SUPQueryResultSet * activities = [ODMobileMBO_getActivities getActivitiesBySubbranchId:[NSString stringWithFormat:@"%@",branchId]];
//    for (int i = 0; i < activities.size; i++) {
//        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
//        for (int j = 0; j < activities.columnNames.size; j++) {
//            if ([[activities objectAtIndex:i] objectAtIndex:j] == nil) {
//                [dict setObject:@"" forKey:[[activities columnNames] objectAtIndex:j]];
//            }
//            else
//            {
//                [dict setObject:[[activities objectAtIndex:i] objectAtIndex:j] forKey:[[activities columnNames] objectAtIndex:j]];
//            }
//        }
//        [dict setObject:@"ACTIVITY" forKey:@"TASK_OR_ACTIVITY"];
//        
//        [tweets addObject:dict];
//        [dict release];
//    }
//    
//    for (int i = 0; i < activities.columnNames.size; i++) {
//        [allKeys addObject:[[activities columnNames] objectAtIndex:i]];
//    }
//    
//    //    NSLog(@"Number of activities = %i",[activities size]);
//    [activities close];
//    
//    activities = [ODMobileMBO_getActivities getActivitiesBySubbranchId:[NSString stringWithFormat:@"%@",unionID]];
//    for (int i = 0; i < activities.size; i++) {
//        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
//        for (int j = 0; j < activities.columnNames.size; j++) {
//            if ([[activities objectAtIndex:i] objectAtIndex:j] == nil) {
//                [dict setObject:@"" forKey:[[activities columnNames] objectAtIndex:j]];
//            }
//            else
//            {
//                [dict setObject:[[activities objectAtIndex:i] objectAtIndex:j] forKey:[[activities columnNames] objectAtIndex:j]];
//            }
//        }
//        [dict setObject:@"ACTIVITY" forKey:@"TASK_OR_ACTIVITY"];
//        
//        [tweets addObject:dict];
//        [dict release];
//    }
//    
//    NSLog(@"Number of activities = %i",tweets.count);
//    [activities close];
//    //    [_tableView reloadData];
//
//}

- (void)updateData
{
    NSLog(@"Update data method is called");
    
//    [self loadWebView];
//    [controlListHTML stopLoading];
//    [controlListHTML reload];
    [[SberbankAuditAppDelegate instance].controlListHTML stopLoading];
    [[SberbankAuditAppDelegate instance].controlListHTML reload];
    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC updateData];
    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController updateData];
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [controlListHTML setFrame:CGRectMake(controlListHTML.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//	return NO;
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
//    return NO;
}

#pragma mark StackScrollViewController Delegate methods

- (void) viewControllerWillClose
{
    printf("viewControllerWillClose called");
    if (timer.isValid) {
        [timer invalidate];
    }
    timer = nil;
//    [taskInfo release];
}

@end
