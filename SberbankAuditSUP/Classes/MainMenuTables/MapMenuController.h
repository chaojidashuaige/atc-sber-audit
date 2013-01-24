//
//  MapMenuController.h
//  SberbankAudit
//
//  Created by Артем Куликов on 01.06.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuFooterTable;
@class DataViewController;
@class MainMapView;

@protocol MyProtocolDelegate<NSObject>

@required

- (void) distanceFilter:(int)distanceValue;

@end

@interface MapMenuController : UIViewController  <UITableViewDelegate, UITableViewDataSource>
{
    MenuFooterTable *footerMenu;
    DataViewController *taskVC;
    UIButton *CLSaveButton;
    UITableView *categoryTable;
    NSMutableArray *category;
    UISlider *procentTask;
    UISlider *procentActivity;
    UILabel *labelTask;
    UILabel *labelActivity;
    UISlider *distanceMap;
    UILabel *labelDistance;
    int taskSliderValue;
    int acivitySliderValue;
    int distanceValue;
    id <MyProtocolDelegate> delegate;
}


@property (nonatomic, retain) DataViewController *taskMenu;
@property (nonatomic, retain) UITableView *categoryTable;
@property (nonatomic, retain) NSMutableArray *category;
@property(nonatomic, retain) UIColor *thumbTintColor;
@property(nonatomic, retain) UIColor *maximumTrackTintColor;
@property(nonatomic, retain) UIColor *minimumTrackTintColor;
@property (nonatomic, assign)id <MyProtocolDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

@end
