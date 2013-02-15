//
//  DetailTaskSlide.h
//  SberbankAudit
//
//  Created by Артем Куликов on 28.02.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupIsTemp.h"
@class ControlList;
@class ODMobileMBO_getTasks;
@class ODMobileMBOVisitTypes;
@class CheckListViewController;
@class TaskPlan;
@interface DetailTaskSlide : UIViewController<UIAlertViewDelegate,UIScrollViewDelegate,UITextViewDelegate>
{
    UIView *noteTextBody;
    UIImageView *noteTextFooter;
    UITextView *noteTextEditor;
    
    UIButton * cancelButton;
    
    NSMutableDictionary *taskData;
    ControlList *controlList;
    UIAlertView * alert;
    UIAlertView * cancelTaskAlert;
    UIAlertView * errorAlert;
    UIScrollView * _scroll;
    CheckListViewController * cl;
    
    
    UILabel * taskSelfMark;
    UILabel *taskField1;
    UILabel *taskField2;
    UILabel *taskField3;
    UILabel *taskField4;
    UILabel *taskField5;
    UILabel *taskField6;
    UILabel *taskAudit;
    UILabel *taskPole1;
    UILabel *taskPole2;
    UILabel *taskPole3;
    UILabel *taskPole4;
    UILabel *taskPole5;
    UILabel *taskPole6;
    
    BOOL screen;
    int height;
    
    UIActivityIndicatorView * indicator;
    UILabel * label;
    UIImageView * largeLabel;
    
    NSString * lastEditText;
    NSString * currentEditText;
    UIButton * saveButton;
    
    UIImageView *mainNoteAnketaDesc;
    UIImageView *underNoteAnketaDesc;
}

- (id)initWithFrame:(CGRect)frame;
- (void) openTP;
- (void) openCL;
- (void) openCheckList;
- (void) cancelMethod;
- (void) updateData;
- (void) cancelTask;
- (void) cancelAlertCall;
- (void) findAllMetrics;
- (void) setSelfMetrics;
- (void) setAuditMetrics;
- (void) setQualityMetricsWithTask:(ODMobileMBO_getTasks*)task withTaskVisitType:(ODMobileMBOVisitTypes*)taskVisitType;

- (void)saveNotes;
- (void)upShift:(id)sender;
- (void)downShift:(id)sender;


@property (nonatomic,retain) NSMutableDictionary *taskData;
@property (nonatomic,retain) UIButton * cancelButton;
//@property (nonatomic,retain) ControlList *controlList;
@property (nonatomic,retain) NSString * lastStatus;
@property (nonatomic,retain) NSString * currentTaskID;
@property (nonatomic,retain) TaskPlan *detailViewController;

@end
