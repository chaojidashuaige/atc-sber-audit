//
//  ControlList.h
//  SberbankAudit
//
//  Created by Artem Koulikov on 29.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupIsTemp.h"
#import "StackScrollViewController.h"

@interface CheckListViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate,StackScrollViewDelegate, UIAlertViewDelegate>
{
}

- (id)initWithFrame:(CGRect)frame;


@end
