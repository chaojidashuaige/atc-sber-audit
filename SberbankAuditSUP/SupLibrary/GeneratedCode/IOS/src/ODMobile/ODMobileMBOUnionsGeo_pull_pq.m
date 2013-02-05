/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.358
*/ 

#import "ODMobileMBOUnionsGeo_pull_pq.h"
#import "ODMobileMBOUnionsGeo_pull_pqMetaData.h"
#import "SUPJsonObject.h"
#import "ODMobileODMobileDB.h"
#import "SUPEntityDelegate.h"
#import "SUPEntityMetaDataRBS.h"
#import "SUPQuery.h"
#import "ODMobileKeyGenerator.h"
#import "ODMobileLocalKeyGenerator.h"
#import "ODMobileLogRecordImpl.h"

@implementation ODMobileMBOUnionsGeo_pull_pq

@synthesize username = _username;
@synthesize remoteId = _remoteId;
@synthesize LON_DELTAParam = _LON_DELTAParam;
@synthesize LAT_DELTAParam = _LAT_DELTAParam;
@synthesize LATParam = _LATParam;
@synthesize LONParam = _LONParam;
@synthesize id_ = _id;

- (int64_t)id_
{
    return _id;
}

- (void)setUsername:(NSString*)newUsername
{
    if (newUsername != self->_username)
    {
		[self->_username release];
        self->_username = [newUsername retain];
        self.isDirty = YES;
    }
}

- (void)setRemoteId:(NSString*)newRemoteId
{
    if (newRemoteId != self->_remoteId)
    {
		[self->_remoteId release];
        self->_remoteId = [newRemoteId retain];
        self.isDirty = YES;
    }
}

- (void)setLON_DELTAParam:(NSString*)newLON_DELTAParam
{
    if (newLON_DELTAParam != self->_LON_DELTAParam)
    {
		[self->_LON_DELTAParam release];
        self->_LON_DELTAParam = [newLON_DELTAParam retain];
        self.isDirty = YES;
    }
}

- (void)setLAT_DELTAParam:(NSString*)newLAT_DELTAParam
{
    if (newLAT_DELTAParam != self->_LAT_DELTAParam)
    {
		[self->_LAT_DELTAParam release];
        self->_LAT_DELTAParam = [newLAT_DELTAParam retain];
        self.isDirty = YES;
    }
}

- (void)setLATParam:(NSString*)newLATParam
{
    if (newLATParam != self->_LATParam)
    {
		[self->_LATParam release];
        self->_LATParam = [newLATParam retain];
        self.isDirty = YES;
    }
}

- (void)setLONParam:(NSString*)newLONParam
{
    if (newLONParam != self->_LONParam)
    {
		[self->_LONParam release];
        self->_LONParam = [newLONParam retain];
        self.isDirty = YES;
    }
}

- (void)setId_:(int64_t)newId_
{
    if (newId_ != self->_id)
    {
        self->_id = newId_;
        self.isNew = YES;
    }
}

static SUPEntityDelegate *g_ODMobileMBOUnionsGeo_pull_pq_delegate = nil;

+ (SUPEntityDelegate *) delegate
{
	@synchronized(self) {
		if (g_ODMobileMBOUnionsGeo_pull_pq_delegate == nil) {
			g_ODMobileMBOUnionsGeo_pull_pq_delegate = [[SUPEntityDelegate alloc] initWithName:@"ODMobileMBOUnionsGeo_pull_pq" clazz:[self class]
				metaData:[self metaData] dbDelegate:[ODMobileODMobileDB delegate] database:[ODMobileODMobileDB instance]];
		}
	}
	
	return [[g_ODMobileMBOUnionsGeo_pull_pq_delegate retain] autorelease];
}

+ (SUPEntityDelegate*) getEntityDelegateForPQ
{
    return [self delegate];
}

static SUPEntityMetaDataRBS* ODMobileMBOUnionsGeo_pull_pq_META_DATA;

