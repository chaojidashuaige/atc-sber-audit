//
//  DashboardVC.h
//  SberbankAudit
//
//  Created by Артем Куликов on 11.04.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//
@class MainMapView;

#import <UIKit/UIKit.h>
#import "SupIsTemp.h"
#import <SUPApplication.h>
#import "ODMobileODMobileDB.h"

//@interface DashboardVC : UIViewController <SupIsTempBindingResponseDelegate>
@interface DashboardVC : UIViewController 
{
    NSMutableArray *allTasks;
    NSMutableArray *todayTasks;
    NSMutableArray *inPlanTasks;
    NSMutableArray *closedAndExpiredTasks;
    NSMutableArray *tasksForLastTaskDate;
    
    
//    SUPObjectList *allTasks;
//    SUPQueryResultSet *todayTasks;
//    SUPQueryResultSet *inPlanTasks;
//    SUPQueryResultSet *closedAndExpiredTasks;
//    SUPQueryResultSet *tasksForLastTaskDate;
    
    SupIsTemp_Task *lastTask;
    MainMapView *mapView;
    
    UIImageView *dashboardBackground;
    UIButton *mainMapButton;
    
    NSInteger previousCount;
    NSInteger todayCount;
    NSInteger futureCount;
    NSString * planStartDttm;
    NSString * subbranchName;
    NSString * subbranchAddress;
}

- (void) filterTasks;
- (void) drawLastTask;
- (NSString *)GetOurIpAddress;


@end
