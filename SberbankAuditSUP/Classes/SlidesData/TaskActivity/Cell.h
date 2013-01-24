//
//  Cell.h
//  SberbankAudit
//
//  Created by pnefedov on 03.12.12.
//
//

#import <Foundation/Foundation.h>

@interface Cell : NSObject{
    NSString * _cellID;
    NSString * _parentCellID;
    NSMutableArray * _employees;
}
@property (nonatomic,retain) NSString * cellID;
@property (nonatomic,retain) NSString * parentCellID;
@property (nonatomic,retain) NSMutableArray * employees;

@end
