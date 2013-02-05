/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.358
*/ 

#import "ODMobileMBO_getActivityTypes.h"
#import "ODMobileMBO_getActivityTypesMetaData.h"
#import "SUPJsonObject.h"
#import "ODMobileODMobileDB.h"
#import "SUPEntityDelegate.h"
#import "SUPEntityMetaDataRBS.h"
#import "SUPQuery.h"
#import "ODMobileKeyGenerator.h"
#import "ODMobileLocalKeyGenerator.h"
#import "ODMobileLogRecordImpl.h"

@implementation ODMobileMBO_getActivityTypes

@synthesize ACTIVITY_TYPE_ID = _ACTIVITY_TYPE_ID;
@synthesize ACTIVITY_TYPE_NAME = _ACTIVITY_TYPE_NAME;
@synthesize CATEGORY_ID = _CATEGORY_ID;
@synthesize BUSINESS_PROCESS_ID = _BUSINESS_PROCESS_ID;
@synthesize surrogateKey = _surrogateKey;

- (int64_t)surrogateKey
{
    return _surrogateKey;
}

- (void)setACTIVITY_TYPE_ID:(NSString*)newACTIVITY_TYPE_ID
{
    if (newACTIVITY_TYPE_ID != self->_ACTIVITY_TYPE_ID)
    {
		[self->_ACTIVITY_TYPE_ID release];
        self->_ACTIVITY_TYPE_ID = [newACTIVITY_TYPE_ID retain];
        self.isDirty = YES;
    }
}

- (void)setACTIVITY_TYPE_NAME:(NSString*)newACTIVITY_TYPE_NAME
{
    if (newACTIVITY_TYPE_NAME != self->_ACTIVITY_TYPE_NAME)
    {
		[self->_ACTIVITY_TYPE_NAME release];
        self->_ACTIVITY_TYPE_NAME = [newACTIVITY_TYPE_NAME retain];
        self.isDirty = YES;
    }
}

- (void)setCATEGORY_ID:(NSString*)newCATEGORY_ID
{
    if (newCATEGORY_ID != self->_CATEGORY_ID)
    {
		[self->_CATEGORY_ID release];
        self->_CATEGORY_ID = [newCATEGORY_ID retain];
        self.isDirty = YES;
    }
}

- (void)setBUSINESS_PROCESS_ID:(NSString*)newBUSINESS_PROCESS_ID
{
    if (newBUSINESS_PROCESS_ID != self->_BUSINESS_PROCESS_ID)
    {
		[self->_BUSINESS_PROCESS_ID release];
        self->_BUSINESS_PROCESS_ID = [newBUSINESS_PROCESS_ID retain];
        self.isDirty = YES;
    }
}

- (void)setSurrogateKey:(int64_t)newSurrogateKey
{
    if (newSurrogateKey != self->_surrogateKey)
    {
        self->_surrogateKey = newSurrogateKey;
        self.isNew = YES;
    }
}

static SUPEntityDelegate *g_ODMobileMBO_getActivityTypes_delegate = nil;

+ (SUPEntityDelegate *) delegate
{
	@synchronized(self) {
		if (g_ODMobileMBO_getActivityTypes_delegate == nil) {
			g_ODMobileMBO_getActivityTypes_delegate = [[SUPEntityDelegate alloc] initWithName:@"ODMobileMBO_getActivityTypes" clazz:[self class]
				metaData:[self metaData] dbDelegate:[ODMobileODMobileDB delegate] database:[ODMobileODMobileDB instance]];
		}
	}
	
	return [[g_ODMobileMBO_getActivityTypes_delegate retain] autorelease];
}

static SUPEntityMetaDataRBS* ODMobileMBO_getActivityTypes_META_DATA;

+ (SUPEntityMetaDataRBS*)metaData
{
    if (ODMobileMBO_getActivityTypes_META_DATA == nil) {
		ODMobileMBO_getActivityTypes_META_DATA = [[ODMobileMBO_getActivityTypesMetaData alloc] init];
	}
	
	return ODMobileMBO_getActivityTypes_META_DATA;
}

- (SUPClassMetaDataRBS*)getClassMetaData
{
    return [[self class] metaData];
}

- (void)clearRelationshipObjects
{
}

+ (NSObject<SUPCallbackHandler>*)callbackHandler
{
	return [[self delegate] callbackHandler];
}

+ (void)registerCallbackHandler:(NSObject<SUPCallbackHandler>*)newCallbackHandler
{
	[[self delegate] registerCallbackHandler:newCallbackHandler];
}
- (id) init
{
    if ((self = [super init]))
    {
        self.classMetaData = [ODMobileMBO_getActivityTypes metaData];
        [self setEntityDelegate:(SUPEntityDelegate*)[ODMobileMBO_getActivityTypes delegate]];
    }
    return self;    
}

