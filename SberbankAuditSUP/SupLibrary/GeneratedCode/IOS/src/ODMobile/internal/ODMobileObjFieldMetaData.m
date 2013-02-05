#import "ODMobileObjFieldMetaData.h"

#import "SUPParameterMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "ODMobileObjField.h"
#import "SUPDataType.h"
#import "SUPAttributeMetaDataRBS.h"

@implementation ODMobileObjFieldMetaData

+ (ODMobileObjFieldMetaData*)getInstance
{
    return [[[ODMobileObjFieldMetaData alloc] init] autorelease];
}

- (id)init
{
	if (self = [super init]) {
		self.name = @"ObjField";
		self.klass = [ODMobileObjField class];
 
		SUPObjectList *attributes = [SUPObjectList listWithCapacity:7];
		SUPAttributeMetaDataRBS* a_vl = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			653:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"vl":@"":@"":
			@"":300:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_vl];
		SUPAttributeMetaDataRBS* a_nm = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			654:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"nm":@"":@"":
			@"":300:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_nm];
 		self.attributes = attributes;
 		
 		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
    	[attributeMap setAttributes:attributes];
    	self.attributeMap = attributeMap;

	}
    return self;
}
@end