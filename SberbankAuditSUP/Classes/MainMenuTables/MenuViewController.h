

#import <UIKit/UIKit.h> 
#import "CreateNewTaskController.h"

@class MenuFooterTable;
@class DataViewController;
//@class CreateNewTaskController;

@interface MenuViewController : UIViewController {
    
    MenuFooterTable *footerMenu;
    DataViewController *taskVC;
    UIButton *CLSaveButton;
    UIButton *CLDoneButton;
    CreateNewTaskController * newTaskController;
}
//- (id)initWithFrame:(CGRect)frame;
- (void) showGembaSheet;
- (void) showDashboard;
- (void) showTaskWindow;
- (void) animateCLSaveButton:(id)sender;
- (void) synchronization;
- (void) propertiesAction;

@property (nonatomic, retain) DataViewController *taskVC;
@property (nonatomic,retain) UIButton *CLSaveButton;
@property (nonatomic,retain) UIButton *CLDoneButton;
//@property (nonatomic,retain) CreateNewTaskController *newTaskController;

@end
