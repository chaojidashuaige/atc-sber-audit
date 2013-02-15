
#import "TaskTableViewCell.h"

#define rowHeight 105.0f

@implementation TaskTableViewCell
@synthesize taskTime,taskTitle,taskAuthor,taskStatus,taskDescription,taskInspector,taskIndicator;

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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		UIView *cellBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 464, rowHeight)];
        UIView *cellBackViewActive = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 464, rowHeight)];
        
        UIImageView *cellBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"task_cell_back.png"]];
        [cellBackImage setFrame:CGRectMake(0, 0, 464, rowHeight)];
        [cellBackView addSubview:cellBackImage];
        [self setBackgroundView:cellBackView];
        
        UIImageView *cellBackImageActive = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"task_cell_back_active.png"]];
        [cellBackImageActive setFrame:CGRectMake(0, 0, 464, rowHeight)];
        [cellBackViewActive addSubview:cellBackImageActive];
        [self setSelectedBackgroundView:cellBackViewActive];
        
        [cellBackImage release];
        [cellBackImageActive release];
        [cellBackView release];
        [cellBackViewActive release];
        
        taskIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(8, 4, 25, 25)];
        [self addSubview:taskIndicator];
        
//        taskTitle = [[UILabel alloc] initWithFrame:CGRectMake(taskIndicator.frame.origin.x+taskIndicator.frame.size.width+5, 8, 400, 20)];
        taskTitle = [[UILabel alloc] initWithFrame:CGRectMake(taskIndicator.frame.origin.x+taskIndicator.frame.size.width+5, 8, 390 - (taskIndicator.frame.origin.x+taskIndicator.frame.size.width+5), 20)];
        [taskTitle setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [taskTitle setBackgroundColor:[UIColor clearColor]];
        [taskTitle setHighlightedTextColor:[UIColor whiteColor]];
        [self addSubview:taskTitle];
        
//        taskTime = [[UILabel alloc] initWithFrame:CGRectMake(374, 8, 90, 15)];
        taskTime = [[UILabel alloc] initWithFrame:CGRectMake(394, 8, 90, 15)];
        [taskTime setFont:[UIFont systemFontOfSize:14.0f]];
        [taskTime setBackgroundColor:[UIColor clearColor]];
        [taskTime setHighlightedTextColor:[UIColor whiteColor]];
        [self addSubview:taskTime];
        
//        taskDescription = [[UILabel alloc] initWithFrame:CGRectMake(taskTitle.frame.origin.x, 25, 410, 25)];
        taskDescription = [[UILabel alloc] initWithFrame:CGRectMake(taskTitle.frame.origin.x, 27, 410, 25)];
//        [taskDescription setFont:[UIFont systemFontOfSize:12.0f]];
        [taskDescription setFont:[UIFont systemFontOfSize:14.0f]];
        [taskDescription setBackgroundColor:[UIColor clearColor]];
        [taskDescription setHighlightedTextColor:[UIColor whiteColor]];
        [self addSubview:taskDescription];
        
        UILabel *taskAuthorTitle = [[UILabel alloc] initWithFrame:CGRectMake(taskTitle.frame.origin.x, 60, 50, 15)];
        [taskAuthorTitle setFont:[UIFont systemFontOfSize:12.0f]];
        [taskAuthorTitle setBackgroundColor:[UIColor clearColor]];
        [taskAuthorTitle setHighlightedTextColor:[UIColor whiteColor]];
        [taskAuthorTitle setText:@"Автор:"];
        
        taskAuthor = [[UILabel alloc] initWithFrame:CGRectMake(taskAuthorTitle.frame.origin.x+40, taskAuthorTitle.frame.origin.y, 200, 15)];
        [taskAuthor setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [taskAuthor setBackgroundColor:[UIColor clearColor]];
        [taskAuthor setHighlightedTextColor:[UIColor whiteColor]];
//        [self addSubview:taskAuthorTitle];
//        [self addSubview:taskAuthor];
        
        [taskAuthorTitle release];
        
//        UILabel *taskStatusTitle = [[UILabel alloc] initWithFrame:CGRectMake(taskTitle.frame.origin.x, 60, 70, 15)];
        UILabel *taskStatusTitle = [[UILabel alloc] initWithFrame:CGRectMake(taskTitle.frame.origin.x, 56, 70, 17)];
        [taskStatusTitle setFont:[UIFont systemFontOfSize:12.0f]];
        [taskStatusTitle setBackgroundColor:[UIColor clearColor]];
        [taskStatusTitle setHighlightedTextColor:[UIColor whiteColor]];
        [taskStatusTitle setText:@"Статус:"];
        
        taskStatus = [[UILabel alloc] initWithFrame:CGRectMake(taskStatusTitle.frame.origin.x+45, taskStatusTitle.frame.origin.y, 200, 15)];
//        [taskStatus setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [taskStatus setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [taskStatus setBackgroundColor:[UIColor clearColor]];
        [taskStatus setHighlightedTextColor:[UIColor whiteColor]];
        [self addSubview:taskStatusTitle];
        [self addSubview:taskStatus];
        
        [taskStatusTitle release];
        
        UILabel *taskInspectorTitle = [[UILabel alloc] initWithFrame:CGRectMake(taskTitle.frame.origin.x, 75, 80, 15)];
        [taskInspectorTitle setFont:[UIFont systemFontOfSize:12.0f]];
        [taskInspectorTitle setBackgroundColor:[UIColor clearColor]];
        [taskInspectorTitle setHighlightedTextColor:[UIColor whiteColor]];
        [taskInspectorTitle setText:@"От:"];
        
        taskInspector = [[UILabel alloc] initWithFrame:CGRectMake(taskInspectorTitle.frame.origin.x+20, taskInspectorTitle.frame.origin.y, 220, 15)];
//        [taskInspector setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [taskInspector setFont:[UIFont systemFontOfSize:12.0f]];
        [taskInspector setBackgroundColor:[UIColor clearColor]];
        [taskInspector setHighlightedTextColor:[UIColor whiteColor]];
        [self addSubview:taskInspectorTitle];
        [self addSubview:taskInspector];
        
        
        [taskInspectorTitle release];
	}
	
	return self;
}

- (void)dealloc
{
	self.taskDescription = nil;
    self.taskAuthor = nil;
    self.taskStatus = nil;
    self.taskInspector = nil;
    self.taskTime = nil;
    self.taskTitle = nil;
    self.taskIndicator = nil;
	
	[super dealloc];
}
@end
