//
//  AuthVC.m
//  SberbankAudit
//
//  Created by Артем Куликов on 11.04.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "AuthVC.h"
#import "SberbankAuditAppDelegate.h"
#import "PropertiesViewController.h"
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
#import "ODMobileMBOEmployeesSubordinations.h"
#import "WaitingViewController.h"

//#define USERNAME            @"supAdmin"
//#define PASSWORD            @"s3pAdmin"
#define APPLICATION_ID      @"ODMobile"
#define REGISTER_TIMEOUT    100


#define LOGIN_TEXT        @"LOGIN_TEXT"
#define PASSWORD_TEXT     @"PASSWORD_TEXT"  

@interface AuthVC ()

@end

@implementation AuthVC
@synthesize _login;
@synthesize _password;
//@synthesize userLogin = userLogin;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    if (self = [super init])
	{
        
        //add backgroundview image
        
        backgroundView = [[UIImageView alloc] init];
        [self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:0.0];
        [self.view addSubview:backgroundView];
        
        //add text fields
        
        userLogin = [[UITextField alloc] init];
        userLogin.placeholder = @"Имя пользователя";
//        userLogin.text = @"a_petrov";
//        userLogin.text = @"v_avdeev";
//        userLogin.text = @"a_gromov";
//        userLogin.text = @"v_komov";
//        userLogin.text = @"SimakovDB_8606";
//        userLogin.text = @"RybochkinaTS_2621@srb.sbrf.ru";
//        userLogin.text = @"KoninDA_8606@srb.sbrf.ru";
//        userLogin.text = @"Dolgov-MM";
//        userLogin.text = @"Arkhipova-TA";
//        userLogin.text = @"Chuvikina-AS";
//        userLogin.text = @"Kiverova-VA";
//        userLogin.text = @"e_larionova";
//        userLogin.text = @"Gusatnikov-SA";
//        userLogin.text = @"Pisarenko-AB";
//        userLogin.text = @"Azovtsev-VA";
//        userLogin.text = @"Shvedova-AA";
//        userLogin.text = @"Zavalko-AN";
//        userLogin.text = @"Ryabova-NA";
//        userLogin.text = @"Pisarev-AN";
//        userLogin.text = @"BARABOSHINA-VV";
//        userLogin.text = @"HotinKA_2650";
//        userLogin.text = @"LunyakovaNS_2621";

        [userLogin setBorderStyle:UITextBorderStyleRoundedRect];
        [userLogin setTextAlignment:UITextAlignmentCenter];
        [userLogin addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self.view addSubview:userLogin];
        
        userPassword = [[UITextField alloc] init];
        userPassword.placeholder = @"Пароль";
//        userPassword.text = @"q";
//        userPassword.text = @"123456";
//        userPassword.text = @"a_gromov";
//        userPassword.text = @"1q2w3e4r";//a_gromov
//        userPassword.text = @"1q2w3e4r5t";//v_avdeev
//        userPassword.text = @"a_petrov";
//        userPassword.text = @"v_avdeev";
//        userPassword.text = @"asdf1234";
//        userPassword.text = @"v_komov";
//        userPassword.text = @"SimakovDB_8606";
//        userPassword.text = @"RybochkinaTS_2621@srb.sbrf.ru";
//        userPassword.text = @"KoninDA_8606@srb.sbrf.ru";
//        userPassword.text = @"Dolgov-MM";
//        userPassword.text = @"Kiverova-VA";
//        userPassword.text = @"e_larionova";
//        userPassword.text = @"Gusatnikov-SA";
//        userPassword.text = @"Arkhipova-TA";
//        userPassword.text = @"Chuvikina-AS";
//        userPassword.text = @"Azovtsev-VA";
//        userPassword.text = @"Shvedova-AA";
//        userPassword.text = @"Zavalko-AN";
//        userPassword.text = @"Pisarenko-AB";
//        userPassword.text = @"Ryabova-NA";
//        userPassword.text = @"Pisarev-AN";
//        userPassword.text = @"BARABOSHINA-VV";
//        userPassword.text = @"HotinKA_2650";
//        userPassword.text = @"LunyakovaNS_2621";

        userPassword.secureTextEntry = YES;
        [userPassword setBorderStyle:UITextBorderStyleRoundedRect];
        [userPassword setTextAlignment:UITextAlignmentCenter];
        [userPassword addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self.view addSubview:userPassword];
        
        getLogon = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [getLogon setTitle:@"Войти" forState:UIControlStateNormal];
        [getLogon addTarget:self action:@selector(sendAuth) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:getLogon];
        
        SberbankAuditAppDelegate * app = [SberbankAuditAppDelegate instance];
        app.mainSupApp = [SUPApplication getInstance];
        [app.mainSupApp setApplicationIdentifier:APPLICATION_ID];
        
        NSString * fileName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSLog(@"Версия - %@",fileName);
        
        versionLabel = [[UILabel alloc] init];
        [versionLabel setText:[NSString stringWithFormat:@"СКАД %@",fileName]];
        [versionLabel setTextAlignment:UITextAlignmentRight];
        [versionLabel setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:versionLabel];

        propertiesButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [propertiesButton setTitle:@"Настройки" forState:UIControlStateNormal];
        [propertiesButton addTarget:self action:@selector(propertiesAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:propertiesButton];
    }
    
    return self;
}

