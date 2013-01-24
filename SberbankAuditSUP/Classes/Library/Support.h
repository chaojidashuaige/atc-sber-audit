//
//  Support.h
//  SberbankAudit
//
//  Created by Артем Куликов on 11.04.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Support : NSObject

+ (void) setUserDef:(id) obj forKey:(NSString *) key;
+ (id) getUserDef:(NSString *) key;
+ (void) showAutoHideSuccessMessage:(NSString *)aTitle deleteTitle:(NSString*)dt;
+ (void) showError:(NSString *)errorString;
@end
