//
//  MainMapAnnotation.m
//  SberbankAudit
//
//  Created by Артем Куликов on 06.06.12.
//  Copyright (c) 2012 koulikovar@gmail.com. All rights reserved.
//

#import "MainMapAnnotation.h"

@implementation MainMapAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (void)dealloc {
    self.title = nil;
    self.subtitle = nil;
    [super dealloc];
}

@end
