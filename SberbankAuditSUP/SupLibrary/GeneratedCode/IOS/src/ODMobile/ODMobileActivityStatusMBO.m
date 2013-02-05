/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.358
*/ 

#import "ODMobileActivityStatusMBO.h"
#import "ODMobileActivityStatusMBOMetaData.h"
#import "SUPJsonObject.h"
#import "ODMobileODMobileDB.h"
#import "SUPEntityDelegate.h"
#import "SUPEntityMetaDataRBS.h"
#import "SUPQuery.h"
#import "ODMobileKeyGenerator.h"
#import "ODMobileLocalKeyGenerator.h"
#import "ODMobileLogRecordImpl.h"

@implementation ODMobileActivityStatusMBO

@synthesize ACTIVITY_STATUS_ID = _ACTIVITY_STATUS_ID;
@synthesize ACTIVITY_STATUS_NAME = _ACTIVITY_STATUS_NAME;
@synthesize ACTIVITY_STATUS_KEY = _ACTIVITY_STATUS_KEY;
@synthesize surrogateKey = _surrogateKey;

- (int64_t)surrogateKey
{
    return _surrogateKey;
}

- (void)setACTIVITY_STATUS_ID:(NSString*)newACTIVITY_STATUS_ID
{
    if (newACTIVITY_STATUS_ID != self->_ACTIVITY_STATUS_ID)
    {
		[self->_ACTIVITY_STATUS_ID release];
        self->_ACTIVITY_STATUS_ID = [newACTIVITY_STATUS_ID retain];
        self.isDirty = YES;
    }
}

- (void)setACTIVITY_STATUS_NAME:(NSString*)newACTIVITY_STATUS_NAME
{
    if (newACTIVITY_STATUS_NAME != self->_ACTIVITY_STATUS_NAME)
    {
		[self->_ACTIVITY_STATUS_NAME release];
        self->_ACTIVITY_STATUS_NAME = [newACTIVITY_STATUS_NAME retain];
        self.isDirty = YES;
    }
}

- (void)setACTIVITY_STATUS_KEY:(NSString*)newACTIVITY_STATUS_KEY
{
    if (newACTIVITY_STATUS_KEY != self->_ACTIVITY_STATUS_KEY)
    {
		[self->_ACTIVITY_STATUS_KEY release];
        self->_ACTIVITY_STATUS_KEY = [newACTIVITY_STATUS_KEY retain];
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

static SUPEntityDelegate *g_ODMobileActivityStatusMBO_delegate = nil;

+ (SUPEntityDelegate *) delegate
{
	@synchronized(self) {
		if (g_ODMobileActivityStatusMBO_delegate == nil) {
			g_ODMobileActivityStatusMBO_delegate = [[SUPEntityDelegate alloc] initWithName:@"ODMobileActivityStatusMBO" clazz:[self class]
				metaData:[self metaData] dbDelegate:[ODMobileODMobileDB delegate] database:[ODMobileODMobileDB instance]];
		}
	}
	
	return [[g_ODMobileActivityStatusMBO_delegate retain] autorelease];
}

static SUPEntityMetaDataRBS* ODMobileActivityStatusMBO_META_DATA;

+ (SUPEntityMetaDataRBS*)metaData
{
    if (ODMobileActivityStatusMBO_META_DATA == nil) {
		ODMobileActivityStatusMBO_META_DATA = [[ODMobileActivityStatusMBOMetaData alloc] init];
	}
	
	return ODMobileActivityStatusMBO_META_DATA;
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
        self.classMetaData = [ODMobileActivityStatusMBO metaData];
        [self setEntityDelegate:(SUPEntityDelegate*)[ODMobileActivityStatusMBO delegate]];
    }
    return self;    
}

- (void)dealloc
{
    if(_ACTIVITY_STATUS_ID)
    {
        [_ACTIVITY_STATUS_ID release];
        _ACTIVITY_STATUS_ID = nil;
    }
    if(_ACTIVITY_STATUS_NAME)
    {
        [_ACTIVITY_STATUS_NAME release];
        _ACTIVITY_STATUS_NAME = nil;
    }
    if(_ACTIVITY_STATUS_KEY)
    {
        [_ACTIVITY_STATUS_KEY release];
        _ACTIVITY_STATUS_KEY = nil;
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

+ (ODMobileActivityStatusMBO*)find:(int64_t)id_
{
    SUPObjectList *keys = [SUPObjectList getInstance];
    [keys add:[NSNumber numberWithLong:id_]];
    return (ODMobileActivityStatusMBO*)[(SUPEntityDelegate*)([[self class] delegate]) findEntityWithKeys:keys];
}

+ (SUPObjectList*)findWithQuery:(SUPQuery*)query
{
    return (SUPObjectList*)[(SUPEntityDelegate*)([[self class] delegate])  findWithQuery:query:[ODMobileActivityStatusMBO class]];
}

- (int64_t)_pk
{
    return (int64_t)[[self i_pk] longValue];
}

+ (ODMobileActivityStatusMBO*)load:(int64_t)id_
{
    return (ODMobileActivityStatusMBO*)[(SUPEntityDelegate*)([[self class] delegate]) load:[NSNumber numberWithLong:id_]];
}

+ (ODMobileActivityStatusMBO*)getInstance
{
    ODMobileActivityStatusMBO* me = [[ODMobileActivityStatusMBO alloc] init];
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
- (ODMobileActivityStatusMBO*)getDownloadState
{
    return (ODMobileActivityStatusMBO*)[self i_getDownloadState];
}

- (ODMobileActivityStatusMBO*) getOriginalState
{
    return (ODMobileActivityStatusMBO*)[self i_getOriginalState];
}
-(SUPLong) getAttributeLong:(int)id_
{
    switch(id_)
    {
    case 658:
        return self.surrogateKey;
    default:
         return [super getAttributeLong:id_];
    }
}

-(void) setAttributeLong:(int)id_:(SUPLong)v
{
    switch(id_)
    {
    case 658:
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
    case 656:
        return self.ACTIVITY_STATUS_NAME;
    case 657:
        return self.ACTIVITY_STATUS_KEY;
    default:
         return [super getAttributeNullableString:id_];
    }
}

-(void) setAttributeNullableString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 656:
        self.ACTIVITY_STATUS_NAME = v;
        break;;
    case 657:
        self.ACTIVITY_STATUS_KEY = v;
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
    case 655:
        return self.ACTIVITY_STATUS_ID;
    default:
         return [super getAttributeString:id_];
    }
}

-(void) setAttributeString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 655:
        self.ACTIVITY_STATUS_ID = v;
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
   return [ODMobileLogRecordImpl findByEntity:@"ActivityStatusMBO":[self keyToString]];
}




- (NSString*)toString
{
	NSString* str = [NSString stringWithFormat:@"\
	ActivityStatusMBO = \n\
	    ACTIVITY_STATUS_ID = %@,\n\
	    ACTIVITY_STATUS_NAME = %@,\n\
	    ACTIVITY_STATUS_KEY = %@,\n\
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
    	,self.ACTIVITY_STATUS_ID
    	,self.ACTIVITY_STATUS_NAME
    	,self.ACTIVITY_STATUS_KEY
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
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:273] autorelease];
	[_selectSQL appendString:@" x.\"a\",x.\"b\",x.\"c\",x.\"_pf\",x.\"_pc\",x.\"_rp\",x.\"_rf\",x.\"d\",x.\"_rc\",x.\"_ds\" FROM \"odmobile_1_21_activitystatusmbo\" x where (((x.\"_pf\" = 1 or not exists (select x_os.\"d\" from \"odmobile_1_21_activitystatusmbo_os\" x_os where x_os.\"d\" = x.\"d\"))))"];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	SUPObjectList* values = [SUPObjectList getInstance];
	return (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withSkip:skip withTake:take withClass:[ODMobileActivityStatusMBO class]];
}