- (void)dealloc
{
    if(_ACTIVITY_TYPE_ID)
    {
        [_ACTIVITY_TYPE_ID release];
        _ACTIVITY_TYPE_ID = nil;
    }
    if(_ACTIVITY_TYPE_NAME)
    {
        [_ACTIVITY_TYPE_NAME release];
        _ACTIVITY_TYPE_NAME = nil;
    }
    if(_CATEGORY_ID)
    {
        [_CATEGORY_ID release];
        _CATEGORY_ID = nil;
    }
    if(_BUSINESS_PROCESS_ID)
    {
        [_BUSINESS_PROCESS_ID release];
        _BUSINESS_PROCESS_ID = nil;
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

+ (ODMobileMBO_getActivityTypes*)find:(int64_t)id_
{
    SUPObjectList *keys = [SUPObjectList getInstance];
    [keys add:[NSNumber numberWithLong:id_]];
    return (ODMobileMBO_getActivityTypes*)[(SUPEntityDelegate*)([[self class] delegate]) findEntityWithKeys:keys];
}

+ (SUPObjectList*)findWithQuery:(SUPQuery*)query
{
    return (SUPObjectList*)[(SUPEntityDelegate*)([[self class] delegate])  findWithQuery:query:[ODMobileMBO_getActivityTypes class]];
}

- (int64_t)_pk
{
    return (int64_t)[[self i_pk] longValue];
}

+ (ODMobileMBO_getActivityTypes*)load:(int64_t)id_
{
    return (ODMobileMBO_getActivityTypes*)[(SUPEntityDelegate*)([[self class] delegate]) load:[NSNumber numberWithLong:id_]];
}

+ (ODMobileMBO_getActivityTypes*)getInstance
{
    ODMobileMBO_getActivityTypes* me = [[ODMobileMBO_getActivityTypes alloc] init];
    [me autorelease];
    return me;
}
- (SUPString)getLastOperation
{
    if (self.pendingChange == 'C')
    {
        return @"create";
    }
    else if (self.pendingChange == 'D')
    {
        return @"delete";
    }
    else if (self.pendingChange == 'U')
    {
        return @"update";
    }
    return @"";

}
+ (void)submitPendingOperations
{
    [[[self class] delegate] submitPendingOperations];
}

+ (void)cancelPendingOperations
{
    [[[self class] delegate] cancelPendingOperations];
}
- (ODMobileMBO_getActivityTypes*)getDownloadState
{
    return (ODMobileMBO_getActivityTypes*)[self i_getDownloadState];
}

- (ODMobileMBO_getActivityTypes*) getOriginalState
{
    return (ODMobileMBO_getActivityTypes*)[self i_getOriginalState];
}
-(SUPLong) getAttributeLong:(int)id_
{
    switch(id_)
    {
    case 782:
        return self.surrogateKey;
    default:
         return [super getAttributeLong:id_];
    }
}

-(void) setAttributeLong:(int)id_:(SUPLong)v
{
    switch(id_)
    {
    case 782:
        self.surrogateKey = v;
        break;;
    default:
        [super setAttributeLong:id_:v];
        break;;
    }
}
-(SUPString) getAttributeNullableString:(int)id_
{
    switch(id_)
    {
    case 779:
        return self.ACTIVITY_TYPE_NAME;
    case 780:
        return self.CATEGORY_ID;
    case 781:
        return self.BUSINESS_PROCESS_ID;
    default:
         return [super getAttributeNullableString:id_];
    }
}

-(void) setAttributeNullableString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 779:
        self.ACTIVITY_TYPE_NAME = v;
        break;;
    case 780:
        self.CATEGORY_ID = v;
        break;;
    case 781:
        self.BUSINESS_PROCESS_ID = v;
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
    case 778:
        return self.ACTIVITY_TYPE_ID;
    default:
         return [super getAttributeString:id_];
    }
}

-(void) setAttributeString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 778:
        self.ACTIVITY_TYPE_ID = v;
        break;;
    default:
        [super setAttributeString:id_:v];
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
- (SUPObjectList*)getLogRecords
{
   return [ODMobileLogRecordImpl findByEntity:@"MBO_getActivityTypes":[self keyToString]];
}




