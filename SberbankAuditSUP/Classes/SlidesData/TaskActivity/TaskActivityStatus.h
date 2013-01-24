//
//  TaskActivityStatusViewController.h
//  SberbankAudit
//
//  Created by pnefedov on 16.11.12.
//
//

#import <UIKit/UIKit.h>
#import "TaskSelectActivity.h"

@interface TaskActivityStatus: UITableViewController
{
//    NSMutableArray *arraySubType;
}

@property (nonatomic,retain) TaskSelectActivity *taClass;
@property (nonatomic,retain) NSMutableArray *arraySubType;

@end
