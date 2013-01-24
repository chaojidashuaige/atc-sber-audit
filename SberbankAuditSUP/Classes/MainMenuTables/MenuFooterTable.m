//
//  MenuFooterTable.m
//  SberbankAudit
//
//  Created by Артем Куликов on 10.02.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "MenuFooterTable.h"
#import "PropertiesViewController.h"
#import "SberbankAuditAppDelegate.h"
#import "RootViewController.h"

@implementation MenuFooterTable


- (id)initWithFrame:(CGRect)aFrame
{
	if ((self = [super initWithFrame:aFrame]))
	{
		UIButton *closed_taskB = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [closed_taskB setBackgroundImage:[UIImage imageNamed:@"closed_task_still.png"] forState:UIControlStateNormal];
        [closed_taskB setBackgroundImage:[UIImage imageNamed:@"closed_task_active.png"] forState:UIControlStateHighlighted];
        [closed_taskB setFrame:CGRectMake(13, 0, 174, 56)];
//        [self addSubview:closed_taskB];
        
        UIButton *settingsB = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [settingsB setBackgroundImage:[UIImage imageNamed:@"settings_still.png"] forState:UIControlStateNormal];
        [settingsB setBackgroundImage:[UIImage imageNamed:@"settings_active.png"] forState:UIControlStateHighlighted];
        [settingsB setFrame:CGRectMake(13, closed_taskB.frame.origin.y+closed_taskB.frame.size.height+5, 174, 56)];
        [settingsB addTarget:self action:@selector(propertiesAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:settingsB];
        

        [closed_taskB release];
        [settingsB release];
        
//        self.backgroundColor = [UIColor purpleColor];
        self.clipsToBounds = YES;
	}
	return self;
}

- (void) propertiesAction
{
    PropertiesViewController * propertyController = [[PropertiesViewController alloc] init];
    propertyController.modalPresentationStyle = UIModalPresentationFormSheet;
    propertyController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [[SberbankAuditAppDelegate instance].rootViewController presentViewController:propertyController animated:YES completion:nil];
    [[propertyController.view superview] setFrame:CGRectMake(roundf([propertyController.view superview].center.x-339), roundf([propertyController.view superview].center.y-252), 678, 504)];
    [propertyController release];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch * touch = [[event allTouches] anyObject];
//    CGPoint location = [touch locationInView:self];
//    
//    NSLog(@"location in footer exists");
//}


- (void)dealloc
{
	[super dealloc];
}

@end
