#import "ODMobilePersonalizationParametersMetaData.h"

#import "SUPParameterMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "ODMobilePersonalizationParameters.h"
#import "SUPDataType.h"
#import "SUPAttributeMetaDataRBS.h"

@implementation ODMobilePersonalizationParametersMetaData

+ (ODMobilePersonalizationParametersMetaData*)getInstance
{
    return [[[ODMobilePersonalizationParametersMetaData alloc] init] autorelease];
}

- (id)init
{
	if (self = [super init]) {
		self.name = @"PersonalizationParameters";
		self.klass = [ODMobilePersonalizationParameters class];
 
		SUPObjectList *attributes = [SUPObjectList listWithCapacity:7];
		SUPAttributeMetaDataRBS* a_didPK = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			385:
			[SUPDataType forName:@"string?"]:@"varchar(300)":@"didPK":@"":@"":
			@"":300:0:0:
			@"null":YES:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_Client:NO];
  		[attributes addThis:a_didPK];
		SUPAttributeMetaDataRBS* a_didPKUserDefined = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			386:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"didPKUserDefined":@"":@"":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_didPKUserDefined];
		SUPAttributeMetaDataRBS* a_userLoginPK = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			387:
			[SUPDataType forName:@"string?"]:@"varchar(300)":@"userLoginPK":@"":@"":
			@"":300:0:0:
			@"null":YES:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_Client:NO];
  		[attributes addThis:a_userLoginPK];
		SUPAttributeMetaDataRBS* a_userLoginPKUserDefined = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			388:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"userLoginPKUserDefined":@"":@"":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_userLoginPKUserDefined];
		SUPAttributeMetaDataRBS* a_userPasswordPK = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			389:
			[SUPDataType forName:@"string?"]:@"varchar(300)":@"userPasswordPK":@"":@"":
			@"":300:0:0:
			@"null":YES:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_Client:NO];
  		[attributes addThis:a_userPasswordPK];
		SUPAttributeMetaDataRBS* a_userPasswordPKUserDefined = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			390:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"userPasswordPKUserDefined":@"":@"":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_userPasswordPKUserDefined];
		SUPAttributeMetaDataRBS* a_username = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			391:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"username":@"":@"":
			@"":300:0:0:
			@"null":YES:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_Session:NO];
  		[attributes addThis:a_username];
		SUPAttributeMetaDataRBS* a_usernameUserDefined = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			392:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"usernameUserDefined":@"":@"":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_usernameUserDefined];
		SUPAttributeMetaDataRBS* a_password = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			393:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"password":@"":@"":
			@"":300:0:0:
			@"null":YES:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_Session:YES];
  		[attributes addThis:a_password];
		SUPAttributeMetaDataRBS* a_passwordUserDefined = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			394:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"passwordUserDefined":@"":@"":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_passwordUserDefined];
 		self.attributes = attributes;
 		
 		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
    	[attributeMap setAttributes:attributes];
    	self.attributeMap = attributeMap;

	}
    return self;
}
@end