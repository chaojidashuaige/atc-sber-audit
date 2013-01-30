//
//  TaskActivity.m
//  SberbankAudit
//
//  Created by Артем Куликов on 24.04.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "TaskActivity.h"
#import "SberbankAuditAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "TaskActivitySubType.h"
#import "TaskActivityPriority.h"
#import "TaskActivityTemplate.h"
#import "TaskActivityCreator.h"
#import "TastActivityResponsible.h"
#import "TaskActivityInspector.h"
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
#import "ODMobileMBO_getActivityPriorities.h"
#import "ODMobileMBO_getActivityTypes.h"
#import "ODMobileMBOActivityTemplates.h"
#import "ODMobileMBO_getEmployees.h"
#import "ODMobileMBO_getTaskTypes.h"
#import "ODMobileMBOUnions.h"
#import "ODMobileMBOEmployeesSubordinations.h"
#import "Cell.h"
#import "EmployeeDTO.h"
#import "WaitingViewController.h"
#import "CameraViewController.h"

#define LABELS_FONT_SIZE 16.0f
#define TITLE_FONT_SIZE 18.0f
#define FIRST_HIERARCHY_LEVEL 1

@interface TaskActivity ()

@end

@implementation TaskActivity

@synthesize aTypeButton;
@synthesize aPriorityButton;
@synthesize aEndDateButton;
@synthesize activity;
@synthesize taskPlan;
@synthesize SUBBRANCH_ID;
@synthesize UNION_ID;
@synthesize aTemplateButton;
@synthesize aNotesArea;
@synthesize aCreatorButton;
@synthesize scroll;
@synthesize aResponsibleButton;
@synthesize aInspectorButton;
@synthesize aPhotoButton;
@synthesize answerID;
@synthesize questionID;
//@synthesize selectedActivityType;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    if (screen == false) {
        SberbankAuditAppDelegate * app = [SberbankAuditAppDelegate instance];
        NSString * employee_ID = [app EMPLOYEE_ID];
        NSLog(@"employee_ID = %@",employee_ID);
        
        ODMobileMBO_getEmployees * employer = [ODMobileMBO_getEmployees findByPrimaryKey:employee_ID];
        NSLog(@"employee: %@",employer);
        NSString * lastName = [employer LAST_NAME];
        NSString * firstName = [employer FIRST_NAME];
        NSString * patronymic = [employer PATRONYMIC];
        //        NSString * employee_position = [employer EMPLOYEE_POSITION];
        
        [activity setObject:employee_ID forKey:@"e.EMPLOYEE_ID"];
        [activity setObject:lastName forKey:@"e.LAST_NAME"];
        [activity setObject:firstName forKey:@"e.FIRST_NAME"];
        [activity setObject:patronymic forKey:@"e.PATRONYMI"];
        
        [activity setObject:[NSString stringWithFormat:@"%@",SUBBRANCH_ID] forKey:@"SUBBRANCH_ID"];
        ODMobileMBO_getSubbranches * subbranch = [ODMobileMBO_getSubbranches findByPrimaryKey:[NSString stringWithFormat:@"%@",SUBBRANCH_ID]];
        NSString * object = [subbranch SUBBRANCH_NAME];

        [activity setObject:[NSString stringWithFormat:@"%@",UNION_ID] forKey:@"UNION_ID"];
        ODMobileMBOUnions * unions = [ODMobileMBOUnions findByPrimaryKey:[NSString stringWithFormat:@"%@",UNION_ID]];
        
        if (unions != nil) {
            object = [unions UNION_NAME];
        }

        
        NSString * chief_ID = [NSString stringWithFormat:@"%@",[subbranch CHIEF_EMPLOYEE_ID]];
        
        ODMobileMBO_getEmployees * chief = [ODMobileMBO_getEmployees findByPrimaryKey:chief_ID];
        NSString * chief_LAST_NAME;
        NSString * chief_FIRST_NAME;
        NSString * chief_PATRONYMIC;
        
        if (chief == nil) {
            chief_LAST_NAME = @"";
            chief_FIRST_NAME = @"";
            chief_PATRONYMIC = @"";
        }
        else{
            chief_LAST_NAME = [NSString stringWithFormat:@"%@",[chief LAST_NAME]];
            chief_FIRST_NAME = [NSString stringWithFormat:@"%@",[chief FIRST_NAME]];
            chief_PATRONYMIC = [NSString stringWithFormat:@"%@",[chief PATRONYMIC]];
        }
        
        
        
