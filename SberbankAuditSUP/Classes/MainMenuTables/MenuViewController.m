

#import "MenuViewController.h"
#import "DataViewController.h"
#import "SberbankAuditAppDelegate.h"
#import "RootViewController.h"
#import "StackScrollViewController.h"
#import "MenuTableViewCell.h"
#import "MenuHeaderView.h"
#import "MenuFooterTable.h"
#import "GembaSheet.h"
#import "ControlList.h"
#import "CreateNewTaskController.h"
#import "DataViewController.h"
#import "DetailTaskSlide.h"
#import "WaitingViewController.h"
#import "ODMobileODMobileDB.h"
#import "ODMobileMBOTaskTypesPriv.h"
#import "PropertiesViewController.h"

@implementation MenuViewController

@synthesize taskVC;
@synthesize CLDoneButton;
@synthesize CLSaveButton;
//@synthesize newTaskController;

#pragma mark -
#pragma mark View lifecycle

- (id)init{
    if (self = [super init]) {
        
        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_menu_back.png"]];
        [self.view addSubview:backgroundImage];
        [backgroundImage release];
//        self.view.backgroundColor = [UIColor whiteColor];
        
        MenuHeaderView *menuHeader = [[MenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, 200, 135)];
        [self.view addSubview:menuHeader];
        [menuHeader release];
        
        SUPObjectList * taskTypePrivs = [ODMobileMBOTaskTypesPriv findAll];
        
        if (taskTypePrivs.size == 0) {
            UIButton *taskB = [UIButton buttonWithType:UIButtonTypeCustom];
            [taskB setBackgroundImage:[UIImage imageNamed:@"create_task_up.png"] forState:UIControlStateNormal];
            [taskB setBackgroundImage:[UIImage imageNamed:@"create_task_down.png"] forState:UIControlStateHighlighted];
            [taskB addTarget:self action:@selector(showTaskWindow) forControlEvents:UIControlEventTouchUpInside];
            [taskB setFrame:CGRectMake(13, 145, 174, 56)];
//            [self.view addSubview:taskB];
            
            UIButton *gembaB = [UIButton buttonWithType:UIButtonTypeCustom];
            [gembaB setBackgroundImage:[UIImage imageNamed:@"gemba_button_still.png"] forState:UIControlStateNormal];
            [gembaB setBackgroundImage:[UIImage imageNamed:@"gemba_button_active.png"] forState:UIControlStateHighlighted];
            [gembaB setFrame:CGRectMake(13, taskB.frame.origin.y+taskB.frame.size.height+5, 174, 56)];
            [gembaB addTarget:self action:@selector(showGembaSheet) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:gembaB];
            
            
//            UIButton *synchronization = [UIButton buttonWithType:UIButtonTypeCustom] ;
//            [synchronization setBackgroundImage:[UIImage imageNamed:@"update_data_up.png"] forState:UIControlStateNormal];
//            [synchronization setBackgroundImage:[UIImage imageNamed:@"update_data_down.png"] forState:UIControlStateHighlighted];
////            [synchronization setFrame:CGRectMake(13, taskB.frame.origin.y+taskB.frame.size.height+5, 174, 56)];
//            [synchronization setFrame:CGRectMake(13, 145, 174, 56)];
//            [synchronization addTarget:self action:@selector(synchronization) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:synchronization];
            
            UIButton *dashboardB = [UIButton buttonWithType:UIButtonTypeCustom];
            [dashboardB setBackgroundImage:[UIImage imageNamed:@"dashboard_up.png"] forState:UIControlStateNormal];
            [dashboardB setBackgroundImage:[UIImage imageNamed:@"dashboard_down.png"] forState:UIControlStateHighlighted];
//            [dashboardB setFrame:CGRectMake(13, gembaB.frame.origin.y+gembaB.frame.size.height+5, 174, 56)];
            [dashboardB setFrame:CGRectMake(13, taskB.frame.origin.y+taskB.frame.size.height+5, 174, 56)];
            [dashboardB addTarget:self action:@selector(showDashboard) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:dashboardB];
            

            CLSaveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [CLSaveButton setFrame:CGRectMake(13, dashboardB.frame.origin.y+dashboardB.frame.size.height+5, 56, 56)];
//            [CLSaveButton setFrame:CGRectMake(13, settingsB.frame.origin.y+settingsB.frame.size.height+5, 56, 56)];
            [CLSaveButton setBackgroundImage:[UIImage imageNamed:@"cl_save_still.png"] forState:UIControlStateNormal];
            [CLSaveButton setBackgroundImage:[UIImage imageNamed:@"cl_save_active.png"] forState:UIControlStateHighlighted];
            [CLSaveButton setAlpha:0.0f];
            [self.view addSubview:CLSaveButton];
            
            CLDoneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [CLDoneButton setFrame:CGRectMake(13, CLSaveButton.frame.origin.y+CLSaveButton.frame.size.height+5, 56, 56)];
            [CLDoneButton setBackgroundImage:[UIImage imageNamed:@"cl_complete_still.png"] forState:UIControlStateNormal];
            [CLDoneButton setBackgroundImage:[UIImage imageNamed:@"cl_complete_active.png"] forState:UIControlStateHighlighted];
            [CLDoneButton setAlpha:0.0f];
            [self.view addSubview:CLDoneButton];
            
            UIButton *settingsB = [UIButton buttonWithType:UIButtonTypeCustom];
            [settingsB setBackgroundImage:[UIImage imageNamed:@"settings_still.png"] forState:UIControlStateNormal];
            [settingsB setBackgroundImage:[UIImage imageNamed:@"settings_active.png"] forState:UIControlStateHighlighted];
            //            [settingsB setFrame:CGRectMake(13, closed_taskB.frame.origin.y+closed_taskB.frame.size.height+5, 174, 56)];
            [settingsB setFrame:CGRectMake(13, dashboardB.frame.origin.y+dashboardB.frame.size.height+5 + 416, 174, 56)];
            [settingsB addTarget:self action:@selector(propertiesAction) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:settingsB];
            
            

//            [settingsB release];
//            [taskB release];
//            [gembaB release];
//            [dashboardB release];
        }
        else {
            UIButton *taskB = [UIButton buttonWithType:UIButtonTypeCustom] ;
            [taskB setBackgroundImage:[UIImage imageNamed:@"create_task_up.png"] forState:UIControlStateNormal];
            [taskB setBackgroundImage:[UIImage imageNamed:@"create_task_down.png"] forState:UIControlStateHighlighted];
            //        [taskB setBackgroundImage:[UIImage imageNamed:@"task_button_still.png"] forState:UIControlStateNormal];
            //        [taskB setBackgroundImage:[UIImage imageNamed:@"task_button_active.png"] forState:UIControlStateHighlighted];
            [taskB addTarget:self action:@selector(showTaskWindow) forControlEvents:UIControlEventTouchUpInside];
            [taskB setFrame:CGRectMake(13, 145, 174, 56)];
            [self.view addSubview:taskB];
            
            UIButton *gembaB = [UIButton buttonWithType:UIButtonTypeCustom] ;
            [gembaB setBackgroundImage:[UIImage imageNamed:@"gemba_button_still.png"] forState:UIControlStateNormal];
            [gembaB setBackgroundImage:[UIImage imageNamed:@"gemba_button_active.png"] forState:UIControlStateHighlighted];
            [gembaB setFrame:CGRectMake(13, taskB.frame.origin.y+taskB.frame.size.height+5, 174, 56)];
            [gembaB addTarget:self action:@selector(showGembaSheet) forControlEvents:UIControlEventTouchUpInside];
            //        [self.view addSubview:gembaB];
            
            
//            UIButton *synchronization = [UIButton buttonWithType:UIButtonTypeCustom];
//            [synchronization setBackgroundImage:[UIImage imageNamed:@"update_data_up.png"] forState:UIControlStateNormal];
//            [synchronization setBackgroundImage:[UIImage imageNamed:@"update_data_down.png"] forState:UIControlStateHighlighted];
//            //        [synchronization setBackgroundImage:[UIImage imageNamed:@"gemba_button_still.png"] forState:UIControlStateNormal];
//            //        [synchronization setBackgroundImage:[UIImage imageNamed:@"gemba_button_active.png"] forState:UIControlStateHighlighted];
//            [synchronization setFrame:CGRectMake(13, taskB.frame.origin.y+taskB.frame.size.height+5, 174, 56)];
//            [synchronization addTarget:self action:@selector(synchronization) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:synchronization];
            
            UIButton *dashboardB = [UIButton buttonWithType:UIButtonTypeCustom];
            [dashboardB setBackgroundImage:[UIImage imageNamed:@"dashboard_up.png"] forState:UIControlStateNormal];
            [dashboardB setBackgroundImage:[UIImage imageNamed:@"dashboard_down.png"] forState:UIControlStateHighlighted];
            //        [dashboardB setBackgroundImage:[UIImage imageNamed:@"dash_still.png"] forState:UIControlStateNormal];
            //        [dashboardB setBackgroundImage:[UIImage imageNamed:@"dash_active.png"] forState:UIControlStateHighlighted];
            [dashboardB setFrame:CGRectMake(13, gembaB.frame.origin.y+gembaB.frame.size.height+5, 174, 56)];
            [dashboardB addTarget:self action:@selector(showDashboard) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:dashboardB];
            
            
            CLSaveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [CLSaveButton setFrame:CGRectMake(13, dashboardB.frame.origin.y+dashboardB.frame.size.height+5, 56, 56)];
//            [CLSaveButton setFrame:CGRectMake(13, settingsB.frame.origin.y+settingsB.frame.size.height+5, 56, 56)];
            [CLSaveButton setBackgroundImage:[UIImage imageNamed:@"cl_save_still.png"] forState:UIControlStateNormal];
            [CLSaveButton setBackgroundImage:[UIImage imageNamed:@"cl_save_active.png"] forState:UIControlStateHighlighted];
            [CLSaveButton setAlpha:0.0f];
            [self.view addSubview:CLSaveButton];
            
            CLDoneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [CLDoneButton setFrame:CGRectMake(13, CLSaveButton.frame.origin.y+CLSaveButton.frame.size.height+5, 56, 56)];
            [CLDoneButton setBackgroundImage:[UIImage imageNamed:@"cl_complete_still.png"] forState:UIControlStateNormal];
            [CLDoneButton setBackgroundImage:[UIImage imageNamed:@"cl_complete_active.png"] forState:UIControlStateHighlighted];
            [CLDoneButton setAlpha:0.0f];
            [self.view addSubview:CLDoneButton];

            
            UIButton *settingsB = [UIButton buttonWithType:UIButtonTypeCustom];
            [settingsB setBackgroundImage:[UIImage imageNamed:@"settings_still.png"] forState:UIControlStateNormal];
            [settingsB setBackgroundImage:[UIImage imageNamed:@"settings_active.png"] forState:UIControlStateHighlighted];
            //            [settingsB setFrame:CGRectMake(13, closed_taskB.frame.origin.y+closed_taskB.frame.size.height+5, 174, 56)];
            [settingsB setFrame:CGRectMake(13, dashboardB.frame.origin.y+dashboardB.frame.size.height+5 + 200, 174, 56)];
            [settingsB addTarget:self action:@selector(propertiesAction) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:settingsB];

            
//            [settingsB release];
//            [taskB release];
//            [gembaB release];
//            [dashboardB release];
        }

        
        CGFloat footerTableYAxis = self.view.frame.size.height-130;
        NSLog(@"%f",footerTableYAxis);
//        footerMenu = [[MenuFooterTable alloc]  initWithFrame:CGRectMake(0, 768 - 130, self.view.frame.size.width, 130)];
        footerMenu = [[MenuFooterTable alloc]  initWithFrame:CGRectMake(0, footerTableYAxis, self.view.frame.size.width, 130)];
        [self.view addSubview:footerMenu];
	}
    return self;
}

