//
//  GembaSheetAnnotation.m
//  SberbankAudit
//
//  Created by Артем Куликов on 23.05.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "GembaSheetAnnotation.h"

@implementation GembaSheetAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (void)dealloc {
    self.title = nil;
    self.subtitle = nil;
    [super dealloc];
}

@end