//        scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
        scroll.showsVerticalScrollIndicator = YES;
        scroll.scrollEnabled = YES;
        scroll.userInteractionEnabled = YES;
        //    scroll.userInteractionEnabled = NO;
        scroll.contentSize = CGSizeMake(504+200, 900);
        scroll.delegate = self;
        [self.view addSubview:scroll];
        
        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 25, 440+200, 21)];
        [aTitleLabel setTextAlignment:UITextAlignmentCenter];
        [aTitleLabel setFont:[UIFont systemFontOfSize:TITLE_FONT_SIZE]];
        [aTitleLabel setText:@"Создание нового мероприятия"];
        [aTitleLabel setTextColor:[UIColor blackColor]];
        [aTitleLabel setBackgroundColor:[UIColor clearColor]];
        //        [self.view addSubview:aTitleLabel];
        [scroll addSubview:aTitleLabel];
        
        UILabel *aTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 85, 240, 17)];
        [aTypeLabel setTextAlignment:UITextAlignmentLeft];
        [aTypeLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aTypeLabel setText:@"Тип мероприятия:"];
        [aTypeLabel setTextColor:[UIColor darkGrayColor]];
        [aTypeLabel setBackgroundColor:[UIColor clearColor]];
        //        [self.view addSubview:aTypeLabel];
        [scroll addSubview:aTypeLabel];
        [aTypeLabel release];
        
        UILabel *aPriorityLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 126, 240, 17)];
        [aPriorityLabel setTextAlignment:UITextAlignmentLeft];
        [aPriorityLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aPriorityLabel setText:@"Приоритет мероприятия:"];
        [aPriorityLabel setTextColor:[UIColor darkGrayColor]];
        [aPriorityLabel setBackgroundColor:[UIColor clearColor]];
        //        [self.view addSubview:aPriorityLabel];
        [scroll addSubview:aPriorityLabel];
        [aPriorityLabel release];
        
        UILabel *aNotesLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 165, 240, 17)];
        [aNotesLabel setTextAlignment:UITextAlignmentLeft];
        [aNotesLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aNotesLabel setText:@"Указания:"];
        [aNotesLabel setTextColor:[UIColor darkGrayColor]];
        [aNotesLabel setBackgroundColor:[UIColor clearColor]];
        //        [self.view addSubview:aNotesLabel];
        [scroll addSubview:aNotesLabel];
        [aNotesLabel release];
        
        UILabel *aEndDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 340, 240, 17)];
        [aEndDateLabel setTextAlignment:UITextAlignmentLeft];
        [aEndDateLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aEndDateLabel setText:@"Выполнить до:"];
        [aEndDateLabel setTextColor:[UIColor darkGrayColor]];
        [aEndDateLabel setBackgroundColor:[UIColor clearColor]];
        //        [self.view addSubview:aEndDateLabel];
        [scroll addSubview:aEndDateLabel];
        [aEndDateLabel release];
        
        //        UILabel *aResponsibleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 380, 240, 17)];
        UILabel *aResponsibleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 380, 150, 17)];
        [aResponsibleLabel setTextAlignment:UITextAlignmentLeft];
        [aResponsibleLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aResponsibleLabel setText:@"Ответственный :"];
        [aResponsibleLabel setTextColor:[UIColor darkGrayColor]];
        [aResponsibleLabel setBackgroundColor:[UIColor clearColor]];
        //        [self.view addSubview:aResponsibleLabel];
        [scroll addSubview:aResponsibleLabel];
        [aResponsibleLabel release];
        
        //        UILabel *aInspectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 420, 240, 17)];
        UILabel *aInspectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 420, 150, 17)];
        [aInspectorLabel setTextAlignment:UITextAlignmentLeft];
        [aInspectorLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aInspectorLabel setText:@"Контролирующий:"];
        [aInspectorLabel setTextColor:[UIColor darkGrayColor]];
        [aInspectorLabel setBackgroundColor:[UIColor clearColor]];
        //        [self.view addSubview:aInspectorLabel];
        [scroll addSubview:aInspectorLabel];
        [aInspectorLabel release];
        
        //        UILabel *aInspectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 420, 240, 17)];
        UILabel *aCreatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 420+40, 150, 17)];
        [aCreatorLabel setTextAlignment:UITextAlignmentLeft];
        [aCreatorLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aCreatorLabel setText:@"Инициатор:"];
        [aCreatorLabel setTextColor:[UIColor darkGrayColor]];
        [aCreatorLabel setBackgroundColor:[UIColor clearColor]];
        //        [self.view addSubview:aInspectorLabel];
        [scroll addSubview:aCreatorLabel];
        [aCreatorLabel release];
        
        UILabel *aProblemsLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 460+40, 240, 17)];
        [aProblemsLabel setTextAlignment:UITextAlignmentLeft];
        [aProblemsLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aProblemsLabel setText:@"Проблемы:"];
        [aProblemsLabel setTextColor:[UIColor darkGrayColor]];
        [aProblemsLabel setBackgroundColor:[UIColor clearColor]];
        //        [self.view addSubview:aProblemsLabel];
        [scroll addSubview:aProblemsLabel];
        [aProblemsLabel release];
        
        UILabel * statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 635+40, 150, 17)];
        statusLabel.text = @"Статус:";
        statusLabel.textAlignment = UITextAlignmentLeft;
        statusLabel.backgroundColor = [UIColor clearColor];
        [statusLabel setTextColor:[UIColor darkGrayColor]];
        [scroll addSubview:statusLabel];
        [statusLabel release];
        
        UILabel * statusValue = [[UILabel alloc] initWithFrame:CGRectMake(220 + 200, 635+40, 230, 25)];
        statusValue.text = @"Назначено";
        statusValue.textAlignment = UITextAlignmentRight;
        statusValue.backgroundColor = [UIColor clearColor];
        [statusValue setFont:[UIFont systemFontOfSize:14.0f]];
        [scroll addSubview:statusValue];
        [statusValue release];
        
        UILabel * dateOfCreateLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 635+80, 150, 17)];
        dateOfCreateLabel.text = @"Дата создания:";
        dateOfCreateLabel.textAlignment = UITextAlignmentLeft;
        dateOfCreateLabel.backgroundColor = [UIColor clearColor];
        [dateOfCreateLabel setTextColor:[UIColor darkGrayColor]];
        [scroll addSubview:dateOfCreateLabel];
        [dateOfCreateLabel release];
        
        NSDate * date = [NSDate date];
        NSString * str;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
//        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        str = [dateFormatter stringFromDate:date];
        [dateFormatter release];
        
        long long dateLong = [date timeIntervalSince1970];
        NSLog(@"%lld",dateLong);
        NSString * stringDate = [NSString stringWithFormat:@"%lld000",dateLong];
        dateOfCreate = [[NSString alloc] initWithString:stringDate];

        
        UILabel * dateOfCreateValue = [[UILabel alloc] initWithFrame:CGRectMake(220, 635+80, 230+200, 25)];
        dateOfCreateValue.text = str;
        dateOfCreateValue.textAlignment = UITextAlignmentRight;
        dateOfCreateValue.backgroundColor = [UIColor clearColor];
        [dateOfCreateValue setFont:[UIFont systemFontOfSize:14.0f]];
        [scroll addSubview:dateOfCreateValue];
        [dateOfCreateValue release];
        
        UILabel * objectLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 635+120, 180, 17)];
        objectLabel.text = @"Объект посещения:";
        objectLabel.textAlignment = UITextAlignmentLeft;
        objectLabel.backgroundColor = [UIColor clearColor];
        [objectLabel setTextColor:[UIColor darkGrayColor]];
        [scroll addSubview:objectLabel];
        [objectLabel release];
        
        UILabel * objectValue = [[UILabel alloc] initWithFrame:CGRectMake(230, 635+120, 220+200, 25)];
        objectValue.text = object;
        objectValue.textAlignment = UITextAlignmentRight;
        objectValue.backgroundColor = [UIColor clearColor];
        [objectValue setFont:[UIFont systemFontOfSize:14.0f]];
        [scroll addSubview:objectValue];
        [objectValue release];
        
        UILabel * chiefLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 635+160, 180, 17)];
        chiefLabel.text = @"Руководитель:";
        chiefLabel.textAlignment = UITextAlignmentLeft;
        chiefLabel.backgroundColor = [UIColor clearColor];
        [chiefLabel setTextColor:[UIColor darkGrayColor]];
        [scroll addSubview:chiefLabel];
        [chiefLabel release];
        
        UILabel * chiefValue = [[UILabel alloc] initWithFrame:CGRectMake(230, 635+160, 220+200, 25)];
        chiefValue.text = [NSString stringWithFormat:@"%@ %@ %@",chief_LAST_NAME, chief_FIRST_NAME,chief_PATRONYMIC];
        chiefValue.textAlignment = UITextAlignmentRight;
        chiefValue.backgroundColor = [UIColor clearColor];
        [chiefValue setFont:[UIFont systemFontOfSize:14.0f]];
        [scroll addSubview:chiefValue];
        [chiefValue release];
        
        
        UIButton *aSaveButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
        //        [aSaveButton setFrame:CGRectMake(190, 635, 120, 35)];
        [aSaveButton setFrame:CGRectMake(80+100, 635+200, 120, 35)];
        [aSaveButton setTitle:@"Сохранить" forState:UIControlStateNormal];
        [aSaveButton addTarget:self action:@selector(aSaveAction) forControlEvents:UIControlEventTouchUpInside];
        //        [self.view addSubview:aSaveButton];
        [scroll addSubview:aSaveButton];
        [aSaveButton release];
        
        UIButton *aCancelButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
        //        [aCancelButton setFrame:CGRectMake(190, 635, 120, 35)];
        [aCancelButton setFrame:CGRectMake(300+100, 635+200, 120, 35)];
        [aCancelButton setTitle:@"Отменить" forState:UIControlStateNormal];
        [aCancelButton addTarget:self action:@selector(aCancelAction) forControlEvents:UIControlEventTouchUpInside];
        //        [self.view addSubview:aCancelButton];
        [scroll addSubview:aCancelButton];
        [aCancelButton release];
        //set interactive components
        
        aTypeButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [aTypeButton setFrame:CGRectMake(210, 85, 240+200, 25)];
