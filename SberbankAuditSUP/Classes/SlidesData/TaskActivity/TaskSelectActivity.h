//
//  TaskSelectActivity.h
//  SberbankAudit
//
//  Created by Артем Куликов on 16.05.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskPlan.h"
#import "Cell.h"
@class SUPObjectList;

@interface TaskSelectActivity : UIViewController

<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIScrollViewDelegate>
{
    UILabel *aTitleLabel;
    UIButton *aTypeButton;
    UIButton *aPriorityButton;
    UITextView *aNotesArea;
    UIButton *aEndDateButton;
    UILabel *aResponsibleValue;
    UILabel *aInspectorValue;
    UITextView *aInspectorsArea;
    UIImageView *userPhoto;
    UITextView *aNotesText;
    UILabel *aEndDateText;
    UILabel *aResponsibleText;
    UILabel *aStatusText;
    UILabel *aEndDateLabel;
    UILabel *aStatusLabel;
    UILabel *aPriorityLabel;
    UILabel *aPriorityValue;
    UILabel *aProblemsLabel;
    UITextView *aProblemsValue;
    UILabel *aInitiatorLabel;
    UILabel *aInitiatorValue;
    UILabel *aResponsibleLabel;
    UILabel *aPerformLabel;
    UILabel *aInspectorLabel;
    UILabel *aControlLabel;
    
    UILabel *aDateOfResponseLabel;
    UILabel *aDateOfResponseValue;
    UILabel *aDateOfInspectLabel;
    UILabel *aDateOfInspectValue;
    
    NSMutableDictionary * arraySelectActivity;
    
    UIScrollView * scroll;
    
    id taskPlan;
    
    bool isCreator;
    bool isResponser;
    bool isInspertor;
    
//    NSString * lastStatus;
//    NSString * currentStatus;
    
    UIButton * aNotesButton;
    UIButton * aStatusButton;
    UIButton * aResponsibleButton;
    UIButton * aInspectorButton;
    
    UIButton *aSaveButton;
    UIButton *aCancelButton;
    
    UIActivityIndicatorView * indicator;
    UILabel * label;
    UIImageView * largeLabel;
    
    UILabel * createDateLabel;
    UILabel * createDateValue;
    
    BOOL requiredResp;
    BOOL requiredInsp;
    
    NSMutableArray * creatorCells;
    NSMutableArray * subbranchCells;
    BOOL creatorCellFoundInBranch;
    int hierarchyLevel;
    NSMutableArray * resultEmployees;
    NSMutableArray * resultInspectors;
    
}

- (id)initWithFrame:(CGRect)frame;
- (void) openCamera;
- (void) aSaveAction;
- (void) aCancelAction;
- (void) identification;
- (void) mainLogic;
- (void) showActivityTemplates;
- (void) showCalendar;
- (void) showStatus;
- (void) showActivityPriority;
- (void) showActivityResponser;
- (void) showActivityInspector;
//- (void)openActivityIndicatorViewWithName:(NSString *)name;
- (void) closeActivityIndicator;

- (void) createListOfResponsibles;
- (NSMutableArray*)findCreatorEmployeeCellsWithHierarchyLevel:(int)hierarchy withArray:(SUPObjectList *)employeeCells;
- (void) getResponsibles;
- (void) fillParentsWithCell:(Cell *)cell withHierarchyLevel:(int)level withArray:(NSMutableArray *)array;
- (void) getInspectors;


- (CGFloat) heightForCellWithText:(NSString*)myCell maxHeight:(float)max;




@property (nonatomic,retain) UIPopoverController *calendarPopover;
@property (nonatomic,retain) UIButton *aTypeButton;
@property (nonatomic,retain) UIButton *aPriorityButton;
@property (nonatomic,retain) UIButton *aEndDateButton;
@property (nonatomic,retain) NSMutableDictionary *arraySelectActivity;
@property (nonatomic,retain) UIScrollView * scroll;
@property (nonatomic,retain) UIButton * aStatusButton;
@property (nonatomic,retain) NSMutableArray * arrayWithStatuses;
@property (nonatomic,retain) NSString * lastStatus;
@property (nonatomic,retain) NSString * currentStatus;
@property (nonatomic,retain) UITextView *aNotesText;
@property (nonatomic,retain) UIButton * aResponsibleButton;
@property (nonatomic,retain) UIButton * aInspectorButton;
@property (nonatomic,retain) NSString * RESPONSER_ID;
@property (nonatomic,retain) NSString * INSPECTOR_ID;
@property (assign) id taskPlan;



@end
