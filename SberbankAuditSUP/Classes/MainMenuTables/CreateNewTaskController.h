//
//  CreateNewTaskController.h
//  SberbankAudit
//
//  Created by pnefedov on 22.11.12.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface CreateNewTaskController : UIViewController<UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
{
    UITableView * _tableView;
    CLLocationCoordinate2D locationCoord2D;
    CLLocationManager * locationManager;
    NSMutableArray * subbranchAdapterList;
    NSMutableArray * taskTypeAdapterList;
    BOOL check;
    UIActivityIndicatorView * indicator;
    UILabel * label;
    UIImageView * largeLabel;
}

- (id)initWithFrame:(CGRect)frame;
- (void)cancelAction;
- (void)loadGeoData;
- (void)syncGeoData;
- (void)updateSubbranchesList;
- (void)createTask;
- (void)showAlert;

@property (nonatomic,retain) NSString * selectedTaskTypeID;
@property (nonatomic,retain) NSString * subbranchID;
@property (nonatomic,retain) NSString * selectedObjectID;
@property (nonatomic,retain) NSString * selectedObjectType;
@property (nonatomic,retain) UILabel * taskLabel;
@property (nonatomic,retain) UIButton *aCancelButton;
@property (nonatomic,retain) UIAlertView * cancelAlert;

@end
