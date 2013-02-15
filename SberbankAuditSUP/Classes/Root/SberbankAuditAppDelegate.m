
#import "SberbankAuditAppDelegate.h"
#import "RootViewController.h"
#import "DashboardVC.h"
#import "DataViewController.h"
#import "AuthVC.h"
#import "StackScrollViewController.h"
#import "WaitingViewController.h"
#import "UIViewWithShadow.h"
#import "MainMapView.h"
#import "MapViewController.h"
#import "SUPApplication.h"
#import "SUPConnectionProfile.h"
#import "ODMobileODMobileDB.h"
#import "ODMobileMBO_getTasks.h"
#import "ODMobileMBO_getSubbranches.h"
#import "ODMobileMBO_getChecklists.h"
#import "ODMobileMBO_getTasksSynchronizationParameters.h"
#import "ODMobileMBO_getActivities.h"
#import "ODMobileMBO_getActivitiesSynchronizationParameters.h"
#import "ODMobileMBO_getSubbranchesSynchronizationParameters.h"
#import "ODMobileMBOTaskTypesPriv.h"
#import "ODMobileMBOTaskTypesPrivSynchronizationParameters.h"
#import "ODMobileMBO_Logon.h"
#import "ODMobilePersonalizationParameters.h"
#import "ODMobileMBOCategoryPrivs.h"
#import "ODMobileMBOCategoryPrivsSynchronizationParameters.h"
#import "ODMobileMBOSubbranchesGeo.h"
#import "ODMobileMBOSubbranchesGeoSynchronizationParameters.h"
#import "ODMobileMBOUnions.h"
#import "ODMobileMBOUnionsSynchronizationParameters.h"
#import "ODMobileMBOProperties.h"
#import "ODMobileMBOTaskBlockMetrics.h"
#import "ODMobileMBOTaskBlockMetricsSynchronizationParameters.h"
#import "SUPConnectionProfile.h"

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

#define USERNAME            @"ODMobileUser"
#define PASSWORD            @"s3pUser"

//#define USERNAME            @"supAdmin"
//#define PASSWORD            @"s3pAdmin"
#define APPLICATION_ID      @"ODMobile"
#define REGISTER_TIMEOUT    100

#define SUP_FCT_TASKS               @"SUP_FCT_TASKS"
#define SUP_FCT_ACTIVITIES          @"SUP_FCT_ACTIVITIES"
#define SUP_FCT_TASK_BLOCK_METRICS  @"SUP_FCT_TASK_BLOCK_METRICS"

#define BASE_EXIST                  @"BASE_EXIST"

@implementation SberbankAuditAppDelegate

@synthesize window;
@synthesize rootViewController,mapViewController;
@synthesize mainSupApp;
@synthesize EMPLOYEE_ID;
@synthesize typeOfTasks;
@synthesize serverName;
@synthesize idName;
@synthesize userLogin;
@synthesize IPAdress;
@synthesize connectionID;
@synthesize currentTaskID;
@synthesize currentControlList;
@synthesize controlListHTML;
@synthesize finishTask;


//#define SERVER_NAME @"194.186.207.157"
#define SERVER_NAME @"skd-rel-pl.at-consulting.ru"
//#define SERVER_NAME @"skd-rel-tst.at-consulting.ru"
//#define SERVER_NAME @"skd-rel-dev.at-consulting.ru"
//#define SERVER_NAME @"91.241.12.145"
//#define SERVER_NAME @"192.168.32.110"


+ (SberbankAuditAppDelegate *) instance {
	return (SberbankAuditAppDelegate *) [[UIApplication sharedApplication] delegate];
}

+(BOOL)hasConnectivity {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    BOOL isReachabile = NO;
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // if target host is not reachable
                isReachabile = NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                isReachabile = YES;
            }
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    isReachabile = YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                isReachabile = YES;
            }
        }
        CFRelease(reachability);
    }
    
    return isReachabile;
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    authWindow = [[AuthVC alloc] init];
    self.window.rootViewController = authWindow;
    [self.window setBackgroundColor:[UIColor clearColor]];
    [self.window makeKeyAndVisible];

    
    self.idName = [[UIDevice currentDevice] uniqueIdentifier];
    self.serverName = SERVER_NAME;
    self.typeOfTasks = @"";
    self.IPAdress = [self GetOurIpAddress];
    self.connectionID = [NSString stringWithFormat:@"%@",[[SUPApplication applicationSettings] connectionId]];
    NSLog(@"IP adress: %@",self.IPAdress);
    
    return YES;
}

