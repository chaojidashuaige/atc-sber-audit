//
//  TaskTypeViewController.h
//  SberbankAudit
//
//  Created by pnefedov on 23.11.12.
//
//

#import <UIKit/UIKit.h>

@interface TaskTypeViewController : UITableViewController
{
//    NSMutableArray * taskArray;
    id parent;
    UIActivityIndicatorView * indicator;
    UILabel * label;
    UIImageView * largeLabel;
}

- (id)initWithFrame:(CGRect)frame;

@property (nonatomic,retain) NSMutableArray * taskArray;
@property (assign) id parent;

@end
