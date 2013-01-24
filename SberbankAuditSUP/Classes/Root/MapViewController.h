#import <UIKit/UIKit.h>
#import "SupIsTemp.h"
#import "MainMapView.h"
#import "MapMenuController.h"

@class MapMenuController;
@class StackScrollViewController;
@class DataViewController;
@class MainMapView;
@class UIViewExt;

@interface MapViewController : UIViewController {

UIViewExt* mapView;
UIView* leftMenuView;
UIView* rightSlideView;
NSMutableArray *SBTasksMenu;
SupIsTemp_Task *SBOpenTaskMenu;
MapMenuController *mapMenuController;
StackScrollViewController *stackMenuScrollViewController;
DataViewController *mainDataMenu;
}

@property (nonatomic, retain) MapMenuController *mapMenuController;
@property (nonatomic, retain) StackScrollViewController *stackMenuScrollViewController;
@property (nonatomic,retain) DataViewController *mainDataMenu;
@property (nonatomic,retain) NSMutableArray *SBTasksMenu;
@property (nonatomic,retain) SupIsTemp_Task *SBOpenTaskMenu;
@property (nonatomic,assign) CGRect frameMenuRect;

@end