+ (SUPEntityMetaDataRBS*)metaData
{
    if (ODMobileMBOUnionsGeo_pull_pq_META_DATA == nil) {
		ODMobileMBOUnionsGeo_pull_pq_META_DATA = [[ODMobileMBOUnionsGeo_pull_pqMetaData alloc] init];
	}
	
	return ODMobileMBOUnionsGeo_pull_pq_META_DATA;
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
        self.classMetaData = [ODMobileMBOUnionsGeo_pull_pq metaData];
        [self setEntityDelegate:(SUPEntityDelegate*)[ODMobileMBOUnionsGeo_pull_pq delegate]];
    }
    return self;    
}

- (void)dealloc
{
    if(_username)
    {
        [_username release];
        _username = nil;
    }
    if(_remoteId)
    {
        [_remoteId release];
        _remoteId = nil;
    }
    if(_LON_DELTAParam)
    {
        [_LON_DELTAParam release];
        _LON_DELTAParam = nil;
    }
    if(_LAT_DELTAParam)
    {
        [_LAT_DELTAParam release];
        _LAT_DELTAParam = nil;
    }
    if(_LATParam)
    {
        [_LATParam release];
        _LATParam = nil;
    }
    if(_LONParam)
    {
        [_LONParam release];
        _LONParam = nil;
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

+ (ODMobileMBOUnionsGeo_pull_pq*)find:(int64_t)id_
{
    SUPObjectList *keys = [SUPObjectList getInstance];
    [keys add:[NSNumber numberWithLong:id_]];
    return (ODMobileMBOUnionsGeo_pull_pq*)[(SUPEntityDelegate*)([[self class] delegate]) findEntityWithKeys:keys];
}

- (int64_t)_pk
{
    return (int64_t)[[self i_pk] longValue];
}

+ (ODMobileMBOUnionsGeo_pull_pq*)load:(int64_t)id_
{
    return (ODMobileMBOUnionsGeo_pull_pq*)[(SUPEntityDelegate*)([[self class] delegate]) load:[NSNumber numberWithLong:id_]];
}

+ (ODMobileMBOUnionsGeo_pull_pq*)getInstance
{
    ODMobileMBOUnionsGeo_pull_pq* me = [[ODMobileMBOUnionsGeo_pull_pq alloc] init];
    [me autorelease];
    return me;
}
-(SUPLong) getAttributeLong:(int)id_
{
    switch(id_)
    {
    case 986:
        return self.id_;
    default:
         return [super getAttributeLong:id_];
    }
}

-(void) setAttributeLong:(int)id_:(SUPLong)v
{
    switch(id_)
    {
    case 986:
        self.id_ = v;
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
    case 987:
        return self.username;
    case 988:
        return self.remoteId;
    case 989:
        return self.LON_DELTAParam;
    case 990:
        return self.LAT_DELTAParam;
    case 991:
        return self.LATParam;
    case 992:
        return self.LONParam;
    default:
         return [super getAttributeNullableString:id_];
    }
}

-(void) setAttributeNullableString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 987:
        self.username = v;
        break;;
    case 988:
        self.remoteId = v;
        break;;
    case 989:
        self.LON_DELTAParam = v;
        break;;
    case 990:
        self.LAT_DELTAParam = v;
        break;;
    case 991:
        self.LATParam = v;
        break;;
    case 992:
        self.LONParam = v;
        break;;
    default:
        [super setAttributeNullableString:id_:v];
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
   return [ODMobileLogRecordImpl findByEntity:@"MBOUnionsGeo_pull_pq":[self keyToString]];
}




- (NSString*)toString
{
	NSString* str = [NSString stringWithFormat:@"\
	MBOUnionsGeo_pull_pq = \n\
	    username = %@,\n\
	    remoteId = %@,\n\
	    LON_DELTAParam = %@,\n\
	    LAT_DELTAParam = %@,\n\
	    LATParam = %@,\n\
	    LONParam = %@,\n\
	    id = %qi,\n\
	    isNew = %i,\n\
        isDirty = %i,\n\
        isDeleted = %i,\n\
	\n"
    	,self.username
    	,self.remoteId
    	,self.LON_DELTAParam
    	,self.LAT_DELTAParam
    	,self.LATParam
    	,self.LONParam
    	,self.id_
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
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:159] autorelease];
	[_selectSQL appendString:@" s.\"username\",s.\"remoteId\",s.\"LON_DELTAParam\",s.\"LAT_DELTAParam\",s.\"LATParam\",s.\"LONParam\",s.\"id\" from \"odmobile_1_21_mbounionsgeo_pull_pq\" s"];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	sql = [[NSMutableString alloc] initWithFormat:@"select %@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	SUPObjectList* values = [SUPObjectList getInstance];
	return (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withSkip:skip withTake:take withClass:[ODMobileMBOUnionsGeo_pull_pq class]];
}



+ (ODMobileMBOUnionsGeo_pull_pq*)findSub:(NSString*)_username withLON_DELTA:(NSString*)lON_DELTA withLAT_DELTA:(NSString*)lAT_DELTA withLAT:(NSString*)lAT withLON:(NSString*)lON
{
	NSMutableString *sql = nil;
	NSMutableString *_selectSQL = nil;
	_selectSQL = [[[NSMutableString alloc] initWithCapacity:574] autorelease];
	[_selectSQL appendString:@"select s.\"username\",s.\"remoteId\",s.\"LON_DELTAParam\",s.\"LAT_DELTAParam\",s.\"LATParam\",s.\"LONParam\",s.\"id\" from \"odmobile_1_21_mbounionsgeo_pull_pq\" s where s.\"username\" =? and ( s.\"LON_DELTAParam\"=? or (s.\"LON_DELTAParam\" IS NULL AND CAST(? AS varchar(100)) IS NULL)) and "
	                               "( s.\"LAT_DELTAParam\"=? or (s.\"LAT_DELTAParam\" IS NULL AND CAST(? AS varchar(100)) IS NULL)) and ( s.\"LATParam\"=? or (s.\"LATParam\" IS NULL AND CAST(? AS varchar(100)) IS NULL)) and ( s.\"LONParam\"=? or (s.\"LONParam\" IS NULL AND CAST(? AS varchar(100)) IS NULL))"];
	sql = [[NSMutableString alloc] initWithFormat:@"%@", _selectSQL];
	[sql autorelease];
	SUPStringList *ids = [SUPStringList listWithCapacity:0];
	SUPObjectList *dts = [SUPObjectList getInstance];
	[dts addObject:[SUPDataType forName:@"string?"]];
	[dts addObject:[SUPDataType forName:@"string?"]];
	[dts addObject:[SUPDataType forName:@"string?"]];
	[dts addObject:[SUPDataType forName:@"string?"]];
	[dts addObject:[SUPDataType forName:@"string?"]];
	[dts addObject:[SUPDataType forName:@"string?"]];
	[dts addObject:[SUPDataType forName:@"string?"]];
	[dts addObject:[SUPDataType forName:@"string?"]];
	[dts addObject:[SUPDataType forName:@"string?"]];
	SUPObjectList* values = [SUPObjectList getInstance];
	[values addObject:_username];
	[values addObject:lON_DELTA];
	[values addObject:lON_DELTA];
	[values addObject:lAT_DELTA];
	[values addObject:lAT_DELTA];
	[values addObject:lAT];
	[values addObject:lAT];
	[values addObject:lON];
	[values addObject:lON];
	
	SUPObjectList* res = (SUPObjectList*)[[[self class] delegate] findWithSQL:sql withDataTypes:dts withValues:values withIDs:ids withClass:[ODMobileMBOUnionsGeo_pull_pq class]];
	if(res && ([res size] > 0))
	{   
		ODMobileMBOUnionsGeo_pull_pq* cus = (ODMobileMBOUnionsGeo_pull_pq*)[res item:0];
	    return cus;
	}
	else
	    return nil;
}

@end