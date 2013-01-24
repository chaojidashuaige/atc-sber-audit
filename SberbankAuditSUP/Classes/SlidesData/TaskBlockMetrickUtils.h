//
//  TaskBlockMetrickUtils.h
//  SberbankAudit
//
//  Created by pnefedov on 07.12.12.
//
//

#import <Foundation/Foundation.h>

@interface TaskBlockMetrickUtils : NSObject{
    NSString * _questionBlockID;
    NSString * _questionBlockName;
    NSString * _metricName;
    NSString * _metricKey;
    NSString * _metricValue;
}

@property (nonatomic,copy) NSString * questionBlockID;
@property (nonatomic,copy) NSString * questionBlockName;
@property (nonatomic,copy) NSString * metricName;
@property (nonatomic,copy) NSString * metricKey;
@property (nonatomic,copy) NSString * metricValue;


@end
