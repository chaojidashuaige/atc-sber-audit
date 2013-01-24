//
//  GembaSheet.m
//  SberbankAudit
//
//  Created by Artem Koulikov on 29.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GembaSheet.h"
#import "GembaSheetAnnotation.h"

@implementation GembaSheet

@synthesize map;
@synthesize GembaSheetTable;

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
        [gembaCancel addTarget:self action:@selector(closeGemba) forControlEvents:UIControlEventTouchUpInside];
        [gembaCancel release];
        
//        UIButton *gembaSave = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
//        [gembaSave setBackgroundImage:[UIImage imageNamed:@"modalview_save.png"] forState:UIControlStateNormal];
//        [gembaSave setFrame:CGRectMake(380, 16, 134, 27)];
//        [gembaSave addTarget:self action:@selector(closeGemba) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:gembaSave];
//        [gembaSave release];
        
        UILabel *gembaTitle = [[UILabel alloc] initWithFrame:CGRectMake(230, 13, 130, 30)];
        [gembaTitle setFont:[UIFont boldSystemFontOfSize:20]];
        [gembaTitle setBackgroundColor:[UIColor clearColor]];
        [gembaTitle setTextColor:[UIColor whiteColor]];
        [gembaTitle setText:@"Гемба"];
        [self.view addSubview:gembaTitle];
        [gembaTitle release];
        
        gembaLatitude = [[UILabel alloc] initWithFrame:CGRectMake(17, 60, 450, 50)];
        [gembaLatitude setFont:[UIFont boldSystemFontOfSize:18]];
        [gembaLatitude setBackgroundColor:[UIColor clearColor]];
        [gembaLatitude setTextColor:[UIColor blackColor]];
        [self.view addSubview:gembaLatitude];
        
        gembaLongitude = [[UILabel alloc] initWithFrame:CGRectMake(17, 100, 450, 50)];
        [gembaLongitude setFont:[UIFont boldSystemFontOfSize:18]];
        [gembaLongitude setBackgroundColor:[UIColor clearColor]];
        [gembaLongitude setTextColor:[UIColor blackColor]];
        [self.view addSubview:gembaLongitude];
    
       
        
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                                [NSArray arrayWithObjects:
                                                 @"Карта",
                                                 @"Спутник",
                                                 @"Гибрид",
                                                 nil]];
        [segmentedControl addTarget:self action:@selector(changeMapType:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.frame = CGRectMake(330.0f, 70.0f, 200.0f, 30.0f);
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        [self.view addSubview:segmentedControl];
        [segmentedControl release];
        
        GembaSheetArray =  [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:
                                                            
                            [NSDictionary dictionaryWithObjectsAndKeys:@"55.773746",@"latitude", @"37.600971", @"longitude", @"ул.Долгоруковская 2", @"adress", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"55.769349",@"latitude", @"37.604924", @"longitude", @"ул.Малая Дмитровка 15", @"adress", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"55.839443",@"latitude", @"37.437343", @"longitude", @"ул.Сходненская 9", @"adress", nil],
                            [NSDictionary dictionaryWithObjectsAndKeys:@"55.782889",@"latitude", @"37.609758", @"longitude", @"ул.Достоевского 3", @"adress", nil],                                      
                            [NSDictionary dictionaryWithObjectsAndKeys:@"55.70694",@"latitude", @"37.679584", @"longitude",  @"ул.6-ая Кожуховская 26", @"adress", nil],                                      
                            [NSDictionary dictionaryWithObjectsAndKeys:@"55.704163",@"latitude", @"37.770417", @"longitude", @"Волгоградский проспект 92", @"adress", nil],                                      
                            [NSDictionary dictionaryWithObjectsAndKeys:@"55.838936",@"latitude", @"37.485617", @"longitude", @"ул.Адмирала Макарова 45", @"adress", nil],                                      
                            [NSDictionary dictionaryWithObjectsAndKeys:@"55.766878",@"latitude", @"37.834312", @"longitude", @"ул.Саянская 18", @"adress", nil],                                      
                            [NSDictionary dictionaryWithObjectsAndKeys:@"55.882742",@"latitude", @"37.696329", @"longitude", @"ул.Малыгина 6", @"adress", nil],                                     
                            [NSDictionary dictionaryWithObjectsAndKeys:@"55.852152",@"latitude", @"37.354572", @"longitude", @"ул.Митинская 52", @"adress", nil],nil]]; 
        
        float left = 500, right = -1, up = 500, down = -1;//вспомогательные переменные для вычитания центральной точки
        
        for (NSDictionary *current in GembaSheetArray){
            float currentLatitude = [[current objectForKey:@"latitude"] floatValue], currentLongtitude = [[current objectForKey:@"longitude"] floatValue];
            left = (currentLatitude < left) ? currentLatitude : left;
            right = (currentLatitude > right) ? currentLatitude : right;
            up = (currentLongtitude < up) ? currentLongtitude : up;
            down = (currentLongtitude > down) ? currentLongtitude : down;
        }
        CLLocationCoordinate2D centerPoint;
        centerPoint.latitude = (right + left)*0.5;
        centerPoint.longitude = (down + up)*0.5;
        MKCoordinateSpan span;
        span.latitudeDelta = right - left;
        span.longitudeDelta = down - up;
        
        map = [[MKMapView alloc] initWithFrame:CGRectMake(4, 70, 532, 261)];
        [map.layer setCornerRadius:10.f];
        map.showsUserLocation = YES;
        map.delegate = self;
        [map setRegion:MKCoordinateRegionMake(centerPoint, span)];
    
        
        
        [self.view addSubview:map]; 
        
//        myAnnotation = [GembaSheetAnnotation new];
//        myAnnotation.title = @"ЭТО Я!";
//        myLocation.latitude = 55.802475;
//        myLocation.longitude = 37.585795;
//        myAnnotation.subtitle = @"Я!";
//        myAnnotation.coordinate = myLocation; 
//        [map addAnnotation:(id<MKAnnotation>)myAnnotation];
        
        GembaSheetTable = [[UITableView alloc] initWithFrame: CGRectMake(0, 335, 540, 300) style: UITableViewStyleGrouped];
        GembaSheetTable.backgroundColor = [UIColor clearColor];
        [GembaSheetTable setBackgroundView:nil];
        [GembaSheetTable setDelegate:self];
		[GembaSheetTable setDataSource:self];
		[self.view addSubview:GembaSheetTable];
        
        for (int i=0; i < GembaSheetArray.count; i++) {
        
        location.longitude = [[[GembaSheetArray objectAtIndex:i] objectForKey:@"longitude"] floatValue];
        location.latitude = [[[GembaSheetArray objectAtIndex:i] objectForKey:@"latitude"] floatValue];

        sheetAnnotation = [GembaSheetAnnotation new];
        sheetAnnotation.title = [NSString stringWithString:(NSString*)[[GembaSheetArray objectAtIndex:i] objectForKey:@"adress"]];
        sheetAnnotation.subtitle = [NSString stringWithFormat:@"Примерное расстояние до банка: %.1f км",
                    [self distanceBetweenCoordinates :[[[GembaSheetArray objectAtIndex:i] objectForKey:@"latitude"]floatValue] : [[[GembaSheetArray objectAtIndex:i] objectForKey:@"longitude"] floatValue]]] ;
        sheetAnnotation.coordinate = location; 
        [map addAnnotation:(id<MKAnnotation>)sheetAnnotation];
        }
        
	}
    return self;
}



