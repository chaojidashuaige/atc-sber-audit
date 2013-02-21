//
//  CreateNewTaskController.m
//  SberbankAudit
//
//  Created by pnefedov on 22.11.12.
//
//

#import "CreateNewTaskController.h"
#import "ODMobileMBOSubbranchesGeoSynchronizationParameters.h"
#import "ODMobileMBOSubbranchesGeo.h"
#import "ODMobileMBOUnionsGeo.h"
#import "ODMobileMBOUnionsGeoSynchronizationParameters.h"
#import "ODMobileMBOObjectTypes.h"
#import "ODMobileMBO_getSubbranches.h"
#import "ODMobileODMobileDB.h"
#import "SUPApplication.h"
#import "ODMobileMBOTaskTypesPriv.h"
#import "ODMobileMBO_getTaskTypes.h"
#import "TaskTypeViewController.h"
#import "ODMobileMBO_getTasks.h"
#import "ODMobileOdObject.h"
#import "ODMobileObjField.h"
#import "ODMobileMBO_getTaskStatuses.h"
#import "ODMobileMBO_getTasks.h"
#import "SberbankAuditAppDelegate.h"
#import "RootViewController.h"
#import "DataViewController.h"

#define GEO @"GEO"
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#ifdef SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(6.0)
# define LINE_BREAK_MODE NSLineBreakByWordWrapping
#define ALIGN_CENTER NSTextAlignmentCenter
#else
# define LINE_BREAK_MODE UILineBreakModeWordWrap
#define ALIGN_CENTER UITextAlignmentCenter
#endif

#define TitleString @"Ваше текущее расположение: %@. Для проверки доступны подразделения:"

@interface CreateNewTaskController ()

@end

@implementation CreateNewTaskController
@synthesize selectedTaskTypeID;
@synthesize subbranchID;
@synthesize selectedObjectID;
@synthesize selectedObjectType;
@synthesize cancelAlert;

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
        
        [self.view setAutoresizesSubviews:NO];
        
        
//        largeLabel = [[UIImageView alloc] initWithFrame:CGRectMake(302, 309, 200, 60)];
//        [largeLabel setBackgroundColor:[UIColor whiteColor]];
//        largeLabel.alpha = 0.8;
////        [self.view addSubview:largeLabel];
//        
//        label = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 140, 60)];
//        [label setText:@"Синхронизация данных"];
//        [label setBackgroundColor:[UIColor clearColor]];
//        [label setTextAlignment:UITextAlignmentCenter];
////        [label setHidden:YES];
//        [largeLabel addSubview:label];
//
//        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        indicator.center = CGPointMake(25, 30);
////        [indicator setHidden:YES];
//        [largeLabel addSubview:indicator];
}
    
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.cancelAlert) {
        if (buttonIndex == 0) {
            [self cancelAction];
        }
    }
}

- (void) showAlert
{
    [self.cancelAlert show];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(62, 90, 680, 500)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0].CGColor;
    _tableView.layer.borderWidth = 1;
    _tableView.layer.cornerRadius = 5;
//    _tableView.layer.shadowColor = [UIColor blackColor].CGColor;
//    _tableView.layer.shadowOffset = CGSizeMake(0, 0);
//    _tableView.layer.shadowRadius = 10;
//    _tableView.layer.masksToBounds = YES;
    [self.view addSubview:_tableView];
    
    subbranchAdapterList = [[NSMutableArray alloc] init];
    taskTypeAdapterList = [[NSMutableArray alloc] init];
    
    cancelAlert = [[UIAlertView alloc] initWithTitle:@"Проверка руководства" message:@"Задача успешно создана" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];

    //эти методы вызывались раньше не из делегата
//    [self loadGeoData];
//    [self updateSubbranchesList];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UILabel *tmpTaskLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(40, 30, 724, 30)];
    self.taskLabel = tmpTaskLabel;
    [tmpTaskLabel release];
//    [self.taskLabel setText:@"Создание задачи \"Проверка руководства\""];
    [self.taskLabel setBackgroundColor:[UIColor clearColor]];
    [self.taskLabel setFont:[UIFont systemFontOfSize:20]];
    [self.taskLabel setTextAlignment:ALIGN_CENTER];
    self.taskLabel.numberOfLines = 0;
    self.taskLabel.lineBreakMode = LINE_BREAK_MODE;
    [self.view addSubview:self.taskLabel];
