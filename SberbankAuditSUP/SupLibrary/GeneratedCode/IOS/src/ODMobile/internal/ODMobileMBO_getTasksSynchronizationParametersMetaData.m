#import "ODMobileMBO_getTasksSynchronizationParametersMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "ODMobileMBO_getTasksSynchronizationParameters.h"
#import "SUPOperationMap.h"
#import "ODMobileODMobileDB.h"
#import "SUPDataType.h"

@implementation ODMobileMBO_getTasksSynchronizationParametersMetaData

+ (ODMobileMBO_getTasksSynchronizationParametersMetaData*)getInstance
{
    return [[[ODMobileMBO_getTasksSynchronizationParametersMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 52;
		self.name = @"MBO_getTasksSynchronizationParameters";
		self.klass = [ODMobileMBO_getTasksSynchronizationParameters class];
 		self.allowPending = NO;;

		self.isClientOnly = YES;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_EMPLOYEE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			1012:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"EMPLOYEE_ID":@"":@"EMPLOYEE_ID":
			@"":80:0:0:
			@"0":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			YES:SUPPersonalizationType_None:NO];
		[a_EMPLOYEE_ID setColumn:@"EMPLOYEE_ID"];
		SUPAttributeMetaDataRBS* a_EMPLOYEE_IDUserDefined = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			1013:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"EMPLOYEE_IDUserDefined":@"":@"EMPLOYEE_IDUserDefined":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_EMPLOYEE_IDUserDefined setColumn:@"EMPLOYEE_IDUserDefined"];
		SUPAttributeMetaDataRBS* a_OBJECT_NAME = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			1014:
			[SUPDataType forName:@"string?"]:@"varchar(280)":@"OBJECT_NAME":@"":@"OBJECT_NAME":
			@"":280:0:0:
			@"SUP_FCT_TASKS":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			YES:SUPPersonalizationType_None:NO];
		[a_OBJECT_NAME setColumn:@"OBJECT_NAME"];
		SUPAttributeMetaDataRBS* a_OBJECT_NAMEUserDefined = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			1015:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"OBJECT_NAMEUserDefined":@"":@"OBJECT_NAMEUserDefined":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_OBJECT_NAMEUserDefined setColumn:@"OBJECT_NAMEUserDefined"];
		SUPAttributeMetaDataRBS* a_size_sp = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			1017:
			[SUPDataType forName:@"int"]:@"integer":@"size_sp":@"":@"size_sp":
			@"":-1:0:0:
			@"2":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_size_sp setColumn:@"size_sp"];
		SUPAttributeMetaDataRBS* a_user_sp = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			1016:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"user_sp":@"":@"user_sp":
			@"":300:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_user_sp setColumn:@"user_sp"];
 		
		[attributes addThis:a_EMPLOYEE_ID];
		[attributes addThis:a_EMPLOYEE_IDUserDefined];
		[attributes addThis:a_OBJECT_NAME];
		[attributes addThis:a_OBJECT_NAMEUserDefined];
		[attributes addThis:a_size_sp];
		[attributes addThis:a_user_sp];
		self.attributes = attributes;
		
		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
   		[attributeMap setAttributes:attributes];
	   	self.attributeMap = attributeMap;

 		SUPOperationMetaData* o_submitPending_0 = [SUPOperationMetaData createOperationMetaData:1:(SUPString)@"submitPending":[SUPDataType forName:@"void"]:true];
		[o_submitPending_0 setIsStatic:NO];
		[o_submitPending_0 setIsCreate:NO];
		[o_submitPending_0 setIsUpdate:NO];
		[o_submitPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_refresh_0 = [SUPOperationMetaData createOperationMetaData:2:(SUPString)@"refresh":[SUPDataType forName:@"void"]:true];
		[o_refresh_0 setIsStatic:NO];
		[o_refresh_0 setIsCreate:NO];
		[o_refresh_0 setIsUpdate:NO];
		[o_refresh_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o__pk_0 = [SUPOperationMetaData createOperationMetaData:3:(SUPString)@"_pk":[SUPDataType forName:@"string?"]:true];
		[o__pk_0 setIsStatic:NO];
		[o__pk_0 setIsCreate:NO];
		[o__pk_0 setIsUpdate:NO];
		[o__pk_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_save_0 = [SUPOperationMetaData createOperationMetaData:4:(SUPString)@"save":[SUPDataType forName:@"void"]:true];
		[o_save_0 setIsStatic:NO];
		[o_save_0 setIsCreate:NO];
		[o_save_0 setIsUpdate:NO];
		[o_save_0 setIsDelete:NO]; 		
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:4];
 		[operations addThis:o_submitPending_0];
 		[operations addThis:o_refresh_0];
 		[operations addThis:o__pk_0];
 		[operations addThis:o_save_0];
	 	self.operations = operations;
 	
		SUPOperationMap *operationMap = [SUPOperationMap getInstance];
		[operationMap setOperations:operations];
		self.operationMap = operationMap;		
		self.table = @"co_odmobile_1_21_mbo_gettaskssp";
		self.synchronizationGroup = @"";

			
		[self.keyList add:a_user_sp];


    }
    return self;
}
@end