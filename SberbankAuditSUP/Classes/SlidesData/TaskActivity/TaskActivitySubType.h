//
//  TaskActivitySubType.h
//  SberbankAudit
//
//  Created by Артем Куликов on 16.05.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskActivity.h"

@interface TaskActivitySubType : UITableViewController

{
    NSMutableArray *arraySubType;
//    NSString * activitySubType;
}

@property (nonatomic,retain) TaskActivity *taClass;
@property (nonatomic,retain) NSMutableArray *arraySubType;
//@property (nonatomic,retain) NSString * activitySubType;

@end
