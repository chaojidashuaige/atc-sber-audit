
#import "MapMenuController.h"
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
#import "MenuHeaderView.h"


@implementation MapMenuController

@synthesize taskMenu,categoryTable,category, thumbTintColor, maximumTrackTintColor, minimumTrackTintColor, delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if(self != nil)
    {
        [self.view setFrame:frame];
        

        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_menu_back.png"]];
        [self.view addSubview:backgroundImage];
        [backgroundImage release];
        
        MenuHeaderView *menuHeader = [[MenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, 200, 135)];
        [self.view addSubview:menuHeader];
        [menuHeader release];

        
        UILabel *showNearestBlack = [[UILabel alloc] initWithFrame:CGRectMake(15, 139, 150, 20)];
        [showNearestBlack setText:@"Расстояние"];
        [showNearestBlack setTextColor:[UIColor grayColor]];
        [showNearestBlack setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:showNearestBlack];
        [showNearestBlack release]; 
        
        UILabel *showNearest = [[UILabel alloc] initWithFrame:CGRectMake(15, 140, 150, 20)];
        [showNearest setText:@"Расстояние"];
        [showNearest setTextColor:[UIColor whiteColor]];
        [showNearest setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:showNearest];
        [showNearest release]; 
        
        UIImageView *sberUnderLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sber_under_line.png"]];
        [sberUnderLine setFrame:CGRectMake(15, 163, 169, 2)];
        [self.view addSubview:sberUnderLine];
        [sberUnderLine release];
        
       
        
        distanceMap = [[UISlider alloc] initWithFrame:CGRectMake(14, 175, 120, 10)];
        [distanceMap setMinimumValue:0.0];
        [distanceMap setMaximumValue:20.0];
        [distanceMap setValue:10];
        [distanceMap   setThumbTintColor:[UIColor grayColor]];
        [distanceMap setMaximumTrackTintColor:[UIColor whiteColor]];
        [distanceMap setMinimumTrackTintColor:[UIColor lightGrayColor]];
        [distanceMap addTarget:self action:@selector(changeLabelText:) forControlEvents:UIControlEventValueChanged];
        [distanceMap setContinuous:YES];
        [self.view addSubview:distanceMap];
        [distanceMap release];  
        
        labelDistance = [[UILabel alloc] initWithFrame:CGRectMake(140, 176, 140, 20)];
        [labelDistance setTextColor:[UIColor whiteColor]];
        [labelDistance setBackgroundColor:[UIColor clearColor]];
        [labelDistance setText:@"10км"];
        [self.view addSubview:labelDistance];
        [labelDistance release]; 
        
        UIImageView *sberUnderLineCat = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sber_under_line.png"]];
        [sberUnderLineCat setFrame:CGRectMake(15, 225, 169, 2)];
        [self.view addSubview:sberUnderLineCat];
        [sberUnderLineCat release];
        
        UILabel *showCatBlack = [[UILabel alloc] initWithFrame:CGRectMake(15, 228, 150, 20)];
        [showCatBlack setText:@"Категории"];
        [showCatBlack setTextColor:[UIColor grayColor]];
        [showCatBlack setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:showCatBlack];
        [showCatBlack release]; 
        
        UILabel *showCat = [[UILabel alloc] initWithFrame:CGRectMake(15, 229, 150, 20)];
        [showCat setText:@"Категории"];
        [showCat setTextColor:[UIColor whiteColor]];
        [showCat setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:showCat];
        [showCat release]; 
        
        UIImageView *sberUnderLineCatBlack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sber_under_line.png"]];
        [sberUnderLineCatBlack setFrame:CGRectMake(15, 252, 169, 2)];
        [self.view addSubview:sberUnderLineCatBlack];
        [sberUnderLineCatBlack release];
        
        
        categoryTable = [[UITableView alloc] initWithFrame: CGRectMake(16, 258, 178, 300) style:UITableViewStylePlain];
        [categoryTable setSeparatorColor:[UIColor clearColor]];
        categoryTable.backgroundColor = [UIColor clearColor];
        [categoryTable setBackgroundView:nil];
        [categoryTable setDelegate:self];
		[categoryTable setDataSource:self];
		[self.view addSubview:categoryTable];
        self.categoryTable.bounces = NO;
        
        UIImageView *sberUnderLineProc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sber_under_line.png"]];
        [sberUnderLineProc setFrame:CGRectMake(15, 390, 169, 2)];
        [self.view addSubview:sberUnderLineProc];
        [sberUnderLineProc release];
        
        UILabel *showProcentBlack = [[UILabel alloc] initWithFrame:CGRectMake(15, 393, 150, 20)];
        [showProcentBlack setText:@"Достижение цели"];
        [showProcentBlack setTextColor:[UIColor grayColor]];
        [showProcentBlack setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:showProcentBlack];
        [showProcentBlack release];
        
        UILabel *showProcent = [[UILabel alloc] initWithFrame:CGRectMake(15, 394, 150, 20)];
        [showProcent setText:@"Достижение цели"];
        [showProcent setTextColor:[UIColor whiteColor]];
        [showProcent setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:showProcent];
        [showProcent release]; 
        
        
        UIImageView *sberUnderLineProcTwo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sber_under_line.png"]];
        [sberUnderLineProcTwo setFrame:CGRectMake(15, 418, 169, 2)];
        [self.view addSubview:sberUnderLineProcTwo];
        [sberUnderLineProcTwo release];
        
        procentTask = [[UISlider alloc] initWithFrame:CGRectMake(15, 430, 120, 10)]; 
        [procentTask setMinimumValue:0.0];
        [procentTask setMaximumValue:100.0];
        [procentTask setValue:50];
        [procentTask   setThumbTintColor:[UIColor grayColor]];
        [procentTask setMaximumTrackTintColor:[UIColor whiteColor]];
        [procentTask setMinimumTrackTintColor:[UIColor lightGrayColor]];
        [procentTask addTarget:self action:@selector(changeLabelText:) forControlEvents:UIControlEventValueChanged];
        [procentTask setContinuous:YES];
        [self.view addSubview:procentTask];
        
        labelTask = [[UILabel alloc] initWithFrame:CGRectMake(152, 431, 150, 20)];
        [labelTask setTextColor:[UIColor whiteColor]];
        [labelTask setBackgroundColor:[UIColor clearColor]];
        [labelTask setText:@"50%"];
        [self.view addSubview:labelTask];
        
        UIImageView *sberUnderLineAct = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sber_under_line.png"]];
        [sberUnderLineAct setFrame:CGRectMake(15, 478, 169, 2)];
        [self.view addSubview:sberUnderLineAct];
        [sberUnderLineAct release];

        UILabel *showActivityBlack = [[UILabel alloc] initWithFrame:CGRectMake(15, 481, 180, 20)];
        [showActivityBlack setText:@"Вып. мероприятий"];
        [showActivityBlack setTextColor:[UIColor blackColor]];
        [showActivityBlack setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:showActivityBlack];
        [showActivityBlack release]; 
        
        UILabel *showActivity = [[UILabel alloc] initWithFrame:CGRectMake(15, 482, 180, 20)];
        [showActivity setText:@"Вып. мероприятий"];
        [showActivity setTextColor:[UIColor whiteColor]];
        [showActivity setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:showActivity];
        [showActivity release]; 
        
        UIImageView *sberUnderLineActTwo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sber_under_line.png"]];
        [sberUnderLineActTwo setFrame:CGRectMake(15, 506, 169, 2)];
        [self.view addSubview:sberUnderLineActTwo];
        [sberUnderLineActTwo release];

        
        procentActivity = [[UISlider alloc] initWithFrame:CGRectMake(15, 517, 120, 10)];
        [procentActivity setMinimumValue:0.0];
        [procentActivity setMaximumValue:100.0];
        [procentActivity setValue:50];
        [procentActivity setThumbTintColor:[UIColor grayColor]];
        [procentActivity setMaximumTrackTintColor:[UIColor whiteColor]];
        [procentActivity setMinimumTrackTintColor:[UIColor lightGrayColor]];
        [procentActivity addTarget:self action:@selector(changeLabelText:) forControlEvents:UIControlEventValueChanged];
        [procentActivity setContinuous:YES];
        [self.view addSubview:procentActivity];
        
        labelActivity = [[UILabel alloc] initWithFrame:CGRectMake(152, 518, 150, 20)];
        [labelActivity setTextColor:[UIColor whiteColor]];
        [labelActivity setBackgroundColor:[UIColor clearColor]];
        [labelActivity setText:@"50%"];
        [self.view addSubview:labelActivity];
        
        UIButton *dashboardB = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [dashboardB setBackgroundImage:[UIImage imageNamed:@"dash_still@2x.png"] forState:UIControlStateNormal];
        [dashboardB setBackgroundImage:[UIImage imageNamed:@"dash_active@2x.png"] forState:UIControlStateHighlighted];
        [dashboardB setFrame:CGRectMake(13, 680, 174, 56)];
        [dashboardB addTarget:self action:@selector(showDashboard) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:dashboardB];
         
    }
    
    return self;
}

