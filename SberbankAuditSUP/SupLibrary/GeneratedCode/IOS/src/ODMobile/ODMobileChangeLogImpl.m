/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.358
*/ 

#import "ODMobileChangeLogImpl.h"
#import "ODMobileChangeLogImplMetaData.h"
#import "SUPJsonObject.h"
#import "ODMobileODMobileDB.h"
#import "SUPEntityDelegate.h"
#import "SUPEntityMetaDataRBS.h"
#import "SUPQuery.h"
#import "ODMobileKeyGenerator.h"
#import "ODMobileLocalKeyGenerator.h"
#import "ODMobileLogRecordImpl.h"
#import "SUPConnectionWrapper.h"
#import "SUPLocalTransaction.h"
#import "SUPStatementWrapper.h"

@implementation ODMobileChangeLogImpl

@synthesize operationType = _operationType;
@synthesize rootEntityType = _rootEntityType;
@synthesize rootSurrogateKey = _rootSurrogateKey;
@synthesize entityType = _entityType;
@synthesize surrogateKey = _surrogateKey;

- (int32_t)entityType
{
    return _entityType;
}

- (int64_t)surrogateKey
{
    return _surrogateKey;
}

- (void)setOperationType:(unichar)newOperationType
{
    if (newOperationType != self->_operationType)
    {
        self->_operationType = newOperationType;
        self.isDirty = YES;
    }
}

- (void)setRootEntityType:(int32_t)newRootEntityType
{
    if (newRootEntityType != self->_rootEntityType)
    {
        self->_rootEntityType = newRootEntityType;
        self.isDirty = YES;
    }
}

- (void)setRootSurrogateKey:(int64_t)newRootSurrogateKey
{
    if (newRootSurrogateKey != self->_rootSurrogateKey)
    {
        self->_rootSurrogateKey = newRootSurrogateKey;
        self.isDirty = YES;
    }
}

