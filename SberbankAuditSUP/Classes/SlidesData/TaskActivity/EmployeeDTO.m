//
//  EmployeeDTO.m
//  SberbankAudit
//
//  Created by pnefedov on 03.12.12.
//
//

#import "EmployeeDTO.h"

@implementation EmployeeDTO
@synthesize employeeID = _employeeID;
@synthesize name = _name;
@synthesize subbranchLevelName = _subbranchLevelName;
@synthesize subbranchLevelID = _subbranchLevelID;
@synthesize hierarchyLevel = _hierarchyLevel;
@synthesize unionID = _unionID;
@synthesize subbranchID = _subbranchID;

- (id)init
{
    self = [super init];
    if (self) {
        _employeeID = [[NSString alloc] init];
        _name = [[NSString alloc] init];
        _subbranchLevelName = [[NSString alloc] init];
        _subbranchLevelID = [[NSString alloc] init];
        _hierarchyLevel= [[NSString alloc] init];
        _unionID = [[NSString alloc] init];
        _subbranchID = [[NSString alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_employeeID release];
    [_name release];
    [_subbranchLevelName release];
    [_subbranchLevelID release];
    [_hierarchyLevel release];
    [_unionID release];
    [_subbranchID release];
    [super dealloc];
}

@end