//        [aTypeButton setTitle:@"Тип мероприятия" forState:UIControlStateNormal];
        [aTypeButton setTitle:@"Выбрать тип" forState:UIControlStateNormal];
        [aTypeButton addTarget:self action:@selector(showActivitySubType) forControlEvents:UIControlEventTouchUpInside];
        //        [self.view addSubview:aTypeButton];
        [scroll addSubview:aTypeButton];
        
        aPriorityButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [aPriorityButton setFrame:CGRectMake(300+200, 126, 150, 25)];
        [aPriorityButton setTitle:@"Приоритет" forState:UIControlStateNormal];
        [aPriorityButton addTarget:self action:@selector(showActivityPriority) forControlEvents:UIControlEventTouchUpInside];
        //        [self.view addSubview:aPriorityButton];
        [scroll addSubview:aPriorityButton];
        
        aTemplateButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [aTemplateButton setFrame:CGRectMake(210, 161, 240+200, 25)];
        [aTemplateButton setTitle:@"Указание" forState:UIControlStateNormal];
        [aTemplateButton addTarget:self action:@selector(showActivityTemplate) forControlEvents:UIControlEventTouchUpInside];
        //        [self.view addSubview:aTemplateButton];
        [scroll addSubview:aTemplateButton];
        
        
        aNotesArea = [[UITextView alloc] initWithFrame:CGRectMake(40, 195, 420+200, 106)];
        [aNotesArea.layer setCornerRadius:10.0f];
        [aNotesArea.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [aNotesArea.layer setBorderWidth:1.0f];
        //        [self.view addSubview:aNotesArea];
        [scroll addSubview:aNotesArea];
        
        
        aEndDateButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [aEndDateButton setFrame:CGRectMake(300+200, 340, 150, 25)];
        [aEndDateButton addTarget:self action:@selector(showCalendar) forControlEvents:UIControlEventTouchUpInside];
        [aEndDateButton setTitle:@"Дата" forState:UIControlStateNormal];
        //        [self.view addSubview:aEndDateButton];
        [scroll addSubview:aEndDateButton];
        
        
        
        
        
        aResponsibleButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        //        [aResponsibleButton setFrame:CGRectMake(300, 380, 150, 25)];
        [aResponsibleButton setFrame:CGRectMake(220, 380, 230+200, 25)];
        [aResponsibleButton addTarget:self action:@selector(showActivityResponsible) forControlEvents:UIControlEventTouchUpInside];
        [aResponsibleButton setTitle:@"Выбрать" forState:UIControlStateNormal];
        //        [self.view addSubview:aCreatorButton];
        [scroll addSubview:aResponsibleButton];

        
        aInspectorButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        //        [aCreatorButton setFrame:CGRectMake(300, 380, 150, 25)];
        [aInspectorButton setFrame:CGRectMake(220, 420, 230+200, 25)];
        [aInspectorButton addTarget:self action:@selector(showActivityInspector) forControlEvents:UIControlEventTouchUpInside];
        [aInspectorButton setTitle:@"Выбрать" forState:UIControlStateNormal];
        //        [self.view addSubview:aCreatorButton];
        [scroll addSubview:aInspectorButton];
        
        aInspectorButton.enabled = NO;
        [aInspectorButton setAlpha:0.5];

        
        aCreatorButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        //        [aCreatorButton setFrame:CGRectMake(300, 380, 150, 25)];
        [aCreatorButton setFrame:CGRectMake(220, 420+40, 230, 25)];
        //        [aCreatorButton addTarget:self action:@selector(showActivityCreator) forControlEvents:UIControlEventTouchUpInside];
        [aCreatorButton setTitle:@"Выбрать" forState:UIControlStateNormal];
        //        [self.view addSubview:aCreatorButton];
        //        [scroll addSubview:aCreatorButton];
        
        UILabel * aCreatorValue = [[UILabel alloc] initWithFrame:CGRectMake(220, 420+40, 230+200, 25)];
        [aCreatorValue setText:[NSString stringWithFormat:@"%@ %@ %@", lastName,firstName,patronymic]];
        [aCreatorValue setTextAlignment:UITextAlignmentRight];
        [aCreatorValue setBackgroundColor:[UIColor clearColor]];
        [aCreatorValue setFont:[UIFont systemFontOfSize:14.0f]];
        [scroll addSubview:aCreatorValue];
        [aCreatorValue release];
        
        
        //        aResponsibleValue = [[UILabel alloc] initWithFrame:CGRectMake(300, 380, 240, 17)];
        //        [aResponsibleValue setTextAlignment:UITextAlignmentLeft];
        //        [aResponsibleValue setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        //        [aResponsibleValue setText:@"Ответственный"];
        //        [aResponsibleValue setTextColor:[UIColor darkGrayColor]];
        //        [aResponsibleValue setBackgroundColor:[UIColor clearColor]];
        //        [self.view addSubview:aResponsibleValue];
        
        aInspectorValue = [[UILabel alloc] initWithFrame:CGRectMake(300, 420, 240, 17)];
        [aInspectorValue setTextAlignment:UITextAlignmentLeft];
        [aInspectorValue setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aInspectorValue setText:@"Контролирующий"];
        [aInspectorValue setTextColor:[UIColor darkGrayColor]];
        [aInspectorValue setBackgroundColor:[UIColor clearColor]];
        //        [self.view addSubview:aInspectorValue];
        //        [scroll addSubview:aInspectorValue];
        
        
        aProblemsArea = [[UITextView alloc] initWithFrame:CGRectMake(40, 495+40, 310+200, 106)];
        [aProblemsArea.layer setCornerRadius:10.0f];
        [aProblemsArea.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [aProblemsArea.layer setBorderWidth:1.0f];
        //        [self.view addSubview:aProblemsArea];
        [scroll addSubview:aProblemsArea];
        
        
        UILabel *aPhotoLabel = [[UILabel alloc] initWithFrame:CGRectMake(360+200, 495+40, 100, 106)];
        [aPhotoLabel setTextAlignment:UITextAlignmentCenter];
        [aPhotoLabel setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [aPhotoLabel setText:@"Фото"];
        [aPhotoLabel setTextColor:[UIColor darkGrayColor]];
        [aPhotoLabel setBackgroundColor:[UIColor lightGrayColor]];
        [aPhotoLabel.layer setCornerRadius:10.0f];
        //        [self.view addSubview:aPhotoLabel];
        //    [scroll addSubview:aPhotoLabel];
        
        aPhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(360+200, 495+40, 100, 106)];
        [aPhotoButton setTitle:@"Фото" forState:UIControlStateNormal];
        [aPhotoButton setBackgroundColor:[UIColor lightGrayColor]];
        [aPhotoButton addTarget:self action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
        //        [self.view addSubview:aPhotoLabel];
        [scroll addSubview:aPhotoButton];
        
        
        userPhoto = [[UIImageView alloc] initWithFrame:aPhotoLabel.frame];
        //    userPhoto = [[UIImageView alloc] initWithFrame:aPhotoButton.frame];
        [userPhoto setHidden:YES];
        [userPhoto.layer setMasksToBounds:YES];
        [userPhoto.layer setCornerRadius:10.0f];
        //        [self.view addSubview:userPhoto];
        [scroll addSubview:userPhoto];
        [aPhotoLabel release];

        
        newLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 250, 250, 60)];
        newLabel.text = @"Идет подготовка данных";
        [newLabel setBackgroundColor:[UIColor lightGrayColor]];
        [newLabel setTextAlignment:UITextAlignmentCenter];
        [scroll addSubview:newLabel];

        newIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        newIndicator.center = CGPointMake(250, 280);
        [newIndicator startAnimating];
        [scroll addSubview:newIndicator];
        
        [self.view setUserInteractionEnabled:NO];

//        [self createListOfResponsibles];

        
//        screen = true;
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

//    newLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 250, 250, 60)];
//    newLabel.text = @"Идет подготовка данных";
//    [newLabel setBackgroundColor:[UIColor lightGrayColor]];
//    [newLabel setTextAlignment:UITextAlignmentCenter];
//    [self.view addSubview:newLabel];
//
//    newIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    newIndicator.center = CGPointMake(250, 530);
//    [newIndicator startAnimating];
    
    
    
    
    
    if (screen == false) {
        screen = true;
        [self createListOfResponsibles];
        
        [newIndicator setHidden:YES];
        [newLabel setHidden:YES];
        
        [newIndicator stopAnimating];
        [newIndicator release];
        [newLabel release];
        
        [self.view setUserInteractionEnabled:YES];
    }


//    [self createListOfResponsibles];
//    
//    [newIndicator setHidden:YES];
//    [newLabel setHidden:YES];
//
//    [newIndicator stopAnimating];
//    [newIndicator release];
//    [newLabel release];
//
//    [self.view setUserInteractionEnabled:YES];
}



- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init])
	{
        [self.view setFrame:frame];
        
        scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
        
//        label = [[UILabel alloc] initWithFrame:CGRectMake(300, 500, 200, 60)];
//        [label setText:@"Идет синхронизация"];
//        [label setBackgroundColor:[UIColor lightGrayColor]];
//        [label setTextAlignment:UITextAlignmentCenter];
////        [scroll addSubview:label];
//        [label setHidden:YES];
//        
//        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        indicator.center = CGPointMake(250, 530);
//        [indicator setHidden:YES];
////        [scroll addSubview:indicator];

        [self.view setAutoresizesSubviews:NO];

    }
    
    return self;
}

- (void) showCalendar
{
    CalendarController *rtCalendar = [[CalendarController alloc] initWithNibName:nil bundle:nil];
    UIViewController *calendarViewController = (UIViewController*)rtCalendar;
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:calendarViewController];
    [calendarPopover setPopoverContentSize:CGSizeMake(rtCalendar.calendar.frame.size.width, rtCalendar.calendar.frame.size.height)];    
    rtCalendar.delegate = self;
    [calendarPopover presentPopoverFromRect:aEndDateButton.bounds inView:aEndDateButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [rtCalendar release];
}

- (void) showActivityInspector
{
    [self getInspectors];
    TaskActivityInspector *Inspector = [[TaskActivityInspector alloc] initWithStyle:UITableViewStylePlain];
    Inspector.taClass = self;
    for (int i = 0; i < resultInspectors.count; i++) {
        ODMobileMBO_getEmployees * employeer = [ODMobileMBO_getEmployees findByPrimaryKey:[NSString stringWithFormat:@"%@",[[resultInspectors objectAtIndex:i] employeeID]]];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer EMPLOYEE_ID]] forKey:@"EMPLOYEE_ID"];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer LAST_NAME]] forKey:@"LAST_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer FIRST_NAME]] forKey:@"FIRST_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer PATRONYMIC]] forKey:@"PATRONYMIC"];
        [Inspector.arraySubType addObject:dict];
    }
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:Inspector];
    calendarPopover.popoverContentSize = CGSizeMake(700, 400);
    [calendarPopover presentPopoverFromRect:aInspectorButton.bounds inView:aInspectorButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [Inspector release];
}

- (void) getInspectors
{
    NSString * employee_ID = [activity objectForKey:@"d.EMPLOYEE_ID"];
    NSString * level;
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
//        if ([emp.hierarchyLevel longLongValue] > [employee_ID longLongValue]) {
//            [resultInspectors addObject:emp];
//        }
    }
    if (resultInspectors.count == 0) {
        for (EmployeeDTO * emp in resultEmployees) {
            if ([emp.employeeID isEqualToString:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].EMPLOYEE_ID]]) {
                [resultInspectors addObject:emp];
            }
        }
    }
}