- (void) propertiesAction
{
    PropertiesViewController * propertyController = [[PropertiesViewController alloc] init];
    propertyController.modalPresentationStyle = UIModalPresentationFormSheet;
    propertyController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [[SberbankAuditAppDelegate instance].rootViewController presentViewController:propertyController animated:YES completion:nil];
    [[propertyController.view superview] setFrame:CGRectMake(roundf([propertyController.view superview].center.x-339), roundf([propertyController.view superview].center.y-252), 678, 504)];
    [propertyController release];
}


- (void) animateCLSaveButton:(id)sender
{
    ControlList *cl = (ControlList *)sender;
    NSLog(@"Current CL: %@", sender);
        
    if([CLSaveButton allTargets].count == 0)
    
        [CLSaveButton addTarget:cl action:@selector(saveCL) forControlEvents:UIControlEventTouchUpInside];

    if([CLDoneButton allTargets].count == 0)
        
        [CLDoneButton addTarget:cl action:@selector(doneCL) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat clsbAlpha = (CLSaveButton.alpha > 0) ? 0.0f : 1.0f;
    
    [UIView animateWithDuration:0.3 animations:^(void)
     {
         [CLSaveButton setAlpha:clsbAlpha];
         [CLDoneButton setAlpha:clsbAlpha];
     }];
}

- (void) showGembaSheet
{
//    GembaSheet *gembaSheet = [[GembaSheet alloc] initWithFrame:CGRectMake(0, 0, 540, 600)];
//    gembaSheet.modalPresentationStyle = UIModalPresentationFormSheet;
//    gembaSheet.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    [self presentModalViewController:gembaSheet animated:YES];
//    [gembaSheet release];
}

- (void)addODRefreshControl
{
//    DataViewController *tmp = [SberbankAuditAppDelegate instance].rootViewController.mainDataVC;
    refresh = [[ODRefreshControl alloc] initInScrollView:[SberbankAuditAppDelegate instance].rootViewController.mainDataVC._tableView];
    [refresh addTarget:self action:@selector(synchronization:) forControlEvents:UIControlEventValueChanged];
//    if (self.refreshControl == nil) {
//        self.refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
//        [self.refreshControl addTarget:[RootViewController sharedController] action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
//    }
}

- (void) synchronization:(ODRefreshControl *)refreshControl
{
    @try
    {
        if (![[SberbankAuditAppDelegate instance] internetConnectionCheck]) {
            return ;
        }
        else
        {
            NSLog(@"Synchronization started");
            
            
            [[SberbankAuditAppDelegate instance] openActivityIndicatorViewWithName:@"Синхронизация данных"];
//            NSLog(@"TaskSG sync started");
//            [ODMobileODMobileDB synchronize:@"TasksSG"];
//            NSLog(@"TaskSG sync finished");
//            NSLog(@"DIMSG sync started");
//            [ODMobileODMobileDB synchronize:@"DIMSG"];
//            NSLog(@"DIMSG sync finished");
//            NSLog(@"DIMSG_TASK_REL sync started");
//            [ODMobileODMobileDB synchronize:@"DIMSG_TASK_REL"];
//            NSLog(@"DIMSG_TASK_REL sync finished");
//            
//            [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC updateData];
//            if ([SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController != nil) {
//                [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController updateData];
//                if ([SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController.detailViewController != nil) {
//                    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController.detailViewController updateData];
//                }
//            }
//            
//            [[SberbankAuditAppDelegate instance] closeActivityIndicator];
//            
//            NSLog(@"SberbankAuditAppDelegate: синхронизация по группам прошла");
//            [refreshControl endRefreshing];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                NSLog(@"TaskSG sync started");
                [ODMobileODMobileDB synchronize:@"TasksSG"];
                NSLog(@"TaskSG sync finished");
                NSLog(@"DIMSG sync started");
                [ODMobileODMobileDB synchronize:@"DIMSG"];
                NSLog(@"DIMSG sync finished");
                NSLog(@"DIMSG_TASK_REL sync started");
                [ODMobileODMobileDB synchronize:@"DIMSG_TASK_REL"];
                NSLog(@"DIMSG_TASK_REL sync finished");
                dispatch_sync(dispatch_get_main_queue(), ^(void){
                    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC updateData];
                    if ([SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController != nil) {
                        [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController updateData];
                        if ([SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController.detailViewController != nil) {
                            [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC.detailViewController.detailViewController updateData];
                        }
                    }
                    
                    [[SberbankAuditAppDelegate instance] closeActivityIndicator];
                    
                    NSLog(@"SberbankAuditAppDelegate: синхронизация по группам прошла");
                    [refreshControl endRefreshing];
                });
            });
            
        }
    }
    @catch (SUPPersistenceException *exception)
    {
        [[SberbankAuditAppDelegate instance] closeActivityIndicator];
        NSLog(@"At-Consulting DevLog: synchronize error: %@ - %@",exception.name,exception.message);
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка синхронизации" message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        [refreshControl endRefreshing];
    }
    
}

