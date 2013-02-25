//
//  TaskSelectActivity.m
//  SberbankAudit
//
//  Created by Артем Куликов on 16.05.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "TaskSelectActivity.h"
#import "SberbankAuditAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
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
#import "ODMobileMBO_getEmployees.h"
#import "ODMobileMBO_getActivities.h"
#import "ODMobileActivityStatusMBO.h"
#import "ODMobileMBOActivityTemplates.h"
#import "ODMobileMBO_getActivityPriorities.h"
#import "TaskActivityStatus.h"
#import "TaskActivityTemplate.h"
#import "TaskActivitySubType.h"
#import "TaskActivityPriority.h"
#import "TastActivityResponsible.h"
#import "TaskActivityInspector.h"
#import "WaitingViewController.h"
#import "ODMobileMBO_getTaskTypes.h"
#import "ODMobileMBOUnions.h"
#import "EmployeeDTO.h"

#define LABELS_FONT_SIZE 16.0f
#define TITLE_FONT_SIZE 18.0f
#define FIRST_HIERARCHY_LEVEL 1


@interface TaskSelectActivity ()

@end

@implementation TaskSelectActivity

@synthesize aTypeButton;
@synthesize aPriorityButton;
@synthesize aEndDateButton;
@synthesize arraySelectActivity;
@synthesize scroll;
@synthesize aStatusButton;
@synthesize taskPlan;
@synthesize arrayWithStatuses;
@synthesize lastStatus;
@synthesize currentStatus;
@synthesize aNotesText;
@synthesize aResponsibleButton;
@synthesize aInspectorButton;
@synthesize RESPONSER_ID;
@synthesize INSPECTOR_ID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (CGFloat) heightForCellWithText:(NSString*)myCell maxHeight:(float)max
{
    CGSize constraint = CGSizeMake(350, max);
    
    CGSize size = [myCell sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 21.0f);
    
    return height;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init])
	{
        [self.view setFrame:frame];
        
        [self.view setAutoresizesSubviews:NO];
        
        isCreator = false;
        isResponser = false;
        isInspertor = false;
        
        self.lastStatus = [NSString string];
        self.currentStatus = [NSString string];
        
//        scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];

//        label = [[UILabel alloc] initWithFrame:CGRectMake(300, 500, 200, 60)];
//        [label setText:@"Идет синхронизация"];
//        [label setBackgroundColor:[UIColor lightGrayColor]];
//        [label setTextAlignment:UITextAlignmentCenter];
//        //        [scroll addSubview:label];
//        [label setHidden:YES];
//        
//        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        indicator.center = CGPointMake(250, 530);
//        [indicator setHidden:YES];
//        //        [scroll addSubview:indicator];

        

        
        self.arrayWithStatuses = [NSMutableArray arrayWithCapacity:0];
        
        scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
        scroll.showsHorizontalScrollIndicator = YES;
        scroll.userInteractionEnabled = YES;
        scroll.scrollEnabled = YES;
        scroll.contentSize = CGSizeMake(504, 1100);
        scroll.delegate = self;
        [self.view addSubview:scroll];
        
        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35 + 100 -100, 25, 440+200, 21)];
        [aTitleLabel setTextAlignment:UITextAlignmentCenter];
        [aTitleLabel setFont:[UIFont systemFontOfSize:TITLE_FONT_SIZE]];
        [aTitleLabel setTextColor:[UIColor blackColor]];
        [aTitleLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aTitleLabel];
           
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 65, 420+200, 4)];
        [lineLabel setBackgroundColor:[UIColor colorWithRed:0.4 green:0.6 blue:1.0 alpha:1.0]];
        [scroll addSubview:lineLabel];
        [lineLabel release];
        
        UILabel *aNotesLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 85, 240, 17)];
        [aNotesLabel setTextAlignment:UITextAlignmentLeft];
        [aNotesLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aNotesLabel setText:@"Указание:"];
        [aNotesLabel setTextColor:[UIColor darkGrayColor]];
        [aNotesLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aNotesLabel];
        [aNotesLabel release];
        
        aNotesText = [[UITextView alloc] initWithFrame:CGRectMake(40, 115, 420, 106)];
        [aNotesText.layer setCornerRadius:10.0f];
        [aNotesText.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [aNotesText.layer setBorderWidth:1.0f];
        [aNotesText setFont:[UIFont systemFontOfSize:14.0f]];
        [scroll addSubview:aNotesText];

        
        aNotesButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        aNotesButton.frame = CGRectMake(310 + 200, 80, 150, 25);
        [aNotesButton setTitle:@"Выбрать" forState:UIControlStateNormal];
        [aNotesButton addTarget:self action:@selector(showActivityTemplates) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:aNotesButton];
        
        
        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"dd.MM.yyyy"];
//        NSString * createString = [NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"CREATED_DTTM"]];
//        double DOUBLE = [createString doubleValue]/1000;
//        NSDate * date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
//        createString = [dateFormatter stringFromDate:date];

//        [dateFormatter release];


        createDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 130, 330, 17)];
        [createDateLabel setTextAlignment:UITextAlignmentLeft];
        [createDateLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
//        [createDateLabel setText:[NSString stringWithFormat:@"Дата создания: %@", createString]];
        [createDateLabel setTextColor:[UIColor darkGrayColor]];
        [createDateLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:createDateLabel];

        
        
//        aEndDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 130, 240, 17)];
        aEndDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(310, 130, 200, 17)];
        [aEndDateLabel setTextAlignment:UITextAlignmentLeft];
        [aEndDateLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aEndDateLabel setText:@"Выполнить до:"];
        [aEndDateLabel setTextColor:[UIColor darkGrayColor]];
        [aEndDateLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aEndDateLabel];
        
        
        aEndDateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [aEndDateButton setFrame:CGRectMake(300, 340, 150, 25)];
        [aEndDateButton addTarget:self action:@selector(showCalendar) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:aEndDateButton];

        
        aStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 160, 240, 17)];
        [aStatusLabel setTextAlignment:UITextAlignmentLeft];
        [aStatusLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aStatusLabel setText:@"Статус:"];
        [aStatusLabel setTextColor:[UIColor darkGrayColor]];
        [aStatusLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aStatusLabel];
        
        aStatusButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [aStatusButton setFrame:CGRectMake(310, 160, 150, 25)];
        [aStatusButton addTarget:self action:@selector(showStatus) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:aStatusButton];

        
        aPriorityLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 190, 240, 17)];
        [aPriorityLabel setTextAlignment:UITextAlignmentLeft];
        [aPriorityLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aPriorityLabel setText:@"Приоритет:"];
        [aPriorityLabel setTextColor:[UIColor darkGrayColor]];
        [aPriorityLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aPriorityLabel];

        
        aPriorityButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        aPriorityButton.frame = CGRectMake(150, 190, 240, 17);
        [aPriorityButton addTarget:self action:@selector(showActivityPriority) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:aPriorityButton];

        
        aProblemsLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 220, 240, 17)];
        [aProblemsLabel setTextAlignment:UITextAlignmentLeft];
        [aProblemsLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aProblemsLabel setText:@"Проблема:"];
        [aProblemsLabel setTextColor:[UIColor darkGrayColor]];
        [aProblemsLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aProblemsLabel];
        
        aProblemsValue = [[UITextView alloc] initWithFrame:CGRectMake(140, 220, 240, 17)];
        [aProblemsValue.layer setCornerRadius:10.0f];
        [aProblemsValue.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [aProblemsValue.layer setBorderWidth:1.0f];
        [aProblemsValue setFont:[UIFont systemFontOfSize:14.0f]];
        [scroll addSubview:aProblemsValue];
        
        aInitiatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 250, 240, 17)];
        [aInitiatorLabel setTextAlignment:UITextAlignmentLeft];
        [aInitiatorLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aInitiatorLabel setText:@"Инициатор:"];
        [aInitiatorLabel setTextColor:[UIColor darkGrayColor]];
        [aInitiatorLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aInitiatorLabel];
        
        aInitiatorValue = [[UILabel alloc] initWithFrame:CGRectMake(150,250, 240, 17)];
        [aInitiatorValue setTextAlignment:UITextAlignmentLeft];
        [aInitiatorValue setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        //        [aInitiatorValue setText:@"Контролирующий"];
        [aInitiatorValue setTextColor:[UIColor darkGrayColor]];
        [aInitiatorValue setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aInitiatorValue];
        
        aResponsibleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 295, 240, 17)];
        [aResponsibleLabel setTextAlignment:UITextAlignmentLeft];
        [aResponsibleLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aResponsibleLabel setText:@"Ответственный:"];
        [aResponsibleLabel setTextColor:[UIColor darkGrayColor]];
        [aResponsibleLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aResponsibleLabel];

        
        aResponsibleButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        aResponsibleButton.frame = CGRectMake(150, 190, 240, 17);
        [aResponsibleButton addTarget:self action:@selector(showActivityResponser) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:aResponsibleButton];
        
        
        aDateOfResponseLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 325, 240, 17)];
        [aDateOfResponseLabel setTextAlignment:UITextAlignmentLeft];
        [aDateOfResponseLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aDateOfResponseLabel setText:@"Дата исполнения:"];
        [aDateOfResponseLabel setTextColor:[UIColor darkGrayColor]];
        [aDateOfResponseLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aDateOfResponseLabel];
        
        aDateOfResponseValue = [[UILabel alloc] initWithFrame:CGRectMake(190,325, 240, 17)];
        [aDateOfResponseValue setTextAlignment:UITextAlignmentLeft];
        [aDateOfResponseValue setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
//        [aDateOfResponseValue setText:@"asdasd"];
        [aDateOfResponseValue setTextColor:[UIColor darkGrayColor]];
        [aDateOfResponseValue setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aDateOfResponseValue];
        
        
        aPerformLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 325+30, 240, 17)];
        [aPerformLabel setTextAlignment:UITextAlignmentLeft];
        [aPerformLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aPerformLabel setText:@"Отметка об исполнении:"];
        [aPerformLabel setTextColor:[UIColor darkGrayColor]];
        [aPerformLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aPerformLabel];
        
        aInspectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 465, 240, 17)];
        [aInspectorLabel setTextAlignment:UITextAlignmentLeft];
        [aInspectorLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aInspectorLabel setText:@"Контролирующий:"];
        [aInspectorLabel setTextColor:[UIColor darkGrayColor]];
        [aInspectorLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aInspectorLabel];
        
        
        aInspectorButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        aInspectorButton.frame = CGRectMake(150, 190, 240, 17);
        [aInspectorButton addTarget:self action:@selector(showActivityInspector) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:aInspectorButton];
        
        aDateOfInspectLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 325, 240, 17)];
        [aDateOfInspectLabel setTextAlignment:UITextAlignmentLeft];
        [aDateOfInspectLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aDateOfInspectLabel setText:@"Дата закрытия:"];
        [aDateOfInspectLabel setTextColor:[UIColor darkGrayColor]];
        [aDateOfInspectLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aDateOfInspectLabel];
        
        aDateOfInspectValue = [[UILabel alloc] initWithFrame:CGRectMake(190,325, 240, 17)];
        [aDateOfInspectValue setTextAlignment:UITextAlignmentLeft];
        [aDateOfInspectValue setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
//        [aDateOfInspectValue setText:@"asdasd"];
        [aDateOfInspectValue setTextColor:[UIColor darkGrayColor]];
        [aDateOfInspectValue setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aDateOfInspectValue];
        
        aControlLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 490, 240, 17)];
        [aControlLabel setTextAlignment:UITextAlignmentLeft];
        [aControlLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aControlLabel setText:@"Отметка о контроле:"];
        [aControlLabel setTextColor:[UIColor darkGrayColor]];
        [aControlLabel setBackgroundColor:[UIColor clearColor]];
        [scroll addSubview:aControlLabel];
        
        
         
        aSaveButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
        [aSaveButton setFrame:CGRectMake(80 + 100, 635 + 250, 120, 35)];
        [aSaveButton setTitle:@"Сохранить" forState:UIControlStateNormal];
        [aSaveButton addTarget:self action:@selector(aSaveAction) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:aSaveButton];