- (void)hideKeyBoard
{
    [userLogin resignFirstResponder];
    [userPassword resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view.frame = CGRectMake(0, 0, 1024, 768);
    }
    else
    {
        self.view.frame = CGRectMake(0, 0, 768, 1024);
    }
    //не удалять!!!это для логина и пароля, чтобы при повторном входе сохранялись данные
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (defaults) {
        userLogin.text = [defaults objectForKey:LOGIN_TEXT];
//        userPassword.text = [defaults objectForKey:PASSWORD_TEXT];
        [SberbankAuditAppDelegate instance].userLogin = userLogin.text;
    }
    
    [userLogin setFrame:CGRectMake((self.view.bounds.size.width/2) - 135, (self.view.bounds.size.height/2) - 15-150, 270, 31)];
    [userPassword setFrame:CGRectMake(userLogin.frame.origin.x, userLogin.frame.origin.y+userLogin.frame.size.height+10, 270, 31)];
    [getLogon setFrame:CGRectMake(userLogin.frame.origin.x,userPassword.frame.origin.y+userPassword.frame.size.height+10, 270, 31)];
    [propertiesButton setFrame:CGRectMake(userLogin.frame.origin.x,getLogon.frame.origin.y+getLogon.frame.size.height+10, 270, 31)];
    [versionLabel setFrame:CGRectMake(700, 710, 300, 30)];
}

- (void) propertiesAction
{
    PropertiesViewController * propertyController = [[PropertiesViewController alloc] init];
    propertyController.modalPresentationStyle = UIModalPresentationFormSheet;
    propertyController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:propertyController animated:YES completion:nil];
    [[propertyController.view superview] setFrame:CGRectMake(roundf([propertyController.view superview].center.x-339), roundf([propertyController.view superview].center.y-252), 678, 504)];
    [propertyController release];
}

- (void)addAlertWithTitle:(NSString *)title Message:(NSString*)message andCancelButtonText:(NSString*)text
{
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:text otherButtonTitles:nil];
    [error show];
    [error release];
}

- (void) sendAuth
{

    if (![[SberbankAuditAppDelegate instance] internetConnectionCheck]) {
        return ;
    }

    [getLogon setEnabled:NO];
    [getLogon setTitle:@"Загрузка..." forState:UIControlStateNormal];
    
    SberbankAuditAppDelegate * app = [SberbankAuditAppDelegate instance];
    
    //тащим логин и пароль
    [_login release];
    if (userLogin.text == nil) {
        _login = [[NSString alloc] initWithString:@""];
    }
    else
        _login = [[NSString alloc] initWithString:userLogin.text];
//    _login = userLogin.text;

    [_password release];
    if (userPassword.text == nil) {
        _password = [[NSString alloc] initWithString:@""];
    }
    else
        _password = [[NSString alloc] initWithString:userPassword.text];
//    _password = userPassword.text;
    
    
    NSLog(@"login = %@, retaintCount = %i",_login,_login.retainCount);
    NSLog(@"pass = %@, retaintCount = %i",_password,_password.retainCount);
    
    
    if (_login == nil || [_login isEqualToString:@""]) {
        _login = @"";
        [self addAlertWithTitle:@"Не заполнено поле с логином" Message:@"Введите логин" andCancelButtonText:@"ОК"];
        [getLogon setEnabled:YES];
        [getLogon setTitle:@"Войти" forState:UIControlStateNormal];
        return ;
    }
    
    if (_password == nil || [_password isEqualToString:@""]) {
        _password = @"";
        [self addAlertWithTitle:@"Не заполнено поле с паролем" Message:@"Введите пароль" andCancelButtonText:@"ОК"];
        [getLogon setEnabled:YES];
        [getLogon setTitle:@"Войти" forState:UIControlStateNormal];
        return ;
    }
    
    [self openActivityIndicatorViewWithName:@"Авторизация данных..."];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        BOOL logAndPass = [app setPropertiesWithLogin:_login andPassword:_password];
        
        if(!logAndPass)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self closeActivityIndicator];

                [getLogon setEnabled:YES];
                [getLogon setTitle:@"Войти" forState:UIControlStateNormal];
                UIAlertView *logonError = [[UIAlertView alloc] initWithTitle:@"Ошибка авторизации" message:@"Повторите попытку." delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil];
                [logonError show];
                [logonError release];
            });
        }
        else
        {


            NSLog(@"Прошли проперти");
            //создаем настройки коннектинга
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self printTextForIndicatorView:@"Регистрация данных..."];
            });
            [app registerApplication];
            
            
            NSLog(@"login = %@, \npassword = %@", _login, _password);
            app.newUserLogin = userLogin.text;
            
            //создаем БД (ConnectionProfile)
            [app createDB];
            
            [app validateAppProperties];//PROPERTY-синхронизация
            
            BOOL a = [app isValidMobileVersion];//проверка текущей версии приложения
            NSString * trueOrFalse = (a)? @"TRUE": @"FALSE";
            NSLog(@"trueOrFalse: %@",trueOrFalse);
            if (!a) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self closeActivityIndicator];
                    
                    [getLogon setEnabled:YES];
                    [getLogon setTitle:@"Войти" forState:UIControlStateNormal];
                    
                    UIAlertView * versionAlert = [[UIAlertView alloc] initWithTitle:@"Текущая версия приложения не поддерживается сервером." message:@"Пожалуйста, обновите приложение." delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
                    [versionAlert show];
                    [versionAlert release];
                });

                return ;
            }

            BOOL check = [app userLogonWithLogin:_login andPassword:_password];
            if (!check) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self closeActivityIndicator];
                    
                    [getLogon setEnabled:YES];
                    [getLogon setTitle:@"Войти" forState:UIControlStateNormal];
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Ошибка синхронизации данных" message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
                    [alert show];
                    [alert release];
                });

                return ;
            }
            
            //userDefaults
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            if (userDefaults) {
                [userDefaults setObject:userLogin.text forKey:LOGIN_TEXT];
            }

            [app dataForDashboardWithObjectName:userLogin.text];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [app openMainVC];
                [self closeActivityIndicator];
                [self.view removeFromSuperview];
            });

        }
        
    });

    
}

