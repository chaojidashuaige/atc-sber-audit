//
//  TastActivityResponsible.h
//  SberbankAudit
//
//  Created by Павел on 02.11.12.
//
//

#import <UIKit/UIKit.h>
#import "TaskActivity.h"
#import "TaskSelectActivity.h"

@interface TastActivityResponsible : UITableViewController
{
    NSMutableArray *arraySubType;
}

@property (nonatomic,retain) TaskActivity *taClass;
@property (nonatomic,retain) TaskSelectActivity *tbClass;
@property (nonatomic,retain) NSMutableArray *arraySubType;

@end