//    [self setFrameToLabel:self.taskLabel text:@"Создание задачи \"Проверка руководства\""];
    
    self.aCancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //        [aCancelButton setFrame:CGRectMake(190, 635, 120, 35)];
    [self.aCancelButton setFrame:CGRectMake(192+150, 620, 120, 35)];
    [self.aCancelButton setTitle:@"Отменить" forState:UIControlStateNormal];
    [self.aCancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    //        [self.view addSubview:aCancelButton];
    [self.view addSubview:self.aCancelButton];
}

- (void)setFrameToLabel:(UILabel *)label text:(NSString *)str font:(UIFont *)font
{
    label.text = str;
    CGSize size = [label.text sizeWithFont:font constrainedToSize:CGSizeMake(724.0f, MAXFLOAT) lineBreakMode:LINE_BREAK_MODE];
    label.frame = CGRectMake((self.view.frame.size.width - size.width)/2.0f, 20.0f, size.width, size.height);
}

- (void)cancelAction
{
    [locationManager stopUpdatingLocation];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocationFrom method called");
    if (!check) {
        locationCoord2D = [newLocation coordinate];

        CLGeocoder *geocoder = [[[CLGeocoder alloc] init] autorelease];
        [geocoder reverseGeocodeLocation:newLocation
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                           
                           if (error){
                               NSLog(@"Geocode failed with error: %@", error);
                               return;
                               
                           }
                           
                           if(placemarks && placemarks.count > 0)
                               
                           {
                               //do something
                               CLPlacemark *topResult = [placemarks objectAtIndex:0];
                               NSString *addressTxt = [NSString stringWithFormat:@"%@, %@ %@",
                                                       [topResult locality], [topResult thoroughfare], [topResult subThoroughfare]];
                               NSLog(@"%@",addressTxt);
                               NSString *resultAdress = [NSString stringWithFormat:TitleString, addressTxt];
                               [self setFrameToLabel:self.taskLabel text:resultAdress font:self.taskLabel.font];
                           }
                       }];
//        locationCoord2D.longitude = 37.579894;
//        locationCoord2D.latitude = 55.700009;
        
//        locationCoord2D.longitude = 37.585258;
//        locationCoord2D.latitude = 55.799014;

        if ([self syncGeoData]) {
            return;
        }
        [self updateSubbranchesList];
        [_tableView reloadData];
        check = TRUE;
        NSLog(@"this string should not be called one's more");
    }
//    locationCoord2D = [newLocation coordinate];
//    [self syncGeoData];
//    [self updateSubbranchesList];
//    [_tableView reloadData];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didUpdateLocations method called");
    if (!check) {
        locationCoord2D = [[locationManager location] coordinate];
        
        CLGeocoder *geocoder = [[[CLGeocoder alloc] init] autorelease];
        [geocoder reverseGeocodeLocation:manager.location
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                           
                           if (error){
                               NSLog(@"Geocode failed with error: %@", error);
                               return;
                               
                           }
                           
                           if(placemarks && placemarks.count > 0)
                               
                           {
                               //do something
                               CLPlacemark *topResult = [placemarks objectAtIndex:0];
                               NSString *addressTxt = [NSString stringWithFormat:@"%@, %@ %@",
                                                       [topResult locality], [topResult thoroughfare], [topResult subThoroughfare]];
                               NSLog(@"%@",addressTxt);
                               NSString *resultAdress = [NSString stringWithFormat:TitleString, addressTxt];
                               [self setFrameToLabel:self.taskLabel text:resultAdress font:self.taskLabel.font];
                           }
                       }];
//        locationCoord2D.longitude = 37.579894;
//        locationCoord2D.latitude = 55.700009;
        
        if ([self syncGeoData]) {
            return;
        }
        [self updateSubbranchesList];
        [_tableView reloadData];
        check = TRUE;
        NSLog(@"this string should not be called one's more");
    }
}

//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    NSLog(@"didUpdateLocations method called");
////    if (!check) {
////        [self loadGeoData];
////        [self updateSubbranchesList];
////        [_tableView reloadData];
////        check = TRUE;
////        NSLog(@"this string should not be called one's more");
////    }
//}