//- (void)setStateToODRefreshControl:(ODRefreshControl *)refreshControl
//{
//    [refreshControl endRefreshing];
//}

- (void) showDashboard
{
    [[SberbankAuditAppDelegate instance].rootViewController.view removeFromSuperview];
    [[SberbankAuditAppDelegate instance] openMainVC];
}

- (void) showTaskWindow
{
    newTaskController = [[CreateNewTaskController alloc] init];
    newTaskController.modalPresentationStyle = UIModalPresentationFormSheet;
    newTaskController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:newTaskController animated:YES];
//    [[newTaskController.view superview] setFrame:CGRectMake(roundf([newTaskController.view superview].center.x-252), roundf([newTaskController.view superview].center.y-339), 504, 678)];
    [[newTaskController.view superview] setFrame:CGRectMake(roundf([newTaskController.view superview].center.x-402), roundf([newTaskController.view superview].center.y-339), 804, 678)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addODRefreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
	
    CGFloat footerTableYAxis = self.view.frame.size.height-130;
    NSLog(@"%f",footerTableYAxis);
    [footerMenu setFrame:CGRectMake(0, footerTableYAxis, self.view.frame.size.width, 130)];
//    [footerMenu setFrame:CGRectMake(0, 768 - 150, 200, 130)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return NO;
    }
    return YES;
}

- (BOOL)shouldAutorotate
{
//    return NO;
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch * touch = [[event allTouches] anyObject];
//    CGPoint location = [touch locationInView:self.view];
//    
//    NSLog(@"location in menu exists");
//}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
    [footerMenu release];
    [CLSaveButton release];
    [CLDoneButton release];
    [taskVC release];
    [newTaskController release];
    [refresh release];
    [super dealloc];
}


@end

