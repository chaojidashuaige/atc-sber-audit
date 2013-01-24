//
//  Support.m
//  SberbankAudit
//
//  Created by Артем Куликов on 11.04.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "Support.h"

@implementation Support

+ (void) setUserDef:(id) obj forKey:(NSString *) key {
	return [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
}

+ (id) getUserDef:(NSString *) key {
	return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void) showAutoHideSuccessMessage:(NSString *)aTitle deleteTitle:(NSString*)dt
{
    UIAlertView *autoAlertView = [[UIAlertView alloc] initWithTitle:dt message:aTitle delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    autoAlertView.transform = CGAffineTransformMake(1.0f, 0.5f, 0.0f, 1.0f, 0.0f, 0.0f);
    [autoAlertView performSelector:@selector(dismissWithClickedButtonIndex:animated:) 
                        withObject:nil 
                        afterDelay:2.0f];
    [autoAlertView show];
    [autoAlertView release];
}

+ (void) showError:(NSString *)errorString
{
    UIAlertView *sAlert = [[UIAlertView alloc] initWithTitle:@"Ошибка!" message:errorString delegate:self cancelButtonTitle:@"ОК" otherButtonTitles:nil];
    [sAlert show];
    [sAlert release];
}


@end
