//
//  GembaSheet.h
//  SberbankAudit
//
//  Created by Artem Koulikov on 29.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DataViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GembaSheetAnnotation.h"

@interface GembaSheet : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>

{
    CLLocationManager *locationManager;
    UILabel *gembaLongitude;
    UILabel *gembaLatitude;
    MKMapView *map;
    DataViewController *invokeVC;
    NSMutableArray *GembaSheetArray;
    UITableView *GembaSheetTable;
    CLLocationCoordinate2D location;
    CLLocationCoordinate2D myLocation;
    GembaSheetAnnotation *sheetAnnotation;
    GembaSheetAnnotation *mySecondAnnotation;
    GembaSheetAnnotation *myAnnotation;
}

@property (nonatomic,retain) MKMapView *map;
@property (nonatomic, retain) UITableView *GembaSheetTable;

- (id)initWithFrame:(CGRect)frame;
- (void) closeGemba;
- (double)distanceBetweenCoordinates:(CLLocationDegrees)latitude :(CLLocationDegrees)longitude;

@end
