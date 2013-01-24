//
//  MainMapView.m
//  SberbankAudit
//
//  Created by Артем Куликов on 31.05.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "MainMapView.h"
#import "SberbankAuditAppDelegate.h"
#import "StackScrollViewController.h"
#import "RootViewController.h"
#import "DetailMapWindow.h"
#import "TaskActivity.h"

#define LABELS_FONT_SIZE 16.0f
#define TITLE_FONT_SIZE 18.0f

@implementation MainMapView

@synthesize placeholder;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init])
	{
        [self.view setFrame:frame];
        [self.view setBackgroundColor:[UIColor clearColor]];
        
        MainMapArray =  [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:
                                                                  
                                                                  [NSDictionary dictionaryWithObjectsAndKeys:@"55.773746",@"latitude", @"37.600971", @"longitude", @"ул. Долгоруковская 2", @"adress", 
                                                                   @"Долгоруковская", @"name",
                                                                   nil],
                                                                  [NSDictionary dictionaryWithObjectsAndKeys:@"55.769349",@"latitude", @"37.604924", @"longitude", @"ул. Малая Дмитровка 15", @"adress",
                                                                   
                                                                   @"Малая Дмитровка", @"name",nil],
                                                                  [NSDictionary dictionaryWithObjectsAndKeys:@"55.839443",@"latitude", @"37.437343", @"longitude", @"ул. Сходненская 9", @"adress",
                                                                   @"Сходненская", @"name",
                                                                   nil],
                                                                  [NSDictionary dictionaryWithObjectsAndKeys:@"55.782889",@"latitude", @"37.609758", @"longitude", @"ул. Достоевского 3", @"adress",
                                                                   @"Достоевского", @"name",
                                                                   nil],                                      
                                                                  [NSDictionary dictionaryWithObjectsAndKeys:@"55.70694",@"latitude", @"37.679584", @"longitude",  @"ул. 6-ая Кожуховская 26", @"adress",
                                                                   @"6-ая Кожуховская", @"name",
                                                                   nil],                                      
                                                                  [NSDictionary dictionaryWithObjectsAndKeys:@"55.704163",@"latitude", @"37.770417", @"longitude", @"Волгоградский проспект 92", @"adress", 
                                                                   @"Вогоградский проспект", @"name",
                                                                   nil],                                      
                                                                  [NSDictionary dictionaryWithObjectsAndKeys:@"55.838936",@"latitude", @"37.485617", @"longitude", @"ул. Адмирала Макарова 45", @"adress",
                                                                   @"Адмирала Макарова", @"name",
                                                                   nil],                                      
                                                                  [NSDictionary dictionaryWithObjectsAndKeys:@"55.766878",@"latitude", @"37.834312", @"longitude", @"ул. Саянская 18", @"adress",
                                                                   @"Саянская", @"name",
                                                                   nil],                                      
                                                                  [NSDictionary dictionaryWithObjectsAndKeys:@"55.882742",@"latitude", @"37.696329", @"longitude", @"ул. Малыгина 6", @"adress",
                                                                   @"Малыгина", @"name",
                                                                   nil],                                     
                                                                  [NSDictionary dictionaryWithObjectsAndKeys:@"55.852152",@"latitude", @"37.354572", @"longitude", @"ул. Митинская 52", @"adress",
                                                                   @"Митинская", @"name",
                                                                   nil],
                                                               
                                                               nil]]; 
        
        mainSortArray = [[NSMutableArray alloc] init];
        
        
                
        float left = 500, right = -1, up = 500, down = -1; //вспомогательные переменные для вычитания центральной точки
 
        for (NSDictionary *current in MainMapArray){
            float currentLatitude = [[current objectForKey:@"latitude"] doubleValue], currentLongtitude = [[current objectForKey:@"longitude"] floatValue];
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
        
        mainMap = [[MKMapView alloc] initWithFrame:frame];
        mainMap.showsUserLocation = YES;
        mainMap.delegate = self;
        [mainMap setRegion:MKCoordinateRegionMake(centerPoint, span)];
        [self.view addSubview:mainMap];
        
        myAnnotation = [MainMapAnnotation new];
        myAnnotation.title = @"ЭТО Я!";
        myLocation.latitude = 55.802475;
        myLocation.longitude = 37.585795;
        myAnnotation.subtitle = @"Я!";
        myAnnotation.coordinate = myLocation; 
        [mainMap addAnnotation:(id<MKAnnotation>)myAnnotation];
    
       
      
        for (int i=0; i < MainMapArray.count; i++) {
            
            location.longitude = [[[MainMapArray objectAtIndex:i] objectForKey:@"longitude"] floatValue];
            location.latitude = [[[MainMapArray objectAtIndex:i] objectForKey:@"latitude"] floatValue];
            
            mapAnnotation = [MainMapAnnotation new];
            mapAnnotation.title = [NSString stringWithString:(NSString*)[[MainMapArray objectAtIndex:i] objectForKey:@"adress"]];
            mapAnnotation.subtitle = [NSString stringWithFormat:@"Примерное расстояние до банка: %.1f км",
                                        [self distanceBetweenCoordinates :[[[MainMapArray objectAtIndex:i] objectForKey:@"latitude"]floatValue] : [[[MainMapArray objectAtIndex:i] objectForKey:@"longitude"] floatValue]]] ;
            mapAnnotation.coordinate = location; 
            [mainMap addAnnotation:(id<MKAnnotation>)mapAnnotation];
        }        
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                                [NSArray arrayWithObjects:
                                                 @"Карта",
                                                 @"Спутник",
                                                 
                                                 nil]];
        
        [segmentedControl addTarget:self action:@selector(changeMainMapType:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.frame = CGRectMake(690.0f, 710.0f, 120.0f, 30.0f);
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        [self.view addSubview:segmentedControl];
        [segmentedControl release];

        
        UIView *gardientViewTop = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024 , 50)] autorelease];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = gardientViewTop.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor lightGrayColor] CGColor], nil];
        [gardientViewTop.layer insertSublayer:gradient atIndex:0];
        [self.view addSubview:gardientViewTop];
        [gardientViewTop release];
        
        searchMap = [[UISearchBar alloc] initWithFrame:CGRectMake (570, 0, 250, 50)];
        for (UIView *subview in searchMap.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [subview removeFromSuperview];
                break;
            }
        }
        searchMap.placeholder = @"Номер ВСП или название отделения";
        searchMap.delegate = self;
        [self.view addSubview:searchMap];
        [searchMap release];
        
        UILabel *showNearest = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 50)];
        [showNearest setText:@"Показать ближайшие:"];
        [showNearest setFont:[UIFont systemFontOfSize:LABELS_FONT_SIZE]];
        [showNearest setTextColor:[UIColor darkGrayColor]];
        [showNearest setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:showNearest];
        [showNearest release];
        
        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [allButton setFrame:CGRectMake(220, 10, 100, 30)];
        [allButton setTitle:@"Все" forState:UIControlStateNormal];
        [allButton setTintColor:[UIColor darkGrayColor]  ];
        [allButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal  ];
        [self.view addSubview:allButton];
        [allButton release];
        
        UIButton *detailWindow = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [detailWindow setFrame:CGRectMake(10, 60, 45, 45)];
        [detailWindow addTarget:self action:@selector(showDetailWindow) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:detailWindow];
        [detailWindow release];

        
        UIButton *eightyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [eightyButton setFrame:CGRectMake(325, 10, 110, 30)];
        [eightyButton setTitle:@"< 80% Цели" forState:UIControlStateNormal];
        [eightyButton setTintColor:[UIColor darkGrayColor]  ];
        [eightyButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal  ];
        [self.view addSubview:eightyButton];
        [eightyButton release];
        
        UIButton *oldActivity = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [oldActivity setFrame:CGRectMake(440, 10, 110, 30)];
        oldActivity.titleLabel.font = [UIFont systemFontOfSize:12];
        oldActivity.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        oldActivity.titleLabel.textAlignment = UITextAlignmentCenter;
        [oldActivity setTitle: @"Просроченные\n мероприятия" forState: UIControlStateNormal];
        [oldActivity setTintColor:[UIColor darkGrayColor]  ];
        [oldActivity setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal  ];
        [self.view addSubview:oldActivity];
        [oldActivity release];
        

	}
    return self;
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText 
{
    [mainSortArray removeAllObjects];
    
    if([searchText length] > 0) 
    {
        isTaskSearch = YES;
        [self searchToTable:searchText];
    }
    else 
    {
        isTaskSearch = NO;
    }
    
    [mainMap removeAnnotations:mainMap.annotations];
    
    for (int i=0; i < mainSortArray.count; i++) {
     
    location.longitude = [[[mainSortArray objectAtIndex:i] objectForKey:@"longitude"] floatValue];
    location.latitude = [[[mainSortArray objectAtIndex:i] objectForKey:@"latitude"] floatValue];
    
    mapAnnotation = [MainMapAnnotation new];
    mapAnnotation.title = [NSString stringWithString:(NSString*)[[mainSortArray objectAtIndex:i] objectForKey:@"adress"]];
    mapAnnotation.subtitle = [NSString stringWithFormat:@"Примерное расстояние до банка: %.1f км",
                              [self distanceBetweenCoordinates :[[[mainSortArray objectAtIndex:i] objectForKey:@"latitude"]floatValue] : [[[mainSortArray objectAtIndex:i] objectForKey:@"longitude"] floatValue]]] ;
    mapAnnotation.coordinate = location; 
    [mainMap addAnnotation:(id<MKAnnotation>)mapAnnotation];
        
        float left = 500, right = -1, up = 500, down = -1; //вспомогательные переменные для вычитания центральной точки
        
        for (NSDictionary *current in mainSortArray){
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
        
        [mainMap setRegion:MKCoordinateRegionMake(centerPoint, span)];
        
    }
    if([searchText isEqualToString:@""])  {
    
        for (int i=0; i < MainMapArray.count; i++) {
            
            location.longitude = [[[MainMapArray objectAtIndex:i] objectForKey:@"longitude"] floatValue];
            location.latitude = [[[MainMapArray objectAtIndex:i] objectForKey:@"latitude"] floatValue];
            
            mapAnnotation = [MainMapAnnotation new];
            mapAnnotation.title = [NSString stringWithString:(NSString*)[[MainMapArray objectAtIndex:i] objectForKey:@"adress"]];
            mapAnnotation.subtitle = [NSString stringWithFormat:@"Примерное расстояние до банка: %.1f км",
                                      [self distanceBetweenCoordinates :[[[MainMapArray objectAtIndex:i] objectForKey:@"latitude"]floatValue] : [[[MainMapArray objectAtIndex:i] objectForKey:@"longitude"] floatValue]]] ;
            mapAnnotation.coordinate = location; 
            [mainMap addAnnotation:(id<MKAnnotation>)mapAnnotation];
        }        
    
        float left = 500, right = -1, up = 500, down = -1; //вспомогательные переменные для вычитания центральной точки
        
        for (NSDictionary *current in MainMapArray){
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
        
        [mainMap setRegion:MKCoordinateRegionMake(centerPoint, span)];
    
    }
    
     
}


- (void) distanceFilter:(int)distanceValue 
{
    int distanceSlider = distanceValue;
    
    if (filteredDistanceArray == nil) {
        filteredDistanceArray = [[NSMutableArray alloc] init];
    }
    
    
    for (int i=0; i<MainMapArray.count; i++) {
        
        NSMutableDictionary *searchResults = [MainMapArray objectAtIndex:i];
        
        float distance = [self distanceBetweenCoordinates :[[searchResults objectForKey:@"latitude"]floatValue] : [[searchResults objectForKey:@"longitude"] floatValue]];

        
        if( distance <= distanceSlider)
        {
            [filteredDistanceArray addObject:[MainMapArray objectAtIndex:i]]; 
        }	
    }
     
    /*
    [mainMap removeAnnotations:mainMap.annotations]; 
    
    for (int i=0; i < filteredDistanceArray.count; i++) {
        
        location.longitude = [[[filteredDistanceArray objectAtIndex:i] objectForKey:@"longitude"] floatValue];
        location.latitude = [[[filteredDistanceArray objectAtIndex:i] objectForKey:@"latitude"] floatValue];
        
        mapAnnotation = [MainMapAnnotation new];
        mapAnnotation.title = [NSString stringWithString:(NSString*)[[filteredDistanceArray objectAtIndex:i] objectForKey:@"adress"]];
        mapAnnotation.subtitle = [NSString stringWithFormat:@"Примерное расстояние до банка: %.1f км",
                                  [self distanceBetweenCoordinates :[[[filteredDistanceArray objectAtIndex:i] objectForKey:@"latitude"]floatValue] : [[[filteredDistanceArray objectAtIndex:i] objectForKey:@"longitude"] floatValue]]] ;
        mapAnnotation.coordinate = location; 
        [mainMap addAnnotation:(id<MKAnnotation>)mapAnnotation];
    }        
    
    */
    
    float left = 500, right = -1, up = 500, down = -1; //вспомогательные переменные для вычитания центральной точки
    
    for (NSDictionary *current in filteredDistanceArray){
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
    
    [mainMap setRegion:MKCoordinateRegionMake(centerPoint, span) animated:YES];
    
        
}


- (void) openActivityEdit
{
    TaskActivity *activity = [[TaskActivity alloc] initWithFrame:CGRectMake(0, 0, 504, 678)];
    activity.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:activity animated:YES];
    [[activity.view superview] setFrame:CGRectMake(roundf([activity.view superview].center.x-252), roundf([activity.view superview].center.y-339), 504, 678)];
    [activity release];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar 
{
    [self searchToTable:theSearchBar.text];
    
}

- (void) searchToTable:(NSString*)sText 
{
    for(int index = 0;index<MainMapArray.count;index++)
    {
        NSMutableDictionary *searchResults = [MainMapArray objectAtIndex:index];
        
        NSRange searchName = [[searchResults objectForKey:@"adress"] rangeOfString:sText options:NSCaseInsensitiveSearch];
                
                if(searchName.length > 0 )
                {
                    [mainSortArray addObject:[MainMapArray objectAtIndex:index]];
                }

    }
}

- (double)distanceBetweenCoordinates: (CLLocationDegrees)latitude : (CLLocationDegrees)longitude
{
    CLLocation *to = [[[CLLocation alloc] initWithLatitude:myLocation.latitude longitude:myLocation.longitude] autorelease];
    
    CLLocation *from = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
    
    CLLocationDistance distance = [to distanceFromLocation:from];
    
    distance /=1000;

    return distance;
    
}

- (void)changeMainMapType:(UISegmentedControl*)sender {
    if (sender.selectedSegmentIndex == 0) {
        mainMap.mapType = MKMapTypeStandard;
    } else if (sender.selectedSegmentIndex == 1) {
        mainMap.mapType = MKMapTypeSatellite;
    } 
}

- (void) showDetailWindow
{
    DetailMapWindow *detailWindow = [[DetailMapWindow alloc] initWithFrame:CGRectMake(0, 0, 540 , 600)];
    [detailWindow setMainMapArray:MainMapArray];
    detailWindow.modalPresentationStyle = UIModalPresentationFormSheet;
    detailWindow.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:detailWindow animated:YES];
    [detailWindow release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    [mainMap setUserTrackingMode:MKUserTrackingModeFollow animated:YES];}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



- (void) dealloc
{
    [super dealloc];
    
    [mainMap release];
    [searchMap release];
    [MainMapArray release];
    [mainSortArray release];
    [mapAnnotation release];
    [mySecondAnnotation release];
    [myAnnotation release];
    [locationManager release];  
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




- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation 
{   
    if (annotation == mapView.userLocation) {
        return nil;
    }
    
    if ( mapAnnotation.title != nil ) {
        static NSString* customAnnotationIdentifier = @"customAnnotationIdentifier";
        MKAnnotationView* annotationView = (MKAnnotationView *)[mapView 
                                                                dequeueReusableAnnotationViewWithIdentifier:
                                                                customAnnotationIdentifier];
        
        if (!annotationView) {
            annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation 
                                                           reuseIdentifier:nil] autorelease];
            annotationView.image = [UIImage imageNamed:@"green-m.png"];
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
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
                annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
                
            }
        }
        
        return annotationView;
    }
}


@end
