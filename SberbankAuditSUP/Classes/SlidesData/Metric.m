//
//  Metric.m
//  SberbankAudit
//
//  Created by pnefedov on 07.12.12.
//
//

#import "Metric.h"

@implementation Metric
@synthesize key = _key;
@synthesize name = _name;
@synthesize value = _value;

- (id)initWithKey:(NSString *)key withName:(NSString *)name withValue:(NSString *)value
{
    self = [super init];
    if (self) {
        _key = [[NSString alloc] initWithString:key];
        _name = [[NSString alloc] initWithString:name];
        _value = [[NSString alloc] initWithString:value];
    }
    return self;
}

- (void)dealloc
{
    [_key release];
    [_name release];
    [_value release];
    [super dealloc];
}

@end
