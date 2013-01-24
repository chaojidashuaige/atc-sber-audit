//
//  MetricsBlock.m
//  SberbankAudit
//
//  Created by pnefedov on 11.12.12.
//
//

#import "MetricsBlock.h"

@implementation MetricsBlock
@synthesize name = _name;
@synthesize metrics = _metrics;

//- (id) init

- (void)dealloc
{
    [_name release];
    [_metrics release];
    [super dealloc];
}

@end
