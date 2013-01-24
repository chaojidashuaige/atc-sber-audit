//
//  PropertiesViewController.h
//  SberbankAudit
//
//  Created by pnefedov on 29.11.12.
//
//

#import <UIKit/UIKit.h>

@interface PropertiesViewController : UIViewController{
    UIButton * aCancelButton;
    UILabel * versionLabel;
    UILabel * versionValue;
    UILabel * serverAdressLabel;
    UILabel * serverAdressValue;
    UILabel * idLabel;
    UILabel * idValue;
    UILabel * IPLabel;
    UILabel * IPValue;
    UILabel * connectionIDLabel;
    UILabel * connectionIDValue;
}

- (void)aCancelAction;

@end