- (void) showActivityResponsible
{
    TastActivityResponsible *Responcer = [[TastActivityResponsible alloc] initWithStyle:UITableViewStylePlain];
    Responcer.taClass = self;
    for (int i = 0; i < resultEmployees.count; i++) {
        ODMobileMBO_getEmployees * employeer = [ODMobileMBO_getEmployees findByPrimaryKey:[NSString stringWithFormat:@"%@",[[resultEmployees objectAtIndex:i] employeeID]]];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer EMPLOYEE_ID]] forKey:@"EMPLOYEE_ID"];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer LAST_NAME]] forKey:@"LAST_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer FIRST_NAME]] forKey:@"FIRST_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[employeer PATRONYMIC]] forKey:@"PATRONYMIC"];
        [Responcer.arraySubType addObject:dict];
    }
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:Responcer];
    calendarPopover.popoverContentSize = CGSizeMake(700, 400);
    [calendarPopover presentPopoverFromRect:aResponsibleButton.bounds inView:aResponsibleButton permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
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
    
    if ([SUBBRANCH_ID integerValue] == 0) {
        _union = [ODMobileMBOUnions findByPrimaryKey:[UNION_ID stringValue]];
        NSLog(@"_union: %@",_union);
    } else {
        subbranch = [ODMobileMBO_getSubbranches findByPrimaryKey:[SUBBRANCH_ID stringValue]];
        NSLog(@"subbranch: %@",subbranch);
    }
    
    NSLog(@"subbranchID = %@",SUBBRANCH_ID);
    NSLog(@"unionID = %@",UNION_ID);
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
    NSMutableArray * result = [[NSMutableArray alloc] init];
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
//        for (EmployeeDTO * emp in creatorCell.employees) {
//            [emp setHierarchyLevel:[NSString stringWithFormat:@"%i",hierarchyLevel]];
//        }
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
    
    NSLog(@"Parent.cellID = %@",cell.parentCellID);
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

- (void) showActivityCreator
{
    TaskActivityCreator *Creator = [[TaskActivityCreator alloc] initWithStyle:UITableViewStylePlain];
    Creator.taClass = self;
    SUPObjectList * activitiesCreator = [ODMobileMBO_getEmployees findAll];
    for (int i = 0; i < activitiesCreator.size; i++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSString stringWithFormat:@"%@",[[activitiesCreator objectAtIndex:i] EMPLOYEE_ID]] forKey:@"EMPLOYEE_ID"];
        [dict setObject:[NSString stringWithFormat:@"%@",[[activitiesCreator objectAtIndex:i] LAST_NAME]] forKey:@"LAST_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[[activitiesCreator objectAtIndex:i] FIRST_NAME]] forKey:@"FIRST_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[[activitiesCreator objectAtIndex:i] PATRONYMIC]] forKey:@"PATRONYMIC"];
        //        NSLog(@"%@ = %@",[[activityPriorities objectAtIndex:i] ACTIVITY_PRIORITY_ID],[[activityPriorities objectAtIndex:i] ACTIVITY_PRIORITY_NAME]);
//        NSLog(@"%@",dict);
        [Creator.arraySubType addObject:dict];
        [dict release];
    }
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:Creator];
    [calendarPopover presentPopoverFromRect:aCreatorButton.bounds inView:aCreatorButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [Creator release];
}

- (void) showActivityTemplate
{
    TaskActivityTemplate *Template = [[TaskActivityTemplate alloc] initWithStyle:UITableViewStylePlain];
    Template.taClass = self;

    NSLog(@"type_id = %@",[activity objectForKey:@"z.ACTIVITY_TYPE_ID"]);
    SUPObjectList * activityTemplatesList = [ODMobileMBOActivityTemplates getByActivityTypeId:[activity objectForKey:@"z.ACTIVITY_TYPE_ID"]];
    for (ODMobileMBOActivityTemplates * template in activityTemplatesList) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSString stringWithFormat:@"%@",[template ACTIVITY_TEMPLATE_ID]] forKey:@"ACTIVITY_TEMPLATE_ID"];
        [dict setObject:[NSString stringWithFormat:@"%@",[template ACTIVITY_NAME]] forKey:@"ACTIVITY_NAME"];
        [dict setObject:[NSString stringWithFormat:@"%@",[template ACTIVITY_PRIORITY_ID]] forKey:@"ACTIVITY_PRIORITY_ID"];
        [dict setObject:[NSString stringWithFormat:@"%@",[template TIME_PERIOD]] forKey:@"TIME_PERIOD"];
        [Template.arraySubType addObject:dict];
        [dict release];
    }
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:Template];
    calendarPopover.popoverContentSize = CGSizeMake(600, 250);
    [calendarPopover presentPopoverFromRect:aTemplateButton.bounds inView:aTemplateButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [Template release];
}

- (void) showActivitySubType
{
    TaskActivitySubType *SubType = [[TaskActivitySubType alloc] initWithStyle:UITableViewStylePlain];
    SubType.taClass = self;
    
    ODMobileMBO_getTasks * selectedTask = [ODMobileMBO_getTasks findByPrimaryKey:[taskPlan taskID]];
    ODMobileMBO_getTaskTypes * taskType  = [ODMobileMBO_getTaskTypes findByPrimaryKey:[NSString stringWithFormat:@"%@",[selectedTask TASK_TYPE_ID]]];
    SUPObjectList * activityTypes = [ODMobileMBO_getActivityTypes getByCategoryId:[NSString stringWithFormat:@"%@",[taskType CATEGORY_ID]]];
    
    for (ODMobileMBO_getActivityTypes * activityType in activityTypes) {
        if ([[NSString stringWithFormat:@"%@",[activityType BUSINESS_PROCESS_ID]] isEqualToString:[NSString stringWithFormat:@"%@",[taskType BUSINESS_PROCESS_ID]]]) {
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
            [dict setObject:[NSString stringWithFormat:@"%@",[activityType ACTIVITY_TYPE_ID]] forKey:@"ACTIVITY_TYPE_ID"];
            [dict setObject:[NSString stringWithFormat:@"%@",[activityType ACTIVITY_TYPE_NAME]] forKey:@"ACTIVITY_TYPE_NAME"];
            [SubType.arraySubType addObject:dict];
            [dict release];
        }
    }
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:SubType];
    calendarPopover.popoverContentSize = CGSizeMake(700, 400);
    [calendarPopover presentPopoverFromRect:aTypeButton.bounds inView:aTypeButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [SubType release];
}

- (void) showActivityPriority
{ 
    TaskActivityPriority *Priority = [[TaskActivityPriority alloc] initWithStyle:UITableViewStylePlain];
    Priority.tbClass = self;
    SUPObjectList * activityPriorities = [ODMobileMBO_getActivityPriorities findAll];
    for (int i = 0; i < activityPriorities.size; i++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSString stringWithFormat:@"%@",[[activityPriorities objectAtIndex:i] ACTIVITY_PRIORITY_ID]] forKey:@"ACTIVITY_PRIORITY_ID"];
        [dict setObject:[NSString stringWithFormat:@"%@",[[activityPriorities objectAtIndex:i] ACTIVITY_PRIORITY_NAME]] forKey:@"ACTIVITY_PRIORITY_NAME"];
        [Priority.arrayWithData addObject:dict];
        [dict release];
    }
    calendarPopover = [[UIPopoverController alloc] initWithContentViewController:Priority];
    calendarPopover.popoverContentSize = CGSizeMake(300, 140);
//    [self.calendarPopover presentPopoverFromRect:aPriorityButton.bounds inView:aPriorityButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [calendarPopover presentPopoverFromRect:aPriorityButton.bounds inView:aPriorityButton permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    [Priority release];
}

- (void) aCancelAction
{
    cancelAlert = [[UIAlertView alloc] initWithTitle:@"Завершение операции" message:@"Действительно хотите отменить создание мероприятия?" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil];
    [cancelAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == cancelAlert) {
        if (buttonIndex == 1) {
            [self dismissTaskWindow];
        }
    }
}

