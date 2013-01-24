//
//  TaskActivityCreator.h
//  SberbankAudit
//
//  Created by Павел on 01.11.12.
//
//

#import <UIKit/UIKit.h>
#import "TaskActivity.h"

@interface TaskActivityCreator : UITableViewController
{
    NSMutableArray *arraySubType;
}

@property (nonatomic,retain) TaskActivity *taClass;
@property (nonatomic,retain) NSMutableArray *arraySubType;
@end
