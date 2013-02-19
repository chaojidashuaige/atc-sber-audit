//
//  TaskPlanButtonCell.m
//  SberbankAudit
//
//  Created by Павел on 01.11.12.
//
//

#import "TaskPlanButtonCell.h"

@implementation TaskPlanButtonCell
@synthesize createTp;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *cellBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tp_header.png"]];
        [cellBackImage setFrame:CGRectMake(0, 0, 464, 45)];
        [self setBackgroundView:cellBackImage];
        [self setSelected:NO];
        [cellBackImage release];
        
        self.createTp = [UIButton buttonWithType:UIButtonTypeCustom];
//        [createTp setBackgroundImage:[UIImage imageNamed:@"create_tp.png"] forState:UIControlStateNormal];
//        [createTp setFrame:CGRectMake(424, 8, 28, 29)];
        [self.createTp setBackgroundImage:[UIImage imageNamed:@"create_activity_up.png"] forState:UIControlStateNormal];
        [self.createTp setFrame:CGRectMake(290, 8, 160, 49)];
        [self.contentView addSubview:createTp];
        
//        UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 6, 400, 30)];
        UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 16, 240, 30)];
        [headerTitle setFont:[UIFont boldSystemFontOfSize:20]];
        [headerTitle setBackgroundColor:[UIColor clearColor]];
        [headerTitle setText:@"План мероприятий"];
        [self.contentView addSubview:headerTitle];
        [headerTitle release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    self.createTp = nil;
    [super dealloc];
}

@end
