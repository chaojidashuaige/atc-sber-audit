
#import <UIKit/UIKit.h>

@interface TaskTableViewCell : UITableViewCell
{
	UILabel *taskTitle;
	UILabel *taskTime;
	UILabel *taskDescription;
    UILabel *taskAuthor;
    UILabel *taskInspector;
    UILabel *taskStatus;
    UIImageView *taskIndicator;
}
@property(nonatomic,retain) UILabel *taskTitle;
@property(nonatomic,retain) UILabel *taskTime;
@property(nonatomic,retain) UILabel *taskDescription;
@property(nonatomic,retain) UILabel *taskAuthor;
@property(nonatomic,retain) UILabel *taskInspector;
@property(nonatomic,retain) UILabel *taskStatus;
@property(nonatomic,retain) UIImageView *taskIndicator;

+ (int)heightForTweetWithText:(NSString*)tweetText;

@end