- (NSString*)toString
{
	NSString* str = [NSString stringWithFormat:@"\
	MBO_getActivityTypes = \n\
	    ACTIVITY_TYPE_ID = %@,\n\
	    ACTIVITY_TYPE_NAME = %@,\n\
	    CATEGORY_ID = %@,\n\
	    BUSINESS_PROCESS_ID = %@,\n\
	    pending = %i,\n\
	    pendingChange = %c,\n\
	    replayPending = %qi,\n\
	    replayFailure = %qi,\n\
	    surrogateKey = %qi,\n\
	    replayCounter = %qi,\n\
	    disableSubmit = %i,\n\
	    isNew = %i,\n\
        isDirty = %i,\n\
        isDeleted = %i,\n\
	\n"
    	,self.ACTIVITY_TYPE_ID
    	,self.ACTIVITY_TYPE_NAME
    	,self.CATEGORY_ID
    	,self.BUSINESS_PROCESS_ID
    	,self.pending
    	,self.pendingChange
    	,self.replayPending
    	,self.replayFailure
    	,self.surrogateKey
    	,self.replayCounter
    	,self.disableSubmit
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
+ (SUPObjectList*)getPendingObjects
{
    return (SUPObjectList*)[(SUPEntityDelegate*)[[self class] delegate] getPendingObjects];
}

+ (SUPObjectList*)getPendingObjects:(int32_t)skip take:(int32_t)take
{
    return (SUPObjectList*)[(SUPEntityDelegate*)[[self class] delegate] getPendingObjects:skip:take];
}




+ (SUPObjectList*)findAll
{
	return [self findAll:0 take:INT_MAX]; 
}


	

+ (SUPObjectList*)findAll:(int32_t)skip take:(int32_t)take
{
	NSMutableString *sql = nil;
	NSMutableString *_selectSQL = nil;
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:287] autorelease];
	[_selectSQL appendString:@" x.\"a\",x.\"b\",x.\"c\",x.\"d\",x.\"_pf\",x.\"_pc\",x.\"_rp\",x.\"_rf\",x.\"e\",x.\"_rc\",x.\"_ds\" FROM \"odmobile_1_21_mbo_getactivitytypes\" x where (((x.\"_pf\" = 1 or not exists (select x_os.\"e\" from \"odmobile_1_21_mbo_getactivitytypes_os\" x_os where x_os.\"e\" = x.\"e\"))))"];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	SUPObjectList* values = [SUPObjectList getInstance];
	return (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withSkip:skip withTake:take withClass:[ODMobileMBO_getActivityTypes class]];
}



+ (ODMobileMBO_getActivityTypes*)findByPrimaryKey:(NSString*)aCTIVITY_TYPE_ID
{
	NSMutableString *sql = nil;
	NSMutableString *_selectSQL = nil;
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:321] autorelease];
	[_selectSQL appendString:@"SELECT x.\"a\",x.\"b\",x.\"c\",x.\"d\",x.\"_pf\",x.\"_pc\",x.\"_rp\",x.\"_rf\",x.\"e\",x.\"_rc\",x.\"_ds\" FROM \"odmobile_1_21_mbo_getactivitytypes\" x WHERE (((x.\"_pf\" = 1 or not exists (select x_os.\"e\" from \"odmobile_1_21_mbo_getactivitytypes_os\" x_os where x_os.\"e\" = x.\"e\")))) and ( x.\"a\" "
	                               "= ?)"];
	sql = [[NSMutableString alloc] initWithFormat:@"%@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	[dts addObject:[SUPDataType forName:@"string"]];
	SUPObjectList* values = [SUPObjectList getInstance];
	[values addObject:aCTIVITY_TYPE_ID];
	
	SUPObjectList* res = (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withClass:[ODMobileMBO_getActivityTypes class]];
	if(res && ([res size] > 0))
	{   
		ODMobileMBO_getActivityTypes* cus = (ODMobileMBO_getActivityTypes*)[res item:0];
	    return cus;
	}
	else
	    return nil;
}



+ (SUPObjectList*)getByCategoryId:(NSString*)categoryId
{
	return [self getByCategoryId:categoryId skip:0 take:INT_MAX]; 
}


	

+ (SUPObjectList*)getByCategoryId:(NSString*)categoryId skip:(int32_t)skip take:(int32_t)take
{
	NSMutableString *sql = nil;
	NSMutableString *_selectSQL = nil;
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:318] autorelease];
	[_selectSQL appendString:@" x.\"a\",x.\"b\",x.\"c\",x.\"d\",x.\"_pf\",x.\"_pc\",x.\"_rp\",x.\"_rf\",x.\"e\",x.\"_rc\",x.\"_ds\" FROM \"odmobile_1_21_mbo_getactivitytypes\" x WHERE (((x.\"_pf\" = 1 or not exists (select x_os.\"e\" from \"odmobile_1_21_mbo_getactivitytypes_os\" x_os where x_os.\"e\" = x.\"e\")))) and ( x.\"c\" LIKE ?"
	                               ")"];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	[dts addObject:[SUPDataType forName:@"string?"]];
	SUPObjectList* values = [SUPObjectList getInstance];
	[values addObject:categoryId];
	return (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withSkip:skip withTake:take withClass:[ODMobileMBO_getActivityTypes class]];
}

/*!
  @method
  @abstract Generated class method 
  @param query
  @throws SUPPersistenceException
 */
+ (int32_t)getSize:(SUPQuery*)query
{
    return [(SUPEntityDelegate*)([[self class] delegate]) getSize:query];
}

@end