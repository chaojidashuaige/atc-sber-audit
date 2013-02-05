#import "ODMobileClientPersonalizationMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "ODMobileClientPersonalization.h"
#import "SUPOperationMap.h"
#import "ODMobileODMobileDB.h"
#import "SUPDataType.h"

@implementation ODMobileClientPersonalizationMetaData

+ (ODMobileClientPersonalizationMetaData*)getInstance
{
    return [[[ODMobileClientPersonalizationMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 53;
		self.name = @"ClientPersonalization";
		self.klass = [ODMobileClientPersonalization class];
 		self.allowPending = NO;;

		self.isClientOnly = YES;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_key_name = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			1024:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"key_name":@"":@"key_name":
			@"":300:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_key_name setColumn:@"key_name"];
		SUPAttributeMetaDataRBS* a_user = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			1025:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"user":@"":@"user":
			@"":300:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_user setColumn:@"user"];
		SUPAttributeMetaDataRBS* a_value = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			1026:
			[SUPDataType forName:@"string?"]:@"LONG VARCHAR":@"value":@"":@"value":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_value setColumn:@"value"];
		SUPAttributeMetaDataRBS* a_user_defined = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			1027:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"user_defined":@"":@"user_defined":
			@"":-1:0:0:
			@"true":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_user_defined setColumn:@"user_defined"];
		SUPAttributeMetaDataRBS* a_description = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			1028:
			[SUPDataType forName:@"string?"]:@"varchar(300)":@"description":@"":@"description":
			@"":300:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_description setColumn:@"description"];
		SUPAttributeMetaDataRBS* a_id = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			1023:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"id":@"":@"id":
			@"":-1:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_LOCAL:
			NO:SUPPersonalizationType_None:NO];
		[a_id setColumn:@"id"];
 		
		[attributes addThis:a_key_name];
		[attributes addThis:a_user];
		[attributes addThis:a_value];
		[attributes addThis:a_user_defined];
		[attributes addThis:a_description];
		[attributes addThis:a_id];
		self.attributes = attributes;
		
		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
   		[attributeMap setAttributes:attributes];
	   	self.attributeMap = attributeMap;

 		SUPOperationMetaData* o_refresh_0 = [SUPOperationMetaData createOperationMetaData:1:(SUPString)@"refresh":[SUPDataType forName:@"void"]:true];
		[o_refresh_0 setIsStatic:NO];
		[o_refresh_0 setIsCreate:NO];
		[o_refresh_0 setIsUpdate:NO];
		[o_refresh_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o__pk_0 = [SUPOperationMetaData createOperationMetaData:2:(SUPString)@"_pk":[SUPDataType forName:@"long?"]:true];
		[o__pk_0 setIsStatic:NO];
		[o__pk_0 setIsCreate:NO];
		[o__pk_0 setIsUpdate:NO];
		[o__pk_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_save_0 = [SUPOperationMetaData createOperationMetaData:3:(SUPString)@"save":[SUPDataType forName:@"void"]:true];
		[o_save_0 setIsStatic:NO];
		[o_save_0 setIsCreate:NO];
		[o_save_0 setIsUpdate:NO];
		[o_save_0 setIsDelete:NO]; 		
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:3];
 		[operations addThis:o_refresh_0];
 		[operations addThis:o__pk_0];
 		[operations addThis:o_save_0];
	 	self.operations = operations;
 	
		SUPOperationMap *operationMap = [SUPOperationMap getInstance];
		[operationMap setOperations:operations];
		self.operationMap = operationMap;		
		self.table = @"co_odmobile_1_21_clientpersonalization";
		self.synchronizationGroup = @"";

			
		[self.keyList add:a_id];


    }
    return self;
}
@end