- (double)distanceBetweenCoordinates: (CLLocationDegrees)latitude : (CLLocationDegrees)longitude
{
    
    //latitude = myLocation.latitude;
    //longitude = myLocation.longitude;
    
    CLLocation *to = [[[CLLocation alloc] initWithLatitude:myLocation.latitude longitude:myLocation.longitude] autorelease];
    
    //latitude = location.latitude;
    //longitude = location.longitude;
    CLLocation *from = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
    
    CLLocationDistance distance = [to distanceFromLocation:from];
    
    distance /=1000;
    
    return distance;
    
}


- (void)changeMapType:(UISegmentedControl*)sender {
    if (sender.selectedSegmentIndex == 0) {
        map.mapType = MKMapTypeStandard;
    } else if (sender.selectedSegmentIndex == 1) {
        map.mapType = MKMapTypeSatellite;
    } else if (sender.selectedSegmentIndex == 2) {
        map.mapType = MKMapTypeHybrid;
    }
}


- (void) closeGemba
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return GembaSheetArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    CLLocationDegrees cellLatitude = [[[GembaSheetArray objectAtIndex:indexPath.row] objectForKey:@"latitude"] floatValue];
    CLLocationDegrees cellLongitude = [[[GembaSheetArray objectAtIndex:indexPath.row] objectForKey:@"longitude"] floatValue];
    
        
    cell.textLabel.text = [[GembaSheetArray objectAtIndex:indexPath.row] objectForKey:@"adress"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Примерное расстояние до банка: %.1f км",
                                 [self distanceBetweenCoordinates:cellLatitude:cellLongitude]];
    cell.imageView.image = [UIImage imageNamed:@"SberLogo.png"];
            
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    [map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    myLocation.latitude = newLocation.coordinate.latitude;
    myLocation.longitude = newLocation.coordinate.longitude;
    [GembaSheetTable reloadData];
}

- (void) dealloc
{   
    self.map = nil;
    [super dealloc];
    [locationManager release];
    [gembaLongitude release];
    [gembaLatitude release];
    [GembaSheetArray release];
    [GembaSheetTable release];
    [sheetAnnotation release];
    [mySecondAnnotation release];
    [myAnnotation release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.map = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation 
{   
    if (annotation == mapView.userLocation) {
        return nil;
    }
    
    if ( sheetAnnotation.title != nil ) {
        static NSString* customAnnotationIdentifier = @"customAnnotationIdentifier";
        MKAnnotationView* annotationView = (MKAnnotationView *)[mapView 
                                                                dequeueReusableAnnotationViewWithIdentifier:
                                                                customAnnotationIdentifier];
        
        if (!annotationView) {
            annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation 
                                                           reuseIdentifier:nil] autorelease];
            annotationView.image = [UIImage imageNamed:@"SberLogo.png"];
            annotationView.canShowCallout = YES;
            UIImageView *sfIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SberLogo.png"]];
            annotationView.leftCalloutAccessoryView = sfIconView;
            [sfIconView release];
            return annotationView;
        }
        
        return annotationView;
        
    }   
        else 
    {
        static NSString* annotationIdentifier = @"annotationIdentifier";
        MKPinAnnotationView* annotationView = (MKPinAnnotationView *)[mapView 
                                                                      dequeueReusableAnnotationViewWithIdentifier:
                                                                      annotationIdentifier];
        
        if (!annotationView) {
            annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation 
                                                              reuseIdentifier:nil] autorelease];
            if([[annotation title] isEqualToString:@"Annotation1"]) {
                [annotationView setPinColor:MKPinAnnotationColorRed];
            } else {
                [annotationView setPinColor:MKPinAnnotationColorGreen];
                annotationView.animatesDrop = YES;
                annotationView.canShowCallout = YES;
            }
        }
        
        return annotationView;
    }
}

@end