/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.1.3.358
*/ 

#import "ODMobilePersonalizationParameters.h"
#import "ODMobilePersonalizationParametersMetaData.h"
#import "SUPJsonObject.h"
#import "ODMobileODMobileDB.h"
#import "SUPClassDelegate.h"
#import "SUPJsonReader.h"
#import "SUPEntityMetaDataRBS.h"

@interface ODMobilePersonalizationParameters(hidden)
-(void)submitPending;
@end
@implementation ODMobilePersonalizationParameters

@synthesize didPK = _didPK;
@synthesize didPKUserDefined = _didPKUserDefined;
@synthesize userLoginPK = _userLoginPK;
@synthesize userLoginPKUserDefined = _userLoginPKUserDefined;
@synthesize userPasswordPK = _userPasswordPK;
@synthesize userPasswordPKUserDefined = _userPasswordPKUserDefined;
@synthesize username = _username;
@synthesize usernameUserDefined = _usernameUserDefined;
@synthesize password = _password;
@synthesize passwordUserDefined = _passwordUserDefined;

- (void)setDidPK:(NSString*)newDidPK
{
    if (newDidPK != self->_didPK)
    {
		[self->_didPK release];
        self->_didPK = [newDidPK retain];
		_didPKUserDefined = YES;
    }
}
- (void)setDidPKUserDefined:(BOOL)newDidPKUserDefined
{
    if (newDidPKUserDefined != self->_didPKUserDefined)
    {
        self->_didPKUserDefined = newDidPKUserDefined;
    }
}
- (void)setUserLoginPK:(NSString*)newUserLoginPK
{
    if (newUserLoginPK != self->_userLoginPK)
    {
		[self->_userLoginPK release];
        self->_userLoginPK = [newUserLoginPK retain];
		_userLoginPKUserDefined = YES;
    }
}
- (void)setUserLoginPKUserDefined:(BOOL)newUserLoginPKUserDefined
{
    if (newUserLoginPKUserDefined != self->_userLoginPKUserDefined)
    {
        self->_userLoginPKUserDefined = newUserLoginPKUserDefined;
    }
}
- (void)setUserPasswordPK:(NSString*)newUserPasswordPK
{
    if (newUserPasswordPK != self->_userPasswordPK)
    {
		[self->_userPasswordPK release];
        self->_userPasswordPK = [newUserPasswordPK retain];
		_userPasswordPKUserDefined = YES;
    }
}
- (void)setUserPasswordPKUserDefined:(BOOL)newUserPasswordPKUserDefined
{
    if (newUserPasswordPKUserDefined != self->_userPasswordPKUserDefined)
    {
        self->_userPasswordPKUserDefined = newUserPasswordPKUserDefined;
    }
}
- (void)setUsername:(NSString*)newUsername
{
    if (newUsername != self->_username)
    {
		[self->_username release];
        self->_username = [newUsername retain];
		_usernameUserDefined = YES;
    }
}
- (void)setUsernameUserDefined:(BOOL)newUsernameUserDefined
{
    if (newUsernameUserDefined != self->_usernameUserDefined)
    {
        self->_usernameUserDefined = newUsernameUserDefined;
    }
}
- (void)setPassword:(NSString*)newPassword
{
    if (newPassword != self->_password)
    {
		[self->_password release];
        self->_password = [newPassword retain];
		_passwordUserDefined = YES;
    }
}
- (void)setPasswordUserDefined:(BOOL)newPasswordUserDefined
{
    if (newPasswordUserDefined != self->_passwordUserDefined)
    {
        self->_passwordUserDefined = newPasswordUserDefined;
    }
}

static SUPClassDelegate *g_ODMobilePersonalizationParameters_delegate = nil;