//        [aSaveButton release];
        
        aCancelButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
        [aCancelButton setFrame:CGRectMake(300 + 100, 635 + 250, 120, 35)];
        [aCancelButton setTitle:@"Отменить" forState:UIControlStateNormal];
        [aCancelButton addTarget:self action:@selector(aCancelAction) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:aCancelButton];
//        [aCancelButton release];

        
        aNotesArea = [[UITextView alloc] initWithFrame:CGRectMake(40, 350, 420, 106)];
        [aNotesArea.layer setCornerRadius:10.0f];
        [aNotesArea.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [aNotesArea.layer setBorderWidth:1.0f];
        [scroll addSubview:aNotesArea];
        
        
        aInspectorsArea = [[UITextView alloc] initWithFrame:CGRectMake(40, 515, 420, 106)];
        [aInspectorsArea.layer setCornerRadius:10.0f];
        [aInspectorsArea.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [aInspectorsArea.layer setBorderWidth:1.0f];
        [scroll addSubview:aInspectorsArea];
        
        }
    
    return self;
}

- (void) openCamera
{    
    UIImagePickerController *photoCamera = [[UIImagePickerController alloc] init];
    photoCamera.delegate = self;
    photoCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:photoCamera animated:YES];
    [photoCamera release];
}

- (void) showActivityTemplates
{
    TaskActivityTemplate *Template = [[TaskActivityTemplate alloc] initWithStyle:UITableViewStylePlain];
    Template.tbClass = self;
    
    ODMobileMBO_getActivities * currentActivity = [ODMobileMBO_getActivities findByPrimaryKey:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.ACTIVITY_ID"]]];
    SUPObjectList * activityTemplatesList = [ODMobileMBOActivityTemplates getByActivityTypeId:[NSString stringWithFormat:@"%@",[currentActivity ACTIVITY_TYPE_ID]]];
    for (ODMobileMBOActivityTemplates * template in activityTemplatesList) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
//        [dict setObject:[NSString stringWithFormat:@"%@",[template ACTIVITY_TEMPLATE_ID]] forKey:@"ACTIVITY_TEMPLATE_ID"];
//        [dict setObject:[NSString stringWithFormat:@"%@",[template ACTIVITY_NAME]] forKey:@"ACTIVITY_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[template ACTIVITY_TEMPLATE_ID]] forKey:@"ACTIVITY_TEMPLATE_ID"];
        [dict setObject:[NSString stringWithFormat:@"%@",[template ACTIVITY_NAME]] forKey:@"ACTIVITY_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[template ACTIVITY_PRIORITY_ID]] forKey:@"ACTIVITY_PRIORITY_ID"];
        [dict setObject:[NSString stringWithFormat:@"%@",[template TIME_PERIOD]] forKey:@"TIME_PERIOD"];

        [Template.arraySubType addObject:dict];
        [dict release];
    }
    if (calendarPopover != nil) {
        [calendarPopover release];
    }
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:Template];
    calendarPopover.popoverContentSize = CGSizeMake(600, 250);
    [calendarPopover presentPopoverFromRect:aNotesButton.bounds inView:aNotesButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [Template release];
}

- (void) showCalendar
{
    NSLog(@"choose date");
    CalendarController *rtCalendar = [[CalendarController alloc] initWithNibName:nil bundle:nil];
    UIViewController *calendarViewController = (UIViewController*)rtCalendar;
    if (calendarPopover != nil) {
        [calendarPopover release];
    }
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:calendarViewController];
    [calendarPopover setPopoverContentSize:CGSizeMake(rtCalendar.calendar.frame.size.width, rtCalendar.calendar.frame.size.height)];
    rtCalendar.delegate = self;
    [calendarPopover presentPopoverFromRect:aEndDateButton.bounds inView:aEndDateButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [rtCalendar release];

}

- (void) showStatus
{
    NSLog(@"choose status");
    
    TaskActivityStatus *Status = [[TaskActivityStatus alloc] initWithStyle:UITableViewStylePlain];
    Status.taClass = self;

    for (int i = 0; i < self.arrayWithStatuses.count; i++) {
        [Status.arraySubType addObject:[self.arrayWithStatuses objectAtIndex:i]];
    }
    if (calendarPopover != nil) {
        [calendarPopover release];
    }
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:Status];
    calendarPopover.popoverContentSize = CGSizeMake(300, 140);
    [calendarPopover presentPopoverFromRect:aStatusButton.bounds inView:aStatusButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [Status release];

}

- (void) showActivityPriority
{
    NSLog(@"choose priority");
    TaskActivityPriority *Priority = [[TaskActivityPriority alloc] initWithStyle:UITableViewStylePlain];
    Priority.taClass = self;
    SUPObjectList * activityPriorities = [ODMobileMBO_getActivityPriorities findAll];
    for (int i = 0; i < activityPriorities.size; i++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSString stringWithFormat:@"%@",[[activityPriorities objectAtIndex:i] ACTIVITY_PRIORITY_ID]] forKey:@"ACTIVITY_PRIORITY_ID"];
        [dict setObject:[NSString stringWithFormat:@"%@",[[activityPriorities objectAtIndex:i] ACTIVITY_PRIORITY_NAME]] forKey:@"ACTIVITY_PRIORITY_NAME"];
        [Priority.arrayWithData addObject:dict];
        [dict release];
    }
    if (calendarPopover != nil) {
        [calendarPopover release];
    }
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:Priority];
    calendarPopover.popoverContentSize = CGSizeMake(300, 140);
    [calendarPopover presentPopoverFromRect:aPriorityButton.bounds inView:aPriorityButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [Priority release];

}

- (void) showActivityResponser
{
    NSLog(@"choose responser");
    
    TastActivityResponsible *Responcer = [[TastActivityResponsible alloc] initWithStyle:UITableViewStylePlain];
    Responcer.tbClass = self;
    for (int i = 0; i < resultEmployees.count; i++) {
        ODMobileMBO_getEmployees * employeer = [ODMobileMBO_getEmployees findByPrimaryKey:[NSString stringWithFormat:@"%@",[[resultEmployees objectAtIndex:i] employeeID]]];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer EMPLOYEE_ID]] forKey:@"EMPLOYEE_ID"];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer LAST_NAME]] forKey:@"LAST_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer FIRST_NAME]] forKey:@"FIRST_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer PATRONYMIC]] forKey:@"PATRONYMIC"];
        [Responcer.arraySubType addObject:dict];
        [dict release];
    }

    if (calendarPopover != nil) {
        [calendarPopover release];
    }
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:Responcer];
    calendarPopover.popoverContentSize = CGSizeMake(700, 400);
    [calendarPopover presentPopoverFromRect:aResponsibleButton.bounds inView:aResponsibleButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [Responcer release];

}