- (void) dismissTaskWindow
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) aSaveAction
{
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

    
    
    
    NSLog(@"%@",[aNotesArea text]);
    if (![aNotesArea.text isEqualToString:@""] && aNotesArea != nil) {
        [activity setObject:[aNotesArea text] forKey:@"x.ACTIVITY_NAME"];
    }
//    [activity setObject:[aNotesArea text] forKey:@"x.ACTIVITY_NAME"];
    [activity setObject:[aProblemsArea text] forKey:@"x.PROBLEMS"];
    
    
    

    @try {
        NSLog(@"Save method began");
        
//        [self.view setUserInteractionEnabled:NO];
//        [scroll addSubview:label];
//        [scroll addSubview:indicator];
//        [label setHidden:NO];
//        [indicator setHidden:NO];
//        [indicator startAnimating];
        
        SUPObjectList * fieldList = [[SUPObjectList alloc]init];
        ODMobileMBO_getActivities * newActivity = [ODMobileMBO_getActivities new];
        
        //ACTIVITY_ID
        [newActivity setACTIVITY_ID:@"0"];
        ODMobileObjField * field1 = [ODMobileObjField new];
        [field1 setNm:@"ACTIVITY_ID"];
        [field1 setVl:@"0"];
        [fieldList add:field1];
        NSLog(@"field1 = %@",field1.vl);
        [field1 release];
        

        //ACTIVITY_TYPE_ID
//        [newActivity setACTIVITY_TYPE_ID:activityTypeID];
        if ([activity objectForKey:@"z.ACTIVITY_TYPE_ID"] == nil) {
            [indicator stopAnimating];
            [largeLabel setHidden:YES];
            [self.view setUserInteractionEnabled:YES];

            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка ввода данных" message:@"Не заполнено поле 'Тип мероприятия:'" delegate:self cancelButtonTitle:@"Вернуться к заполнению" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return ;
        }
        ODMobileObjField * field2 = [ODMobileObjField new];
        [field2 setNm:@"ACTIVITY_TYPE_ID"];
//        [field2 setVl:activityTypeID];
        [field2 setVl:[NSString stringWithFormat:@"%@",[activity objectForKey:@"z.ACTIVITY_TYPE_ID"]]];
        [fieldList add:field2];
//        [activityTypeID release];
        NSLog(@"field2 = %@",field2.vl);
        [field2 release];
        
        
        NSLog(@"Activity name = %@",[activity objectForKey:@"x.ACTIVITY_NAME"]);
        //ACTIVITY_NAME
        if ([activity objectForKey:@"x.ACTIVITY_NAME"] == nil || [activity objectForKey:@"x.ACTIVITY_NAME"] == @"") {
            [indicator stopAnimating];
            [largeLabel setHidden:YES];
            [self.view setUserInteractionEnabled:YES];

            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка ввода данных" message:@"Не заполнено поле 'Указание'" delegate:self cancelButtonTitle:@"Вернуться к заполнению" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return ;
        }
//        [newActivity setACTIVITY_NAME:[activity objectForKey:@"x.ACTIVITY_NAME"]];
        ODMobileObjField * field3 = [ODMobileObjField new];
        [field3 setNm:@"ACTIVITY_NAME"];
        [field3 setVl:[activity objectForKey:@"x.ACTIVITY_NAME"]];
        [fieldList add:field3];
        NSLog(@"field3 = %@",field3.vl);
        [field3 release];
        
        
        //ACTIVITY_PRIORITY_ID
        NSString * selectedItemPriority = [activity objectForKey:@"a.ACTIVITY_PRIORITY_NAME"];
        if ([activity objectForKey:@"a.ACTIVITY_PRIORITY_NAME"] == nil) {
            [indicator stopAnimating];
            [largeLabel setHidden:YES];
            [self.view setUserInteractionEnabled:YES];

            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка ввода данных" message:@"Не заполнено поле 'Приоритет:'" delegate:self cancelButtonTitle:@"Вернуться к заполнению" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return ;
        }
        NSMutableString * activityPriorityID = [[NSMutableString alloc] initWithString:@""];
        if ([selectedItemPriority isEqualToString:@"Высокий"]) {
            [activityPriorityID appendString:@"3"];
        } else if ([selectedItemPriority isEqualToString:@"Средний"]){
            [activityPriorityID appendString:@"2"];
        } else if ([selectedItemPriority isEqualToString:@"Низкий"]){
            [activityPriorityID appendString:@"1"];
        }
//        [newActivity setACTIVITY_PRIORITY_ID:activityPriorityID];
        ODMobileObjField * field4 = [ODMobileObjField new];
        [field4 setNm:@"ACTIVITY_PRIORITY_ID"];
        [field4 setVl:activityPriorityID];
        [fieldList add:field4];
        [activityPriorityID release];
        NSLog(@"field4 = %@",field4.vl);
        [field4 release];
        
        
        //PROBLEMS
//        [newActivity setPROBLEMS:[activity objectForKey:@"x.PROBLEMS"]];
        ODMobileObjField * field5 = [ODMobileObjField new];
        [field5 setNm:@"PROBLEMS"];
        [field5 setVl:[activity objectForKey:@"x.PROBLEMS"]];
        [fieldList add:field5];
        NSLog(@"field5 = %@",field5.vl);
        [field5 release];
        
        
        //DUEDATE_DTTM
        if ([activity objectForKey:@"x.DUEDATE_DTTM"] == nil) {
            [indicator stopAnimating];
            [largeLabel setHidden:YES];
            [self.view setUserInteractionEnabled:YES];

            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка ввода данных" message:@"Не заполнено поле 'Выполнить до:'" delegate:self cancelButtonTitle:@"Вернуться к заполнению" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return ;
        }

//        [newActivity setDUEDATE_DTTM:[activity objectForKey:@"x.DUEDATE_DTTM"]];
        ODMobileObjField * field6 = [ODMobileObjField new];
        [field6 setNm:@"DUEDATE_DTTM"];
        [field6 setVl:[activity objectForKey:@"x.DUEDATE_DTTM"]];
        [fieldList add:field6];
        NSLog(@"field6 = %@",field6.vl);
        [field6 release];
        
        
        //CREATOR_EMPLOYEE_ID
//        NSString * EMPLOYEE_ID = @"4";
        NSString * EMPLOYEE_ID = [activity objectForKey:@"e.EMPLOYEE_ID"];
        ODMobileObjField * field7 = [ODMobileObjField new];
        [field7 setNm:@"CREATOR_EMPLOYEE_ID"];
        [field7 setVl:EMPLOYEE_ID];
        [fieldList add:field7];
        NSLog(@"field7 = %@",field7.vl);
        [field7 release];
        

        if ([activity objectForKey:@"d.EMPLOYEE_ID"] == nil) {
            [indicator stopAnimating];
            [largeLabel setHidden:YES];
            [self.view setUserInteractionEnabled:YES];

            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка ввода данных" message:@"Не заполнено поле 'Ответственный'" delegate:self cancelButtonTitle:@"Вернуться к заполнению" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return ;
        }
        NSString * c_EMPLOYEE_ID = [activity objectForKey:@"d.EMPLOYEE_ID"];
//        [newActivity setRESPONSIBLE_EMPLOYEE_ID:EMPLOYEE_ID];
        ODMobileObjField * field8 = [ODMobileObjField new];
        [field8 setNm:@"RESPONSIBLE_EMPLOYEE_ID"];
        [field8 setVl:c_EMPLOYEE_ID];
        [fieldList add:field8];
        NSLog(@"field8 = %@",field8.vl);
        [field8 release];

        
        
        //INSPECTOR_EMPLOYEE_ID
        if ([activity objectForKey:@"h.EMPLOYEE_ID"] == nil) {
            [indicator stopAnimating];
            [largeLabel setHidden:YES];
            [self.view setUserInteractionEnabled:YES];

            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка ввода данных" message:@"Не заполнено поле 'Контролирующий'" delegate:self cancelButtonTitle:@"Вернуться к заполнению" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return ;
        }
        NSString * d_EMPLOYEE_ID = [activity objectForKey:@"h.EMPLOYEE_ID"];
//        [newActivity setINSPECTOR_EMPLOYEE_ID:EMPLOYEE_ID];
        ODMobileObjField * field9 = [ODMobileObjField new];
        [field9 setNm:@"INSPECTOR_EMPLOYEE_ID"];
        [field9 setVl:d_EMPLOYEE_ID];
        [fieldList add:field9];
        NSLog(@"field9 = %@",field9.vl);
        [field9 release];
        
        
        //ACTIVITY_STATUS_ID
        NSString * assignedStatusID = [[ODMobileActivityStatusMBO getByStatusKey:@"AST_ASSIGNED"] ACTIVITY_STATUS_ID];
//        [newActivity setACTIVITY_STATUS_ID:assignedStatusID];
        ODMobileObjField * field10 = [ODMobileObjField new];
        [field10 setNm:@"ACTIVITY_STATUS_ID"];
        [field10 setVl:assignedStatusID];
        [fieldList add:field10];
        NSLog(@"field10 = %@",field10.vl);
        [field10 release];
        
        
        //TASK_ID
        NSString * task_ID = [taskPlan taskID];
//        [newActivity setTASK_ID:task_ID];
        ODMobileObjField * field11 = [ODMobileObjField new];
        [field11 setNm:@"TASK_ID"];
        [field11 setVl:task_ID];
        [fieldList add:field11];
        NSLog(@"field11 = %@",field11.vl);
        [field11 release];
        
        

        
        //SUBBRANCH_ID OR UNION_ID
        NSLog(@"SUBBRANCH: %@",[NSString stringWithFormat:@"%@",SUBBRANCH_ID]);
        NSLog(@"UNION: %@",[NSString stringWithFormat:@"%@",UNION_ID]);
        if ([[NSString stringWithFormat:@"%@",UNION_ID] isEqualToString:@"0"]) {
            [newActivity setSUBBRANCH_ID:[NSString stringWithFormat:@"%@",SUBBRANCH_ID]];
            ODMobileObjField * field12 = [ODMobileObjField new];
            [field12 setNm:@"SUBBRANCH_ID"];
            [field12 setVl:[NSString stringWithFormat:@"%@",SUBBRANCH_ID]];
            [fieldList add:field12];
            NSLog(@"field12 = %@",field12.vl);
            [field12 release];
        }
        else
        {
            [newActivity setUNION_ID:[NSString stringWithFormat:@"%@",UNION_ID]];
            ODMobileObjField * field12 = [ODMobileObjField new];
            [field12 setNm:@"UNION_ID"];
            [field12 setVl:[NSString stringWithFormat:@"%@",UNION_ID]];
            [fieldList add:field12];
            NSLog(@"field12 = %@",field12.vl);
            [field12 release];
        }
        
        NSLog(@"questionID = %@", questionID);
        NSLog(@"answerID = %@", answerID);
        //QUESTION_ID
        if (questionID != nil) {
            [newActivity setQUESTION_ID:@""];
            ODMobileObjField * field13 = [ODMobileObjField new];
            [field13 setNm:@"QUESTION_ID"];
            [field13 setVl:questionID];
            [fieldList add:field13];
            NSLog(@"field13 = %@",field13.vl);
            [field13 release];
        }
        
        if (answerID != nil) {
//            [newActivity setQUESTION_ID:@""];
            ODMobileObjField * field14 = [ODMobileObjField new];
            [field14 setNm:@"ANSWER_ITEM_ID"];
            [field14 setVl:answerID];
            [fieldList add:field14];
            NSLog(@"field14 = %@",field14.vl);
            [field14 release];
        }
        

        
        //ATTACHMENT_NAME
//        [newActivity setATTACHMENT_NAME:[NSString stringWithFormat:@"Приложение к мероприятию '%@'",[activity objectForKey:@"x.ACTIVITY_NAME"]]];
        ODMobileObjField * field24 = [ODMobileObjField new];
        [field24 setNm:@"ATTACHMENT_NAME"];
        [field24 setVl:[NSString stringWithFormat:@"Приложение к мероприятию '%@'",[activity objectForKey:@"x.ACTIVITY_NAME"]]];
        [fieldList add:field24];
        NSLog(@"field24 = %@",field24.vl);
        [field24 release];
        
        
        //ATTACHMENT_BODY
        if (aPhotoImage != nil) {
            aPhotoImage = [self resizeImage:aPhotoImage width:1024 height:768];
            NSLog(@"image.width = %f, image.length = %f",aPhotoImage.size.width, aPhotoImage.size.height);
            NSData * dataObject = UIImageJPEGRepresentation(aPhotoImage, 1.0);
            NSString * photo = [self Base64Encode:dataObject];
        
            ODMobileObjField * field25 = [ODMobileObjField new];
            [field25 setNm:@"ATTACHMENT_BODY"];
            [field25 setVl:photo];
            [fieldList add:field25];
//            NSLog(@"field25 = %@",field25.vl);
            [field25 release];
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
        

        //CREATED_DTTM
        ODMobileObjField * field33 = [ODMobileObjField new];
        [field33 setNm:@"CREATED_DTTM"];
        [field33 setVl:dateOfCreate];
        [fieldList add:field33];
        NSLog(@"name = %@, value =%@",field33.nm, field33.vl);
        [field33 release];
        

        ODMobileOdObject * odObject = [ODMobileOdObject new];
        [odObject setFl:fieldList];
        [newActivity create:@"SUP_FCT_ACTIVITIES" withOdObject:odObject];
        [newActivity submitPending];
        

        
        [ODMobileODMobileDB synchronize:@"TasksSG"];
        
        
        [indicator stopAnimating];
        [largeLabel setHidden:YES];
        [self.view setUserInteractionEnabled:YES];

        [taskPlan updateData];
        
        
        
        [newActivity release];
        [fieldList release];
        
        NSLog(@"At-Consulting: Application is saved");
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
    
//    [self.taskPlan dismissModalViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
//    [taskPlan updateData];
}

- (void)openActivityIndicatorViewWithName:(NSString *)name
{
    WaitingViewController * activityIndicator = [[[WaitingViewController alloc] init] autorelease];
    activityIndicator.label.text = name;
    activityIndicator.modalPresentationStyle = UIModalPresentationFormSheet;
    activityIndicator.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //    [[SberbankAuditAppDelegate instance].rootViewController presentModalViewController:activityIndicator animated:YES];
    [self presentModalViewController:activityIndicator animated:YES];
    [[activityIndicator.view superview] setFrame:CGRectMake(roundf([activityIndicator.view superview].center.x-200), roundf([activityIndicator.view superview].center.y-50), 400, 100)];
    
    //    [activityIndicator release];
}

- (void) closeActivityIndicator
{
    [[SberbankAuditAppDelegate instance].rootViewController dismissModalViewControllerAnimated:YES];
}


-(UIImage *)resizeImage:(UIImage *)anImage width:(int)width height:(int)height
{
    
    CGImageRef imageRef = [anImage CGImage];
    
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    
    if (alphaInfo == kCGImageAlphaNone)
        alphaInfo = kCGImageAlphaNoneSkipLast;
    
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), 4 * width, CGImageGetColorSpace(imageRef), alphaInfo);
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;	
}