- (BOOL) internetConnectionCheck
{
    BOOL internetConnection = [SberbankAuditAppDelegate hasConnectivity];
    if (internetConnection) {
        NSLog(@"Internet connection exists");
    }
    else
    {
        UIAlertView * internetErrorAlert = [[UIAlertView alloc] initWithTitle:@"Недоступно сетевое подключение" message:@"Проверьте настройки" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
        [internetErrorAlert show];
        [internetErrorAlert release];
    }
    return internetConnection;
}

- (void)openActivityIndicatorViewWithName:(NSString *)name
{
    WaitingViewController * activityIndicator = [[[WaitingViewController alloc] init] autorelease];
    activityIndicator.label.text = name;
    activityIndicator.modalPresentationStyle = UIModalPresentationFormSheet;
    activityIndicator.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [[SberbankAuditAppDelegate instance].rootViewController presentModalViewController:activityIndicator animated:YES];
    [[activityIndicator.view superview] setFrame:CGRectMake(roundf([activityIndicator.view superview].center.x-200), roundf([activityIndicator.view superview].center.y-50), 400, 100)];
    
}


- (void) closeActivityIndicator
{
    [[SberbankAuditAppDelegate instance].rootViewController dismissModalViewControllerAnimated:YES];
}

- (NSString *)GetOurIpAddress
{
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;
    
    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0
                NSLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself
                
                if([name isEqualToString:@"en0"]) {
                    // Interface is the wifi connection on the iPhone
                    wifiAddress = addr;
                } else
                    if([name isEqualToString:@"pdp_ip0"]) {
                        // Interface is the cell connection on the iPhone
                        cellAddress = addr;
                    }
            }
            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSString *addr = wifiAddress ? wifiAddress : cellAddress;
    return addr ? addr : @"0.0.0.0";
}


- (void) openMainVC
{
    if(mapViewController != nil)
    {
        [mapViewController.view removeFromSuperview];
    }
    DashboardVC *dashboardWindow = [[DashboardVC alloc] init];
    self.window.rootViewController = dashboardWindow;
    [self.window setBackgroundColor:[UIColor clearColor]];
    [self.window makeKeyAndVisible];
    [dashboardWindow release];
 
}

- (void) openTasksVC:(NSMutableArray*)tasksArray openTask:(SupIsTemp_Task*)openTask
{
    rootViewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
    rootViewController.SBTasks = tasksArray;
    self.window.rootViewController = self.rootViewController;
	[self.window setBackgroundColor:[UIColor clearColor]];
    [self.window makeKeyAndVisible];
    [self.window setAutoresizesSubviews:YES];

}

- (void) openMapVC 
{   
    if(mapViewController == nil)
    {
        mapViewController = [[MapViewController alloc] init];
    }
    self.window.rootViewController = self.mapViewController;
//    [self.window addSubview:mapViewController.view];
	[self.window setBackgroundColor:[UIColor clearColor]];
    [self.window makeKeyAndVisible];
    [self.window setAutoresizesSubviews:YES];
}




