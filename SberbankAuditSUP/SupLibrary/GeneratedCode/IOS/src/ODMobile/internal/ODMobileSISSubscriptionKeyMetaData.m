#import "ODMobileSISSubscriptionKeyMetaData.h"

#import "SUPParameterMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "ODMobileSISSubscriptionKey.h"
#import "SUPDataType.h"
#import "SUPAttributeMetaDataRBS.h"

@implementation ODMobileSISSubscriptionKeyMetaData

+ (ODMobileSISSubscriptionKeyMetaData*)getInstance
{
    return [[[ODMobileSISSubscriptionKeyMetaData alloc] init] autorelease];
}

- (id)init
{
	if (self = [super init]) {
		self.name = @"SISSubscriptionKey";
		self.klass = [ODMobileSISSubscriptionKey class];
 
		SUPObjectList *attributes = [SUPObjectList listWithCapacity:7];
		SUPAttributeMetaDataRBS* a_domain = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			893:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"domain":@"":@"":
			@"":300:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_domain];
		SUPAttributeMetaDataRBS* a_package = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			894:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"package":@"":@"":
			@"":300:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_package];
		SUPAttributeMetaDataRBS* a_syncGroup = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			895:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"syncGroup":@"":@"":
			@"":300:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_syncGroup];
		SUPAttributeMetaDataRBS* a_clientId = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			896:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"clientId":@"":@"":
			@"":300:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_clientId];
 		self.attributes = attributes;
 		
 		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
    	[attributeMap setAttributes:attributes];
    	self.attributeMap = attributeMap;

	}
    return self;
}
@end