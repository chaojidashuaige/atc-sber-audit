//
//  TaskBlockMetrickUtils.m
//  SberbankAudit
//
//  Created by pnefedov on 07.12.12.
//
//

#import "TaskBlockMetrickUtils.h"

@implementation TaskBlockMetrickUtils
@synthesize questionBlockID = _questionBlockID;
@synthesize questionBlockName = _questionBlockName;
@synthesize metricName = _metricName;
@synthesize metricKey = _metricKey;
@synthesize metricValue = _metricValue;

- (id)init
{
    self = [super init];
    if (self) {
        _questionBlockID = [[NSString alloc] init];
        _questionBlockName = [[NSString alloc] init];
        _metricKey = [[NSString alloc] init];
        _metricName = [[NSString alloc] init];
        _metricValue = [[NSString alloc] init];
    }
    return  self;
}

- (void)dealloc
{
    [_questionBlockID release];
    [_questionBlockName release];
    [_metricKey release];
    [_metricName release];
    [_metricValue release];
    [super dealloc];
}


@end