+ (ODMobileActivityStatusMBO*)findByPrimaryKey:(NSString*)aCTIVITY_STATUS_ID
{
	NSMutableString *sql = nil;
	NSMutableString *_selectSQL = nil;
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:298] autorelease];
	[_selectSQL appendString:@"SELECT x.\"a\",x.\"b\",x.\"c\",x.\"_pf\",x.\"_pc\",x.\"_rp\",x.\"_rf\",x.\"d\",x.\"_rc\",x.\"_ds\" FROM \"odmobile_1_21_activitystatusmbo\" x WHERE (((x.\"_pf\" = 1 or not exists (select x_os.\"d\" from \"odmobile_1_21_activitystatusmbo_os\" x_os where x_os.\"d\" = x.\"d\")))) and ( x.\"a\" = ?)"];
	sql = [[NSMutableString alloc] initWithFormat:@"%@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	[dts addObject:[SUPDataType forName:@"string"]];
	SUPObjectList* values = [SUPObjectList getInstance];
	[values addObject:aCTIVITY_STATUS_ID];
	
	SUPObjectList* res = (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withClass:[ODMobileActivityStatusMBO class]];
	if(res && ([res size] > 0))
	{   
		ODMobileActivityStatusMBO* cus = (ODMobileActivityStatusMBO*)[res item:0];
	    return cus;
	}
	else
	    return nil;
}



+ (ODMobileActivityStatusMBO*)getByStatusKey:(NSString*)sTATUS_KEY
{
	NSMutableString *sql = nil;
	NSMutableString *_selectSQL = nil;
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:298] autorelease];
	[_selectSQL appendString:@"select x.\"a\",x.\"b\",x.\"c\",x.\"_pf\",x.\"_pc\",x.\"_rp\",x.\"_rf\",x.\"d\",x.\"_rc\",x.\"_ds\" from \"odmobile_1_21_activitystatusmbo\" x where (((x.\"_pf\" = 1 or not exists (select x_os.\"d\" from \"odmobile_1_21_activitystatusmbo_os\" x_os where x_os.\"d\" = x.\"d\")))) and ( x.\"c\" = ?)"];
	sql = [[NSMutableString alloc] initWithFormat:@"%@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	[dts addObject:[SUPDataType forName:@"string"]];
	SUPObjectList* values = [SUPObjectList getInstance];
	[values addObject:sTATUS_KEY];
	
	SUPObjectList* res = (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withClass:[ODMobileActivityStatusMBO class]];
	if(res && ([res size] > 0))
	{   
		ODMobileActivityStatusMBO* cus = (ODMobileActivityStatusMBO*)[res item:0];
	    return cus;
	}
	else
	    return nil;
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