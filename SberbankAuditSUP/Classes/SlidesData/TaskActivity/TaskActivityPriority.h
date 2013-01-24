//
//  TaskActivityPriority.h
//  SberbankAudit
//
//  Created by Артем Куликов on 16.05.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskActivity.h"
#import "TaskSelectActivity.h"

@interface TaskActivityPriority : UITableViewController
{
    NSMutableArray *arrayWithData;
}

@property (nonatomic,retain) TaskActivity *tbClass;
@property (nonatomic,retain) TaskSelectActivity *taClass;
@property (nonatomic,retain)  NSMutableArray *arrayWithData;

@end
