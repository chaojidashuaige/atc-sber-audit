//
//  DetailMapWindow.h
//  SberbankAudit
//
//  Created by Артем Куликов on 09.06.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMapView.h"


@interface DetailMapWindow : UIViewController <UITableViewDelegate, UITableViewDataSource>

{
    UITableView *detailMapTable;
    NSMutableArray *distanceLeastThree;
    NSMutableArray *distanceLeastFive;
    NSMutableArray *distanceMoreTen;
    CLLocationCoordinate2D myLocation;
    NSMutableDictionary *allObjects;
}

@property (nonatomic, retain) UITableView *detailMapTable;
@property (nonatomic, retain) NSMutableArray *MainMapArray;
@property (nonatomic, retain) NSMutableDictionary *allObjects;

- (NSArray*)curentObjects:(NSInteger)index;
- (id)initWithFrame:(CGRect)frame;
- (void) closeWindow;
- (void) filterDistance;


@end
