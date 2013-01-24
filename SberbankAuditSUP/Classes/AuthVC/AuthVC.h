//
//  AuthVC.h
//  SberbankAudit
//
//  Created by Артем Куликов on 11.04.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupIsTemp.h"
#import "SberbankAuditAppDelegate.h"
#import "Support.h"

@class SUPApplication;
@class WaitingViewController;

//@interface AuthVC : UIViewController <SupIsTempBindingResponseDelegate>
@interface AuthVC : UIViewController<UITextFieldDelegate>
{
    UIImageView *backgroundView;
    
    UITextField *userLogin;
    UITextField *userPassword;
    UIButton *getLogon;
    
    NSString * _login;
    NSString * _password;
    UILabel * versionLabel;
    UIButton * propertiesButton;
    WaitingViewController * activityIndicator;
}

- (void) openActivityIndicatorViewWithName:(NSString*)name;
- (void) printTextForIndicatorView:(NSString*)text;
- (void) closeActivityIndicator;
- (void)addAlertWithTitle:(NSString *)title Message:(NSString*)message andCancelButtonText:(NSString*)text;

@property (nonatomic,retain) NSString * _login;
@property (nonatomic,retain) NSString * _password;
//@property (nonatomic,retain) UITextField * userLogin;

- (void) propertiesAction;

@end
