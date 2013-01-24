//
//  Metric.h
//  SberbankAudit
//
//  Created by pnefedov on 07.12.12.
//
//

#import <Foundation/Foundation.h>

@interface Metric : NSObject{
    NSString * _key;
    NSString * _name;
    NSString * _value;
}

@property (nonatomic,copy) NSString * key;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * value;

- (id)initWithKey:(NSString*)key withName:(NSString*)name withValue:(NSString*)value;

@end
