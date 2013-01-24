//
//  TaskActivity.h
//  SberbankAudit
//
//  Created by Артем Куликов on 24.04.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ODMobileMBOEmployeesSubordinations.h"
#import "Cell.h"

@interface TaskActivity : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
{
    UILabel *aTitleLabel;
    UIButton *aTypeButton;
    UIButton *aPriorityButton;
    UITextView *aNotesArea;
    UIButton *aEndDateButton;
    UILabel *aResponsibleValue;
    UILabel *aInspectorValue;
    UITextView *aProblemsArea;
    UIImageView *userPhoto;
    id taskPlan;
    NSNumber * SUBBRANCH_ID;
    NSNumber * UNION_ID;
    UIButton * aTemplateButton;
    UIButton * aCreatorButton;
    UIButton * aResponsibleButton;
    UIButton * aInspectorButton;
    UIButton * aPhotoButton;
    NSString * dateOfCreate;
    
    UIAlertView * cancelAlert;
    
//    NSString * answerID;
//    NSString * questionID;

    NSMutableDictionary * activity;
    
    UIScrollView * scroll;
    bool screen;
    
    UIImage * aPhotoImage;
    NSMutableArray * creatorCells;
    NSMutableArray * subbranchCells;
    BOOL creatorCellFoundInBranch;
    int hierarchyLevel;
    NSMutableArray * resultEmployees;
    NSMutableArray * resultInspectors;
    
    UIActivityIndicatorView * indicator;
    UILabel * label;
    UIImageView * largeLabel;

    UILabel * newLabel;
    UIActivityIndicatorView * newIndicator;
}
- (id)initWithFrame:(CGRect)frame;
- (void) openCamera;
- (void) aSaveAction;
- (void) aCancelAction;
- (void) showCalendar;
- (void) showActivitySubType;
- (void) showActivityPriority;
- (void) showActivityTemplate;
- (void) showActivityCreator;
- (void) showActivityResponsible;
- (void) createListOfResponsibles;
- (void) showActivityInspector;
-(NSString *)Base64Encode:(NSData *)data;
-(UIImage *)resizeImage:(UIImage *)anImage width:(int)width height:(int)height;

- (NSMutableArray*)findCreatorEmployeeCellsWithHierarchyLevel:(int)hierarchyLevel withArray:(SUPObjectList*)employeeCells;
- (void) getResponsibles;
- (void) fillParentsWithCell:(Cell*)cell withHierarchyLevel:(int)level withArray:(NSMutableArray*)array;
- (void) getInspectors;
- (void) dismissTaskWindow;
- (void)openActivityIndicatorViewWithName:(NSString *)name;
- (void) closeActivityIndicator;







@property (nonatomic,retain) UIPopoverController *calendarPopover;
@property (nonatomic,retain) UIButton *aTypeButton;
@property (nonatomic,retain) UIButton *aPriorityButton;
@property (nonatomic,retain) UIButton *aEndDateButton;
@property (assign) id taskPlan;
@property (nonatomic,retain) NSMutableDictionary * activity;
@property (nonatomic,retain) NSNumber * SUBBRANCH_ID;
@property (nonatomic,retain) NSNumber * UNION_ID;
@property (nonatomic,retain) UIButton * aTemplateButton;
@property (nonatomic,retain) UITextView *aNotesArea;
@property (nonatomic,retain) UIButton * aCreatorButton;
@property (nonatomic,retain) UIScrollView * scroll;
@property (nonatomic,retain) UIButton * aResponsibleButton;
@property (nonatomic,retain) UIButton * aInspectorButton;
@property (nonatomic,retain) UIButton * aPhotoButton;
@property (nonatomic,retain) NSString * answerID;
@property (nonatomic,retain) NSString * questionID;
//@property (nonatomic,retain) NSString * selectedActivityType;

@end