- (void)registerApplication
{
//    [authWindow printTextForIndicatorView:@"Регистрация данных..."];
    
    [mainSupApp setApplicationCallback:self];
    SUPConnectionProperties *mainSupAppProperties = mainSupApp.connectionProperties;
    mainSupAppProperties.serverName = SERVER_NAME;
    mainSupAppProperties.portNumber = 80;
    [mainSupAppProperties setNetworkProtocol:@"http"];
    
    
    self.serverName = [NSString stringWithFormat:@"%@",mainSupAppProperties.serverName];
    
    SUPLoginCredentials *mainSupAppLoginData = [SUPLoginCredentials getInstance];
    mainSupAppLoginData.username = USERNAME;
    mainSupAppLoginData.password = PASSWORD;
    
    mainSupAppProperties.loginCredentials = mainSupAppLoginData;
    
    mainSupAppProperties.urlSuffix = @"/ias_relay_server/client/rs_client.dll/%cid%/tm";
    mainSupAppProperties.farmId = @"sigma.sbrf.msg";
    
    if([mainSupApp registrationStatus] != SUPRegistrationStatus_REGISTERED)
    {
        @try
        {
            NSLog(@"Старт регистрации");
            [mainSupApp registerApplication:60];
            NSLog(@"Приложение зарегистрировано");
        }
        @catch (SUPApplicationRuntimeException *appRegisterException)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [authWindow closeActivityIndicator];
                
                UIAlertView * runTimeAlert = [[UIAlertView alloc] initWithTitle:@"Ошибка подключения" message:@"Превышено время ожидания ответа от сервера" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
                [runTimeAlert show];
                [runTimeAlert release];
            });
            NSLog(@"Registration block - %@: %@",[appRegisterException name],[appRegisterException message]);
        }
    }
    else if([mainSupApp connectionStatus] != SUPConnectionStatus_CONNECTING)
    {
        @try
        {
            NSLog(@"Старт приложения");
            [mainSupApp startConnection:60];
            NSLog(@"Стартовало приложение");
        }
        @catch (SUPApplicationTimeoutException *appRegisterException)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [authWindow closeActivityIndicator];
                
                UIAlertView * runTimeAlert = [[UIAlertView alloc] initWithTitle:@"Ошибка подключения" message:@"Превышено время ожидания ответа от сервера" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
                [runTimeAlert show];
                [runTimeAlert release];
            });
            NSLog(@"Registration block - %@: %@",[appRegisterException name],[appRegisterException message]);
        }
    }
    
}



- (void)regApp
{
    NSLog(@"");
    @try
    {
        if([mainSupApp registrationStatus] != SUPRegistrationStatus_REGISTERED)
        {
            [mainSupApp registerApplication:100];
            NSLog(@"Приложение зарегистрировано");
        }
        else
        {
            [mainSupApp startConnection:100];
            NSLog(@"Старт приложения");
        }
    }
    @catch (SUPApplicationTimeoutException *appRegisterException)
    {
        NSLog(@"Registration block - %@: %@",[appRegisterException name],[appRegisterException message]);
    }
}

- (void)createDB
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * check = [defaults objectForKey:BASE_EXIST];

    if(![check isEqualToString:@"TRUE"])
    {
        @try
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [authWindow printTextForIndicatorView:@"Создание новой БД..."];
            });

            [ODMobileODMobileDB createDatabase];

            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:@"TRUE" forKey:BASE_EXIST];

            
            NSLog(@"At-Consulting DevLog: DB recreated successfully");
        }
        @catch (NSException *exception)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [authWindow closeActivityIndicator];
            });
            NSLog(@"At-Consulting DevLog: %@ - %@",exception.name,exception.description);
        }
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [authWindow printTextForIndicatorView:@"Подключение к БД..."];
        });

        if (![self.newUserLogin isEqualToString:self.userLogin]) {
            @try
            {
                [ODMobileODMobileDB cleanAllData:FALSE];
                
                NSLog(@"At-Consulting DevLog: DB cleaned successfully");
            }
            @catch (NSException *exception)
            {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [authWindow closeActivityIndicator];
                });
                NSLog(@"At-Consulting DevLog: DB creation error: %@ - %@",exception.name,exception.description);
            }
        }
        else {
            NSLog(@"At-Consulting DevLog: DB reopened");
        }
    }
}