- (void)openActivityIndicatorViewWithName:(NSString *)name
{
    activityIndicator = [[[WaitingViewController alloc] init] autorelease];
    activityIndicator.label.text = name;
    activityIndicator.modalPresentationStyle = UIModalPresentationFormSheet;
    activityIndicator.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:activityIndicator animated:YES];
    [[activityIndicator.view superview] setFrame:CGRectMake(roundf([activityIndicator.view superview].center.x-200), roundf([activityIndicator.view superview].center.y-50), 400, 100)];
    
}

- (void)printTextForIndicatorView:(NSString *)text
{
    activityIndicator.label.text = text;
}

- (void) closeActivityIndicator
{
    [self dismissModalViewControllerAnimated:YES];
//    [activityIndicator release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    self._login = nil;
    self._password = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) dealloc
{
    [super dealloc];
    
    [backgroundView release];
    [userLogin release];
    [userPassword release];
    [getLogon release];
    
    [_login release];
    [_password release];
    [versionLabel release];
    [propertiesButton release];
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [userLogin setFrame:CGRectMake((self.view.bounds.size.width/2) - 135, (self.view.bounds.size.height/2) - 15-150, 270, 31)];
    [userPassword setFrame:CGRectMake(userLogin.frame.origin.x, userLogin.frame.origin.y+userLogin.frame.size.height+10, 270, 31)];
    [getLogon setFrame:CGRectMake(userLogin.frame.origin.x,userPassword.frame.origin.y+userPassword.frame.size.height+10, 270, 31)];
    [propertiesButton setFrame:CGRectMake(userLogin.frame.origin.x,getLogon.frame.origin.y+getLogon.frame.size.height+10, 270, 31)];
    [versionLabel setFrame:CGRectMake(700, 710, 300, 30)];
    
    if(UIDeviceOrientationIsLandscape(toInterfaceOrientation))
    {
        [backgroundView setFrame:CGRectMake(0, 0, 1024, 768)];
        [backgroundView setImage:[UIImage imageNamed:@"ipad_sber_welcome_1024x768.png"]];
        [versionLabel setFrame:CGRectMake(700, 710, 300, 30)];
    }
    else if(UIDeviceOrientationIsPortrait(toInterfaceOrientation))
    {
        [backgroundView setFrame:CGRectMake(0, 0, 768, 1024)];
        [backgroundView setImage:[UIImage imageNamed:@"ipad_sber_welcome_768x1024.png"]];
        [versionLabel setFrame:CGRectMake(430, 965, 300, 30)];
    }
    
    
//    if (UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
//        menuViewController.view.frame = CGRectMake(0, 0, leftMenuView.frame.size.width, 768-20);
//    }
//    else if (UIDeviceOrientationIsPortrait(toInterfaceOrientation)) {
//        menuViewController.view.frame = CGRectMake(0, 0, leftMenuView.frame.size.width, 1024-20);
//    }
//	[menuViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
//	[stackScrollViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
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

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
//    return UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
    return UIInterfaceOrientationPortrait;
}

@end