- (void) createListOfResponsibles
{
    NSString * creatorID = [NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].EMPLOYEE_ID];
    NSString * taskID = [NSString stringWithFormat:@"%@",[taskPlan taskID]];
    ODMobileMBO_getTasks * selectedTask = [ODMobileMBO_getTasks findByPrimaryKey:taskID];
    ODMobileMBO_getTaskTypes * taskType = [ODMobileMBO_getTaskTypes findByPrimaryKey:[NSString stringWithFormat:@"%@",[selectedTask TASK_TYPE_ID]]];
    NSString * businessProcessID = [NSString stringWithFormat:@"%@",[taskType BUSINESS_PROCESS_ID]];
    ODMobileMBO_getSubbranches * subbranch = nil;
    ODMobileMBOUnions * _union = nil;
    
    if ([[NSString stringWithFormat:@"%@",[selectedTask SUBBRANCH_ID]] integerValue] == 0) {
//    if ([SUBBRANCH_ID integerValue] == 0) {
        _union = [ODMobileMBOUnions findByPrimaryKey:[NSString stringWithFormat:@"%@",[selectedTask UNION_ID]]];
        NSLog(@"_union: %@",_union);
    } else {
        subbranch = [ODMobileMBO_getSubbranches findByPrimaryKey:[NSString stringWithFormat:@"%@",[selectedTask SUBBRANCH_ID]]];
        NSLog(@"subbranch: %@",subbranch);
    }
    
    NSLog(@"businessID = %@",businessProcessID);
    NSLog(@"creatorID = %@",creatorID);
    NSLog(@"taskID = %@",taskID);
    
    if (subbranch == nil && _union == nil) {
        NSLog(@"SUBBRANCHes и UNIONs not found");
    }
    
    if (_union == nil) {
        NSLog(@"_union = nil");
    }
    if (subbranch == nil) {
        NSLog(@"subbranch = nil");
    }
    
    //поиск ячеек по creatorID: метод findCreatorEmployeeCells(creatorId);
    //    hierarchyLevel = 0;//переменная инициализирована в методе viewDidLoad
    SUPObjectList * employeeCells =  [ODMobileMBOEmployeesSubordinations getByEmployeeId:creatorID withBusinessProcessId:businessProcessID];
    NSMutableArray * arrayWithCells = [self findCreatorEmployeeCellsWithHierarchyLevel:1000 withArray:employeeCells];
    creatorCells = [[NSMutableArray alloc] initWithArray:arrayWithCells];
    
    //поиск ячеек по subbranchID: метод findSubbranchCells(subbranch, union);
    if (subbranch != nil && _union == nil) {
        NSString * branch = [NSString stringWithFormat:@"%@",[subbranch SUBBRANCH_ID]];
        SUPObjectList * list = [ODMobileMBOEmployeesSubordinations getBySubbranchId:branch withBusunessProcessId:businessProcessID];
        arrayWithCells = [self findCreatorEmployeeCellsWithHierarchyLevel:FIRST_HIERARCHY_LEVEL withArray:list];
        subbranchCells = [[NSMutableArray alloc] initWithArray:arrayWithCells];
    }
    if (subbranch == nil && _union != nil) {
        NSString * unnion = [NSString stringWithFormat:@"%@",[_union UNION_ID]];
        SUPObjectList * list = [ODMobileMBOEmployeesSubordinations getByUnionId:unnion withBusinessProcessId:businessProcessID];
        arrayWithCells = [self findCreatorEmployeeCellsWithHierarchyLevel:FIRST_HIERARCHY_LEVEL withArray:list];
        subbranchCells = [[NSMutableArray alloc] initWithArray:arrayWithCells];
    }
    
    for (int i = 0; i < subbranchCells.count; i++) {
        NSLog(@"id = %@",[[subbranchCells objectAtIndex:i] cellID]);
        NSLog(@"parent_id = %@",[[subbranchCells objectAtIndex:i] parentCellID]);
    }
    
    
    [self getResponsibles];
    NSLog(@"Size of resultEmployyes = %i", resultEmployees.count);
    if (resultEmployees.count == 0) {
        EmployeeDTO * creator = [[EmployeeDTO alloc] init];
        [creator setEmployeeID:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].EMPLOYEE_ID]];
        NSLog(@"Creator: %@", [creator employeeID]);
        [resultEmployees addObject:creator];
        [creator release];
    }
    
}

- (NSMutableArray*)findCreatorEmployeeCellsWithHierarchyLevel:(int)hierarchy withArray:(SUPObjectList *)employeeCells
{
    NSMutableArray * resultSize = [[NSMutableArray alloc] init];
    NSMutableArray * result = [[[NSMutableArray alloc] init] autorelease];
    for (int i = 0; i < employeeCells.size; i++) {
        ODMobileMBOEmployeesSubordinations * cell = [employeeCells objectAtIndex:i];
        //        if (cell != nil) {
        //            [resultSize addObject:[NSString stringWithFormat:@"%@",[cell CELL_ID]]];
        //        }
        [resultSize addObject:[NSString stringWithFormat:@"%@",[cell CELL_ID]]];
    }
    
    
    for (NSString * strID in resultSize) {
        Cell * cell = [[Cell alloc] init];
        [cell setCellID:strID];
        NSMutableArray * employees = [[NSMutableArray alloc] init];
        
        for (ODMobileMBOEmployeesSubordinations * row in employeeCells) {
            if ([[NSString stringWithFormat:@"%@",[row CELL_ID]] isEqualToString:strID]) {
                if ([row PARENT_CELL_ID] != nil) {
                    [cell setParentCellID:[NSString stringWithFormat:@"%@",[row PARENT_CELL_ID]]];
                }
                else
                {
                    cell.parentCellID = @"asd";
                }
                //                [cell setParentCellID:[NSString stringWithFormat:@"%@",[row PARENT_CELL_ID]]];
                if (row.EMPLOYEE_ID != nil) {
                    //                    hierarchyLevel = 0;
                    EmployeeDTO * employee = [[EmployeeDTO alloc] init];
                    [employee setHierarchyLevel:[NSString stringWithFormat:@"%i",hierarchy]];
                    [employee setEmployeeID:[NSString stringWithFormat:@"%@",[row EMPLOYEE_ID]]];
                    if (row.SUBBRANCH_ID != nil) {
                        [employee setSubbranchID:[NSString stringWithFormat:@"%@",[row SUBBRANCH_ID]]];
                    }
                    if (row.UNION_ID != nil) {
                        [employee setUnionID:[NSString stringWithFormat:@"%@",[row UNION_ID]]];
                    }
                    [employees addObject:employee];
                    [employee release];
                }
            }
        }
        [cell setEmployees:employees];
        [employees release];
        [result addObject:cell];
        [cell release];
    }
    
    [resultSize release];
    
    return result;
}

- (void) getResponsibles
{
    resultEmployees = [[NSMutableArray alloc] init];
    for (Cell * cell in subbranchCells) {
        NSMutableArray * branchEmployees = [[NSMutableArray alloc] init];
        creatorCellFoundInBranch = FALSE;
        
        hierarchyLevel = FIRST_HIERARCHY_LEVEL;
        [self fillParentsWithCell:cell withHierarchyLevel:hierarchyLevel withArray:branchEmployees];
        
        if (creatorCellFoundInBranch) {
            for (int i = 0; i < branchEmployees.count; i++) {
                [resultEmployees addObject:[branchEmployees objectAtIndex:i]];
            }
        }
        else {
            NSLog(@"Пустая ячейка");
        }
        [branchEmployees release];
    }
    for (Cell * creatorCell in creatorCells) {
        [resultEmployees addObjectsFromArray:creatorCell.employees];
    }
    
    for (int i = 0; i < resultEmployees.count; i++) {
        NSLog(@"name = %@, level = %@",[[resultEmployees objectAtIndex:i] name],[[resultEmployees objectAtIndex:i] hierarchyLevel]);
    }
    
    
    NSMutableArray * sortArray = [[NSMutableArray alloc] init];
    for (EmployeeDTO * emp in resultEmployees) {
        NSLog(@"%@", [emp hierarchyLevel]);
        BOOL var = TRUE;
        for (EmployeeDTO * e in sortArray) {
            if ([[e employeeID] isEqualToString:[emp employeeID]]) {
                NSLog(@"e: %@, emp: %@",e.hierarchyLevel, emp.hierarchyLevel);
                if (([[e hierarchyLevel] integerValue]) < ([[emp hierarchyLevel] integerValue])) {
                    [e setHierarchyLevel:emp.hierarchyLevel];
                    NSLog(@"asd");
                }
                var = FALSE;
            }
        }
        if (var) {
            [sortArray addObject:emp];
        }
    }
    
    
    
    resultEmployees = sortArray;
    //    [sortArray release];
    for (int i = 0; i < resultEmployees.count; i++) {
        NSLog(@"name = %@, level = %@",[[resultEmployees objectAtIndex:i] name],[[resultEmployees objectAtIndex:i] hierarchyLevel]);
    }
    
    //здесь надо дописать код return и изменить значение, возвращаемое методов getResponsibles
}

- (void) fillParentsWithCell:(Cell *)cell withHierarchyLevel:(int)level withArray:(NSMutableArray *)array
{
    for (Cell * cc in creatorCells) {
        if ([cc.cellID isEqualToString:cell.cellID]) {
            creatorCellFoundInBranch = TRUE;
            return ;
        }
    }
    if (creatorCellFoundInBranch) {
        return ;
    }
    
    [array addObjectsFromArray:cell.employees];
    for (EmployeeDTO * c in array) {
        //        NSLog(@"employee_ID = %@",c.employeeID);
    }
    level++;
    hierarchyLevel = level;
    
//    NSLog(@"Parent.cellID = %@",cell.parentCellID);
    if (cell.parentCellID != nil && cell.parentCellID != @"asd") {
        SUPObjectList * parentCells = [ODMobileMBOEmployeesSubordinations getByCellId:cell.parentCellID];
        if (parentCells != nil) {
            NSMutableArray * parents = [self findCreatorEmployeeCellsWithHierarchyLevel:hierarchyLevel withArray:parentCells];
            for (Cell * parent in parents) {
                [self fillParentsWithCell:parent withHierarchyLevel:hierarchyLevel withArray:array];
            }
        }
    }
    
}

- (void) showActivityInspector
{
    NSLog(@"choose inspector");

    [self getInspectors];
    TaskActivityInspector *Inspector = [[TaskActivityInspector alloc] initWithStyle:UITableViewStylePlain];
    Inspector.tbClass = self;
    for (int i = 0; i < resultInspectors.count; i++) {
        ODMobileMBO_getEmployees * employeer = [ODMobileMBO_getEmployees findByPrimaryKey:[NSString stringWithFormat:@"%@",[[resultInspectors objectAtIndex:i] employeeID]]];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer EMPLOYEE_ID]] forKey:@"EMPLOYEE_ID"];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer LAST_NAME]] forKey:@"LAST_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer FIRST_NAME]] forKey:@"FIRST_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer PATRONYMIC]] forKey:@"PATRONYMIC"];
        [Inspector.arraySubType addObject:dict];
        [dict release];
    }

    if (calendarPopover != nil) {
        [calendarPopover release];
    }
    
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:Inspector];
    calendarPopover.popoverContentSize = CGSizeMake(700, 400);
    [calendarPopover presentPopoverFromRect:aInspectorButton.bounds inView:aInspectorButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [Inspector release];

}

