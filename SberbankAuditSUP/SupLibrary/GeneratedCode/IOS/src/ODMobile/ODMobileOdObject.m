/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.358
*/ 

#import "ODMobileOdObject.h"
#import "ODMobileOdObjectMetaData.h"
#import "SUPJsonObject.h"
#import "ODMobileODMobileDB.h"
#import "SUPClassDelegate.h"
#import "SUPEntityMetaDataRBS.h"
#import "SUPObjectList.h"
#import "ODMobileObjField.h"

@implementation ODMobileOdObject

@synthesize fl = _fl;
@synthesize rn = _rn;

static SUPClassDelegate *g_ODMobileOdObject_delegate = nil;

+ (SUPClassDelegate *) delegate
{
	@synchronized(self) {
		if (g_ODMobileOdObject_delegate == nil) {
			g_ODMobileOdObject_delegate = [[SUPClassDelegate alloc] initWithName:@"ODMobileOdObject" clazz:[self class]
				metaData:[self metaData] dbDelegate:[ODMobileODMobileDB delegate] database:[ODMobileODMobileDB instance]];
		}
	}
	
	return [[g_ODMobileOdObject_delegate retain] autorelease];
}
- (SUPJsonObject*)getAttributeJson:(int)id_
{
    switch(id_)
    {
    case 651:
        return (SUPJsonObject*)[[ODMobileObjField delegate] toJsonArray:self.fl];
        default:
        return [super getAttributeJson:id_];
    }

}
- (void)setAttributeJson:(int)id_:(SUPJsonObject*)value
{
    switch(id_)
    { 
    case 651:
        self.fl = (SUPObjectList*)[[ODMobileObjField delegate] fromJsonArray:(SUPJsonArray*)value];
        break;
        default:
            [super setAttributeJson:id_:value];
            break;
    }

}
static SUPClassMetaDataRBS* ODMobileOdObject_META_DATA;

+ (SUPClassMetaDataRBS*)metaData
{
    if (ODMobileOdObject_META_DATA == nil) {
 	   	ODMobileOdObject_META_DATA = [[ODMobileOdObjectMetaData alloc] init];
	}
	
	return ODMobileOdObject_META_DATA;
}

- (SUPClassMetaDataRBS*)getClassMetaData
{
    return [[self class] metaData];
}
- (id) init
{
    if ((self = [super init]))
    {
        self.classMetaData = (SUPEntityMetaDataRBS *)[ODMobileOdObject metaData];
        [self setClassDelegate:[[self class] delegate]];
        
    }
    return self;    
}

-(SUPNullableLong) getAttributeNullableLong:(int)id_
{
    switch(id_)
    {
    case 652:
        return self.rn;
    default:
        return [super getAttributeNullableLong:id_];
    }
}

-(void) setAttributeNullableLong:(int)id_:(SUPNullableLong)v
{
    switch(id_)
    {
    case 652:
        self.rn = v;
        break;;
    default:
        [super setAttributeNullableLong:id_:v];
        break;;
    }
}
-(id) getAttributeObject:(int)id_
{
    switch(id_)
    {
    case 651:
        return self.fl;
    default:
        return [super getAttributeObject:id_];
    }
}

-(void) setAttributeObject:(int)id_:(id)v
{
    switch(id_)
    {
    case 651:
        self.fl = v;
        break;;
    default:
        [super setAttributeObject:id_:v];
        break;;
    }
}
- (id)getAttributeLargeObject:(int)id_ loadFromDB:(BOOL)loadFromDB
{
    switch(id_)
    {
        default:
        return [super getAttributeJson:id_];
    }
}
- (void)setAttributeLargeObject:(int)id_:(id)value
{
    switch(id_)
    {
        default:
            [super setAttributeJson:id_:value];
            break;
    }

}
+ (ODMobileOdObject*)getInstance
{
    ODMobileOdObject* me = [[ODMobileOdObject alloc] init];
    [me autorelease];
    return me;
}
- (void)dealloc
{
    if(_fl)
    {
        [_fl release];
        _fl = nil;
    }
    if(_rn)
    {
        [_rn release];
        _rn = nil;
    }
	[super dealloc];
}

@end