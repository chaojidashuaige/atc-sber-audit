//
//  WaitingViewController.h
//  SberbankAudit
//
//  Created by pnefedov on 06.12.12.
//
//

#import <UIKit/UIKit.h>

@interface WaitingViewController : UIViewController
{
    UIActivityIndicatorView * indicator;
    UILabel * _label;
}
@property (nonatomic,retain) UILabel * label;

@end
