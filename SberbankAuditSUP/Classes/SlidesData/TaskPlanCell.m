
#import "TaskPlanCell.h"

@implementation TaskPlanCell

@synthesize taskDate,taskTitle,taskIndicator,taskDescription,taskResponsible,taskStatus,createTp;

+ (int)heightForTweetWithText:(NSString*)tweetText
{
	CGFloat height = 0;
	height += 12; // top padding.
	height += 18; // author label.
	height += 5;  // padding between author and tweet.
	
	CGSize tweetTextSize = [tweetText sizeWithFont:[UIFont boldSystemFontOfSize:[UIFont labelFontSize]] constrainedToSize:CGSizeMake(390, 10000) lineBreakMode:UILineBreakModeWordWrap];
	
	height += tweetTextSize.height;
	height += 12; // bottom padding.
	
	return (int)height;
}

- (id)initWithStyle:(UITableViewCellStyle)style isHeader:(BOOL)isHeader reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
        if(isHeader)
        {
            UIImageView *cellBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tp_header.png"]];
            [cellBackImage setFrame:CGRectMake(0, 0, 464, 45)];
            [self setBackgroundView:cellBackImage];
            [self setSelected:NO];
            [cellBackImage release];
            
            createTp = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
            [createTp setBackgroundImage:[UIImage imageNamed:@"create_tp.png"] forState:UIControlStateNormal];
            [createTp setFrame:CGRectMake(424, 8, 28, 29)];
            [self.contentView addSubview:createTp];
            
            UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 6, 400, 30)];
            [headerTitle setFont:[UIFont boldSystemFontOfSize:20]];
            [headerTitle setBackgroundColor:[UIColor clearColor]];
            [headerTitle setText:@"План мероприятий"];
            [self.contentView addSubview:headerTitle];
            [headerTitle release];
        }
        else
        {
            UIView *cellBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 464, 124)];
            UIView *cellBackViewActive = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 464, 124)];
            
            UIImageView *cellBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tp_cell_still.png"]];
            [cellBackView addSubview:cellBackImage];
            [self setBackgroundView:cellBackView];
            
            UIImageView *cellBackImageActive = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tp_cell_active.png"]];
            [cellBackViewActive addSubview:cellBackImageActive];
            [self setSelectedBackgroundView:cellBackViewActive];
            
            [cellBackImage release];
            [cellBackImageActive release];
            [cellBackView release];
            [cellBackViewActive release];
            
            taskTitle = [[UILabel alloc] initWithFrame:CGRectMake(42, 53, 410, 60)];
            [taskTitle setFont:[UIFont systemFontOfSize:14]];
            [taskTitle setLineBreakMode:UILineBreakModeWordWrap];
            [taskTitle setNumberOfLines:2];
            [taskTitle setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:taskTitle];
            
            taskDescription = [[UILabel alloc] initWithFrame:CGRectMake(42, 8, 400, 30)];
            [taskDescription setFont:[UIFont boldSystemFontOfSize:16]];
            [taskDescription setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:taskDescription];
            
            taskIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
            [self.contentView addSubview:taskIndicator];
            
            
            taskStatus = [[UILabel alloc] initWithFrame:CGRectMake(42, 45, 150, 30)];
            [taskStatus setFont:[UIFont systemFontOfSize:12]];
            [taskStatus setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:taskStatus];
            
            taskDate = [[UILabel alloc] initWithFrame:CGRectMake(140, 45, 310, 30)];
            [taskDate setFont:[UIFont systemFontOfSize:12]];
            [taskDate setTextAlignment:UITextAlignmentRight];
            [taskDate setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:taskDate];
            
            taskResponsible = [[UILabel alloc] initWithFrame:CGRectMake(42, 90, 400, 30)];
            [taskResponsible setFont:[UIFont systemFontOfSize:12]];
            [taskResponsible setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:taskResponsible];
        }

	
    