- (void) getInspectors
{
    NSString * employee_ID = self.RESPONSER_ID;
    NSString * level = nil;
    resultInspectors = [[NSMutableArray alloc] init];
    for (EmployeeDTO * emp in resultEmployees) {
        ODMobileMBO_getEmployees * e = [ODMobileMBO_getEmployees findByPrimaryKey:emp.employeeID];
        NSLog(@"level = %@, last_name = %@",emp.hierarchyLevel, [e LAST_NAME]);
        if ([emp.employeeID isEqualToString:employee_ID]) {
            level = emp.hierarchyLevel;
        }
    }
    NSLog(@"hierLevel = %@",level);
    for (EmployeeDTO * emp in resultEmployees) {
        if ([emp.hierarchyLevel integerValue] > level.integerValue) {
            ODMobileMBO_getEmployees * e = [ODMobileMBO_getEmployees findByPrimaryKey:emp.employeeID];
            NSLog(@"level = %@, last_name = %@",emp.hierarchyLevel, [e LAST_NAME]);
            [resultInspectors addObject:emp];
        }
    }
    if (resultInspectors.count == 0) {
        for (EmployeeDTO * emp in resultEmployees) {
            if ([emp.employeeID isEqualToString:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].EMPLOYEE_ID]]) {
                [resultInspectors addObject:emp];
            }
        }
    }
}


- (void) aCancelAction
{
    [self dismissModalViewControllerAnimated:YES];
    [taskPlan updateData];
}

- (void) aSaveAction
{
    if (aNotesArea.editable && !requiredResp && [aNotesArea.text isEqualToString:[arraySelectActivity valueForKey:@"x.RESPONSIBLE_DESC"]]) {
//    if (aNotesArea.editable && [aNotesArea.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка ввода данных" message:@"Необходимо заполнить поле \"Отметка об исполнении\"" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return ;
    }

    if (aInspectorsArea.editable && !requiredInsp && [aInspectorsArea.text isEqualToString:[arraySelectActivity valueForKey:@"x.INSPECTOR_DESC"]]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка ввода данных" message:@"Необходимо заполнить поле \"Отметка о контроле\"" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return ;
    }

//    [arraySelectActivity setObject:[aNotesArea text] forKey:@"x.RESPONSIBLE_DESC"];

    [self.view setUserInteractionEnabled:NO];
    
    largeLabel = [[UIImageView alloc] initWithFrame:CGRectMake(252-50, 309-20, 300, 100)];
    [largeLabel setBackgroundColor:[UIColor lightGrayColor]];
    largeLabel.alpha = 0.8;
    [largeLabel.layer setCornerRadius:5];
    [self.view addSubview:largeLabel];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 240, 60)];
    [label setText:@"Синхронизация данных"];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:UITextAlignmentCenter];
    [largeLabel addSubview:label];
    
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.color = [UIColor blackColor];
    indicator.center = CGPointMake(25, 50);
    [indicator startAnimating];
    [largeLabel addSubview:indicator];

    
    NSLog(@"Save method is called");
    
    [arraySelectActivity setObject:[aNotesText text] forKey:@"x.ACTIVITY_NAME"];
    [arraySelectActivity setObject:[aProblemsValue text] forKey:@"x.PROBLEMS"];
    [arraySelectActivity setObject:[aNotesArea text] forKey:@"x.RESPONSIBLE_DESC"];
    [arraySelectActivity setObject:[aInspectorsArea text] forKey:@"x.INSPECTOR_DESC"];
    
    NSLog(@"%@",[arraySelectActivity valueForKey:@"x.RESPONSIBLE_DESC"]);

    @try {
        NSString * activity_ID = [NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.ACTIVITY_ID"]];
        NSLog(@"ID = %@",activity_ID);
        ODMobileMBO_getActivities * updateActivity = [ODMobileMBO_getActivities findByPrimaryKey:activity_ID];
        NSLog(@"%@",updateActivity);
        SUPObjectList * fieldList = [[SUPObjectList alloc]init];
        

        
        //ACTIVITY_ID
//        [updateActivity setACTIVITY_ID:activity_ID];
        ODMobileObjField * field1 = [ODMobileObjField new];
        [field1 setNm:@"ACTIVITY_ID"];
        [field1 setVl:activity_ID];
//        [field1 setVl:@"3061"];
        [fieldList add:field1];
        NSLog(@"field1 = %@",field1.vl);
        [field1 release];
        
        //UNION_ID OR SUBBRANCH_ID
        NSLog(@"SUBBRANCH: %@",[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.SUBBRANCH_ID"]]);
        NSLog(@"UNION: %@",[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"unions.UNION_ID"]]);
        if ([[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"unions.UNION_ID"]] isEqualToString:@"0"]) {
//            [updateActivity setUNION_ID:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.SUBBRANCH_ID"]]];
            ODMobileObjField * field2 = [ODMobileObjField new];
            [field2 setNm:@"SUBBRANCH_ID"];
            [field2 setVl:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.SUBBRANCH_ID"]]];
            [fieldList add:field2];
            [field2 release];
        }else
        {
//            [updateActivity setUNION_ID:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"unions.UNION_ID"]]];
            ODMobileObjField * field2 = [ODMobileObjField new];
            [field2 setNm:@"UNION_ID"];
            [field2 setVl:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"unions.UNION_ID"]]];
            //        [field2 setVl:@"6"];
            [fieldList add:field2];
            [field2 release];
        }
        NSLog(@"branch = %@",[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.SUBBRANCH_ID"]]);
        NSLog(@"union = %@",[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"unions.UNION_ID"]]);

        
        //ACTIVITY_NAME
//        [updateActivity setACTIVITY_NAME:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.ACTIVITY_NAME"]]];
        ODMobileObjField * field3 = [ODMobileObjField new];
        [field3 setNm:@"ACTIVITY_NAME"];
        [field3 setVl:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.ACTIVITY_NAME"]]];
//        [field3 setVl:@"iOS up2"];
        [fieldList add:field3];
        NSLog(@"field3 = %@",field3.vl);
        [field3 release];
        
        
        //DUEDATE_DTTM
//        [updateActivity setDUEDATE_DTTM:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.DUEDATE_DTTM"]]];
        ODMobileObjField * field6 = [ODMobileObjField new];
        [field6 setNm:@"DUEDATE_DTTM"];
        [field6 setVl:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.DUEDATE_DTTM"]]];
        [fieldList add:field6];
        NSLog(@"field6 = %@",field6.vl);
        [field6 release];

        
        
        //PROBLEMS
//        [updateActivity setPROBLEMS:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.PROBLEMS"]]];
        ODMobileObjField * field5 = [ODMobileObjField new];
        [field5 setNm:@"PROBLEMS"];
        [field5 setVl:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.PROBLEMS"]]];
        [fieldList add:field5];
        NSLog(@"field5 = %@",field5.vl);
        [field5 release];
        
        

        //ACTIVITY_STATUS_ID
        NSString * statusName = [NSString stringWithFormat:@"%@",[arraySelectActivity objectForKey:@"i.ACTIVITY_STATUS_NAME"]];
        NSMutableString * assignedStatusID = [[NSMutableString alloc] initWithString:@""];

        if ([statusName isEqualToString:@"Назначено"]) {
            [assignedStatusID appendString:@"1"];
        }
        if ([statusName isEqualToString:@"Отменено"]) {
            [assignedStatusID appendString:@"2"];
        }
        if ([statusName isEqualToString:@"Исполнено"]) {
            [assignedStatusID appendString:@"3"];
        }
        if ([statusName isEqualToString:@"Закрыто"]) {
            [assignedStatusID appendString:@"4"];
        }
        NSLog(@"Статус ID = %@",assignedStatusID);
//        [updateActivity setACTIVITY_STATUS_ID:assignedStatusID];
        ODMobileObjField * field10 = [ODMobileObjField new];
        [field10 setNm:@"ACTIVITY_STATUS_ID"];
        [field10 setVl:assignedStatusID];
        [fieldList add:field10];
        NSLog(@"field10 = %@",field10.vl);
        [field10 release];
        
        
        //ACTIVITY_PRIORITY_ID
        NSString * selectedItemPriority = [NSString stringWithFormat:@"%@",[arraySelectActivity objectForKey:@"a.ACTIVITY_PRIORITY_NAME"]];
        NSMutableString * activityPriorityID = [[NSMutableString alloc] initWithString:@""];
        if ([selectedItemPriority isEqualToString:@"Высокий"]) {
            [activityPriorityID appendString:@"3"];
        } else if ([selectedItemPriority isEqualToString:@"Средний"]){
            [activityPriorityID appendString:@"2"];
        } else if ([selectedItemPriority isEqualToString:@"Низкий"]){
            [activityPriorityID appendString:@"1"];
        }
//        [updateActivity setACTIVITY_PRIORITY_ID:activityPriorityID];
        ODMobileObjField * field4 = [ODMobileObjField new];
        [field4 setNm:@"ACTIVITY_PRIORITY_ID"];
        [field4 setVl:activityPriorityID];
        [fieldList add:field4];
        [activityPriorityID release];
        NSLog(@"field4 = %@",field4.vl);
        [field4 release];
        
        
        
        
        //RESPONSIBLE_DESC
//        [updateActivity setRESPONSIBLE_DESC:aNotesArea.text];
        ODMobileObjField * field7 = [ODMobileObjField new];
        [field7 setNm:@"RESPONSIBLE_DESC"];
        [field7 setVl:aNotesArea.text];
//        [field7 setVl:[arraySelectActivity valueForKey:@"x.RESPONSIBLE_DESC"]];
        [fieldList add:field7];
        NSLog(@"field7 = %@",field7.vl);
        [field7 release];
        
        
        //INSPECTOR_DESC
//        [updateActivity setINSPECTOR_DESC:aInspectorsArea.text];
        ODMobileObjField * field81 = [ODMobileObjField new];
        [field81 setNm:@"INSPECTOR_DESC"];
        [field81 setVl:aInspectorsArea.text];
        [fieldList add:field81];
        NSLog(@"field8 = %@",field81.vl);
        [field81 release];

        
        NSLog(@"INSPECTOR_ID = %@",INSPECTOR_ID);
        //INSPECTOR_EMPLOYEE_ID
        if (INSPECTOR_ID != nil) {
            //        [updateActivity setINSPECTOR_EMPLOYEE_ID:self.INSPECTOR_ID];
            ODMobileObjField * field9 = [ODMobileObjField new];
            [field9 setNm:@"INSPECTOR_EMPLOYEE_ID"];
            [field9 setVl:self.INSPECTOR_ID];
            [fieldList add:field9];
            NSLog(@"field9 = %@",field9.vl);
            [field9 release];
        }


        NSLog(@"RESPONSIBLE_ID = %@",RESPONSER_ID);
        //RESPONSE_EMPLOYEE_ID
        if (RESPONSER_ID != nil) {
            //        [updateActivity setRESPONSIBLE_EMPLOYEE_ID:self.RESPONSER_ID];
            ODMobileObjField * field19 = [ODMobileObjField new];
            [field19 setNm:@"RESPONSIBLE_EMPLOYEE_ID"];
            [field19 setVl:self.RESPONSER_ID];
            [fieldList add:field19];
            NSLog(@"field19 = %@",field19.vl);
            [field19 release];
        }


        //FACT_END_DTTM
        if ([currentStatus isEqualToString:@"3"] && ![currentStatus isEqualToString:lastStatus]) {
            NSDate * currentDate = [NSDate date];
            long long date = [currentDate timeIntervalSince1970];
            NSString * stringDate = [NSString stringWithFormat:@"%lld000",date];
            NSLog(@"%lld",date);
            
//            [updateActivity setFACT_END_DTTM:stringDate];
            ODMobileObjField * field20 = [ODMobileObjField new];
            [field20 setNm:@"FACT_END_DTTM"];
            [field20 setVl:stringDate];
            [fieldList add:field20];
            NSLog(@"field20 = %@",field20.vl);
            [field20 release];
        }
        
        if ([currentStatus isEqualToString:@"1"] && [lastStatus isEqualToString:@"3"]) {
            NSString * stringDate = @"NO_VALUE";
            
//            [updateActivity setFACT_END_DTTM:stringDate];
            ODMobileObjField * field20 = [ODMobileObjField new];
            [field20 setNm:@"FACT_END_DTTM"];
            [field20 setVl:stringDate];
            [fieldList add:field20];
            NSLog(@"field20 = %@",field20.vl);
            [field20 release];
        }


        //CLOSE_DTTM
        if ([currentStatus isEqualToString:@"4"] && ![currentStatus isEqualToString:lastStatus]) {
            NSDate * currentDate = [NSDate date];
            long long date = [currentDate timeIntervalSince1970];
            NSString * stringDate = [NSString stringWithFormat:@"%lld000",date];
            NSLog(@"%lld",date);
            
//            [updateActivity setCLOSE_DTTM:stringDate];
            ODMobileObjField * field21 = [ODMobileObjField new];
            [field21 setNm:@"CLOSE_DTTM"];
            [field21 setVl:stringDate];
            [fieldList add:field21];
            NSLog(@"field21 = %@",field21.vl);
            [field21 release];
        }
        
        //USER_LOGIN
        ODMobileObjField * field29 = [ODMobileObjField new];
        [field29 setNm:@"USER_LOGIN"];
        [field29 setVl:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].newUserLogin]];
        [fieldList add:field29];
        NSLog(@"name = %@, value =%@",field29.nm, field29.vl);
        [field29 release];
        
        
        //CONNECTION_ID
        [[SUPApplication applicationSettings] connectionId];
        ODMobileObjField * field30 = [ODMobileObjField new];
        [field30 setNm:@"CONNECTION_ID"];
        [field30 setVl:[NSString stringWithFormat:@"%@",[[SUPApplication applicationSettings] connectionId]]];
        [fieldList add:field30];
        NSLog(@"name = %@, value =%@",field30.nm, field30.vl);
        [field30 release];
        
        
        //DEVICE_ID
        ODMobileObjField * field31 = [ODMobileObjField new];
        [field31 setNm:@"DEVICE_ID"];
        [field31 setVl:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].idName]];
        [fieldList add:field31];
        NSLog(@"name = %@, value =%@",field31.nm, field31.vl);
        [field31 release];
        
        
        //IP
        ODMobileObjField * field32 = [ODMobileObjField new];
        [field32 setNm:@"IP"];
        [field32 setVl:[SberbankAuditAppDelegate instance].IPAdress];
        [fieldList add:field32];
        NSLog(@"name = %@, value =%@",field32.nm, field32.vl);
        [field32 release];

        
        
        ODMobileOdObject * odObject = [ODMobileOdObject new];
        [odObject setFl:fieldList];
        [updateActivity update:@"SUP_FCT_ACTIVITIES" withOdObject:odObject];
        [updateActivity submitPending];
        

        [ODMobileODMobileDB synchronize:@"TasksSG"];
        
//        NSLog(@"TaskSG sync started");
//        [ODMobileODMobileDB synchronize:@"TasksSG"];
//        NSLog(@"TaskSG sync finished");
//        NSLog(@"DIMSG sync started");
//        [ODMobileODMobileDB synchronize:@"DIMSG"];
//        NSLog(@"DIMSG sync finished");
//        NSLog(@"DIMSG_TASK_REL sync started");
//        [ODMobileODMobileDB synchronize:@"DIMSG_TASK_REL"];
//        NSLog(@"DIMSG_TASK_REL sync finished");


        
        
        [fieldList release];
        
        NSLog(@"At-Consulting: Application is saved");
        
        NSLog(@"%@",[arraySelectActivity valueForKey:@"x.RESPONSIBLE_DESC"]);

        [indicator stopAnimating];
        [largeLabel setHidden:YES];
        [self.view setUserInteractionEnabled:YES];

        [taskPlan updateData];
    }
    @catch (SUPPersistenceException *exception)
    {
        [indicator stopAnimating];
        [largeLabel setHidden:YES];
        [self.view setUserInteractionEnabled:YES];
        
        NSLog(@"At-Consulting: Save error: %@ - %@",exception.name,exception.message);
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:@"Ошибка синхронизации" message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [alert1 show];
        [alert1 release];
    }
    
    [self dismissModalViewControllerAnimated:YES];
