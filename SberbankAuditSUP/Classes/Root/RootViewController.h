#import <UIKit/UIKit.h>
#import "SupIsTemp.h"
#import "MainMapView.h"
#import "SUPApplication.h"
#import "SUPConnectionProfile.h"
#import "ODMobileODMobileDB.h"

@class MenuViewController;
@class StackScrollViewController;
@class DataViewController;
@class MainMapView;
@class UIViewExt;

@interface RootViewController : UIViewController {
	UIViewExt* rootView;
	UIView* leftMenuView;
	UIView* rightSlideView;
    NSMutableArray *SBTasks;
	
	MenuViewController* menuViewController;
	StackScrollViewController* stackScrollViewController;
    DataViewController *mainDataVC;

}

@property (nonatomic, retain) MenuViewController* menuViewController;
@property (nonatomic, retain) StackScrollViewController* stackScrollViewController;
@property (nonatomic,retain) DataViewController *mainDataVC;
@property (nonatomic,retain) NSMutableArray *SBTasks;
@property (nonatomic,assign) CGRect frameRect;
@property BOOL isMap;

@end