- (BOOL)setPropertiesWithLogin:(NSString *)login andPassword:(NSString *)password
{
    [ODMobileODMobileDB setApplication:mainSupApp];
//    NSLog(@"app id = %@",mainSupApp.applicationIdentifier);
    
    SUPConnectionProfile *dbConnectionProfile = [ODMobileODMobileDB getSynchronizationProfile];
    [dbConnectionProfile setUser:USERNAME];
    [dbConnectionProfile setPassword:PASSWORD];
    [dbConnectionProfile setAsyncReplay:NO];  //If you want to do asynchronous replay ,you can set to YES.
    [dbConnectionProfile setServerName:SERVER_NAME];
    [dbConnectionProfile setNetworkProtocol:@"http"];
    [dbConnectionProfile setPortNumber:80];
    [dbConnectionProfile setNetworkStreamParams:@"compression=zlib;url_suffix=/ias_relay_server/client/rs_client.dll/sigma.sbrf.rep"];
    
    
    
    ODMobilePersonalizationParameters *dbPersonalizationParam = [ODMobileODMobileDB getPersonalizationParameters];

//    NSString * didPK = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString * didPK = [[UIDevice currentDevice] uniqueIdentifier];
//    NSLog(@"%@",didPK);
    NSMutableString * did = [NSMutableString stringWithCapacity:0];
    [did appendString:didPK];
    [did appendString:@";"];
    [did appendString:[NSString stringWithFormat:@"%@",[[SUPApplication applicationSettings] connectionId]]];
    [did appendString:@";"];
    [did appendString:self.IPAdress];//pдесь надо будет вставить IP адрес
    
//    NSLog(@"did = %@",did);
    
//    NSLog(@"LoginName: %@",login);
    
    NSLog(@"login = %@, retaintCount = %i",login,login.retainCount);
    NSLog(@"pass = %@, retaintCount = %i",password,password.retainCount);

    NSMutableString * loginText = [NSMutableString stringWithString:login];
    NSString * encryptedLogin = [self encodingWithString:loginText];
    NSData * dataLogin = [encryptedLogin dataUsingEncoding:NSUTF8StringEncoding];
    login = [NSString stringWithFormat:@"%@", [dataLogin base64Encoding]];
//    login = [[dataLogin base64Encoding] copy];

    NSMutableString * passwordText = [NSMutableString stringWithString:password];
    NSString * encryptedPassword = [self encodingWithString:passwordText];
    NSData * dataPassword = [encryptedPassword dataUsingEncoding:NSUTF8StringEncoding];
    password = [NSString stringWithFormat:@"%@", [dataPassword base64Encoding]];
//    password = [[dataPassword base64Encoding] copy];

    
    NSLog(@"login = %@, retaintCount = %i",login,login.retainCount);
    NSLog(@"pass = %@, retaintCount = %i",password,password.retainCount);

    
//    [dbPersonalizationParam setDidPK:didPK];
    [dbPersonalizationParam setDidPK:did];
    [dbPersonalizationParam setUserLoginPK:login];
    [dbPersonalizationParam setUserPasswordPK:password];
    [dbPersonalizationParam save];
    
    NSLog(@"setPropertiesWithLogin method end.");
    
    return TRUE;
}

- (BOOL)userLogonWithLogin:(NSString*)login andPassword:(NSString*)password
{
    BOOL var = TRUE;
    @try
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [authWindow printTextForIndicatorView:@"Синхронизация данных..."];
        });
        
        NSLog(@"Старт синхронизации LogonSG");
        
        [ODMobileODMobileDB synchronize:@"LogonSG"];//LOGON - синхронизация

        NSLog(@"At-Consulting DevLog: Syncronize was successfull");
    }
    @catch (SUPPersistenceException *exception)
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [authWindow closeActivityIndicator];
        });
        
        NSLog(@"At-Consulting DevLog: synchronize error: %@ - %@",exception.name,exception.message);
        var = FALSE;
    }
    return var;
}

