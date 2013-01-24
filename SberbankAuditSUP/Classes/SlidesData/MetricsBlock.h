//
//  MetricsBlock.h
//  SberbankAudit
//
//  Created by pnefedov on 11.12.12.
//
//

#import <Foundation/Foundation.h>

@interface MetricsBlock : NSObject{
    NSString * _name;
    NSMutableArray * _metrics;
}

@property (nonatomic, copy) NSString * name;
@property (nonatomic,retain) NSMutableArray * metrics;

@end