//        if(isHeader)
//        {
//            createTp = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
//        }
//        else
//        {
//            taskTitle = [[UILabel alloc] init];
//            
//            taskIndicator = [[UIImageView alloc] init];
//
//            taskDescription = [[UILabel alloc] init];
//
//            taskStatus = [[UILabel alloc] init];
//
//            taskDate = [[UILabel alloc] init];
//            
//            taskResponsible = [[UILabel alloc] init];
//        }
    }
	
	return self;
}

//- (void)setFrameWithHeader:(BOOL)isHeader
//{
//    for (UIView * v in [self.contentView subviews]) {
//        [v removeFromSuperview];
//    }
//    if(isHeader)
//    {
//        UIImageView *cellBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tp_header.png"]];
//        [cellBackImage setFrame:CGRectMake(0, 0, 464, 45)];
//        [self setBackgroundView:cellBackImage];
//        [self setSelected:NO];
//        [cellBackImage release];
//        
//        [createTp setBackgroundImage:[UIImage imageNamed:@"create_tp.png"] forState:UIControlStateNormal];
//        [createTp setFrame:CGRectMake(424, 8, 28, 29)];
//        [self.contentView addSubview:createTp];
//        
//        UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, 6, 400, 30)];
//        [headerTitle setFont:[UIFont boldSystemFontOfSize:20]];
//        [headerTitle setBackgroundColor:[UIColor clearColor]];
//        [headerTitle setText:@"План мероприятий"];
//        [self.contentView addSubview:headerTitle];
//        [headerTitle release];
//    }
//    else
//    {
//        UIView *cellBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 464, 124)];
//        UIView *cellBackViewActive = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 464, 124)];
//        
//        UIImageView *cellBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tp_cell_still.png"]];
//        [cellBackView addSubview:cellBackImage];
//        [self setBackgroundView:cellBackView];
//        
//        UIImageView *cellBackImageActive = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tp_cell_active.png"]];
//        [cellBackViewActive addSubview:cellBackImageActive];
//        [self setSelectedBackgroundView:cellBackViewActive];
//        
//        [cellBackImage release];
//        [cellBackImageActive release];
//        [cellBackView release];
//        [cellBackViewActive release];
//
//        
//        taskTitle.frame = CGRectMake(42, 8, 400, 30);
//        [taskTitle setFont:[UIFont boldSystemFontOfSize:16]];
//        [taskTitle setBackgroundColor:[UIColor clearColor]];
//        [self.contentView addSubview:taskTitle];
//        
//        taskIndicator.frame = CGRectMake(10, 10, 25, 25);
//        [self.contentView addSubview:taskIndicator];
//        
//        taskDescription.frame = CGRectMake(42, 45, 410, 60);
//        [taskDescription setFont:[UIFont systemFontOfSize:14]];
//        [taskDescription setLineBreakMode:UILineBreakModeWordWrap];
//        [taskDescription setNumberOfLines:2];
//        [taskDescription setBackgroundColor:[UIColor clearColor]];
//        [self.contentView addSubview:taskDescription];
//        
//        taskStatus.frame = CGRectMake(42, 30, 150, 30);
//        [taskStatus setFont:[UIFont systemFontOfSize:12]];
//        [taskStatus setBackgroundColor:[UIColor clearColor]];
//        [self.contentView addSubview:taskStatus];
//        
//        taskDate.frame = CGRectMake(140, 30, 310, 30);
//        [taskDate setFont:[UIFont systemFontOfSize:12]];
//        [taskDate setTextAlignment:UITextAlignmentRight];
//        [taskDate setBackgroundColor:[UIColor clearColor]];
//        [self.contentView addSubview:taskDate];
//        
//        taskResponsible.frame = CGRectMake(42, 90, 400, 30);
//        [taskResponsible setFont:[UIFont systemFontOfSize:12]];
//        [taskResponsible setBackgroundColor:[UIColor clearColor]];
//        [self.contentView addSubview:taskResponsible];
//    }
//
//}

- (void)dealloc
{
    
    self.taskDate = nil;
    self.taskDescription = nil;
    self.taskIndicator = nil;
    self.taskResponsible = nil;
    self.taskTitle = nil;
    self.taskStatus = nil;
    self.createTp = nil;
    
    [super dealloc];
}
@end
