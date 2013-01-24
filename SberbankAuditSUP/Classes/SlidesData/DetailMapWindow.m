//
//  DetailMapWindow.m
//  SberbankAudit
//
//  Created by Артем Куликов on 09.06.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "DetailMapWindow.h"
#import "MainMapView.h"

#define titleThree @"Не менее 3км"
#define titleFive @"Не менее 5км"
#define titleTen @"Более 5км"

@implementation DetailMapWindow

@synthesize detailMapTable, MainMapArray, allObjects;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init])
	{
        [self.view setFrame:frame];
        
        [self.view setBackgroundColor:[UIColor whiteColor]];

        UIImageView *gembaHead = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"modalview_head.png"]];
        [gembaHead setFrame:CGRectMake(0, 0, 540, 51)];
        [self.view addSubview:gembaHead];
        [gembaHead release];
        
        UIButton *gembaCancel = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [gembaCancel setBackgroundImage:[UIImage imageNamed:@"modalview_cancel.png"] forState:UIControlStateNormal];
        [gembaCancel setFrame:CGRectMake(17, 16, 134, 27)];
        [self.view addSubview:gembaCancel];
        [gembaCancel addTarget:self action:@selector(closeWindow) forControlEvents:UIControlEventTouchUpInside];
        [gembaCancel release];
        
        UILabel *detailWindowTitle = [[UILabel alloc] initWithFrame:CGRectMake(230, 13, 130, 30)];
        [detailWindowTitle setFont:[UIFont boldSystemFontOfSize:20]];
        [detailWindowTitle setBackgroundColor:[UIColor clearColor]];
        [detailWindowTitle setTextColor:[UIColor whiteColor]];
        [detailWindowTitle setText:@"Отделения"];
        [self.view addSubview:detailWindowTitle];
        [detailWindowTitle release];
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:
                                                                                          @"По расстоянию", @"По % выполнения целей",@"По % выполнения мер-ий ",    nil]];
        [segmentedControl addTarget:self action:@selector(changeMainMapType:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.frame = CGRectMake(5.0f, 58.0f, 530.0f, 30.0f);
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        [self.view addSubview:segmentedControl];
        [segmentedControl release];
        
        
        detailMapTable = [[UITableView alloc] initWithFrame: CGRectMake(0, 95, 540, 520) style: UITableViewStylePlain];
        detailMapTable.backgroundColor = [UIColor clearColor];
        [detailMapTable setBackgroundView:nil];
        [detailMapTable setDelegate:self];
		[detailMapTable setDataSource:self];
		[self.view addSubview:detailMapTable];
        
        myLocation.latitude = 55.802475;
        myLocation.longitude = 37.585795;  
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self filterDistance];
}

- (void) filterDistance {

    if(distanceLeastThree == nil)
    {
        distanceLeastThree = [[NSMutableArray alloc] init];
    }
    if(distanceLeastFive == nil)
    {
        distanceLeastFive = [[NSMutableArray alloc] init];
    }
    if(distanceMoreTen == nil)
    {
        distanceMoreTen = [[NSMutableArray alloc] init];
    }
    
    for (int i=0; i<MainMapArray.count; i++) {
         
        NSMutableDictionary *searchResults = [MainMapArray objectAtIndex:i];
        
        float distance = [self distanceBetweenCoordinates :[[searchResults objectForKey:@"latitude"]floatValue] : [[searchResults objectForKey:@"longitude"] floatValue]];
        
        if( distance < 3)
        {
            [distanceLeastThree addObject:[MainMapArray objectAtIndex:i]]; 
        }	
        if( distance < 5 && distance > 3)
        {
            [distanceLeastFive addObject:[MainMapArray objectAtIndex:i]]; 
        }	
        if( distance > 5)
        {
            [distanceMoreTen addObject:[MainMapArray objectAtIndex:i]]; 
        }
    }
    
    self.allObjects  = [NSDictionary dictionaryWithObjectsAndKeys:distanceLeastThree, titleThree, distanceLeastFive, titleFive, distanceMoreTen, titleTen, nil];
    
}

- (NSArray*)curentObjects:(NSInteger)index {
    NSArray *keys = [allObjects allKeys];
    NSString *curentKey = [keys objectAtIndex:index];
    NSArray *curentObjectsArray = [allObjects objectForKey:curentKey];
    return curentObjectsArray;
}

- (double)distanceBetweenCoordinates: (CLLocationDegrees)latitude : (CLLocationDegrees)longitude
{
    CLLocation *to = [[[CLLocation alloc] initWithLatitude:myLocation.latitude longitude:myLocation.longitude] autorelease];
    
    CLLocation *from = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
    
    CLLocationDistance distance = [to distanceFromLocation:from];
    
    distance /=1000;
    
    return distance;
    
}

- (void) closeWindow
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)changeMainMapType:(UISegmentedControl*)sender {
    if (sender.selectedSegmentIndex == 0) {
     
         
        
    } else if (sender.selectedSegmentIndex == 1) {
       
        
        
    } 
    
    else if (sender.selectedSegmentIndex == 2) {
        
        
        
    } 
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return allObjects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *curentObjects;
    curentObjects = [self curentObjects:section];
    return curentObjects.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[allObjects allKeys] objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    NSArray *curentObjectsArray = [self curentObjects:indexPath.section];
    
    CLLocationDegrees cellLatitude = [[[curentObjectsArray objectAtIndex:indexPath.row] objectForKey:@"latitude"] floatValue];
    CLLocationDegrees cellLongitude = [[[curentObjectsArray objectAtIndex:indexPath.row] objectForKey:@"longitude"] floatValue];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%.2f км)",  [[curentObjectsArray objectAtIndex:indexPath.row] objectForKey:@"name"], [self distanceBetweenCoordinates: cellLatitude :cellLongitude]];
    cell.detailTextLabel.text = [NSString stringWithString:(NSString*)[[curentObjectsArray objectAtIndex:indexPath.row] objectForKey:@"adress"]];
     cell.imageView.image = [UIImage imageNamed:@"indicator_0.png"];
    
    return cell;
}

- (void) dealloc
{
    [super dealloc];
    
    [detailMapTable release];
    [distanceLeastThree release];
    [distanceLeastFive release];
    [distanceMoreTen release];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


@end
