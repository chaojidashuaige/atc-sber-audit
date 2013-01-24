//
//  EmployeeDTO.h
//  SberbankAudit
//
//  Created by pnefedov on 03.12.12.
//
//

#import <Foundation/Foundation.h>

@interface EmployeeDTO : NSObject{
    NSString * _employeeID;
    NSString * _name;
    NSString * _subbranchLevelName;
    NSString * _subbranchLevelID;
    NSString * _hierarchyLevel;
    NSString * _unionID;
    NSString * _subbranchID;
}

@property (nonatomic,retain) NSString * employeeID;
@property (nonatomic,retain) NSString * name;
@property (nonatomic,retain) NSString * subbranchLevelName;
@property (nonatomic,retain) NSString * subbranchLevelID;
@property (nonatomic,retain) NSString * hierarchyLevel;
@property (nonatomic,retain) NSString * unionID;
@property (nonatomic,retain) NSString * subbranchID;

@end