- (void) dataForDashboardWithObjectName:(NSString *)objectName
{
    ODMobileMBO_LogonList * resource = [ODMobileMBO_Logon findAll];
    
    EMPLOYEE_ID = [[resource objectAtIndex:0] valueForKey:@"logonReturn"];
    
    NSMutableString * emp = [[NSMutableString alloc] initWithString:[[resource objectAtIndex:0] valueForKey:@"logonReturn"]];
    NSString * str = @";";
    NSRange substr = [emp rangeOfString:str];
    NSLog(@"Index = %i, length = %i",substr.location, substr.length);
    if (substr.location != 0) {
        EMPLOYEE_ID = [emp substringToIndex:substr.location];
    }

    [emp release];
    
    ODMobileMBO_getTasksSynchronizationParameters * sp = [ODMobileMBO_getTasks getSynchronizationParameters];
    [sp delete];
    sp = [ODMobileMBO_getTasks getSynchronizationParameters];
    [sp setEMPLOYEE_ID:[NSString stringWithFormat:@"%@",EMPLOYEE_ID]];
    [sp setOBJECT_NAME:[NSString stringWithFormat:@"%@;%@",SUP_FCT_TASKS, objectName]];
//    [sp setResourceSync:EMPLOYEE_ID];
    [sp save];
    
    ODMobileMBO_getActivitiesSynchronizationParameters * ac = [ODMobileMBO_getActivities getSynchronizationParameters];
    [ac delete];
    ac = [ODMobileMBO_getActivities getSynchronizationParameters];
    [ac setEMPLOYEE_ID:[NSString stringWithFormat:@"%@",EMPLOYEE_ID]];
    [ac setOBJECT_NAME:[NSString stringWithFormat:@"%@;%@",SUP_FCT_ACTIVITIES, objectName]];
//    [ac setResourceSync:EMPLOYEE_ID];
    [ac save];
    
    ODMobileMBO_getSubbranchesSynchronizationParameters * subBr = [ODMobileMBO_getSubbranches getSynchronizationParameters];
    [subBr delete];
    subBr = [ODMobileMBO_getSubbranches getSynchronizationParameters];
    [subBr setRESOURCE_EMPLOYEE_ID:EMPLOYEE_ID];
    [subBr save];
    
    ODMobileMBOTaskTypesPrivSynchronizationParameters * taskTypes = [ODMobileMBOTaskTypesPriv getSynchronizationParameters];
    [taskTypes delete];
    taskTypes = [ODMobileMBOTaskTypesPriv getSynchronizationParameters];
    [taskTypes setEmloyeeId:EMPLOYEE_ID];
    [taskTypes save];
    
    ODMobileMBOCategoryPrivsSynchronizationParameters * catPrivs = [ODMobileMBOCategoryPrivs getSynchronizationParameters];
    [catPrivs delete];
    catPrivs = [ODMobileMBOCategoryPrivs getSynchronizationParameters];
    [catPrivs setEmployeeId:EMPLOYEE_ID];
    [catPrivs save];
    
    ODMobileMBOUnionsSynchronizationParameters * unionsSP = [ODMobileMBOUnions getSynchronizationParameters];
    [unionsSP delete];
    unionsSP = [ODMobileMBOUnions getSynchronizationParameters];
    [unionsSP setRESOURCE_EMPLOYEE_ID:EMPLOYEE_ID];
    [unionsSP save];
    
    ODMobileMBOTaskBlockMetricsSynchronizationParameters * spTaskBlock = [ODMobileMBOTaskBlockMetrics getSynchronizationParameters];
    [spTaskBlock delete];
    spTaskBlock = [ODMobileMBOTaskBlockMetrics getSynchronizationParameters];
    [spTaskBlock setEMPLOYEE_ID:[NSString stringWithFormat:@"%@",EMPLOYEE_ID]];
    [spTaskBlock setOBJECT_NAME:[NSString stringWithFormat:@"%@;%@",SUP_FCT_TASK_BLOCK_METRICS, objectName]];
//    [spTaskBlock setRESOURCE_EMPLOYEE_ID:EMPLOYEE_ID];
    [spTaskBlock save];
    

    @try
    {
        NSLog(@"TaskSG sync started");
        [authWindow printTextForIndicatorView:@"Синхронизация 1/3..."];
        
        [ODMobileODMobileDB synchronize:@"TasksSG"];
        NSLog(@"TaskSG sync finished");
        NSLog(@"DIMSG sync started");
        [authWindow printTextForIndicatorView:@"Синхронизация 2/3..."];
        
        [ODMobileODMobileDB synchronize:@"DIMSG"];

        NSLog(@"DIMSG sync finished");
        NSLog(@"DIMSG_TASK_REL sync started");
        [authWindow printTextForIndicatorView:@"Синхронизация 3/3..."];
        
        [ODMobileODMobileDB synchronize:@"DIMSG_TASK_REL"];
        
        NSLog(@"DIMSG_TASK_REL sync finished");

        NSLog(@"SberbankAuditAppDelegate: синхронизация по группам прошла");
    }
    @catch (SUPPersistenceException *exception)
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [authWindow closeActivityIndicator];
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка синхронизации по группам" message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        });
        NSLog(@"At-Consulting DevLog: synchronize error: %@ - %@",exception.name,exception.message);
    }
}


