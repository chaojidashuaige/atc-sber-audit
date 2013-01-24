//
//  MainMapView.h
//  SberbankAudit
//
//  Created by Артем Куликов on 31.05.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SberbankAuditAppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "MainMapAnnotation.h"
#import "MapMenuController.h"

@interface MainMapView : UIViewController <MyProtocolDelegate,MKMapViewDelegate, CLLocationManagerDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
{
    MKMapView * mainMap;
    NSMutableArray *MainMapArray;
    NSMutableArray *mainSortArray;
    CLLocationCoordinate2D location;
    MainMapAnnotation *mapAnnotation;
    MainMapAnnotation *mySecondAnnotation;
    MainMapAnnotation *myAnnotation;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D myLocation;
    UISearchBar *searchMap;
    BOOL isTaskSearch;
    NSMutableArray *filteredDistanceArray;
}

- (id) initWithFrame:(CGRect)frame;
- (void) searchToTable:(NSString*)sText;
- (void) showDetailWindow;
- (void) distanceFilter:(int)distanceValue;

@property (nonatomic, copy) NSString *placeholder;

@end
