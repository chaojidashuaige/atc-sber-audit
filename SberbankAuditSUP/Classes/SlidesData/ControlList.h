//
//  ControlList.h
//  SberbankAudit
//
//  Created by Artem Koulikov on 29.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupIsTemp.h"
#import "StackScrollViewController.h"

@class TaskActivity;
@interface ControlList : UIViewController <UIWebViewDelegate, UIScrollViewDelegate,StackScrollViewDelegate, UIAlertViewDelegate>
{
    UIWebView *controlListHTML;
    NSMutableDictionary *taskInfo;
    NSMutableString * checkListTemplate;
    
    NSTimer * timer;
    NSString * varForLoadCL;
    bool timerCount;
    
    NSString * taskID;
    UIAlertView * errorAlert;
    NSString * currentTaskID;
    NSString * currentActivityID;
    UIAlertView * finishTaskAlert;
    TaskActivity *tmpTaskActivity;
}
- (id)initWithFrame:(CGRect)frame;
//- (void) readAnswers;
- (void) saveCL;
- (void) doneCL;
- (void) lookCL;
- (void) loadCL;
- (void) loadWebView;
- (void) webViewText;
- (void)timerStart;
- (void)checkScriptFunc;
- (void)getCheckList;
- (void)createNewActivity;
- (void)openActivity;
- (void)updateData;
- (void)getInitialData;

- (id)initWithFrame:(CGRect)frame andTaskInfo:(NSDictionary*)info;

@property (nonatomic,assign) CGRect frameRect;
@property (nonatomic,retain) NSMutableString * checkListTemplate;
@property (nonatomic,retain) NSTimer * timer;
@property (nonatomic,assign) NSString * varForLoadCL;
@property (nonatomic,retain) NSString * taskID;



@end