//    [taskPlan updateData];
}

//- (void)openActivityIndicatorViewWithName:(NSString *)name
//{
//    WaitingViewController * activityIndicator = [[[WaitingViewController alloc] init] autorelease];
//    activityIndicator.label.text = name;
//    activityIndicator.modalPresentationStyle = UIModalPresentationFormSheet;
//    activityIndicator.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    [[SberbankAuditAppDelegate instance].rootViewController presentModalViewController:activityIndicator animated:YES];
//    [[activityIndicator.view superview] setFrame:CGRectMake(roundf([activityIndicator.view superview].center.x-200), roundf([activityIndicator.view superview].center.y-50), 400, 100)];
//    
//    //    [activityIndicator release];
//}

- (void) closeActivityIndicator
{
    [[SberbankAuditAppDelegate instance].rootViewController dismissModalViewControllerAnimated:YES];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    [userPhoto setImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    [userPhoto setHidden:NO];
    [[self.view superview] setFrame:CGRectMake(roundf([self.view superview].center.x-252), roundf([self.view superview].center.y-339), 504, 678)];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    [[self.view superview] setFrame:CGRectMake(roundf([self.view superview].center.x-252), roundf([self.view superview].center.y-339), 504, 678)];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *userTouch = [[event allTouches] anyObject];
    CGPoint touchLocation = [userTouch locationInView:self.view];
    
    if(CGRectContainsPoint(CGRectMake(360, 495, 100, 106), touchLocation))
    {
        [self openCamera];
    }
}

- (void) dealloc
{
    [super dealloc];
    [aTitleLabel release];
    [aNotesArea release];
    [aEndDateLabel release];
    [aStatusLabel release];
    [aPriorityLabel release];
    [aResponsibleValue release];
    [aInspectorValue release];
    [aInspectorsArea release];
    [userPhoto release];
    [arraySelectActivity release];
    [aEndDateText release];
    [aStatusText release];
    [aResponsibleText release];
    [aProblemsLabel release];
    [aInitiatorLabel release];  
    [aResponsibleLabel release];
    [aPerformLabel release];
    [aInspectorLabel release];
    [aControlLabel release];
    [scroll release];
    [aPriorityValue release];
    [aProblemsValue release];
//    [taskPlan release];
    
    [aDateOfResponseLabel release];
    [aDateOfResponseValue release];
    [aDateOfInspectLabel release];
    [aDateOfInspectValue release];

    [aNotesButton release];
    [aStatusButton release];
    [aResponsibleButton release];
    [aSaveButton release];
    [aCancelButton release];
    [label release];
    [indicator release];
    [largeLabel release];
    [createDateLabel release];
    [createDateValue release];
    
    [creatorCells release];
    [subbranchCells release];
    [resultEmployees release];
    [resultInspectors release];
    
//    [self.RESPONSER_ID release];
//    [self.INSPECTOR_ID release];
//    [self.lastStatus release];
//    [self.currentStatus release];
    
//    [self.arrayWithStatuses release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    calendarPopover = nil;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)identification
{
    NSString * actID = [NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.ACTIVITY_ID"]];
    ODMobileMBO_getActivities * theActivity = [ODMobileMBO_getActivities findByPrimaryKey:actID];
    
    //определяем поля RESPONSIBLE_EMPLOYEE_ID, INSPECTOR_EMPLOYEE_ID, CREATOR_EMPLOYEE_ID
    NSString * creatorID = [NSString stringWithFormat:@"%@",[theActivity valueForKey:@"CREATOR_EMPLOYEE_ID"]];
    NSString * responserID = [NSString stringWithFormat:@"%@",[theActivity valueForKey:@"RESPONSIBLE_EMPLOYEE_ID"]];
    NSString * inspectorID = [NSString stringWithFormat:@"%@",[theActivity valueForKey:@"INSPECTOR_EMPLOYEE_ID"]];
    NSLog(@"creator: %@",creatorID);
    NSLog(@"responser: %@",responserID);
    NSLog(@"inspector: %@",inspectorID);
    
    SberbankAuditAppDelegate * app = [SberbankAuditAppDelegate instance];
    NSString * employee_ID = [app EMPLOYEE_ID];
    NSLog(@"employer: %@",employee_ID);
    
    if ([employee_ID isEqualToString:creatorID]) {
        isCreator = true;
    }
    if ([employee_ID isEqualToString:responserID]) {
        isResponser = true;
    }
    if ([employee_ID isEqualToString:inspectorID]) {
        isInspertor = true;
    }
    NSString * str1 = (isCreator)? @"YES" : @"NO";
    NSLog(@"isCreator: %@", str1);
    NSString * str2 = (isResponser)? @"YES" : @"NO";
    NSLog(@"isResponser: %@", str2);
    NSString * str3 = (isInspertor)? @"YES" : @"NO";
    NSLog(@"isInspector: %@", str3);
    
    NSString * activityStatusID = [NSString stringWithFormat:@"%@",[theActivity valueForKey:@"ACTIVITY_STATUS_ID"]];
    self.lastStatus = activityStatusID;
    self.currentStatus = activityStatusID;

}

- (void)mainLogic
{
    NSLog(@"статус: %@",self.lastStatus);
    NSLog(@"статус: %@",self.currentStatus);
    
//    NSString * aNotesAreaText = @"";
    
    //назначено     1
    //Отменено      2
    //Исполнено     3
    //Закрыто       4
    [self.arrayWithStatuses removeAllObjects];

    if ([self.lastStatus isEqualToString:@"2"] || [self.lastStatus isEqualToString:@"4"]) {//отменено и закрыто
        NSLog(@"Редактирование мероприятия запрещено");
        aNotesButton.hidden = YES;
        
        aNotesText.editable = NO;
        [aNotesText setBackgroundColor:[UIColor clearColor]];
        
        [aEndDateButton setEnabled:NO];
        [aEndDateButton setAlpha:0.5];
        
        aStatusButton.enabled = NO;
        [aStatusButton setAlpha:0.5];

        aPriorityButton.enabled = NO;
        [aPriorityButton setAlpha:0.5];
        
        aProblemsValue.editable = NO;
        [aProblemsValue setBackgroundColor:[UIColor clearColor]];
        
        aResponsibleButton.enabled = NO;
        [aResponsibleButton setAlpha:0.5];
        
        aInspectorButton.enabled = NO;
        [aInspectorButton setAlpha:0.5];
        
        aNotesArea.editable = NO;
        [aNotesArea setBackgroundColor:[UIColor clearColor]];
        
        aInspectorsArea.editable = NO;
        [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
        
        aSaveButton.enabled = NO;
        [aSaveButton setAlpha:0.5];
        
        requiredResp = FALSE;
        requiredInsp = FALSE;
    }
    else
    {
        NSDictionary * assigned = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"Назначено", nil] forKeys:[NSArray arrayWithObjects:@"ACTIVITY_STATUS_ID",@"ACTIVITY_STATUS_NAME", nil]];
        NSDictionary * canceled = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"2", @"Отменено", nil] forKeys:[NSArray arrayWithObjects:@"ACTIVITY_STATUS_ID",@"ACTIVITY_STATUS_NAME", nil]];
        NSDictionary * completed = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"3", @"Исполнено", nil] forKeys:[NSArray arrayWithObjects:@"ACTIVITY_STATUS_ID",@"ACTIVITY_STATUS_NAME", nil]];
        NSDictionary * closed = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"4", @"Закрыто", nil] forKeys:[NSArray arrayWithObjects:@"ACTIVITY_STATUS_ID",@"ACTIVITY_STATUS_NAME", nil]];
        
