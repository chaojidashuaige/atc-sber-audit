
#import <UIKit/UIKit.h>
#import "SupIsTemp.h"
#import <MapKit/MapKit.h>
#import <SUPApplication.h>
#import "ODMobileODMobileDB.h"


@class RootViewController;
@class AuthVC;

@class MenuViewController;
@class StackScrollViewController;
@class DataViewController;
@class MapViewController;
@class MapMenuController;
@class SUPApplication;
@class ControlList;
@class WaitingViewController;

@interface SberbankAuditAppDelegate : NSObject <UIApplicationDelegate,SUPApplicationCallback> {
//    UIWindow *window;
	RootViewController *rootViewController;
    AuthVC *authWindow;
    MenuViewController* menuViewController;
    
    SUPApplication *mainSupApp;
    NSString * EMPLOYEE_ID;
    NSString * typeOfTasks;
}

+ (SberbankAuditAppDelegate *) instance;
+ (BOOL) hasConnectivity;
- (BOOL) internetConnectionCheck;
- (void) openMainVC;
- (void) openTasksVC:(NSMutableArray*)tasksArray openTask:(SupIsTemp_Task*)openTask;
- (void) openMapVC;
- (void) regApp;

- (void) registerApplication;
- (void) createDB;
- (BOOL) dataForDashboardWithObjectName:(NSString*)objectName;
- (BOOL) setPropertiesWithLogin:(NSString*)login andPassword:(NSString*)password;
- (BOOL) userLogonWithLogin:(NSString*)login andPassword:(NSString*)password;
- (void) validateAppProperties;
- (BOOL)isValidMobileVersion;
- (NSString *)GetOurIpAddress;
- (void) openActivityIndicatorViewWithName:(NSString*)name;
- (void) closeActivityIndicator;
- (NSString *)encodingWithString: (NSString *)string;




@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) RootViewController *rootViewController;
@property (nonatomic, retain) MapViewController *mapViewController;
@property (nonatomic,retain) SUPApplication *mainSupApp;
@property (readonly, nonatomic) NSString * EMPLOYEE_ID;
@property (nonatomic,retain) NSString * typeOfTasks;
@property (nonatomic,retain) NSString * odmobile_ios_app_version;
@property (nonatomic,retain) NSString * odmobile_version_unchecked;
@property (nonatomic,retain) NSString * serverName;
@property (nonatomic,retain) NSString * idName;
@property (nonatomic,retain) NSString * userLogin;
@property (nonatomic,retain) NSString * newUserLogin;
@property (nonatomic,retain) NSString * IPAdress;
@property (nonatomic,retain) NSString * connectionID;
@property (nonatomic,retain) NSString * currentTaskID;
@property (nonatomic,retain) ControlList * currentControlList;
@property (nonatomic,retain) UIWebView *controlListHTML;
@property BOOL finishTask;


@end

