
#import <UIKit/UIKit.h>
#import "SupIsTemp.h"
#import <SUPApplication.h>
#import "ODMobileODMobileDB.h"
@class DetailTaskSlide;

@interface DataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate> {
	UITableView*  _tableView;
	
	NSMutableArray *tweets;
    UISearchBar *parentTaskSearchBar;
    NSMutableArray *tweetsSearch;
    NSMutableArray *userActivities;
	NSDateFormatter *formatter;
    NSMutableDictionary *activitiesDictionary;
//    SupIsTemp_Task *SBOpenDetailSlide;
    BOOL isPreviousOpen;
    BOOL isTaskSearch;
    
    long minLeftToStart;
    long minLeftToFinish;
    
//    NSString * typeOfTasks;
}

- (id)initWithFrame:(CGRect)frame;
- (void) groupTaskByDate;
- (void) searchToTable:(NSString*)sText;
- (void) updateData;
- (NSString*) findMaxTaskID;

@property (nonatomic,retain) NSMutableArray *tweets;
@property (nonatomic,retain) UITableView*  _tableView;
@property (nonatomic,retain) DetailTaskSlide *detailViewController;
//@property (nonatomic,retain) NSString * typeOfTasks;
//@property (nonatomic,retain) SupIsTemp_Task *SBOpenDetailSlide;

@end
