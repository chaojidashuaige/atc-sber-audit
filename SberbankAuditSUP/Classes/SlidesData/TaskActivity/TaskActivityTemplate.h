//
//  TaskActivityTemplate.h
//  SberbankAudit
//
//  Created by Павел on 01.11.12.
//
//

#import <UIKit/UIKit.h>
#import "TaskActivity.h"
#import "TaskSelectActivity.h"

@interface TaskActivityTemplate : UITableViewController
{
    NSMutableArray *arraySubType;
    //    NSString * activitySubType;
}

@property (nonatomic,retain) TaskActivity *taClass;
@property (nonatomic,retain) TaskSelectActivity *tbClass;
@property (nonatomic,retain) NSMutableArray *arraySubType;
//@property (nonatomic,retain) NSString * activitySubType;

@end
