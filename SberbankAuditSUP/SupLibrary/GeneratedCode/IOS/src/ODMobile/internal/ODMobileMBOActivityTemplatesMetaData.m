#import "ODMobileMBOActivityTemplatesMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "ODMobileMBOActivityTemplates.h"
#import "SUPOperationMap.h"
#import "ODMobileODMobileDB.h"
#import "SUPDataType.h"

@implementation ODMobileMBOActivityTemplatesMetaData

+ (ODMobileMBOActivityTemplatesMetaData*)getInstance
{
    return [[[ODMobileMBOActivityTemplatesMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 4;
		self.name = @"MBOActivityTemplates";
		self.klass = [ODMobileMBOActivityTemplates class];
 		self.allowPending = YES;;

		self.isClientOnly = NO;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_ACTIVITY_TEMPLATE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			659:
			[SUPDataType forName:@"string"]:@"varchar(80)":@"ACTIVITY_TEMPLATE_ID":@"":@"a":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_ACTIVITY_TEMPLATE_ID setColumn:@"a"];
		SUPAttributeMetaDataRBS* a_ACTIVITY_NAME = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			660:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"ACTIVITY_NAME":@"":@"b":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_ACTIVITY_NAME setColumn:@"b"];
		SUPAttributeMetaDataRBS* a_TIME_PERIOD = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			661:
			[SUPDataType forName:@"string?"]:@"varchar(40)":@"TIME_PERIOD":@"":@"c":
			@"":40:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_TIME_PERIOD setColumn:@"c"];
		SUPAttributeMetaDataRBS* a_ACTIVITY_TYPE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			662:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"ACTIVITY_TYPE_ID":@"":@"d":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_ACTIVITY_TYPE_ID setColumn:@"d"];
		SUPAttributeMetaDataRBS* a_CATEGORY_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			663:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"CATEGORY_ID":@"":@"e":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_CATEGORY_ID setColumn:@"e"];
		SUPAttributeMetaDataRBS* a_ACTIVITY_PRIORITY_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			664:
			[SUPDataType forName:@"string?"]:@"varchar(40)":@"ACTIVITY_PRIORITY_ID":@"":@"f":
			@"":40:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_ACTIVITY_PRIORITY_ID setColumn:@"f"];
		SUPAttributeMetaDataRBS* a_BUSINESS_PROCESS_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			665:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"BUSINESS_PROCESS_ID":@"":@"g":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_BUSINESS_PROCESS_ID setColumn:@"g"];
		SUPAttributeMetaDataRBS* a_QUESTION_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			666:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"QUESTION_ID":@"":@"h":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_QUESTION_ID setColumn:@"h"];
		SUPAttributeMetaDataRBS* a_ANSWER_ITEM_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			667:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"ANSWER_ITEM_ID":@"":@"i":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_ANSWER_ITEM_ID setColumn:@"i"];
		SUPAttributeMetaDataRBS* a_pending = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			20001:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"pending":@"":@"_pf":
			@"default 'N'":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_pending setColumn:@"_pf"];
		SUPAttributeMetaDataRBS* a_pendingChange = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			20002:
			[SUPDataType forName:@"char"]:@"char(1)":@"pendingChange":@"":@"_pc":
			@"":1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_pendingChange setColumn:@"_pc"];
		SUPAttributeMetaDataRBS* a_replayPending = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			20005:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"replayPending":@"":@"_rp":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_replayPending setColumn:@"_rp"];
		SUPAttributeMetaDataRBS* a_replayFailure = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			20006:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"replayFailure":@"":@"_rf":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_replayFailure setColumn:@"_rf"];
		SUPAttributeMetaDataRBS* a_surrogateKey = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			668:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"surrogateKey":@"":@"j":
			@"":-1:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_GLOBAL:
			NO:SUPPersonalizationType_None:NO];
		[a_surrogateKey setColumn:@"j"];
		SUPAttributeMetaDataRBS* a_replayCounter = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			20004:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"replayCounter":@"_rc":@"_rc":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_replayCounter setColumn:@"_rc"];
		SUPAttributeMetaDataRBS* a_disableSubmit = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			20003:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"disableSubmit":@"":@"_ds":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_disableSubmit setColumn:@"_ds"];
 		
		[attributes addThis:a_ACTIVITY_TEMPLATE_ID];
		[attributes addThis:a_ACTIVITY_NAME];
		[attributes addThis:a_TIME_PERIOD];
		[attributes addThis:a_ACTIVITY_TYPE_ID];
		[attributes addThis:a_CATEGORY_ID];
		[attributes addThis:a_ACTIVITY_PRIORITY_ID];
		[attributes addThis:a_BUSINESS_PROCESS_ID];
		[attributes addThis:a_QUESTION_ID];
		[attributes addThis:a_ANSWER_ITEM_ID];
		[attributes addThis:a_pending];
		[attributes addThis:a_pendingChange];
		[attributes addThis:a_replayPending];
		[attributes addThis:a_replayFailure];
		[attributes addThis:a_surrogateKey];
		[attributes addThis:a_replayCounter];
		[attributes addThis:a_disableSubmit];
		self.attributes = attributes;
		
		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
   		[attributeMap setAttributes:attributes];
	   	self.attributeMap = attributeMap;

 		SUPOperationMetaData* o_findAll_0 = [SUPOperationMetaData createOperationMetaData:1:(SUPString)@"findAll":[SUPDataType forName:@"MBOActivityTemplates*"]:true];
		[o_findAll_0 setIsStatic:YES];
		[o_findAll_0 setIsCreate:NO];
		[o_findAll_0 setIsUpdate:NO];
		[o_findAll_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findByPrimaryKey_1 = [SUPOperationMetaData createOperationMetaData:2:(SUPString)@"findByPrimaryKey":[SUPDataType forName:@"MBOActivityTemplates"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_findByPrimaryKey_ACTIVITY_TEMPLATE_ID = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"ACTIVITY_TEMPLATE_ID":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_findByPrimaryKey_ACTIVITY_TEMPLATE_ID];
			o_findByPrimaryKey_1.parameters = parameters_list;
	 	}
		[o_findByPrimaryKey_1 setIsStatic:YES];
		[o_findByPrimaryKey_1 setIsCreate:NO];
		[o_findByPrimaryKey_1 setIsUpdate:NO];
		[o_findByPrimaryKey_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getByActivityTypeId_1 = [SUPOperationMetaData createOperationMetaData:3:(SUPString)@"getByActivityTypeId":[SUPDataType forName:@"MBOActivityTemplates*"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getByActivityTypeId_ACTIVITY_TYPE_ID = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"ACTIVITY_TYPE_ID":[SUPDataType forName:@"string?"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_getByActivityTypeId_ACTIVITY_TYPE_ID];
			o_getByActivityTypeId_1.parameters = parameters_list;
	 	}
		[o_getByActivityTypeId_1 setIsStatic:YES];
		[o_getByActivityTypeId_1 setIsCreate:NO];
		[o_getByActivityTypeId_1 setIsUpdate:NO];
		[o_getByActivityTypeId_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getByQuestionAndAnswerId_2 = [SUPOperationMetaData createOperationMetaData:4:(SUPString)@"getByQuestionAndAnswerId":[SUPDataType forName:@"MBOActivityTemplates*"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getByQuestionAndAnswerId_QUESTION_ID = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"QUESTION_ID":[SUPDataType forName:@"string?"]];
	 		SUPParameterMetaData* p_getByQuestionAndAnswerId_ANSWER_ITEM_ID = [SUPParameterMetaData createParameterMetaData:2:(SUPString)@"ANSWER_ITEM_ID":[SUPDataType forName:@"string?"]];
 			parameters_list = [SUPObjectList listWithCapacity:2];
			[parameters_list addThis:p_getByQuestionAndAnswerId_QUESTION_ID];
			[parameters_list addThis:p_getByQuestionAndAnswerId_ANSWER_ITEM_ID];
			o_getByQuestionAndAnswerId_2.parameters = parameters_list;
	 	}
		[o_getByQuestionAndAnswerId_2 setIsStatic:YES];
		[o_getByQuestionAndAnswerId_2 setIsCreate:NO];
		[o_getByQuestionAndAnswerId_2 setIsUpdate:NO];
		[o_getByQuestionAndAnswerId_2 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_refresh_0 = [SUPOperationMetaData createOperationMetaData:5:(SUPString)@"refresh":[SUPDataType forName:@"void"]:true];
		[o_refresh_0 setIsStatic:NO];
		[o_refresh_0 setIsCreate:NO];
		[o_refresh_0 setIsUpdate:NO];
		[o_refresh_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o__pk_0 = [SUPOperationMetaData createOperationMetaData:6:(SUPString)@"_pk":[SUPDataType forName:@"long?"]:true];
		[o__pk_0 setIsStatic:NO];
		[o__pk_0 setIsCreate:NO];
		[o__pk_0 setIsUpdate:NO];
		[o__pk_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_submitPending_0 = [SUPOperationMetaData createOperationMetaData:7:(SUPString)@"submitPending":[SUPDataType forName:@"void"]:true];
		[o_submitPending_0 setIsStatic:NO];
		[o_submitPending_0 setIsCreate:NO];
		[o_submitPending_0 setIsUpdate:NO];
		[o_submitPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_cancelPending_0 = [SUPOperationMetaData createOperationMetaData:8:(SUPString)@"cancelPending":[SUPDataType forName:@"void"]:true];
		[o_cancelPending_0 setIsStatic:NO];
		[o_cancelPending_0 setIsCreate:NO];
		[o_cancelPending_0 setIsUpdate:NO];
		[o_cancelPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_submitPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:9:(SUPString)@"submitPendingOperations":[SUPDataType forName:@"void"]:true];
		[o_submitPendingOperations_0 setIsStatic:YES];
		[o_submitPendingOperations_0 setIsCreate:NO];
		[o_submitPendingOperations_0 setIsUpdate:NO];
		[o_submitPendingOperations_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_cancelPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:10:(SUPString)@"cancelPendingOperations":[SUPDataType forName:@"void"]:true];
		[o_cancelPendingOperations_0 setIsStatic:YES];
		[o_cancelPendingOperations_0 setIsCreate:NO];
		[o_cancelPendingOperations_0 setIsUpdate:NO];
		[o_cancelPendingOperations_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_save_0 = [SUPOperationMetaData createOperationMetaData:11:(SUPString)@"save":[SUPDataType forName:@"void"]:true];
		[o_save_0 setIsStatic:NO];
		[o_save_0 setIsCreate:NO];
		[o_save_0 setIsUpdate:NO];
		[o_save_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findWithQuery_1 = [SUPOperationMetaData createOperationMetaData:12:(SUPString)@"findWithQuery":[SUPDataType forName:@"MBOActivityTemplates*"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_findWithQuery_query = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"query":[SUPDataType forName:@"com.sybase.persistence.Query"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_findWithQuery_query];
			o_findWithQuery_1.parameters = parameters_list;
	 	}
		[o_findWithQuery_1 setIsStatic:YES];
		[o_findWithQuery_1 setIsCreate:NO];
		[o_findWithQuery_1 setIsUpdate:NO];
		[o_findWithQuery_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getSize_1 = [SUPOperationMetaData createOperationMetaData:13:(SUPString)@"getSize":[SUPDataType forName:@"int"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getSize_query = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"query":[SUPDataType forName:@"com.sybase.persistence.Query"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_getSize_query];
			o_getSize_1.parameters = parameters_list;
	 	}
		[o_getSize_1 setIsStatic:YES];
		[o_getSize_1 setIsCreate:NO];
		[o_getSize_1 setIsUpdate:NO];
		[o_getSize_1 setIsDelete:NO]; 		
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:13];
 		[operations addThis:o_findAll_0];
 		[operations addThis:o_findByPrimaryKey_1];
 		[operations addThis:o_getByActivityTypeId_1];
 		[operations addThis:o_getByQuestionAndAnswerId_2];
 		[operations addThis:o_refresh_0];
 		[operations addThis:o__pk_0];
 		[operations addThis:o_submitPending_0];
 		[operations addThis:o_cancelPending_0];
 		[operations addThis:o_submitPendingOperations_0];
 		[operations addThis:o_cancelPendingOperations_0];
 		[operations addThis:o_save_0];
 		[operations addThis:o_findWithQuery_1];
 		[operations addThis:o_getSize_1];
	 	self.operations = operations;
 	
		SUPOperationMap *operationMap = [SUPOperationMap getInstance];
		[operationMap setOperations:operations];
		self.operationMap = operationMap;		
		self.table = @"odmobile_1_21_mboactivitytemplates";
		self.synchronizationGroup = @"DIMSG";

		SUPIndexMetaData *i_findByPrimaryKeyIndex = [[[SUPIndexMetaData alloc] init] autorelease];
		i_findByPrimaryKeyIndex.name = @"findByPrimaryKeyIndex";
		[i_findByPrimaryKeyIndex.attributes add:a_ACTIVITY_TEMPLATE_ID];
	
		SUPIndexMetaData *i_getByActivityTypeIdIndex = [[[SUPIndexMetaData alloc] init] autorelease];
		i_getByActivityTypeIdIndex.name = @"getByActivityTypeIdIndex";
		[i_getByActivityTypeIdIndex.attributes add:a_ACTIVITY_TYPE_ID];
	
		[self.indexList add:i_findByPrimaryKeyIndex];
		[self.indexList add:i_getByActivityTypeIdIndex];
			
		[self.keyList add:a_surrogateKey];


    }
    return self;
}
@end