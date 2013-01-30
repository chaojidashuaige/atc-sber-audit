
#import "MapViewController.h"

#import "mapMenuController.h"
#import "StackScrollViewController.h"
#import "SberbankAuditAppDelegate.h"
#import "DataViewController.h"
#import "UIViewExt.h"



@implementation MapViewController

@synthesize mapMenuController, stackMenuScrollViewController,mainDataMenu,SBTasksMenu,SBOpenTaskMenu, frameMenuRect;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	mapView = [[UIViewExt alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [mapView setAutoresizesSubviews:YES];
	mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth + UIViewAutoresizingFlexibleHeight;
	[mapView setBackgroundColor:[UIColor clearColor]];
    
    
    
	leftMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, self.view.frame.size.height)];
    [leftMenuView setAutoresizesSubviews:YES];
	leftMenuView.autoresizingMask = UIViewAutoresizingFlexibleHeight;	
    mapMenuController = [[MapMenuController alloc] initWithFrame:CGRectMake(0, 0, leftMenuView.frame.size.width, leftMenuView.frame.size.height)];
    mainDataMenu = [[DataViewController alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
    mainDataMenu.tweets = SBTasksMenu;
//    mainDataMenu.SBOpenDetailSlide = SBOpenTaskMenu;
    mapMenuController.taskMenu = mainDataMenu;
    [mapMenuController.view setAutoresizesSubviews:YES];
	[mapMenuController.view setBackgroundColor:[UIColor clearColor]];
	[mapMenuController viewWillAppear:FALSE];
	[mapMenuController viewDidAppear:FALSE];
	
    [leftMenuView addSubview:mapMenuController.view];
    
	rightSlideView = [[UIView alloc] initWithFrame:CGRectMake(leftMenuView.frame.size.width, 0, mapView.frame.size.width - leftMenuView.frame.size.width, mapView.frame.size.height)];
	rightSlideView.autoresizingMask = UIViewAutoresizingFlexibleWidth + UIViewAutoresizingFlexibleHeight;
    
	stackMenuScrollViewController = [[StackScrollViewController alloc] init];	
	[stackMenuScrollViewController.view setFrame:CGRectMake(0, 0, rightSlideView.frame.size.width, rightSlideView.frame.size.height)];
	[stackMenuScrollViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth + UIViewAutoresizingFlexibleHeight];
	[stackMenuScrollViewController viewWillAppear:FALSE];
	[stackMenuScrollViewController viewDidAppear:FALSE];
	[rightSlideView addSubview:stackMenuScrollViewController.view];
	[mapView addSubview:leftMenuView];
	[mapView addSubview:rightSlideView];
    
    //add back to main view
    
    UIImageView *mainSpaceBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_space_back.png"]];
    [mainSpaceBack setFrame:CGRectMake(leftMenuView.frame.size.width, 0, self.view.frame.size.height, self.view.frame.size.height)];
    [self.view addSubview:mainSpaceBack];
    [mainSpaceBack release];
    
	[self.view addSubview:mapView];
    
    //add task view when application start
    
    MainMapView *map = [[MainMapView alloc] initWithFrame:CGRectMake(0, 0, 826, 748)];
    
    mapMenuController.delegate = map;


    [[SberbankAuditAppDelegate instance].mapViewController.stackMenuScrollViewController addViewInSlider:map drawShadow:NO invokeByController:mapMenuController isStackStartView:YES];

    [map release];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[mapMenuController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[stackMenuScrollViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
	[mapMenuController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[stackMenuScrollViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}	

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
    [SBOpenTaskMenu release];
    [SBTasksMenu release];
}


@end