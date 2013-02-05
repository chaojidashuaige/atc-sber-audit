/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.358
*/ 

#import "ODMobileMBOUnionsSynchronizationParameters.h"
#import "ODMobileMBOUnionsSynchronizationParametersMetaData.h"
#import "SUPJsonObject.h"
#import "ODMobileODMobileDB.h"
#import "SUPSyncParamEntityDelegate.h"
#import "SUPEntityMetaDataRBS.h"
#import "SUPQuery.h"
#import "ODMobileKeyGenerator.h"
#import "ODMobileLocalKeyGenerator.h"
#import "ODMobileLogRecordImpl.h"
#import "ODMobileMBOUnions_pull_pq.h"
#import "ODMobilePersonalizationParameters.h"

@implementation ODMobileMBOUnionsSynchronizationParameters

@synthesize RESOURCE_EMPLOYEE_ID = _RESOURCE_EMPLOYEE_ID;
@synthesize RESOURCE_EMPLOYEE_IDUserDefined = _RESOURCE_EMPLOYEE_IDUserDefined;

- (void)setRESOURCE_EMPLOYEE_ID:(NSString*)newRESOURCE_EMPLOYEE_ID
{
    if (newRESOURCE_EMPLOYEE_ID != self->_RESOURCE_EMPLOYEE_ID)
    {
		[self->_RESOURCE_EMPLOYEE_ID release];
        self->_RESOURCE_EMPLOYEE_ID = [newRESOURCE_EMPLOYEE_ID retain];
        self.isDirty = YES;
		_RESOURCE_EMPLOYEE_IDUserDefined = YES;
    }
}

- (void)setRESOURCE_EMPLOYEE_IDUserDefined:(BOOL)newRESOURCE_EMPLOYEE_IDUserDefined
{
    if (newRESOURCE_EMPLOYEE_IDUserDefined != self->_RESOURCE_EMPLOYEE_IDUserDefined)
    {
        self->_RESOURCE_EMPLOYEE_IDUserDefined = newRESOURCE_EMPLOYEE_IDUserDefined;
        self.isDirty = YES;
    }
}

static SUPSyncParamEntityDelegate *g_ODMobileMBOUnionsSynchronizationParameters_delegate = nil;

+ (SUPSyncParamEntityDelegate *) delegate
{
	@synchronized(self) {
		if (g_ODMobileMBOUnionsSynchronizationParameters_delegate == nil) {
			g_ODMobileMBOUnionsSynchronizationParameters_delegate = [[SUPSyncParamEntityDelegate alloc] initWithName:@"ODMobileMBOUnionsSynchronizationParameters" clazz:[self class]
				metaData:[self metaData] dbDelegate:[ODMobileODMobileDB delegate] database:[ODMobileODMobileDB instance]];
		}
	}
	
	return [[g_ODMobileMBOUnionsSynchronizationParameters_delegate retain] autorelease];
}

static SUPEntityMetaDataRBS* ODMobileMBOUnionsSynchronizationParameters_META_DATA;

+ (SUPEntityMetaDataRBS*)metaData
{
    if (ODMobileMBOUnionsSynchronizationParameters_META_DATA == nil) {
		ODMobileMBOUnionsSynchronizationParameters_META_DATA = [[ODMobileMBOUnionsSynchronizationParametersMetaData alloc] init];
	}
	
	return ODMobileMBOUnionsSynchronizationParameters_META_DATA;
}

- (SUPClassMetaDataRBS*)getClassMetaData
{
    return [[self class] metaData];
}

- (void)clearRelationshipObjects
{
}

- (id) init
{
    if ((self = [super init]))
    {
        self.classMetaData = [ODMobileMBOUnionsSynchronizationParameters metaData];
        [self setEntityDelegate:(SUPEntityDelegate*)[ODMobileMBOUnionsSynchronizationParameters delegate]];
		self.persistentQueryDelegate = [ODMobileMBOUnions_pull_pq getEntityDelegateForPQ];
    }
    return self;    
}

