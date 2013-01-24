//
//  Cell.m
//  SberbankAudit
//
//  Created by pnefedov on 03.12.12.
//
//

#import "Cell.h"

@implementation Cell
@synthesize cellID = _cellID;
@synthesize parentCellID = _parentCellID;
@synthesize employees = _employees;

- (id)init
{
    self = [super init];
    if (self) {
        _cellID = [[NSString alloc] init];
        _parentCellID = [[NSString alloc] init];
        _employees = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_cellID release];
    [_parentCellID release];
    [_employees release];
    [super dealloc];
}

@end