- (void)loadGeoData
{
    //необходимо записать кусок кода с получением GPS-координат
    //сперва я просто буду задавать эти координаты самостоятельно, чтобы можно было делать проверку с хранилищем данных по поиску подходящих задач
    
////    CLLocationManager * locationManager = [[CLLocationManager alloc] init];
////    locationManager.delegate = self;
////    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
////    locationManager.distanceFilter = kCLDistanceFilterNone;
////    [locationManager startUpdatingLocation];
////    
////    CLLocation * location = [locationManager location];
//    
//    locationCoord2D = [location coordinate];
//    locationCoord2D.longitude = 37.625299f;
//    locationCoord2D.latitude = 55.697869f;
    NSLog(@"longitude = %f, latitude = %f",locationCoord2D.longitude, locationCoord2D.latitude);
    if (locationCoord2D.latitude == 0.0f &&  locationCoord2D.longitude == 0.0f ) {
        NSLog(@"Device doesn't work");
    }
    [self syncGeoData];
}

- (BOOL)syncGeoData
{
    BOOL isSynchGeoError = NO;
    if (locationCoord2D.longitude == 0.0f && locationCoord2D.latitude == 0.0f) {
        isSynchGeoError = YES;
        return isSynchGeoError;
    }
//    NSString * LON_DELTA = @"0.08";
//    NSString * LAT_DELTA = @"0.045";
    NSString * LON_DELTA = @"0.07";
    NSString * LAT_DELTA = @"0.07";
//    NSString * LON_DELTA = @"0.020782";
//    NSString * LAT_DELTA = @"0.010858";
    
    ODMobileMBOSubbranchesGeoSynchronizationParameters * spGeoSubbranches = [ODMobileMBOSubbranchesGeo getSynchronizationParameters];
    [spGeoSubbranches delete];
//    NSLog(@"LONGITUDE %@",[NSString stringWithFormat:@"%.6f",locationCoord2D.longitude]);
//    NSLog(@"LATITUDE %@",[NSString stringWithFormat:@"%.6f",locationCoord2D.latitude]);
    spGeoSubbranches = [ODMobileMBOSubbranchesGeo getSynchronizationParameters];
    [spGeoSubbranches setLON:[NSString stringWithFormat:@"%f",locationCoord2D.longitude]];
    [spGeoSubbranches setLAT:[NSString stringWithFormat:@"%f",locationCoord2D.latitude]];
    [spGeoSubbranches setLON_DELTA:LON_DELTA];
    [spGeoSubbranches setLAT_DELTA:LAT_DELTA];
    [spGeoSubbranches save];
    
    ODMobileMBOUnionsGeoSynchronizationParameters * spGeoUnions = [ODMobileMBOUnionsGeo getSynchronizationParameters];
    [spGeoUnions delete];
    spGeoUnions = [ODMobileMBOUnionsGeo getSynchronizationParameters];
    [spGeoUnions setLON:[NSString stringWithFormat:@"%f",locationCoord2D.longitude]];
    [spGeoUnions setLAT:[NSString stringWithFormat:@"%f",locationCoord2D.latitude]];
    [spGeoUnions setLON_DELTA:LON_DELTA];
    [spGeoUnions setLAT_DELTA:LAT_DELTA];
    [spGeoUnions save];
    
    @try {
        [ODMobileODMobileDB synchronize:GEO];
        NSLog(@"CreateNewTaskController's message: Синхронизация прошла успешно");
    }
    @catch (SUPPersistenceException *exception) {
        isSynchGeoError = YES;
        
        NSLog(@"CreateNewTaskController's error: Ошибка синхронизации данных - %@, %@", exception.name,exception.message);
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка синхронизации" message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    return isSynchGeoError;
}

- (void)updateSubbranchesList
{
    SUPObjectList * subbranchGeo = [ODMobileMBOSubbranchesGeo findAll];
    SUPObjectList * unionsGeo = [ODMobileMBOUnionsGeo findAll];
    
    if (subbranchGeo.size == 0 && unionsGeo.size == 0) {
        NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"S", @"Подразделений не найдено", nil] forKeys:[NSArray arrayWithObjects:@"OBJECT_ID", @"OBJECT_TYPE", @"OBJECT_NAME", nil]];
        [subbranchAdapterList addObject:dict];
    } else {
        
        SUPObjectList * taskTypePrivs = [ODMobileMBOTaskTypesPriv findAll];
        NSMutableArray * allowedObjectTypeIds = [[NSMutableArray alloc] init];
        for (ODMobileMBOTaskTypesPriv * priv  in taskTypePrivs) {
            ODMobileMBO_getTaskTypes * taskType = [ODMobileMBO_getTaskTypes findByPrimaryKey:[NSString stringWithFormat:@"%@",[priv TASK_TYPE_ID]]];
            [allowedObjectTypeIds addObject:[NSString stringWithFormat:@"%@",[taskType OBJECT_TYPE_ID]]];
        }
        
        NSMutableArray * result = [[NSMutableArray alloc] init];
        
        for (ODMobileMBOSubbranchesGeo * subbranch in subbranchGeo) {
            ODMobileMBOObjectTypes * objectType = [ODMobileMBOObjectTypes getBySubbranchLevelId:[NSString stringWithFormat:@"%@",[subbranch SUBBRANCH_LEVEL_ID]]];
            for (NSString * str  in allowedObjectTypeIds) {
                if ([str isEqualToString:[NSString stringWithFormat:@"%@",[objectType OBJECT_TYPE_ID]]]) {
                    [result addObject:subbranch];
                }
            }
        }
        
        for (ODMobileMBOSubbranchesGeo * subbranch  in result) {
            NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[subbranch SUBBRANCH_ID]], @"S", [NSString stringWithFormat:@"%@",[subbranch SUBBRANCH_NAME]], nil]
                                                              forKeys:[NSArray arrayWithObjects:@"OBJECT_ID", @"OBJECT_TYPE", @"OBJECT_NAME", nil]];
            [subbranchAdapterList addObject:dict];
        }
        
        BOOL myBool= FALSE;
        
        SUPObjectList * taskTypePrivs2 = [ODMobileMBOTaskTypesPriv findAll];
        NSMutableArray * allowedObjectTypeIds2 = [[NSMutableArray alloc] init];
        for (ODMobileMBOTaskTypesPriv * priv  in taskTypePrivs2) {
            ODMobileMBO_getTaskTypes * taskType = [ODMobileMBO_getTaskTypes findByPrimaryKey:[NSString stringWithFormat:@"%@",[priv TASK_TYPE_ID]]];
            [allowedObjectTypeIds2 addObject:[NSString stringWithFormat:@"%@",[taskType OBJECT_TYPE_ID]]];
        }
        
        ODMobileMBOObjectTypes * type = [ODMobileMBOObjectTypes getByKey:@"OT_RM"];
        NSString * type_id = [NSString stringWithFormat:@"%@",[type OBJECT_TYPE_ID]];
        for (NSString * str in allowedObjectTypeIds2) {
            if ([str isEqualToString:type_id]) {
                myBool = TRUE;
            }
        }
        
        if (myBool) {
            for (ODMobileMBOUnionsGeo * _union in unionsGeo) {
                NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[_union UNION_ID]], @"U", [NSString stringWithFormat:@"%@",[_union UNION_NAME]], nil] forKeys:[NSArray arrayWithObjects:@"OBJECT_ID", @"OBJECT_TYPE", @"OBJECT_NAME", nil]];
                [subbranchAdapterList addObject:dict];
            }
        }
        
        NSMutableArray * sortArray = [[NSMutableArray alloc] init];
        for (NSDictionary * dict in subbranchAdapterList) {
            BOOL var = TRUE;
            for (NSDictionary * d in sortArray) {
                if ([[d valueForKey:@"OBJECT_ID"] isEqualToString:[dict valueForKey:@"OBJECT_ID"]]) {
                    var = FALSE;
                }
            }
            if (var) {
                [sortArray addObject:dict];
            }
        }
        
        [subbranchAdapterList release];
        subbranchAdapterList = [sortArray retain];
        
        [sortArray release];
        
        
        
        [result release];
        [allowedObjectTypeIds release];
        [allowedObjectTypeIds2 release];
    }

    [_tableView reloadData];
}


