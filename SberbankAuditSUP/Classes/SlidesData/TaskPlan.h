//
//  TaskPlan.h
//  SberbankAudit
//
//  Created by Artem Koulikov on 29.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupIsTemp.h"

@interface TaskPlan : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITableView*  _tableView;
	
	NSMutableArray *tweets;
    NSMutableArray *tweetsSearch;
    NSNumber *branchId;
    NSNumber *unionID;
    
    BOOL isTaskSearch;
    
    NSMutableArray * allKeys;
    
    NSString * taskID;
    NSString * employee_ID;
    
    long minLeftToFinish;
}

- (id)initWithFrame:(CGRect)frame;
- (void) openActivityEdit;
- (void) searchToTable:(NSString*)sText;
- (void) updateData;

@property (nonatomic,retain) NSNumber *branchId;
@property (nonatomic,retain) NSNumber *unionID;
@property (nonatomic,retain) NSMutableArray * tweets;
@property (nonatomic,retain) NSMutableArray * allKeys;
@property (nonatomic,retain) NSString * taskID;
@property (nonatomic,retain) UITableView*  _tableView;
@property (nonatomic,retain) NSString * employee_ID;


@end