//        [self.arrayWithStatuses addObject:assigned];
//        [self.arrayWithStatuses addObject:canceled];
//        [self.arrayWithStatuses addObject:completed];
//        [self.arrayWithStatuses addObject:closed];

        
        if (isCreator && isResponser && isInspertor) {
            NSLog(@"User is cr, resp, insp");
            if ([self.lastStatus isEqualToString:@"1"]) {//назначено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:canceled];
                [self.arrayWithStatuses addObject:completed];
                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aNotesButton.hidden = NO;
                    
                    aNotesText.editable = YES;
                    [aNotesText setBackgroundColor:[UIColor whiteColor]];
                    
                    [aEndDateButton setEnabled:YES];
                    [aEndDateButton setAlpha:1.0];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = YES;
                    [aPriorityButton setAlpha:1.0];
                    
                    aProblemsValue.editable = YES;
                    [aProblemsValue setBackgroundColor:[UIColor whiteColor]];
                    
                    aResponsibleButton.enabled = YES;
                    [aResponsibleButton setAlpha:1.0];
                    
                    aInspectorButton.enabled = YES;
                    [aInspectorButton setAlpha:1.0];
                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];

                    
                    aNotesArea.editable = YES;
                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];

//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];

                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    aSaveButton.enabled = YES;
                    [aSaveButton setAlpha:1.0];
                    
                    
                    requiredResp = TRUE;
                    requiredInsp = FALSE;

                    
