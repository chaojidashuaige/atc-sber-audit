#import "ODMobileMBO_getActivitiesMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "ODMobileMBO_getActivities.h"
#import "SUPOperationMap.h"
#import "ODMobileODMobileDB.h"
#import "SUPDataType.h"

@implementation ODMobileMBO_getActivitiesMetaData

+ (ODMobileMBO_getActivitiesMetaData*)getInstance
{
    return [[[ODMobileMBO_getActivitiesMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 26;
		self.name = @"MBO_getActivities";
		self.klass = [ODMobileMBO_getActivities class];
 		self.allowPending = YES;;

		self.isClientOnly = NO;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_EMPLOYEE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			746:
			[SUPDataType forName:@"string"]:@"varchar(80)":@"EMPLOYEE_ID":@"":@"a":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_EMPLOYEE_ID setColumn:@"a"];
		SUPAttributeMetaDataRBS* a_ACTIVITY_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			747:
			[SUPDataType forName:@"string"]:@"varchar(80)":@"ACTIVITY_ID":@"":@"b":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_ACTIVITY_ID setColumn:@"b"];
		SUPAttributeMetaDataRBS* a_ACTIVITY_TYPE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			748:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"ACTIVITY_TYPE_ID":@"":@"c":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_ACTIVITY_TYPE_ID setColumn:@"c"];
		SUPAttributeMetaDataRBS* a_UNION_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			749:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"UNION_ID":@"":@"d":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_UNION_ID setColumn:@"d"];
		SUPAttributeMetaDataRBS* a_ACTIVITY_NAME = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			750:
			[SUPDataType forName:@"string?"]:@"varchar(2000)":@"ACTIVITY_NAME":@"":@"e":
			@"":2000:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_ACTIVITY_NAME setColumn:@"e"];
		SUPAttributeMetaDataRBS* a_ACTIVITY_PRIORITY_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			751:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"ACTIVITY_PRIORITY_ID":@"":@"f":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_ACTIVITY_PRIORITY_ID setColumn:@"f"];
		SUPAttributeMetaDataRBS* a_PROBLEMS = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			752:
			[SUPDataType forName:@"string?"]:@"varchar(2000)":@"PROBLEMS":@"":@"g":
			@"":2000:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_PROBLEMS setColumn:@"g"];
		SUPAttributeMetaDataRBS* a_DUEDATE_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			753:
			[SUPDataType forName:@"string?"]:@"varchar(120)":@"DUEDATE_DTTM":@"":@"h":
			@"":120:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_DUEDATE_DTTM setColumn:@"h"];
		SUPAttributeMetaDataRBS* a_CREATOR_EMPLOYEE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			754:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"CREATOR_EMPLOYEE_ID":@"":@"i":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_CREATOR_EMPLOYEE_ID setColumn:@"i"];
		SUPAttributeMetaDataRBS* a_RESPONSIBLE_EMPLOYEE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			755:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"RESPONSIBLE_EMPLOYEE_ID":@"":@"j":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_RESPONSIBLE_EMPLOYEE_ID setColumn:@"j"];
		SUPAttributeMetaDataRBS* a_INSPECTOR_EMPLOYEE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			756:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"INSPECTOR_EMPLOYEE_ID":@"":@"l":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_INSPECTOR_EMPLOYEE_ID setColumn:@"l"];
		SUPAttributeMetaDataRBS* a_FACT_END_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			757:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"FACT_END_DTTM":@"":@"m":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_FACT_END_DTTM setColumn:@"m"];
		SUPAttributeMetaDataRBS* a_CLOSE_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			758:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"CLOSE_DTTM":@"":@"n":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_CLOSE_DTTM setColumn:@"n"];
		SUPAttributeMetaDataRBS* a_RESPONSIBLE_DESC = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			759:
			[SUPDataType forName:@"string?"]:@"varchar(2000)":@"RESPONSIBLE_DESC":@"":@"o":
			@"":2000:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_RESPONSIBLE_DESC setColumn:@"o"];
		SUPAttributeMetaDataRBS* a_INSPECTOR_DESC = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			760:
			[SUPDataType forName:@"string?"]:@"varchar(2000)":@"INSPECTOR_DESC":@"":@"p":
			@"":2000:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_INSPECTOR_DESC setColumn:@"p"];
		SUPAttributeMetaDataRBS* a_ACTIVITY_STATUS_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			761:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"ACTIVITY_STATUS_ID":@"":@"q":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_ACTIVITY_STATUS_ID setColumn:@"q"];
		SUPAttributeMetaDataRBS* a_TASK_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			762:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"TASK_ID":@"":@"r":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_TASK_ID setColumn:@"r"];
		SUPAttributeMetaDataRBS* a_QUESTION_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			763:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"QUESTION_ID":@"":@"s":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_QUESTION_ID setColumn:@"s"];
		SUPAttributeMetaDataRBS* a_SUBBRANCH_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			764:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"SUBBRANCH_ID":@"":@"t":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_SUBBRANCH_ID setColumn:@"t"];
		SUPAttributeMetaDataRBS* a_ANSWER_ITEM_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			765:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"ANSWER_ITEM_ID":@"":@"u":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_ANSWER_ITEM_ID setColumn:@"u"];
		SUPAttributeMetaDataRBS* a_CHANGED_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			766:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"CHANGED_DTTM":@"":@"v":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_CHANGED_DTTM setColumn:@"v"];
		SUPAttributeMetaDataRBS* a_CREATED_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			767:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"CREATED_DTTM":@"":@"w":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_CREATED_DTTM setColumn:@"w"];
		SUPAttributeMetaDataRBS* a_createCalled = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			769:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"createCalled":@"":@"y":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_createCalled setColumn:@"y"];
		SUPAttributeMetaDataRBS* a_createObjectName = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			770:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"createObjectName":@"":@"z":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_createObjectName setColumn:@"z"];
		SUPAttributeMetaDataRBS* a_createOdObject = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			771:
			[SUPDataType forName:@"OdObject?"]:@"LONG VARCHAR":@"createOdObject":@"":@"ba":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_createOdObject setColumn:@"ba"];
		SUPAttributeMetaDataRBS* a_updateCalled = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			772:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"updateCalled":@"":@"bb":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_updateCalled setColumn:@"bb"];
		SUPAttributeMetaDataRBS* a_updateObjectName = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			773:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"updateObjectName":@"":@"bc":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_updateObjectName setColumn:@"bc"];
		SUPAttributeMetaDataRBS* a_updateOdObject = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			774:
			[SUPDataType forName:@"OdObject?"]:@"LONG VARCHAR":@"updateOdObject":@"":@"bd":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_updateOdObject setColumn:@"bd"];
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
			768:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"surrogateKey":@"":@"x":
			@"":-1:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_GLOBAL:
			NO:SUPPersonalizationType_None:NO];
		[a_surrogateKey setColumn:@"x"];
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
 		
		[attributes addThis:a_EMPLOYEE_ID];
		[attributes addThis:a_ACTIVITY_ID];
		[attributes addThis:a_ACTIVITY_TYPE_ID];
		[attributes addThis:a_UNION_ID];
		[attributes addThis:a_ACTIVITY_NAME];
		[attributes addThis:a_ACTIVITY_PRIORITY_ID];
		[attributes addThis:a_PROBLEMS];
		[attributes addThis:a_DUEDATE_DTTM];
		[attributes addThis:a_CREATOR_EMPLOYEE_ID];
		[attributes addThis:a_RESPONSIBLE_EMPLOYEE_ID];
		[attributes addThis:a_INSPECTOR_EMPLOYEE_ID];
		[attributes addThis:a_FACT_END_DTTM];
		[attributes addThis:a_CLOSE_DTTM];
		[attributes addThis:a_RESPONSIBLE_DESC];
		[attributes addThis:a_INSPECTOR_DESC];
		[attributes addThis:a_ACTIVITY_STATUS_ID];
		[attributes addThis:a_TASK_ID];
		[attributes addThis:a_QUESTION_ID];
		[attributes addThis:a_SUBBRANCH_ID];
		[attributes addThis:a_ANSWER_ITEM_ID];
		[attributes addThis:a_CHANGED_DTTM];
		[attributes addThis:a_CREATED_DTTM];
		[attributes addThis:a_createCalled];
		[attributes addThis:a_createObjectName];
		[attributes addThis:a_createOdObject];
		[attributes addThis:a_updateCalled];
		[attributes addThis:a_updateObjectName];
		[attributes addThis:a_updateOdObject];
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

 		SUPOperationMetaData* o_create_2 = [SUPOperationMetaData createOperationMetaData:1:(SUPString)@"create":[SUPDataType forName:@"void"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_create_objectName = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"objectName":[SUPDataType forName:@"string?"]];
	 		SUPParameterMetaData* p_create_odObject = [SUPParameterMetaData createParameterMetaData:2:(SUPString)@"odObject":[SUPDataType forName:@"OdObject"]];
 			parameters_list = [SUPObjectList listWithCapacity:2];
			[parameters_list addThis:p_create_objectName];
			[parameters_list addThis:p_create_odObject];
			o_create_2.parameters = parameters_list;
	 	}
		[o_create_2 setIsStatic:NO];
		[o_create_2 setIsCreate:YES];
		[o_create_2 setIsUpdate:NO];
		[o_create_2 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_update_2 = [SUPOperationMetaData createOperationMetaData:2:(SUPString)@"update":[SUPDataType forName:@"void"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_update_objectName = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"objectName":[SUPDataType forName:@"string?"]];
	 		SUPParameterMetaData* p_update_odObject = [SUPParameterMetaData createParameterMetaData:2:(SUPString)@"odObject":[SUPDataType forName:@"OdObject"]];
 			parameters_list = [SUPObjectList listWithCapacity:2];
			[parameters_list addThis:p_update_objectName];
			[parameters_list addThis:p_update_odObject];
			o_update_2.parameters = parameters_list;
	 	}
		[o_update_2 setIsStatic:NO];
		[o_update_2 setIsCreate:NO];
		[o_update_2 setIsUpdate:YES];
		[o_update_2 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findAll_0 = [SUPOperationMetaData createOperationMetaData:3:(SUPString)@"findAll":[SUPDataType forName:@"MBO_getActivities*"]:true];
		[o_findAll_0 setIsStatic:YES];
		[o_findAll_0 setIsCreate:NO];
		[o_findAll_0 setIsUpdate:NO];
		[o_findAll_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findByPrimaryKey_1 = [SUPOperationMetaData createOperationMetaData:4:(SUPString)@"findByPrimaryKey":[SUPDataType forName:@"MBO_getActivities"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_findByPrimaryKey_ACTIVITY_ID = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"ACTIVITY_ID":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_findByPrimaryKey_ACTIVITY_ID];
			o_findByPrimaryKey_1.parameters = parameters_list;
	 	}
		[o_findByPrimaryKey_1 setIsStatic:YES];
		[o_findByPrimaryKey_1 setIsCreate:NO];
		[o_findByPrimaryKey_1 setIsUpdate:NO];
		[o_findByPrimaryKey_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getActivitiesBySubbranchId_1 = [SUPOperationMetaData createOperationMetaData:5:(SUPString)@"getActivitiesBySubbranchId":[SUPDataType forName:@"com.sybase.persistence.QueryResultSet"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getActivitiesBySubbranchId_subbranchId = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"subbranchId":[SUPDataType forName:@"string?"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_getActivitiesBySubbranchId_subbranchId];
			o_getActivitiesBySubbranchId_1.parameters = parameters_list;
	 	}
		[o_getActivitiesBySubbranchId_1 setIsStatic:YES];
		[o_getActivitiesBySubbranchId_1 setIsCreate:NO];
		[o_getActivitiesBySubbranchId_1 setIsUpdate:NO];
		[o_getActivitiesBySubbranchId_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_refresh_0 = [SUPOperationMetaData createOperationMetaData:6:(SUPString)@"refresh":[SUPDataType forName:@"void"]:true];
		[o_refresh_0 setIsStatic:NO];
		[o_refresh_0 setIsCreate:NO];
		[o_refresh_0 setIsUpdate:NO];
		[o_refresh_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o__pk_0 = [SUPOperationMetaData createOperationMetaData:7:(SUPString)@"_pk":[SUPDataType forName:@"long?"]:true];
		[o__pk_0 setIsStatic:NO];
		[o__pk_0 setIsCreate:NO];
		[o__pk_0 setIsUpdate:NO];
		[o__pk_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_submitPending_0 = [SUPOperationMetaData createOperationMetaData:8:(SUPString)@"submitPending":[SUPDataType forName:@"void"]:true];
		[o_submitPending_0 setIsStatic:NO];
		[o_submitPending_0 setIsCreate:NO];
		[o_submitPending_0 setIsUpdate:NO];
		[o_submitPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_cancelPending_0 = [SUPOperationMetaData createOperationMetaData:9:(SUPString)@"cancelPending":[SUPDataType forName:@"void"]:true];
		[o_cancelPending_0 setIsStatic:NO];
		[o_cancelPending_0 setIsCreate:NO];
		[o_cancelPending_0 setIsUpdate:NO];
		[o_cancelPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_submitPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:10:(SUPString)@"submitPendingOperations":[SUPDataType forName:@"void"]:true];
		[o_submitPendingOperations_0 setIsStatic:YES];
		[o_submitPendingOperations_0 setIsCreate:NO];
		[o_submitPendingOperations_0 setIsUpdate:NO];
		[o_submitPendingOperations_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_cancelPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:11:(SUPString)@"cancelPendingOperations":[SUPDataType forName:@"void"]:true];
		[o_cancelPendingOperations_0 setIsStatic:YES];
		[o_cancelPendingOperations_0 setIsCreate:NO];
		[o_cancelPendingOperations_0 setIsUpdate:NO];
		[o_cancelPendingOperations_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getSynchronizationParameters_0 = [SUPOperationMetaData createOperationMetaData:12:(SUPString)@"getSynchronizationParameters":[SUPDataType forName:@"MBO_getActivitiesSynchronizationParameters"]:true];
		[o_getSynchronizationParameters_0 setIsStatic:YES];
		[o_getSynchronizationParameters_0 setIsCreate:NO];
		[o_getSynchronizationParameters_0 setIsUpdate:NO];
		[o_getSynchronizationParameters_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_save_0 = [SUPOperationMetaData createOperationMetaData:13:(SUPString)@"save":[SUPDataType forName:@"void"]:true];
		[o_save_0 setIsStatic:NO];
		[o_save_0 setIsCreate:NO];
		[o_save_0 setIsUpdate:NO];
		[o_save_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findWithQuery_1 = [SUPOperationMetaData createOperationMetaData:14:(SUPString)@"findWithQuery":[SUPDataType forName:@"MBO_getActivities*"]:true];
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
 		SUPOperationMetaData* o_getSize_1 = [SUPOperationMetaData createOperationMetaData:15:(SUPString)@"getSize":[SUPDataType forName:@"int"]:true];
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
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:15];
 		[operations addThis:o_create_2];
 		[operations addThis:o_update_2];
 		[operations addThis:o_findAll_0];
 		[operations addThis:o_findByPrimaryKey_1];
 		[operations addThis:o_getActivitiesBySubbranchId_1];
 		[operations addThis:o_refresh_0];
 		[operations addThis:o__pk_0];
 		[operations addThis:o_submitPending_0];
 		[operations addThis:o_cancelPending_0];
 		[operations addThis:o_submitPendingOperations_0];
 		[operations addThis:o_cancelPendingOperations_0];
 		[operations addThis:o_getSynchronizationParameters_0];
 		[operations addThis:o_save_0];
 		[operations addThis:o_findWithQuery_1];
 		[operations addThis:o_getSize_1];
	 	self.operations = operations;
 	
		SUPOperationMap *operationMap = [SUPOperationMap getInstance];
		[operationMap setOperations:operations];
		self.operationMap = operationMap;		
		self.table = @"odmobile_1_21_mbo_getactivities";
		self.synchronizationGroup = @"TasksSG";

		SUPIndexMetaData *i_findByPrimaryKeyIndex = [[[SUPIndexMetaData alloc] init] autorelease];
		i_findByPrimaryKeyIndex.name = @"findByPrimaryKeyIndex";
		[i_findByPrimaryKeyIndex.attributes add:a_ACTIVITY_ID];
	
		SUPIndexMetaData *i_getActivitiesBySubbranchIdIndex = [[[SUPIndexMetaData alloc] init] autorelease];
		i_getActivitiesBySubbranchIdIndex.name = @"getActivitiesBySubbranchIdIndex";
		[i_getActivitiesBySubbranchIdIndex.attributes add:a_SUBBRANCH_ID];
	
		[self.indexList add:i_findByPrimaryKeyIndex];
		[self.indexList add:i_getActivitiesBySubbranchIdIndex];
			
		[self.keyList add:a_surrogateKey];


    }
    return self;
}
@end