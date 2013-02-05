#import "ODMobileOdObjectMetaData.h"

#import "SUPParameterMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "ODMobileOdObject.h"
#import "SUPDataType.h"
#import "SUPAttributeMetaDataRBS.h"

@implementation ODMobileOdObjectMetaData

+ (ODMobileOdObjectMetaData*)getInstance
{
    return [[[ODMobileOdObjectMetaData alloc] init] autorelease];
}

- (id)init
{
	if (self = [super init]) {
		self.name = @"OdObject";
		self.klass = [ODMobileOdObject class];
 
		SUPObjectList *attributes = [SUPObjectList listWithCapacity:7];
		SUPAttributeMetaDataRBS* a_fl = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			651:
			[SUPDataType forName:@"ObjField*"]:@"ObjField*":@"fl":@"":@"":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_fl];
		SUPAttributeMetaDataRBS* a_rn = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			652:
			[SUPDataType forName:@"long?"]:@"decimal(20,0)":@"rn":@"":@"":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
  		[attributes addThis:a_rn];
 		self.attributes = attributes;
 		
 		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
    	[attributeMap setAttributes:attributes];
    	self.attributeMap = attributeMap;

	}
    return self;
}
@end