- (void)dealloc
{
    [_tableView release];
    [subbranchAdapterList release];
    [taskTypeAdapterList release];
    self.taskLabel = nil;
    self.aCancelButton = nil;
    self.cancelAlert = nil;
    [indicator release];
    [label release];
    [largeLabel release];
    [locationManager release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [subbranchAdapterList count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell;

    cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    

    cell.textLabel.text = [[subbranchAdapterList objectAtIndex:indexPath.row] objectForKey:@"OBJECT_NAME"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedObjectID = [[subbranchAdapterList objectAtIndex:indexPath.row] valueForKey:@"OBJECT_ID"];
    if ([self.selectedObjectID isEqualToString:@"0"]) {
        return ;
    }
    
    self.selectedObjectType = [[subbranchAdapterList objectAtIndex:indexPath.row] valueForKey:@"OBJECT_TYPE"];
    
    ODMobileMBOSubbranchesGeo * selectedSubbranch = nil;
    ODMobileMBOUnionsGeo * selectedUnion = nil;
    
    if ([selectedObjectType isEqualToString:@"S"]) {
        selectedSubbranch = [ODMobileMBOSubbranchesGeo findByPrimaryKey:selectedObjectID];
    }
    else {
        selectedUnion = [ODMobileMBOUnionsGeo findByPrimaryKey:selectedObjectID];
    }

    NSMutableArray * filteredTypes = [NSMutableArray arrayWithCapacity:0];
    SUPObjectList * taskTypes = [ODMobileMBOTaskTypesPriv findAll];
    
    if (selectedSubbranch != nil) {
        NSString * selectedObjectTypeID = [NSString stringWithFormat:@"%@",[[ODMobileMBOObjectTypes getBySubbranchLevelId:[NSString stringWithFormat:@"%@",[selectedSubbranch SUBBRANCH_LEVEL_ID]]] OBJECT_TYPE_ID]];
        for (ODMobileMBOTaskTypesPriv * taskTypePriv in taskTypes) {
            ODMobileMBO_getTaskTypes * taskType = [ODMobileMBO_getTaskTypes findByPrimaryKey:[NSString stringWithFormat:@"%@",[taskTypePriv TASK_TYPE_ID]]];
            if ([selectedObjectTypeID isEqualToString:[NSString stringWithFormat:@"%@",[taskType OBJECT_TYPE_ID]]]) {
                [filteredTypes addObject:taskTypePriv];
            }
        }
    } else if (selectedUnion != nil){
        ODMobileMBOObjectTypes * type = [ODMobileMBOObjectTypes getByKey:@"OT_RM"];
        NSString * selectedObjectTypeID = [NSString stringWithFormat:@"%@",[type OBJECT_TYPE_ID]];
        for (ODMobileMBOTaskTypesPriv * taskTypePriv in taskTypes) {
            ODMobileMBO_getTaskTypes * taskType = [ODMobileMBO_getTaskTypes findByPrimaryKey:[NSString stringWithFormat:@"%@",[taskTypePriv TASK_TYPE_ID]]];
            if ([selectedObjectTypeID isEqualToString:[NSString stringWithFormat:@"%@",[taskType OBJECT_TYPE_ID]]]) {
                [filteredTypes addObject:taskTypePriv];
            }
        }
    } else {
        NSLog(@"Ошибка при передаче типа задачи. Не найдено подразделение.");
    }
    
    if (filteredTypes.count == 0) {
        NSLog(@"Не найдено типов задач.");
        return ;
    } else if (filteredTypes.count == 1) {
        self.selectedTaskTypeID = [NSString stringWithFormat:@"%@",[[filteredTypes objectAtIndex:0] TASK_TYPE_ID]];
        [self createTask];
        [self dismissModalViewControllerAnimated:YES];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Задача успешно создана." message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    } else {
        for (ODMobileMBOTaskTypesPriv * typePriv in filteredTypes) {
            NSString * taskTypeID = [NSString stringWithFormat:@"%@",[typePriv TASK_TYPE_ID]];
            ODMobileMBO_getTaskTypes *taskType = [ODMobileMBO_getTaskTypes findByPrimaryKey:taskTypeID];
            if (taskType == nil) {
                return ;
            }
            NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[taskType TASK_TYPE_ID]],[NSString stringWithFormat:@"%@",[taskType TASK_TYPE_NAME]], nil] forKeys:[NSArray arrayWithObjects:@"TASK_TYPE_ID", @"TASK_TYPE_NAME", nil]];
            [taskTypeAdapterList addObject:dict];
        }
        
        NSLog(@"%@",taskTypeAdapterList);

        TaskTypeViewController * taskTypeController = [[TaskTypeViewController alloc] initWithFrame:_tableView.frame];
        taskTypeController.taskArray = taskTypeAdapterList;
        taskTypeController.parent = self;
//        taskTypeController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        taskTypeController.modalPresentationStyle = UIModalPresentationFormSheet;
        taskTypeController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:taskTypeController animated:YES];
        [self setFrameToLabel:self.taskLabel text:@"Выберите категорию проверки" font:self.taskLabel.font];
        [[taskTypeController.view superview] setFrame:CGRectMake(roundf([taskTypeController.view superview].center.x-190-150), roundf([taskTypeController.view superview].center.y-249), 680, 500)];
        [taskTypeController release];
    }
}