- (void)validateAppProperties
{
    @try {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [authWindow printTextForIndicatorView:@"Проверка версии..."];
        });

        
        [ODMobileODMobileDB synchronize:@"PROPERTIES"];
        NSLog(@"asda");
        
        SUPObjectList * allProperties = [ODMobileMBOProperties findAll];
        ODMobileMBOProperties * properties = [allProperties getObject:0];
        NSString * rawProps = [properties PROPERTIES];
        NSLog(@"%@",rawProps);
        
        if ([rawProps isEqualToString:@""] || rawProps == nil) {
            NSLog(@"Не удалось получить настройки приложения");
        }

        
        
        //новый способ
        NSString * separator = @"\";";
        NSString * iosVersion = @"odmobile.ios.app.version=\"";
        NSRange IOSRangeVersion = [rawProps rangeOfString:iosVersion];
        NSString * iosString = [rawProps substringFromIndex:IOSRangeVersion.location + IOSRangeVersion.length];
        NSRange separatorRange = [iosString rangeOfString:separator];
        NSString * numberOfVersion = [iosString substringToIndex:separatorRange.location];
        NSLog(@"%@",iosString);
        NSLog(@"%@",numberOfVersion);
        
//        NSError *error = NULL;
//        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"((\\d)+(\\.){1})+(\\d)+"
//                                                                               options:NSRegularExpressionCaseInsensitive
//                                                                                 error:&error];
//        NSArray * matches = [regex matchesInString:rawProps options:0 range:NSMakeRange(0, [rawProps length])];
//        NSRange androidRange;
//        androidRange = [[matches objectAtIndex:0] range];
//        NSRange iOSRange;
//        iOSRange = [[matches objectAtIndex:[matches count]-1] range];
//        for (NSTextCheckingResult *match in matches) {
//            NSRange matchRange = [match range];
//            NSLog(@"origin = %i, length = %i",matchRange.location, matchRange.length);
//        }
//        NSString * odmobile_android_app_version = [rawProps substringWithRange:androidRange];
//        self.odmobile_ios_app_version = [rawProps substringWithRange:iOSRange];

        self.odmobile_ios_app_version = numberOfVersion;
        
        NSRange falseRange = [rawProps rangeOfString:@"FALSE"];
        self.odmobile_version_unchecked = (falseRange.length == 0) ? @"TRUE" : @"FALSE";
        
//        NSLog(@"odmobile_android_app_version: %@",odmobile_android_app_version);
        NSLog(@"odmobile_ios_app_version: %@",self.odmobile_ios_app_version);
        NSLog(@"odmobile_version_unchecked: %@",self.odmobile_version_unchecked);
    }
    @catch (SUPPersistenceException *exception)
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [authWindow closeActivityIndicator];
            NSLog(@"At-Consulting DevLog: Property synchronize error: %@ - %@",exception.name,exception.message);
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка синхронизации" message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        });
    }
}