- (void)dealloc
{
    if(_RESOURCE_EMPLOYEE_ID)
    {
        [_RESOURCE_EMPLOYEE_ID release];
        _RESOURCE_EMPLOYEE_ID = nil;
    }
	[super dealloc];
}


- (SUPJsonObject*)getAttributeJson:(int)id_
{
    switch(id_)
    {
        default:
        return [super getAttributeJson:id_];
    }

}
- (void)setAttributeJson:(int)id_:(SUPJsonObject*)value
{
    switch(id_)
    { 
        default:
            [super setAttributeJson:id_:value];
            break;
    }

}

+ (ODMobileMBOUnionsSynchronizationParameters*)find:(NSString*)id_
{
    SUPObjectList *keys = [SUPObjectList getInstance];
    [keys add:id_];
    return (ODMobileMBOUnionsSynchronizationParameters*)[(SUPEntityDelegate*)([[self class] delegate]) findEntityWithKeys:keys];
}

- (NSString*)_pk
{
    return (NSString*)[self i_pk];
}

+ (ODMobileMBOUnionsSynchronizationParameters*)load:(NSString*)id_
{
    return (ODMobileMBOUnionsSynchronizationParameters*)[(SUPEntityDelegate*)([[self class] delegate]) load:id_];
}

+ (ODMobileMBOUnionsSynchronizationParameters*)getInstance
{
    ODMobileMBOUnionsSynchronizationParameters* me = [[ODMobileMBOUnionsSynchronizationParameters alloc] init];
    [me autorelease];
    return me;
}
-(SUPString) getAttributeNullableString:(int)id_
{
    switch(id_)
    {
    case 968:
        return self.RESOURCE_EMPLOYEE_ID;
    default:
         return [super getAttributeNullableString:id_];
    }
}

-(void) setAttributeNullableString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 968:
        self.RESOURCE_EMPLOYEE_ID = v;
        break;;
    default:
        [super setAttributeNullableString:id_:v];
        break;;
    }
}
-(SUPString) getAttributeString:(int)id_
{
    switch(id_)
    {
    case 970:
        return self.user_sp;
    default:
         return [super getAttributeString:id_];
    }
}

-(void) setAttributeString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 970:
        self.user_sp = v;
        break;;
    default:
        [super setAttributeString:id_:v];
        break;;
    }
}
-(SUPInt) getAttributeInt:(int)id_
{
    switch(id_)
    {
    case 971:
        return self.size_sp;
    default:
         return [super getAttributeInt:id_];
    }
}

-(void) setAttributeInt:(int)id_:(SUPInt)v
{
    switch(id_)
    {
    case 971:
        self.size_sp = v;
        break;;
    default:
        [super setAttributeInt:id_:v];
        break;;
    }
}
-(SUPBoolean) getAttributeBoolean:(int)id_
{
    switch(id_)
    {
    case 969:
        return self.RESOURCE_EMPLOYEE_IDUserDefined;
    default:
         return [super getAttributeBoolean:id_];
    }
}

-(void) setAttributeBoolean:(int)id_:(SUPBoolean)v
{
    switch(id_)
    {
    case 969:
        self.RESOURCE_EMPLOYEE_IDUserDefined = v;
        break;;
    default:
        [super setAttributeBoolean:id_:v];
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




- (NSString*)toString
{
	NSString* str = [NSString stringWithFormat:@"\
	MBOUnionsSynchronizationParameters = \n\
	    RESOURCE_EMPLOYEE_ID = %@,\n\
	    RESOURCE_EMPLOYEE_IDUserDefined = %i,\n\
	    size_sp = %i,\n\
	    user_sp = %@,\n\
	    isNew = %i,\n\
        isDirty = %i,\n\
        isDeleted = %i,\n\
	\n"
    	,self.RESOURCE_EMPLOYEE_ID
    	,self.RESOURCE_EMPLOYEE_IDUserDefined
    	,self.size_sp
    	,self.user_sp
		,self.isNew
		,self.isDirty
		,self.isDeleted
	];
	return str;

}

- (NSString*)description
{
	return [self toString];
}

@end