//                    aNotesButton.enabled = NO;
//                    [aNotesButton setAlpha:0.5];
//                    
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//
//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//
//                    aInspectorsArea.editable = NO;
//                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                }
                if ([self.currentStatus isEqualToString:@"3"]) {//исполнено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = YES;
                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    aSaveButton.enabled = YES;
                    [aSaveButton setAlpha:1.0];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;



                    
//                    aNotesButton.enabled = NO;
//                    [aNotesButton setAlpha:0.5];
//
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//
//                    aNotesArea.editable = YES;
//                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];
//                    
//                    aInspectorsArea.editable = NO;
//                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                }
                if ([self.currentStatus isEqualToString:@"2"]) {//отменено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = YES;
                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = TRUE;

                }

            }
            if ([self.lastStatus isEqualToString:@"3"]) {//исполнено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:completed];
                [self.arrayWithStatuses addObject:closed];

                if ([self.currentStatus isEqualToString:@"3"]) {//исполнено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = YES;
                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = TRUE;
                    requiredInsp = FALSE;


                    
//                    aNotesButton.enabled = NO;
//                    [aNotesButton setAlpha:0.5];
//                    
//                    aNotesText.editable = NO;
//                    [aNotesText setBackgroundColor:[UIColor clearColor]];
//                    
//                    [aEndDateButton setEnabled:NO];
//                    [aEndDateButton setAlpha:0.5];
//
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aProblemsValue.editable = NO;
//                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//                    
//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//                    
//                    aInspectorsArea.editable = NO;
//                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                }
                if ([self.currentStatus isEqualToString:@"4"]) {//закрыто
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];

                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = TRUE;


                    
//                    aDateOfResponseValue.hidden = NO;

                }
                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = YES;
                    [aNotesText setBackgroundColor:[UIColor whiteColor]];
                    
                    [aEndDateButton setEnabled:YES];
                    [aEndDateButton setAlpha:1.0];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = YES;
                    [aPriorityButton setAlpha:1.0];
                    
                    aProblemsValue.editable = YES;
                    [aProblemsValue setBackgroundColor:[UIColor whiteColor]];
                    
                    aResponsibleButton.enabled = YES;
                    [aResponsibleButton setAlpha:1.0];
                    
                    aInspectorButton.enabled = YES;
                    [aInspectorButton setAlpha:1.0];

//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = TRUE;


                    
//                    aNotesArea.text = @"";
//                    aDateOfResponseLabel.hidden = YES;
                    
                    
//                    aNotesButton.hidden = YES;
//                    
////                    aNotesText.editable = NO;
////                    [aNotesText setBackgroundColor:[UIColor clearColor]];
////                    
////                    [aEndDateButton setEnabled:NO];
////                    [aEndDateButton setAlpha:0.5];
//
//                    aNotesText.editable = YES;
//                    [aNotesText setBackgroundColor:[UIColor whiteColor]];
//
//                    [aEndDateButton setEnabled:YES];
//                    [aEndDateButton setAlpha:1];
//                    
////                    aStatusButton.enabled = NO;
////                    [aStatusButton setAlpha:0.5];
//                    
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//                    
//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//                    
////                    aInspectorsArea.editable = YES;
////                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
//                    aNotesArea.text = @"";
//                    aDateOfResponseValue.hidden = YES;
//                    
//                    aInspectorsArea.editable = NO;
//                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
//
                }
            }
        }else if (isCreator && isResponser){
            NSLog(@"User is cr, resp");
            if ([self.lastStatus isEqualToString:@"1"]) {//назначено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:canceled];
                [self.arrayWithStatuses addObject:completed];

                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
                if ([self.currentStatus isEqualToString:@"3"]) {//исполнено
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = YES;
                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
                if ([self.currentStatus isEqualToString:@"2"]) {//отменено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = YES;
                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }

            }
            if ([self.lastStatus isEqualToString:@"3"]) {//исполнено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:completed];

                if ([self.currentStatus isEqualToString:@"3"]) {//исполнено
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
            }
        }else if (isCreator && isInspertor){
            NSLog(@"User is cr, insp");
            if ([self.lastStatus isEqualToString:@"1"]) {//назначено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:canceled];

                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aNotesButton.hidden = NO;
                    
                    aNotesText.editable = YES;
                    [aNotesText setBackgroundColor:[UIColor whiteColor]];
                    
                    [aEndDateButton setEnabled:YES];
                    [aEndDateButton setAlpha:1.0];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = YES;
                    [aPriorityButton setAlpha:1.0];
                    
                    aProblemsValue.editable = YES;
                    [aProblemsValue setBackgroundColor:[UIColor whiteColor]];
                    
                    aResponsibleButton.enabled = YES;
                    [aResponsibleButton setAlpha:1.0];
                    
                    aInspectorButton.enabled = YES;
                    [aInspectorButton setAlpha:1.0];
                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];

                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                    
//                    aNotesButton.hidden = YES;
//
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//                    
////                    aNotesArea.editable = NO;
////                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//                    
//                    aInspectorsArea.editable = NO;
//                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                }
                if ([self.currentStatus isEqualToString:@"3"]) {//исполнено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = YES;
                    [aNotesText setBackgroundColor:[UIColor whiteColor]];
                    
                    [aEndDateButton setEnabled:YES];
                    [aEndDateButton setAlpha:1.0];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                    
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aProblemsValue.editable = NO;
//                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//                    
//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//                    
//                    aInspectorsArea.editable = NO;
//                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                }
                if ([self.currentStatus isEqualToString:@"2"]) {//отменено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = TRUE;


                }
            }
            if ([self.lastStatus isEqualToString:@"3"]) {//исполнено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:completed];
                [self.arrayWithStatuses addObject:closed];

                if ([self.currentStatus isEqualToString:@"3"]) {//исполнено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                    
//                    aNotesButton.hidden = YES;
//                    
//                    aNotesText.editable = NO;
//                    [aNotesText setBackgroundColor:[UIColor clearColor]];
//                    
//                    [aEndDateButton setEnabled:NO];
//                    [aEndDateButton setAlpha:0.5];
//
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aProblemsValue.editable = NO;
//                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//                    
//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//                    
//                    aInspectorsArea.editable = NO;
//                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                }
                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = YES;
                    [aNotesText setBackgroundColor:[UIColor whiteColor]];
                    
                    [aEndDateButton setEnabled:YES];
                    [aEndDateButton setAlpha:1.0];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = YES;
                    [aPriorityButton setAlpha:1.0];
                    
                    aProblemsValue.editable = YES;
                    [aProblemsValue setBackgroundColor:[UIColor whiteColor]];
                    
                    aResponsibleButton.enabled = YES;
                    [aResponsibleButton setAlpha:1.0];
                    
                    aInspectorButton.enabled = YES;
                    [aInspectorButton setAlpha:1.0];
                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];

                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = TRUE;


                    
//                    aNotesText.editable = YES;
//                    [aNotesText setBackgroundColor:[UIColor whiteColor]];
//                    
//                    [aEndDateButton setEnabled:YES];
//                    [aEndDateButton setAlpha:1.0];
//
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//                    
//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//                    
//                    aInspectorsArea.editable = YES;
//                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
//                    aDateOfResponseValue.hidden = YES;
//                    aNotesArea.text = @"";
                }
                if ([self.currentStatus isEqualToString:@"4"]) {//закрыто
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = TRUE;


                }
            }
        }else if (isResponser && isInspertor){
            NSLog(@"User is resp, insp");
            if ([self.lastStatus isEqualToString:@"1"]) {//назначено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:canceled];
                [self.arrayWithStatuses addObject:completed];

                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
                if ([self.currentStatus isEqualToString:@"3"]) {//исполнено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = YES;
                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];

                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
                if ([self.currentStatus isEqualToString:@"2"]) {//отменено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = YES;
                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
            }
            if ([self.lastStatus isEqualToString:@"3"]) {//исполнено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:completed];
                [self.arrayWithStatuses addObject:closed];

                if ([self.currentStatus isEqualToString:@"3"]) {//исполнено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
                if ([self.currentStatus isEqualToString:@"4"]) {//закрыто
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
            }
        }else if (isCreator){
            NSLog(@"User is cr");
            if ([self.lastStatus isEqualToString:@"1"]) {//назначено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:canceled];
//                [self.arrayWithStatuses addObject:closed];


                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aNotesButton.hidden = NO;
                    
                    aNotesText.editable = YES;
                    [aNotesText setBackgroundColor:[UIColor whiteColor]];
                    
                    [aEndDateButton setEnabled:YES];
                    [aEndDateButton setAlpha:1.0];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = YES;
                    [aPriorityButton setAlpha:1.0];
                    
                    aProblemsValue.editable = YES;
                    [aProblemsValue setBackgroundColor:[UIColor whiteColor]];
                    
                    aResponsibleButton.enabled = YES;
                    [aResponsibleButton setAlpha:1.0];
                    
                    aInspectorButton.enabled = YES;
                    [aInspectorButton setAlpha:1.0];
                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];

                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                    
//                    aNotesButton.hidden = YES;
//
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//                    
//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//                    
//                    aInspectorsArea.editable = NO;
//                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                }
                if ([self.currentStatus isEqualToString:@"2"]) {//отменено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = TRUE;


                }
            }
            if ([self.lastStatus isEqualToString:@"3"]) {//исполнено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:completed];

                if ([self.currentStatus isEqualToString:@"3"]) {//исполнено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = YES;
                    [aNotesText setBackgroundColor:[UIColor whiteColor]];
                    
                    [aEndDateButton setEnabled:YES];
                    [aEndDateButton setAlpha:1.0];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;

                    
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aProblemsValue.editable = NO;
//                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//                    
//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//                    
//                    aInspectorsArea.editable = NO;
//                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                }
                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = YES;
                    [aNotesText setBackgroundColor:[UIColor whiteColor]];
                    
                    [aEndDateButton setEnabled:YES];
                    [aEndDateButton setAlpha:1.0];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = YES;
                    [aPriorityButton setAlpha:1.0];
                    
                    aProblemsValue.editable = YES;
                    [aProblemsValue setBackgroundColor:[UIColor whiteColor]];
                    
                    aResponsibleButton.enabled = YES;
                    [aResponsibleButton setAlpha:1.0];
                    
                    aInspectorButton.enabled = YES;
                    [aInspectorButton setAlpha:1.0];
                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];

                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = TRUE;


                    
                    
//                    aDateOfResponseValue.hidden = YES;
//                    aNotesArea.text = @"";

//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//                    
//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//                    
//                    aInspectorsArea.editable = YES;
//                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                }
                if ([self.currentStatus isEqualToString:@"4"]) {//закрыто
                    aNotesButton.hidden = NO;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = TRUE;
                    
                }

            }
        }else if (isResponser){
            NSLog(@"User is resp");
            if ([self.lastStatus isEqualToString:@"1"]) {//назначено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:canceled];
                [self.arrayWithStatuses addObject:completed];

                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = YES;
                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = TRUE;
                    requiredInsp = FALSE;


                    
//                    aNotesButton.hidden = YES;
//                    
//                    aNotesText.editable = NO;
//                    [aNotesText setBackgroundColor:[UIColor clearColor]];
//                    
//                    [aEndDateButton setEnabled:NO];
//                    [aEndDateButton setAlpha:0.5];
//                    
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aProblemsValue.editable = NO;
//                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//                    
//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//                    
//                    aInspectorsArea.editable = NO;
//                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                }
                if ([self.currentStatus isEqualToString:@"3"]) {//исполнено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = YES;
                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
                if ([self.currentStatus isEqualToString:@"2"]) {//отменено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = YES;
                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
            }
            if ([self.lastStatus isEqualToString:@"3"]) {//исполнено

                if ([self.currentStatus isEqualToString:@"3"]) {//исполнено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = YES;
                    [aNotesArea setBackgroundColor:[UIColor whiteColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    aSaveButton.enabled = NO;
                    [aSaveButton setAlpha:0.5];
                    
                    requiredResp = TRUE;
                    requiredInsp = FALSE;


                }
            }
        }else if (isInspertor){
            NSLog(@"User is insp");
            if ([self.lastStatus isEqualToString:@"1"]) {//назначено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:canceled];

                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                    
//                    aNotesButton.hidden = YES;
//                    
//                    aNotesText.editable = NO;
//                    [aNotesText setBackgroundColor:[UIColor clearColor]];
//                    
//                    [aEndDateButton setEnabled:NO];
//                    [aEndDateButton setAlpha:0.5];
//                    
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aProblemsValue.editable = NO;
//                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//                    
//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//                    
//                    aInspectorsArea.editable = NO;
//                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                }
                if ([self.currentStatus isEqualToString:@"2"]) {//отменено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
            }
            if ([self.lastStatus isEqualToString:@"3"]) {//исполнено
                [self.arrayWithStatuses addObject:assigned];
                [self.arrayWithStatuses addObject:completed];
                [self.arrayWithStatuses addObject:closed];

                if ([self.currentStatus isEqualToString:@"3"]) {//исполнено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = YES;
                    [aStatusButton setAlpha:1.0];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = NO;
                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                    
//                    aNotesButton.hidden = YES;
//                    
//                    aNotesText.editable = NO;
//                    [aNotesText setBackgroundColor:[UIColor clearColor]];
//                    
//                    [aEndDateButton setEnabled:NO];
//                    [aEndDateButton setAlpha:0.5];
//                    
//                    aPriorityButton.enabled = NO;
//                    [aPriorityButton setAlpha:0.5];
//                    
//                    aProblemsValue.editable = NO;
//                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
//                    
//                    aResponsibleButton.enabled = NO;
//                    [aResponsibleButton setAlpha:0.5];
//                    
//                    aInspectorButton.enabled = NO;
//                    [aInspectorButton setAlpha:0.5];
//                    
//                    aNotesArea.editable = NO;
//                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
//                    
//                    aInspectorsArea.editable = NO;
//                    [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
                }
                if ([self.currentStatus isEqualToString:@"1"]) {//назначено
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
                if ([self.currentStatus isEqualToString:@"4"]) {//закрыто
                    aNotesButton.hidden = YES;
                    
                    aNotesText.editable = NO;
                    [aNotesText setBackgroundColor:[UIColor clearColor]];
                    
                    [aEndDateButton setEnabled:NO];
                    [aEndDateButton setAlpha:0.5];
                    
                    aStatusButton.enabled = NO;
                    [aStatusButton setAlpha:0.5];
                    
                    aPriorityButton.enabled = NO;
                    [aPriorityButton setAlpha:0.5];
                    
                    aProblemsValue.editable = NO;
                    [aProblemsValue setBackgroundColor:[UIColor clearColor]];
                    
                    aResponsibleButton.enabled = NO;
                    [aResponsibleButton setAlpha:0.5];
                    
                    aInspectorButton.enabled = NO;
                    [aInspectorButton setAlpha:0.5];
                    
                    aNotesArea.editable = NO;
                    [aNotesArea setBackgroundColor:[UIColor clearColor]];
                    
                    aInspectorsArea.editable = YES;
                    [aInspectorsArea setBackgroundColor:[UIColor whiteColor]];
                    
                    requiredResp = FALSE;
                    requiredInsp = FALSE;


                }
            }
        }else if (!isCreator && !isResponser && !isInspertor ){
            NSLog(@"User is out of any employeers");
            aNotesButton.hidden = YES;
            
            aNotesText.editable = NO;
            [aNotesText setBackgroundColor:[UIColor clearColor]];
            
            [aEndDateButton setEnabled:NO];
            [aEndDateButton setAlpha:0.5];
            
            aStatusButton.enabled = NO;
            [aStatusButton setAlpha:0.5];
            
            aPriorityButton.enabled = NO;
            [aPriorityButton setAlpha:0.5];
            
            aProblemsValue.editable = NO;
            [aProblemsValue setBackgroundColor:[UIColor clearColor]];
            
            aResponsibleButton.enabled = NO;
            [aResponsibleButton setAlpha:0.5];
            
            aInspectorButton.enabled = NO;
            [aInspectorButton setAlpha:0.5];
            
            aNotesArea.editable = NO;
            [aNotesArea setBackgroundColor:[UIColor clearColor]];
            
            aInspectorsArea.editable = NO;
            [aInspectorsArea setBackgroundColor:[UIColor clearColor]];
            
            aSaveButton.enabled = NO;
            [aSaveButton setAlpha:0.5];
            
            requiredResp = FALSE;
            requiredInsp = FALSE;


        }
    }
}

- (NSString*) showDate: (NSString*)d
{
    NSDate * date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    
    NSString * str = [NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:d]];
    double DOUBLE = [str doubleValue]/1000;
    date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
    str = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    return str;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWilAppear method called");
    NSLog(@"%@",[arraySelectActivity objectForKey:@"x.RESPONSIBLE_DESC"]);

    
    [aTitleLabel setText:[NSString stringWithFormat:@"%@, %@", [arraySelectActivity valueForKey:@"b.CATEGORY_NAME"], [arraySelectActivity valueForKey:@"z.ACTIVITY_TYPE_NAME"]]];
    
    NSDate * date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    NSString * str = [NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.DUEDATE_DTTM"]];
    double DOUBLE = [str doubleValue]/1000;
    date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
    str = [dateFormatter stringFromDate:date];
    [aEndDateText setText:[NSString stringWithFormat:@"%@",str]];
    
    [aEndDateButton setTitle:[NSString stringWithFormat:@"%@",str] forState:UIControlStateNormal];
    
    ODMobileMBO_getActivities * curActivity = [ODMobileMBO_getActivities findByPrimaryKey:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.ACTIVITY_ID"]]];
    NSString * createString = [NSString stringWithFormat:@"%@",[curActivity CREATED_DTTM]];
    DOUBLE = [createString doubleValue]/1000;
    date = [NSDate dateWithTimeIntervalSince1970:DOUBLE];
    createString = [dateFormatter stringFromDate:date];
    [dateFormatter release];

    [createDateLabel setText:[NSString stringWithFormat:@"Дата создания: %@", createString]];
    

    
    if (![[self showDate:@"x.FACT_END_DTTM"] isEqualToString:@"01.01.1970"]) {
        [aDateOfResponseValue setText:[self showDate:@"x.FACT_END_DTTM"]];
    }
    if (![[self showDate:@"x.CLOSE_DTTM"] isEqualToString:@"01.01.1970"]) {
        [aDateOfInspectValue setText:[self showDate:@"x.CLOSE_DTTM"]];
    }
    NSLog(@"%@",[self showDate:@"x.FACT_END_DTTM"]);

    
    NSString * actID = [NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.ACTIVITY_ID"]];
    ODMobileMBO_getActivities * theActivity = [ODMobileMBO_getActivities findByPrimaryKey:actID];
    
    
    ODMobileMBO_getEmployees * employer1 = [ODMobileMBO_getEmployees findByPrimaryKey:[NSString stringWithFormat:@"%@",[theActivity valueForKey:@"RESPONSIBLE_EMPLOYEE_ID"]]];
    ODMobileMBO_getEmployees * employer2 = [ODMobileMBO_getEmployees findByPrimaryKey:[NSString stringWithFormat:@"%@",[theActivity valueForKey:@"INSPECTOR_EMPLOYEE_ID"]]];
    
    NSString * lastName1 = [employer1 LAST_NAME];
    NSString * firstName1 = [employer1 FIRST_NAME];
    NSString * patronymic1 = [employer1 PATRONYMIC];
    
    
    NSString * lastName2 = [employer2 LAST_NAME];
    NSString * firstName2 = [employer2 FIRST_NAME];
    NSString * patronymic2 = [employer2 PATRONYMIC];


    self.RESPONSER_ID = [NSString stringWithFormat:@"%@",[theActivity valueForKey:@"RESPONSIBLE_EMPLOYEE_ID"]];
    [aResponsibleButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",lastName1,firstName1,patronymic1] forState:UIControlStateNormal];
    [aInspectorButton setTitle:[NSString stringWithFormat:@"%@ %@ %@", lastName2, firstName2, patronymic2] forState:UIControlStateNormal];

    [aPriorityButton setTitle:[NSString stringWithFormat:@"%@", [arraySelectActivity valueForKey:@"a.ACTIVITY_PRIORITY_NAME"]] forState:UIControlStateNormal];
    [aProblemsValue setText:[NSString stringWithFormat:@"%@", [arraySelectActivity valueForKey:@"x.PROBLEMS"]]];
    [aInitiatorValue setText:[NSString stringWithFormat:@"%@ %@ %@", [arraySelectActivity valueForKey:@"e.LAST_NAME"],[arraySelectActivity valueForKey:@"e.FIRST_NAME"],[arraySelectActivity valueForKey:@"e.PATRONYMIC"]]];
    
    if ([arraySelectActivity objectForKey:@"x.RESPONSIBLE_DESC"] == nil) {
        [aNotesArea setText:@""];
    }
    else
    {
        [aNotesArea setText:[NSString stringWithFormat:@"%@",[arraySelectActivity objectForKey:@"x.RESPONSIBLE_DESC"]]];
        NSLog(@"%@",aNotesArea.text);
    }

    if ([arraySelectActivity objectForKey:@"x.INSPECTOR_DESC"] == nil) {
        [aInspectorsArea setText:@""];
    }
    else
    {
        [aInspectorsArea setText:[NSString stringWithFormat:@"%@",[arraySelectActivity objectForKey:@"x.INSPECTOR_DESC"]]];
    }
    //свойста, которые позволяют сделать UITextView недоступным для редактирования
    //    [aNotesArea setEditable:NO];
    //    [aNotesArea setBackgroundColor:[UIColor clearColor]];
    
//    [aDateOfResponseValue setText:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.FACT_END_DTTM"] ]];
//    [aDateOfInspectValue setText:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.CLOSE_DTTM"]]];

    
    [aStatusButton setTitle:[NSString stringWithFormat:@"%@", [self.arraySelectActivity valueForKey:@"i.ACTIVITY_STATUS_NAME"]] forState:UIControlStateNormal];
    NSLog(@"Статус = %@",[self.arraySelectActivity valueForKey:@"i.ACTIVITY_STATUS_NAME"]);
    
    
    
    [aNotesText setFrame:CGRectMake(aNotesText.frame.origin.x, aNotesText.frame.origin.y, aNotesText.frame.size.width + 200, 106)];
//    [aEndDateLabel setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 15, 240, 17)];
    [createDateLabel setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 15, 330, 17)];
    [aEndDateLabel setFrame:CGRectMake(380, aNotesText.frame.origin.y + aNotesText.frame.size.height + 15, 200, 17)];
    [aEndDateButton setFrame:CGRectMake(310 + 200, aNotesText.frame.origin.y + aNotesText.frame.size.height + 7, 150, 22)];
    [aStatusLabel setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 35, 240, 17)];
    [aStatusButton setFrame:CGRectMake(310 + 200, aNotesText.frame.origin.y + aNotesText.frame.size.height + 30, 150, 22)];
    [aPriorityLabel setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 55, 240, 17)];
    [aPriorityButton setFrame:CGRectMake(310 + 200, aNotesText.frame.origin.y + aNotesText.frame.size.height + 55, 150, 22)];
    [aProblemsLabel setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 75, 240, 17)];
    [aProblemsValue setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 75 + 20, 420 + 200, 106)];
    [aInitiatorLabel setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 95 + 106 + 10, 240, 17)];
    [aInitiatorValue setFrame:CGRectMake(135, aNotesText.frame.origin.y + aNotesText.frame.size.height + 95 + 106 + 10, 240 + 200, 17)];
    [aResponsibleLabel setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 150 + 106, 240, 17)];
    [aResponsibleButton setFrame:CGRectMake(185, aNotesText.frame.origin.y + aNotesText.frame.size.height + 147 + 106, 275 + 200, 22)];
    [aDateOfResponseLabel setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 170 + 106, 240, 17)];
    [aDateOfResponseValue setFrame:CGRectMake(180, aNotesText.frame.origin.y + aNotesText.frame.size.height + 170 + 106, 240, 17)];
    [aPerformLabel setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 170 + 20 + 106, 240, 17)];
    [aNotesArea setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 195 + 20 + 106, 420 + 200, 106)];
    [aInspectorLabel setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 325 + 10 + 106, 240, 17)];
    [aInspectorButton setFrame:CGRectMake(185, aNotesText.frame.origin.y + aNotesText.frame.size.height + 322 + 10 + 106, 275 + 200, 22)];
    [aDateOfInspectLabel setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 325 + 30 + 106, 240, 17)];
    [aDateOfInspectValue setFrame:CGRectMake(163, aNotesText.frame.origin.y + aNotesText.frame.size.height + 325 + 30 + 106, 240, 17)];
    [aControlLabel setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 345 + 30 + 106, 240, 17)];
    [aInspectorsArea setFrame:CGRectMake(40, aNotesText.frame.origin.y + aNotesText.frame.size.height + 370 + 30 + 106, 420 + 200, 106)];
    [aNotesText setText:[NSString stringWithFormat:@"%@",[arraySelectActivity valueForKey:@"x.ACTIVITY_NAME"]]];
    
    [self identification];
    [self mainLogic];
    [self createListOfResponsibles];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    NSLog(@"viewDidUnload method called");
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