- (void)createTask
{
    [self.view setUserInteractionEnabled:NO];
    
    largeLabel = [[UIImageView alloc] initWithFrame:CGRectMake(252, 309-20, 300, 100)];
    [largeLabel setBackgroundColor:[UIColor lightGrayColor]];
    largeLabel.alpha = 0.8;
    [largeLabel.layer setCornerRadius:5];
    [self.view addSubview:largeLabel];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 240, 60)];
    [label setText:@"Синхронизация данных"];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:UITextAlignmentCenter];
    [largeLabel addSubview:label];
    
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.color = [UIColor blackColor];
    indicator.center = CGPointMake(25, 50);
    [indicator startAnimating];
    [largeLabel addSubview:indicator];

    

    NSLog(@"Creater task function called");
    
    @try {
        SUPObjectList * fieldList = [SUPObjectList new];
        ODMobileMBO_getTasks * Task = [ODMobileMBO_getTasks new];
        
        
        //TASK_ID
        ODMobileObjField * field1 = [ODMobileObjField new];
        [field1 setNm:@"TASK_ID"];
        [field1 setVl:@"0"];
        [fieldList add:field1];
        NSLog(@"name = %@, value =%@",field1.nm, field1.vl);
        [field1 release];
        
        
        //TASK_STATUS_ID
        ODMobileMBO_getTaskStatuses * assignStatus = [ODMobileMBO_getTaskStatuses getByKey:@"TST_ASSIGNED"];
        ODMobileObjField * field3 = [ODMobileObjField new];
        [field3 setNm:@"TASK_STATUS_ID"];
        [field3 setVl:[NSString stringWithFormat:@"%@",[assignStatus TASK_STATUS_ID]]];
        [fieldList add:field3];
        NSLog(@"name = %@, value =%@",field3.nm, field3.vl);
        [field3 release];
        
        
        //TASK_TYPE_ID
        ODMobileObjField * field2 = [ODMobileObjField new];
        [field2 setNm:@"TASK_TYPE_ID"];
        [field2 setVl:self.selectedTaskTypeID];
        [fieldList add:field2];
        NSLog(@"name = %@, value =%@",field2.nm, field2.vl);
        [field2 release];
        
        
        //CREATOR_EMPLOYEE_ID
        ODMobileObjField * field4 = [ODMobileObjField new];
        [field4 setNm:@"CREATOR_EMPLOYEE_ID"];
        [field4 setVl:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].EMPLOYEE_ID]];
        [fieldList add:field4];
        NSLog(@"name = %@, value =%@",field4.nm, field4.vl);
        [field4 release];
        
        //SUBBRANCH_ID OR UNION_ID
        if ([selectedObjectType isEqualToString:@"S"]) {
            ODMobileObjField * field5 = [ODMobileObjField new];
            [field5 setNm:@"SUBBRANCH_ID"];
            [field5 setVl:[NSString stringWithFormat:@"%@",self.selectedObjectID]];
            [fieldList add:field5];
            NSLog(@"name = %@, value =%@",field5.nm, field5.vl);
            [field5 release];
        }
        else {
            ODMobileObjField * field5 = [ODMobileObjField new];
            [field5 setNm:@"UNION_ID"];
            [field5 setVl:[NSString stringWithFormat:@"%@",self.selectedObjectID]];
            [fieldList add:field5];
            NSLog(@"name = %@, value =%@",field5.nm, field5.vl);
            [field5 release];
        }
        
        
        ODMobileMBO_getTaskTypes * taskType = [ODMobileMBO_getTaskTypes findByPrimaryKey:self.selectedTaskTypeID];
        NSDate * currentDate = [NSDate date];
        long long currentTime = [currentDate timeIntervalSince1970];
        currentTime = currentTime * 1000;
        long long taskDuration = [[NSString stringWithFormat:@"%@",[taskType TASK_DURATION]] longLongValue];
        taskDuration = taskDuration * 1000;
        long long planEndDttm = currentTime + taskDuration;
        NSNumber * numberCurrentTime = [NSNumber numberWithLongLong:currentTime];
        NSNumber * numberPlanEndDttm = [NSNumber numberWithLongLong:planEndDttm];
        
        
        //PLAN_START_DTTM
        ODMobileObjField * field6 = [ODMobileObjField new];
        [field6 setNm:@"PLAN_START_DTTM"];
        [field6 setVl:[NSString stringWithFormat:@"%@",numberCurrentTime]];
        [fieldList add:field6];
        NSLog(@"name = %@, value =%@",field6.nm, field6.vl);
        [field6 release];
        

        //PLAN_END_DTTM
        ODMobileObjField * field7 = [ODMobileObjField new];
        [field7 setNm:@"PLAN_END_DTTM"];
        [field7 setVl:[NSString stringWithFormat:@"%@",numberPlanEndDttm]];
        [fieldList add:field7];
        NSLog(@"name = %@, value =%@",field7.nm, field7.vl);
        [field7 release];
        
        
        //RESOURCE_EMPLOYEE_ID
        ODMobileObjField * field8 = [ODMobileObjField new];
        [field8 setNm:@"RESOURCE_EMPLOYEE_ID"];
        [field8 setVl:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].EMPLOYEE_ID]];
        [fieldList add:field8];
        NSLog(@"name = %@, value =%@",field8.nm, field8.vl);
        [field8 release];
        
        
        //USER_LOGIN
        ODMobileObjField * field9 = [ODMobileObjField new];
        [field9 setNm:@"USER_LOGIN"];
        [field9 setVl:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].newUserLogin]];
        [fieldList add:field9];
        NSLog(@"name = %@, value =%@",field9.nm, field9.vl);
        [field9 release];
        
        
        //CONNECTION_ID
        [[SUPApplication applicationSettings] connectionId];
        ODMobileObjField * field10 = [ODMobileObjField new];
        [field10 setNm:@"CONNECTION_ID"];
        [field10 setVl:[NSString stringWithFormat:@"%@",[[SUPApplication applicationSettings] connectionId]]];
        [fieldList add:field10];
        NSLog(@"name = %@, value =%@",field10.nm, field10.vl);
        [field10 release];

        
        //DEVICE_ID
        ODMobileObjField * field11 = [ODMobileObjField new];
        [field11 setNm:@"DEVICE_ID"];
        [field11 setVl:[NSString stringWithFormat:@"%@",[SberbankAuditAppDelegate instance].idName]];
        [fieldList add:field11];
        NSLog(@"name = %@, value =%@",field11.nm, field11.vl);
        [field11 release];
        
        
        //IP
        ODMobileObjField * field12 = [ODMobileObjField new];
        [field12 setNm:@"IP"];
        [field12 setVl:[SberbankAuditAppDelegate instance].IPAdress];
        [fieldList add:field12];
        NSLog(@"name = %@, value =%@",field12.nm, field12.vl);
        [field12 release];

        
        
        ODMobileOdObject * odObject = [ODMobileOdObject new];
        [odObject setFl:fieldList];
        [Task update:@"SUP_FCT_TASKS" withOdObject:odObject];
        [Task submitPending];
        
        [ODMobileODMobileDB synchronize:@"TasksSG"];
        [ODMobileODMobileDB synchronize:@"DIMSG"];
        [ODMobileODMobileDB synchronize:@"DIMSG_TASK_REL"];

        
        [fieldList release];
        
        NSLog(@"At-Consulting: Application is saved");
        
        [indicator stopAnimating];
        [largeLabel setHidden:YES];
        [self.view setUserInteractionEnabled:YES];
        [locationManager stopUpdatingLocation];
    }
    @catch (SUPPersistenceException *exception)
    {
        NSLog(@"At-Consulting: Save error: %@ - %@",exception.name,exception.message);
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка синхронизации" message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    [[SberbankAuditAppDelegate instance].rootViewController.mainDataVC updateData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    //    return UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
//    return (UIInterfaceOrientationLandscapeLeft || UIInterfaceOrientationLandscapeRight);
//}


@end