- (void)setEntityType:(int32_t)newEntityType
{
    if (newEntityType != self->_entityType)
    {
        self->_entityType = newEntityType;
        self.isNew = YES;
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

static SUPEntityDelegate *g_ODMobileChangeLogImpl_delegate = nil;

+ (SUPEntityDelegate *) delegate
{
	@synchronized(self) {
		if (g_ODMobileChangeLogImpl_delegate == nil) {
			g_ODMobileChangeLogImpl_delegate = [[SUPEntityDelegate alloc] initWithName:@"ODMobileChangeLogImpl" clazz:[self class]
				metaData:[self metaData] dbDelegate:[ODMobileODMobileDB delegate] database:[ODMobileODMobileDB instance]];
		}
	}
	
	return [[g_ODMobileChangeLogImpl_delegate retain] autorelease];
}

static SUPEntityMetaDataRBS* ODMobileChangeLogImpl_META_DATA;

+ (SUPEntityMetaDataRBS*)metaData
{
    if (ODMobileChangeLogImpl_META_DATA == nil) {
		ODMobileChangeLogImpl_META_DATA = [[ODMobileChangeLogImplMetaData alloc] init];
	}
	
	return ODMobileChangeLogImpl_META_DATA;
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
        self.classMetaData = [ODMobileChangeLogImpl metaData];
        [self setEntityDelegate:(SUPEntityDelegate*)[ODMobileChangeLogImpl delegate]];
    }
    return self;    
}

- (void)dealloc
{
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

+ (ODMobileChangeLogImpl*)find:(ODMobileChangeLogKey*)id_
{
    SUPObjectList *keys = [SUPObjectList getInstance];
    [keys add:[NSNumber numberWithInt:id_.entityType]];
    [keys add:[NSNumber numberWithLong:id_.surrogateKey]];
    return (ODMobileChangeLogImpl*)[(SUPEntityDelegate*)([[self class] delegate]) findEntityWithKeys:keys];
}

+ (SUPObjectList*)findWithQuery:(SUPQuery*)query
{
    return (SUPObjectList*)[(SUPEntityDelegate*)([[self class] delegate])  findWithQuery:query:[ODMobileChangeLogImpl class]];
}

- (ODMobileChangeLogKey*)_pk
{
    return (ODMobileChangeLogKey*)[self i_pk];
}

+ (ODMobileChangeLogImpl*)load:(ODMobileChangeLogKey*)id_
{
    return (ODMobileChangeLogImpl*)[(SUPEntityDelegate*)([[self class] delegate]) load:id_];
}

+ (ODMobileChangeLogImpl*)getInstance
{
    ODMobileChangeLogImpl* me = [[ODMobileChangeLogImpl alloc] init];
    [me autorelease];
    return me;
}
-(SUPLong) getAttributeLong:(int)id_
{
    switch(id_)
    {
    case 921:
        return self.rootSurrogateKey;
    case 918:
        return self.surrogateKey;
    default:
         return [super getAttributeLong:id_];
    }
}

-(void) setAttributeLong:(int)id_:(SUPLong)v
{
    switch(id_)
    {
    case 921:
        self.rootSurrogateKey = v;
        break;;
    case 918:
        self.surrogateKey = v;
        break;;
    default:
        [super setAttributeLong:id_:v];
        break;;
    }
}
-(SUPChar) getAttributeChar:(int)id_
{
    switch(id_)
    {
    case 919:
        return self.operationType;
    default:
         return [super getAttributeChar:id_];
    }
}

-(void) setAttributeChar:(int)id_:(SUPChar)v
{
    switch(id_)
    {
    case 919:
        self.operationType = v;
        break;;
    default:
        [super setAttributeChar:id_:v];
        break;;
    }
}
-(SUPInt) getAttributeInt:(int)id_
{
    switch(id_)
    {
    case 920:
        return self.rootEntityType;
    case 917:
        return self.entityType;
    default:
         return [super getAttributeInt:id_];
    }
}

-(void) setAttributeInt:(int)id_:(SUPInt)v
{
    switch(id_)
    {
    case 920:
        self.rootEntityType = v;
        break;;
    case 917:
        self.entityType = v;
        break;;
    default:
        [super setAttributeInt:id_:v];
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
   return [ODMobileLogRecordImpl findByEntity:@"ChangeLogImpl":[self keyToString]];
}




- (NSString*)toString
{
	NSString* str = [NSString stringWithFormat:@"\
	ChangeLogImpl = \n\
	    operationType = %c,\n\
	    rootEntityType = %i,\n\
	    rootSurrogateKey = %qi,\n\
	    entityType = %i,\n\
	    surrogateKey = %qi,\n\
	    isNew = %i,\n\
        isDirty = %i,\n\
        isDeleted = %i,\n\
	\n"
    	,self.operationType
    	,self.rootEntityType
    	,self.rootSurrogateKey
    	,self.entityType
    	,self.surrogateKey
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


+ (void) deleteChangeLogs
{
    NSString *sql = @"truncate table odmobile_1_21_changelogimpl";
    id<SUPConnectionWrapper> connection = nil;
    id<SUPStatementWrapper> preparedStatement = nil;
    SUPLocalTransaction* transaction = nil;
    BOOL ok = NO;
    @try
    {
        [[ODMobileODMobileDB dblock] writeLock];
        connection = [ODMobileODMobileDB getConnectionWrapper];
        transaction = ([connection inTransaction] ? nil : [ODMobileODMobileDB beginTransaction]);
        preparedStatement = [connection prepareStatement:sql];
        [preparedStatement execute];
     	ok = YES;
    }
    @catch (NSException *e) {
        ok = NO;
        @throw e;
    }
    @finally {
        [preparedStatement close];
        if (ok)
        {
            [transaction commit];
        }
        else
        {
            [transaction rollback];
        }
        [connection releaseToPool];
        [[ODMobileODMobileDB dblock] unlock];
    }    
    
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