-(NSString *)Base64Encode:(NSData *)data{
    //Point to start of the data and set buffer sizes
    int inLength = [data length];
    int outLength = ((((inLength * 4)/3)/4)*4) + (((inLength * 4)/3)%4 ? 4 : 0);
    const char *inputBuffer = [data bytes];
    char *outputBuffer = malloc(outLength);
    outputBuffer[outLength] = 0;
    
    //64 digit code
    static char Encode[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    //start the count
    int cycle = 0;
    int inpos = 0;
    int outpos = 0;
    char temp;
    
    //Pad the last to bytes, the outbuffer must always be a multiple of 4
    outputBuffer[outLength-1] = '=';
    outputBuffer[outLength-2] = '=';
    
    /* http://en.wikipedia.org/wiki/Base64
     Text content   M           a           n
     ASCII          77          97          110
     8 Bit pattern  01001101    01100001    01101110
     
     6 Bit pattern  010011  010110  000101  101110
     Index          19      22      5       46
     Base64-encoded T       W       F       u
     */
    
    
    while (inpos < inLength){
        switch (cycle) {
            case 0:
                outputBuffer[outpos++] = Encode[(inputBuffer[inpos]&0xFC)>>2];
                cycle = 1;
                break;
            case 1:
                temp = (inputBuffer[inpos++]&0x03)<<4;
                outputBuffer[outpos] = Encode[temp];
                cycle = 2;
                break;
            case 2:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xF0)>> 4];
                temp = (inputBuffer[inpos++]&0x0F)<<2;
                outputBuffer[outpos] = Encode[temp];
                cycle = 3;
                break;
            case 3:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xC0)>>6];
                cycle = 4;
                break;
            case 4:
                outputBuffer[outpos++] = Encode[inputBuffer[inpos++]&0x3f];
                cycle = 0;
                break;                          
            default:
                cycle = 0;
                break;
        }
    }
    NSString *pictemp = [NSString stringWithUTF8String:outputBuffer];
    free(outputBuffer); 
    return pictemp;
}