- (BOOL)isValidMobileVersion
{
    if ([self.odmobile_version_unchecked isEqualToString:@"TRUE"]) {
        return TRUE;
    }
    NSString * fileName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSMutableArray * ios_app_Array = [NSMutableArray arrayWithArray:[self.odmobile_ios_app_version componentsSeparatedByString:@"."]];
    NSMutableArray * fileNameArray = [NSMutableArray arrayWithArray:[fileName componentsSeparatedByString:@"."]];
    NSLog(@"ios_array = %@",ios_app_Array);
    NSLog(@"fileNamearray = %@",fileNameArray);
    int iosCount = [ios_app_Array count];
    int fileNameCount = [fileNameArray count];
    NSLog(@"Before adding elements: ios = %i, file = %i",ios_app_Array.count, fileNameArray.count);
    if (iosCount < fileNameCount) {
        for (int i = 0; i < (fileNameCount - iosCount); i++) {
            [ios_app_Array addObject:@"0"];
        }
    }
    if (iosCount > fileNameCount) {
        for (int i = 0; i < (iosCount - fileNameCount); i++) {
            [fileNameArray addObject:@"0"];
        }
    }
    NSLog(@"After adding elements: ios = %i, file = %i",ios_app_Array.count, fileNameArray.count);
    for (int i = 0; i < ios_app_Array.count; i++) {
        if ([[fileNameArray objectAtIndex:i] integerValue] > [[ios_app_Array objectAtIndex:i] integerValue]) {
            return TRUE;
        }
        if ([[fileNameArray objectAtIndex:i] integerValue] < [[ios_app_Array objectAtIndex:i] integerValue]) {
            return FALSE;
        }
    }
    return TRUE;
}


- (NSString *)encodingWithString:(NSString *)string
{
    NSArray * FROM_CHARS = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    int SHIFT = 11;
    int count = FROM_CHARS.count;
    NSMutableArray * TO_CHARS = [[NSMutableArray alloc] init];
    for (int index = 0; index < count; index++) {
        int position = index + SHIFT;
        if ( index + SHIFT >= count) {
            position = index + SHIFT - count;
        }
        [TO_CHARS addObject:[FROM_CHARS objectAtIndex:position]];
    }
    
    NSMutableArray * newArray = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < string.length; i++) {
        [newArray addObject:[string substringWithRange:NSMakeRange(i, 1)]];
//        NSLog(@"%@",[newArray objectAtIndex:i]);
    }
    
    NSMutableArray * encryptedArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < newArray.count; i++) {
        BOOL check = TRUE;
        for (int j = 0; j < count; j++) {
            if ([[newArray objectAtIndex:i] isEqualToString:[FROM_CHARS objectAtIndex:j]]) {
                [encryptedArray addObject:[TO_CHARS objectAtIndex:j]];
                check = FALSE;
            }
        }
        if (check) {
            [encryptedArray addObject:[newArray objectAtIndex:i]];
        }
    }
    
    NSMutableString * result = [[[NSMutableString alloc] init] autorelease];
    
    for (NSString * c in encryptedArray) {
        [result appendString:c];
    }
    
    
    [encryptedArray release];
    [newArray release];
    [TO_CHARS release];
    [FROM_CHARS release];
    return result;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


//- (void)applicationWillTerminate:(UIApplication *)application {
//    
//    [[SUPApplication getInstance] stopConnection:10];
//    /*
//     Called when the application is about to terminate.
//     See also applicationDidEnterBackground:.
//     */
//}

- (void) applicationDidEnterBackground:(UIApplication *)application
{
    
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
 с    */
}


//- (void)dealloc {
//    [authWindow release];
//    [rootViewController release];
//    [mapViewController release];
//    [self.window release];
//    [self.typeOfTasks release];
//    [self.IPAdress release];
//    [super dealloc];
//}

#pragma mark - SUPApplicationCallback
- (void)onDeviceConditionChanged:(SUPDeviceConditionType)condition
{
}
- (void)onApplicationSettingsChanged:(SUPStringList *)names
{
}
- (void)onHttpCommunicationError:(int32_t)errorCode :(NSString *)errorMessage :(SUPStringProperties *)responseHeaders
{
}
- (void)onRegistrationStatusChanged:(SUPRegistrationStatusType)registrationStatus :(int32_t)errorCode :(NSString *)errorMessage
{
}
- (void)onConnectionStatusChanged:(SUPConnectionStatusType)connectionStatus :(int32_t)errorCode :(NSString *)errorMessage
{
}
- (BOOL)onHttpsCertificateChallenge:(NSString*)certInfo
{
    return NO;
}

@end