- (void)dismissPopover
{
    if (calendarPopover != nil) {
        [calendarPopover dismissPopoverAnimated:YES];
    }
}

#pragma mark - CalendarControllerDelegate

- (void)dismissPopoverWithSelectedDate:(NSDate *)d
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate * now = [NSDate date];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString * nowStr = [formatter stringFromDate:now];
    NSString * dStr = [formatter stringFromDate:d];
    [formatter setDateFormat:@"dd.MM.yyyy"];

    if ([dStr compare:nowStr] == NSOrderedDescending || [nowStr compare:dStr] == NSOrderedSame) {
        [self.aEndDateButton setTitle:[formatter stringFromDate:d] forState:UIControlStateNormal];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Неверная дата" message:@"Нельзя назначить дату исполнения в прошлом" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        [self.aEndDateButton setTitle:[formatter stringFromDate:now] forState:UIControlStateNormal];
    }
//        [bSender.aEndDateButton setTitle:[formatter stringFromDate:d] forState:UIControlStateNormal];

    long long date = [d timeIntervalSince1970];
    NSLog(@"%lld",date);
    NSString * stringDate = [NSString stringWithFormat:@"%lld000",date];
    
    [self.arraySelectActivity setObject:stringDate forKey:@"x.DUEDATE_DTTM"];
    [calendarPopover dismissPopoverAnimated:YES];
    
    [formatter release];

}

- (void)setContentSizeForPopover:(CGSize)size
{
    calendarPopover.popoverContentSize = size;
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [popoverController release];
}

@end
