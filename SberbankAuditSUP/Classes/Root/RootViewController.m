
#import "RootViewController.h"


#import "MenuViewController.h"
#import "StackScrollViewController.h"
#import "SberbankAuditAppDelegate.h"
#import "DataViewController.h"
#import "UIViewExt.h"



@implementation RootViewController
@synthesize menuViewController, stackScrollViewController,mainDataVC,SBTasks, isMap, frameRect;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {		
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 1024, 748);
    
	rootView = [[UIViewExt alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [rootView setAutoresizesSubviews:YES];
	rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth + UIViewAutoresizingFlexibleHeight;
	[rootView setBackgroundColor:[UIColor clearColor]];
    
	leftMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, self.view.frame.size.height)];
    [leftMenuView setAutoresizesSubviews:YES];
	leftMenuView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//	leftMenuView.clipsToBounds = YES;
//    menuViewController = [[MenuViewController alloc] init];

    mainDataVC = [[DataViewController alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
    mainDataVC.tweets = SBTasks;
    menuViewController = [[MenuViewController alloc] init];
    menuViewController.view.frame = CGRectMake(0, 0, leftMenuView.frame.size.width, leftMenuView.frame.size.height);
    menuViewController.taskVC = mainDataVC;
//    menuViewController.view.backgroundColor = [UIColor whiteColor];
    [menuViewController.view setAutoresizesSubviews:YES];
	[menuViewController.view setBackgroundColor:[UIColor clearColor]];
	[menuViewController viewWillAppear:FALSE];
	[menuViewController viewDidAppear:FALSE];
	
    [leftMenuView addSubview:menuViewController.view];
    
	rightSlideView = [[UIView alloc] initWithFrame:CGRectMake(leftMenuView.frame.size.width, 0, rootView.frame.size.width - leftMenuView.frame.size.width, rootView.frame.size.height)];
//    rightSlideView.backgroundColor = [UIColor redColor];
	rightSlideView.autoresizingMask = UIViewAutoresizingFlexibleWidth + UIViewAutoresizingFlexibleHeight;
        
	stackScrollViewController = [[StackScrollViewController alloc] init];	
	[stackScrollViewController.view setFrame:CGRectMake(0, 0, rightSlideView.frame.size.width, rightSlideView.frame.size.height)];
	[stackScrollViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth + UIViewAutoresizingFlexibleHeight];
	[stackScrollViewController viewWillAppear:FALSE];
	[stackScrollViewController viewDidAppear:FALSE];
	[rightSlideView addSubview:stackScrollViewController.view];
	[rootView addSubview:leftMenuView];
	[rootView addSubview:rightSlideView];
    
    //add back to main view
    
    UIImageView *mainSpaceBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_space_back.png"]];
    [mainSpaceBack setFrame:CGRectMake(leftMenuView.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:mainSpaceBack];
    [mainSpaceBack release];
    
    [self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:0.0];
    
	[self.view addSubview:rootView];
        
   
    [[SberbankAuditAppDelegate instance].rootViewController.stackScrollViewController addViewInSlider:mainDataVC drawShadow:NO invokeByController:menuViewController isStackStartView:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    [super viewDidUnload];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch * touch = [[event allTouches] anyObject];
//    CGPoint location = [touch locationInView:self.view];
//    
//    NSLog(@"location in root exists");
//}



- (void)dealloc {
    [super dealloc];
    [SBTasks release];
}


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[menuViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [mainDataVC didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[stackScrollViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
        menuViewController.view.frame = CGRectMake(0, 0, leftMenuView.frame.size.width, 768-20);
//        menuViewController.view.frame = CGRectMake(0, 0, leftMenuView.frame.size.width, leftMenuView.frame.size.height - 20);
        mainDataVC.view.frame = CGRectMake(0, 0, 477, 768-20);
    }
    else if (UIDeviceOrientationIsPortrait(toInterfaceOrientation)) {
        menuViewController.view.frame = CGRectMake(0, 0, leftMenuView.frame.size.width, 1024-20);
    }
	[menuViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [mainDataVC willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[stackScrollViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
    //        return YES;
    //    }
    //    return NO;
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationMaskAll;
//}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


@end
