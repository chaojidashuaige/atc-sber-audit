
#import <UIKit/UIKit.h>

@interface TaskPlanCell : UITableViewCell
{
    UILabel *taskTitle;
	UILabel *taskDescription;
    UILabel *taskDate;
    UILabel *taskResponsible;
    UILabel *taskStatus;
    UIImageView *taskIndicator;
    UIButton *createTp;
}

+ (int)heightForTweetWithText:(NSString*)tweetText;

- (id)initWithStyle:(UITableViewCellStyle)style isHeader:(BOOL)isHeader reuseIdentifier:(NSString *)reuseIdentifier;

//- (void)setFrameWithHeader: (BOOL)isHeader;

@property(nonatomic,retain) UILabel *taskTitle;
@property(nonatomic,retain) UILabel *taskDescription;
@property(nonatomic,retain) UILabel *taskDate;
@property(nonatomic,retain) UILabel *taskResponsible;
@property(nonatomic,retain) UIImageView *taskIndicator;
@property(nonatomic,retain) UILabel *taskStatus;
@property(nonatomic,retain) UIButton *createTp;

@end