+ (SUPClassDelegate *) delegate
{
	@synchronized(self) {
		if (g_ODMobilePersonalizationParameters_delegate == nil) {
			g_ODMobilePersonalizationParameters_delegate = [[SUPClassDelegate alloc] initWithName:@"ODMobilePersonalizationParameters" clazz:[self class]
				metaData:[self metaData] dbDelegate:[ODMobileODMobileDB delegate] database:[ODMobileODMobileDB instance]];
		}
	}
	
	return [[g_ODMobilePersonalizationParameters_delegate retain] autorelease];
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
static SUPClassMetaDataRBS* ODMobilePersonalizationParameters_META_DATA;

+ (SUPClassMetaDataRBS*)metaData
{
    if (ODMobilePersonalizationParameters_META_DATA == nil) {
 	   	ODMobilePersonalizationParameters_META_DATA = [[ODMobilePersonalizationParametersMetaData alloc] init];
	}
	
	return ODMobilePersonalizationParameters_META_DATA;
}

- (SUPClassMetaDataRBS*)getClassMetaData
{
    return [[self class] metaData];
}
- (id) init
{
    if ((self = [super init]))
    {
        self.classMetaData = (SUPEntityMetaDataRBS *)[ODMobilePersonalizationParameters metaData];
        [self setClassDelegate:[[self class] delegate]];
        _usernameUserDefined = NO;
        _passwordUserDefined = NO;   
        clientPersonalizationTableName = @"co_odmobile_1_21_clientpersonalization";
        [self load];
        
    }
    return self;    
}

-(SUPString) getAttributeNullableString:(int)id_
{
    switch(id_)
    {
    case 1036:
        return self.didPK;
    case 1038:
        return self.userLoginPK;
    case 1040:
        return self.userPasswordPK;
    default:
        return [super getAttributeNullableString:id_];
    }
}

-(void) setAttributeNullableString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 1036:
        self.didPK = v;
        break;;
    case 1038:
        self.userLoginPK = v;
        break;;
    case 1040:
        self.userPasswordPK = v;
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
    case 1042:
        return self.username;
    case 1044:
        return self.password;
    default:
        return [super getAttributeString:id_];
    }
}

-(void) setAttributeString:(int)id_:(SUPString)v
{
    switch(id_)
    {
    case 1042:
        self.username = v;
        break;;
    case 1044:
        self.password = v;
        break;;
    default:
        [super setAttributeString:id_:v];
        break;;
    }
}
-(SUPBoolean) getAttributeBoolean:(int)id_
{
    switch(id_)
    {
    case 1037:
        return self.didPKUserDefined;
    case 1039:
        return self.userLoginPKUserDefined;
    case 1041:
        return self.userPasswordPKUserDefined;
    case 1043:
        return self.usernameUserDefined;
    case 1045:
        return self.passwordUserDefined;
    default:
        return [super getAttributeBoolean:id_];
    }
}

-(void) setAttributeBoolean:(int)id_:(SUPBoolean)v
{
    switch(id_)
    {
    case 1037:
        self.didPKUserDefined = v;
        break;;
    case 1039:
        self.userLoginPKUserDefined = v;
        break;;
    case 1041:
        self.userPasswordPKUserDefined = v;
        break;;
    case 1043:
        self.usernameUserDefined = v;
        break;;
    case 1045:
        self.passwordUserDefined = v;
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
+ (ODMobilePersonalizationParameters*)getInstance
{
    ODMobilePersonalizationParameters* me = [[ODMobilePersonalizationParameters alloc] init];
    [me autorelease];
    return me;
}
- (void)dealloc
{
    if(_didPK)
    {
        [_didPK release];
        _didPK = nil;
    }
    if(_userLoginPK)
    {
        [_userLoginPK release];
        _userLoginPK = nil;
    }
    if(_userPasswordPK)
    {
        [_userPasswordPK release];
        _userPasswordPK = nil;
    }
    if(_username)
    {
        [_username release];
        _username = nil;
    }
    if(_password)
    {
        [_password release];
        _password = nil;
    }
	[super dealloc];
}

@end