- (void)changeLabelText:(id)sender 
{
    taskSliderValue = procentTask.value;
	labelTask.text = [NSString stringWithFormat:@"%d%%", taskSliderValue];
    
    acivitySliderValue = procentActivity.value;
    labelActivity.text = [NSString stringWithFormat:@"%d%%", acivitySliderValue];
    
    distanceValue = distanceMap.value;
    labelDistance.text = [NSString stringWithFormat:@"%dкм", distanceValue];
    
    [delegate distanceFilter:distanceValue];


    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) showDashboard
{
    [[SberbankAuditAppDelegate instance] openMainVC];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *tmpCategory = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:
                                                                         [NSDictionary dictionaryWithObjectsAndKeys:@"ВСП",@"otdel",  nil],
                                                                         [NSDictionary dictionaryWithObjectsAndKeys:@"ОПЕРУ",@"otdel",  nil],
                                                                         [NSDictionary dictionaryWithObjectsAndKeys:@"ОСБ",@"otdel",  nil],
                                                                         [NSDictionary dictionaryWithObjectsAndKeys:@"ГОСБ",@"otdel",  nil],
                                                                         [NSDictionary dictionaryWithObjectsAndKeys:@"ТБ",@"otdel",  nil],
                                                                         nil]];
    self.category = tmpCategory;
    [tmpCategory release];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return category.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 5) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    NSString *cellText = [NSString stringWithString:(NSString*)[[category objectAtIndex:indexPath.row] objectForKey:@"otdel"]];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    CGSize constraintSize = CGSizeMake(100.0f, MAXFLOAT);
    
    CGSize labelSize = [cellText sizeWithFont:cellFont 
                            constrainedToSize:constraintSize 
                                lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 5.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
    }
    
    cell.textLabel.text = [NSString stringWithString:(NSString*)[[category objectAtIndex:indexPath.row] objectForKey:@"otdel"]];
    cell.backgroundColor = [UIColor clearColor];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    

    
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)dealloc
{
	[categoryTable release];
    [category release];
    [procentTask release];
    [procentActivity release];
    [labelTask release];
    [labelActivity release];
    [distanceMap release];
    [labelDistance release];
	[super dealloc];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//	return UIDeviceOrientationIsLandscape(interfaceOrientation);
//}
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}

@end