- (void) openCamera
{
    UIImagePickerController *photoCamera = [[UIImagePickerController alloc] init];
//    CameraViewController *photoCamera = [[CameraViewController alloc] init];
    photoCamera.delegate = self;
    photoCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
    //    [self presentModalViewController:photoCamera animated:YES];
    [self presentModalViewController:photoCamera animated:YES];
    [photoCamera release];
//    [[photoCamera.view superview] setFrame:CGRectMake(roundf([photoCamera.view superview].center.x-512), roundf([photoCamera.view superview].center.y-384), 1024, 768)];

}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    aPhotoImage = [[UIImage alloc] init];
    aPhotoImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [aPhotoButton setBackgroundImage:aPhotoImage forState:UIControlStateNormal];
    [aPhotoButton setTitle:@"" forState:UIControlStateNormal];
    [[self.view superview] setFrame:CGRectMake(roundf([self.view superview].center.x-352), roundf([self.view superview].center.y-339), 704, 678)];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    [[self.view superview] setFrame:CGRectMake(roundf([self.view superview].center.x-352), roundf([self.view superview].center.y-339), 704, 678)];
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
    [aTitleLabel release];
    [aNotesArea release];
    [aResponsibleValue release];
    [aInspectorValue release];
    [aProblemsArea release];
    [userPhoto release];
//    [taskPlan release];
    [activity release];
    [SUBBRANCH_ID release];
    [UNION_ID release];
    [aTemplateButton release];
    [aCreatorButton release];
    [aResponsibleButton release];
    [aInspectorButton release];
    [scroll release];
    [aPhotoButton release];
    [questionID release];
    [answerID release];
//    [aPhotoImage release];
    [creatorCells release];
    [subbranchCells release];
    [resultEmployees release];
    [resultInspectors release];
    [cancelAlert release];
    [indicator release];
    [label release];
    [largeLabel release];
    [dateOfCreate release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.activity = [[NSMutableDictionary alloc] init];
    hierarchyLevel = 0;
	// Do any additional setup after loading the view, typically from a nib.
}



- (void)viewDidUnload
{
    [super viewDidUnload];
//    [indicator stopAnimating];
    // Release any retained subviews of the main view.
}

//-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    if (UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
//        menuViewController.view.frame = CGRectMake(0, 0, leftMenuView.frame.size.width, 768-20);
//    }
//    else if (UIDeviceOrientationIsPortrait(toInterfaceOrientation)) {
//        menuViewController.view.frame = CGRectMake(0, 0, leftMenuView.frame.size.width, 1024-20);
//    }
//	[menuViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
//	[stackScrollViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
//}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
//	return YES;
	return NO;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
////    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
//    return UIInterfaceOrientationMaskAll;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscapeLeft;
//}

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
//        [aSender.aEndDateButton setTitle:[formatter stringFromDate:d] forState:UIControlStateNormal];
    

    long long date = [d timeIntervalSince1970];
    NSLog(@"%lld",date);
    NSString * stringDate = [NSString stringWithFormat:@"%lld000",date];

    [self.activity setObject:stringDate forKey:@"x.DUEDATE_DTTM"];
    [calendarPopover dismissPopoverAnimated:YES];
    
    [formatter release];
}

- (void)setContentSizeForPopover:(CGSize)size
{
    calendarPopover.popoverContentSize = size;
}

@end
