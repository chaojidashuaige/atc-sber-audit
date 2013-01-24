#import "ODMobileMBO_getTasksMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "ODMobileMBO_getTasks.h"
#import "SUPOperationMap.h"
#import "ODMobileODMobileDB.h"
#import "SUPDataType.h"

@implementation ODMobileMBO_getTasksMetaData

+ (ODMobileMBO_getTasksMetaData*)getInstance
{
    return [[[ODMobileMBO_getTasksMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 38;
		self.name = @"MBO_getTasks";
		self.klass = [ODMobileMBO_getTasks class];
 		self.allowPending = YES;;

		self.isClientOnly = NO;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_UNION_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			179:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"UNION_ID":@"":@"a":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_UNION_ID setColumn:@"a"];
		SUPAttributeMetaDataRBS* a_TASK_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			180:
			[SUPDataType forName:@"string"]:@"varchar(80)":@"TASK_ID":@"":@"b":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_TASK_ID setColumn:@"b"];
		SUPAttributeMetaDataRBS* a_TASK_TYPE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			181:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"TASK_TYPE_ID":@"":@"c":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_TASK_TYPE_ID setColumn:@"c"];
		SUPAttributeMetaDataRBS* a_TASK_STATUS_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			182:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"TASK_STATUS_ID":@"":@"d":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_TASK_STATUS_ID setColumn:@"d"];
		SUPAttributeMetaDataRBS* a_CREATOR_EMPLOYEE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			183:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"CREATOR_EMPLOYEE_ID":@"":@"e":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_CREATOR_EMPLOYEE_ID setColumn:@"e"];
		SUPAttributeMetaDataRBS* a_RESOURCE_EMPLOYEE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			184:
			[SUPDataType forName:@"string"]:@"varchar(80)":@"RESOURCE_EMPLOYEE_ID":@"":@"f":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_RESOURCE_EMPLOYEE_ID setColumn:@"f"];
		SUPAttributeMetaDataRBS* a_TASK_DURATION = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			185:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"TASK_DURATION":@"":@"g":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_TASK_DURATION setColumn:@"g"];
		SUPAttributeMetaDataRBS* a_TASK_DESC = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			186:
			[SUPDataType forName:@"string?"]:@"varchar(2000)":@"TASK_DESC":@"":@"h":
			@"":2000:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_TASK_DESC setColumn:@"h"];
		SUPAttributeMetaDataRBS* a_PLAN_START_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			187:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"PLAN_START_DTTM":@"":@"i":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_PLAN_START_DTTM setColumn:@"i"];
		SUPAttributeMetaDataRBS* a_CHECKLIST_TEMPLATE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			188:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"CHECKLIST_TEMPLATE_ID":@"":@"j":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_CHECKLIST_TEMPLATE_ID setColumn:@"j"];
		SUPAttributeMetaDataRBS* a_INITIAL_DATA = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			189:
			[SUPDataType forName:@"string?"]:@"LONG VARCHAR":@"INITIAL_DATA":@"":@"l":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_INITIAL_DATA setColumn:@"l"];
		SUPAttributeMetaDataRBS* a_SUBBRANCH_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			190:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"SUBBRANCH_ID":@"":@"m":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_SUBBRANCH_ID setColumn:@"m"];
		SUPAttributeMetaDataRBS* a_FACT_START_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			191:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"FACT_START_DTTM":@"":@"n":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_FACT_START_DTTM setColumn:@"n"];
		SUPAttributeMetaDataRBS* a_FACT_END_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			192:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"FACT_END_DTTM":@"":@"o":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_FACT_END_DTTM setColumn:@"o"];
		SUPAttributeMetaDataRBS* a_SELF_CHECK_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			193:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"SELF_CHECK_ID":@"":@"p":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_SELF_CHECK_ID setColumn:@"p"];
		SUPAttributeMetaDataRBS* a_SELF_CHECK_RESOURCE_FIO = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			194:
			[SUPDataType forName:@"string?"]:@"varchar(400)":@"SELF_CHECK_RESOURCE_FIO":@"":@"q":
			@"":400:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_SELF_CHECK_RESOURCE_FIO setColumn:@"q"];
		SUPAttributeMetaDataRBS* a_SELF_CHECK_FACT_END_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			195:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"SELF_CHECK_FACT_END_DTTM":@"":@"r":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_SELF_CHECK_FACT_END_DTTM setColumn:@"r"];
		SUPAttributeMetaDataRBS* a_OTHER_CHECK_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			196:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"OTHER_CHECK_ID":@"":@"s":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_OTHER_CHECK_ID setColumn:@"s"];
		SUPAttributeMetaDataRBS* a_OTHER_CHECK_RESOURCE_FIO = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			197:
			[SUPDataType forName:@"string?"]:@"varchar(400)":@"OTHER_CHECK_RESOURCE_FIO":@"":@"t":
			@"":400:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_OTHER_CHECK_RESOURCE_FIO setColumn:@"t"];
		SUPAttributeMetaDataRBS* a_OTHER_CHECK_FACT_END_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			198:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"OTHER_CHECK_FACT_END_DTTM":@"":@"u":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_OTHER_CHECK_FACT_END_DTTM setColumn:@"u"];
		SUPAttributeMetaDataRBS* a_QUALITY_CONTROL_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			199:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"QUALITY_CONTROL_ID":@"":@"v":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_QUALITY_CONTROL_ID setColumn:@"v"];
		SUPAttributeMetaDataRBS* a_QUALITY_CONTROL_RESOURCE_FIO = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			200:
			[SUPDataType forName:@"string?"]:@"varchar(400)":@"QUALITY_CONTROL_RESOURCE_FIO":@"":@"w":
			@"":400:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_QUALITY_CONTROL_RESOURCE_FIO setColumn:@"w"];
		SUPAttributeMetaDataRBS* a_QUALITY_CONTROL_FACT_END_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			201:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"QUALITY_CONTROL_FACT_END_DTTM":@"":@"x":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_QUALITY_CONTROL_FACT_END_DTTM setColumn:@"x"];
		SUPAttributeMetaDataRBS* a_INSPECTOR_CONTROL_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			202:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"INSPECTOR_CONTROL_ID":@"":@"y":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_INSPECTOR_CONTROL_ID setColumn:@"y"];
		SUPAttributeMetaDataRBS* a_INSPECTOR_CONTROL_RESOURCE_FIO = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			203:
			[SUPDataType forName:@"string?"]:@"varchar(400)":@"INSPECTOR_CONTROL_RESOURCE_FIO":@"":@"z":
			@"":400:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_INSPECTOR_CONTROL_RESOURCE_FIO setColumn:@"z"];
		SUPAttributeMetaDataRBS* a_INSPECTOR_CONTROL_FACT_END_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			204:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"INSPECTOR_CONTROL_FACT_END_DTTM":@"":@"ba":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_INSPECTOR_CONTROL_FACT_END_DTTM setColumn:@"ba"];
		SUPAttributeMetaDataRBS* a_PLAN_END_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			205:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"PLAN_END_DTTM":@"":@"bb":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_PLAN_END_DTTM setColumn:@"bb"];
		SUPAttributeMetaDataRBS* a_CHANGED_DTTM = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			206:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"CHANGED_DTTM":@"":@"bc":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_CHANGED_DTTM setColumn:@"bc"];
		SUPAttributeMetaDataRBS* a_updateCalled = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			208:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"updateCalled":@"":@"be":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_updateCalled setColumn:@"be"];
		SUPAttributeMetaDataRBS* a_updateObjectName = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			209:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"updateObjectName":@"":@"bf":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_updateObjectName setColumn:@"bf"];
		SUPAttributeMetaDataRBS* a_updateOdObject = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			210:
			[SUPDataType forName:@"OdObject?"]:@"LONG VARCHAR":@"updateOdObject":@"":@"bg":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_updateOdObject setColumn:@"bg"];
		SUPAttributeMetaDataRBS* a_createCalled = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			211:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"createCalled":@"":@"bh":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_createCalled setColumn:@"bh"];
		SUPAttributeMetaDataRBS* a_createObjectName = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			212:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"createObjectName":@"":@"bi":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_createObjectName setColumn:@"bi"];
		SUPAttributeMetaDataRBS* a_createOdObject = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			213:
			[SUPDataType forName:@"OdObject?"]:@"LONG VARCHAR":@"createOdObject":@"":@"bj":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_createOdObject setColumn:@"bj"];
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
			207:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"surrogateKey":@"":@"bd":
			@"":-1:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_GLOBAL:
			NO:SUPPersonalizationType_None:NO];
		[a_surrogateKey setColumn:@"bd"];
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
 		
		[attributes addThis:a_UNION_ID];
		[attributes addThis:a_TASK_ID];
		[attributes addThis:a_TASK_TYPE_ID];
		[attributes addThis:a_TASK_STATUS_ID];
		[attributes addThis:a_CREATOR_EMPLOYEE_ID];
		[attributes addThis:a_RESOURCE_EMPLOYEE_ID];
		[attributes addThis:a_TASK_DURATION];
		[attributes addThis:a_TASK_DESC];
		[attributes addThis:a_PLAN_START_DTTM];
		[attributes addThis:a_CHECKLIST_TEMPLATE_ID];
		[attributes addThis:a_INITIAL_DATA];
		[attributes addThis:a_SUBBRANCH_ID];
		[attributes addThis:a_FACT_START_DTTM];
		[attributes addThis:a_FACT_END_DTTM];
		[attributes addThis:a_SELF_CHECK_ID];
		[attributes addThis:a_SELF_CHECK_RESOURCE_FIO];
		[attributes addThis:a_SELF_CHECK_FACT_END_DTTM];
		[attributes addThis:a_OTHER_CHECK_ID];
		[attributes addThis:a_OTHER_CHECK_RESOURCE_FIO];
		[attributes addThis:a_OTHER_CHECK_FACT_END_DTTM];
		[attributes addThis:a_QUALITY_CONTROL_ID];
		[attributes addThis:a_QUALITY_CONTROL_RESOURCE_FIO];
		[attributes addThis:a_QUALITY_CONTROL_FACT_END_DTTM];
		[attributes addThis:a_INSPECTOR_CONTROL_ID];
		[attributes addThis:a_INSPECTOR_CONTROL_RESOURCE_FIO];
		[attributes addThis:a_INSPECTOR_CONTROL_FACT_END_DTTM];
		[attributes addThis:a_PLAN_END_DTTM];
		[attributes addThis:a_CHANGED_DTTM];
		[attributes addThis:a_updateCalled];
		[attributes addThis:a_updateObjectName];
		[attributes addThis:a_updateOdObject];
		[attributes addThis:a_createCalled];
		[attributes addThis:a_createObjectName];
		[attributes addThis:a_createOdObject];
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

 		SUPOperationMetaData* o_update_2 = [SUPOperationMetaData createOperationMetaData:1:(SUPString)@"update":[SUPDataType forName:@"void"]:true];
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
 		SUPOperationMetaData* o_create_2 = [SUPOperationMetaData createOperationMetaData:2:(SUPString)@"create":[SUPDataType forName:@"void"]:true];
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
 		SUPOperationMetaData* o_findAll_0 = [SUPOperationMetaData createOperationMetaData:3:(SUPString)@"findAll":[SUPDataType forName:@"MBO_getTasks*"]:true];
		[o_findAll_0 setIsStatic:YES];
		[o_findAll_0 setIsCreate:NO];
		[o_findAll_0 setIsUpdate:NO];
		[o_findAll_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findByPrimaryKey_1 = [SUPOperationMetaData createOperationMetaData:4:(SUPString)@"findByPrimaryKey":[SUPDataType forName:@"MBO_getTasks"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_findByPrimaryKey_TASK_ID = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"TASK_ID":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_findByPrimaryKey_TASK_ID];
			o_findByPrimaryKey_1.parameters = parameters_list;
	 	}
		[o_findByPrimaryKey_1 setIsStatic:YES];
		[o_findByPrimaryKey_1 setIsCreate:NO];
		[o_findByPrimaryKey_1 setIsUpdate:NO];
		[o_findByPrimaryKey_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getTodayTasks_1 = [SUPOperationMetaData createOperationMetaData:5:(SUPString)@"getTodayTasks":[SUPDataType forName:@"com.sybase.persistence.QueryResultSet"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getTodayTasks_current_time = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"current_time":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_getTodayTasks_current_time];
			o_getTodayTasks_1.parameters = parameters_list;
	 	}
		[o_getTodayTasks_1 setIsStatic:YES];
		[o_getTodayTasks_1 setIsCreate:NO];
		[o_getTodayTasks_1 setIsUpdate:NO];
		[o_getTodayTasks_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getPreviousTasks_0 = [SUPOperationMetaData createOperationMetaData:6:(SUPString)@"getPreviousTasks":[SUPDataType forName:@"com.sybase.persistence.QueryResultSet"]:true];
		[o_getPreviousTasks_0 setIsStatic:YES];
		[o_getPreviousTasks_0 setIsCreate:NO];
		[o_getPreviousTasks_0 setIsUpdate:NO];
		[o_getPreviousTasks_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getFutureTasks_1 = [SUPOperationMetaData createOperationMetaData:7:(SUPString)@"getFutureTasks":[SUPDataType forName:@"com.sybase.persistence.QueryResultSet"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getFutureTasks_current_time = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"current_time":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_getFutureTasks_current_time];
			o_getFutureTasks_1.parameters = parameters_list;
	 	}
		[o_getFutureTasks_1 setIsStatic:YES];
		[o_getFutureTasks_1 setIsCreate:NO];
		[o_getFutureTasks_1 setIsUpdate:NO];
		[o_getFutureTasks_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getCurrentTask_1 = [SUPOperationMetaData createOperationMetaData:8:(SUPString)@"getCurrentTask":[SUPDataType forName:@"com.sybase.persistence.QueryResultSet"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getCurrentTask_current_time = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"current_time":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_getCurrentTask_current_time];
			o_getCurrentTask_1.parameters = parameters_list;
	 	}
		[o_getCurrentTask_1 setIsStatic:YES];
		[o_getCurrentTask_1 setIsCreate:NO];
		[o_getCurrentTask_1 setIsUpdate:NO];
		[o_getCurrentTask_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getTodayTasksCount_1 = [SUPOperationMetaData createOperationMetaData:9:(SUPString)@"getTodayTasksCount":[SUPDataType forName:@"com.sybase.persistence.QueryResultSet"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getTodayTasksCount_current_time = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"current_time":[SUPDataType forName:@"string?"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_getTodayTasksCount_current_time];
			o_getTodayTasksCount_1.parameters = parameters_list;
	 	}
		[o_getTodayTasksCount_1 setIsStatic:YES];
		[o_getTodayTasksCount_1 setIsCreate:NO];
		[o_getTodayTasksCount_1 setIsUpdate:NO];
		[o_getTodayTasksCount_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getPreviousTasksCount_0 = [SUPOperationMetaData createOperationMetaData:10:(SUPString)@"getPreviousTasksCount":[SUPDataType forName:@"com.sybase.persistence.QueryResultSet"]:true];
		[o_getPreviousTasksCount_0 setIsStatic:YES];
		[o_getPreviousTasksCount_0 setIsCreate:NO];
		[o_getPreviousTasksCount_0 setIsUpdate:NO];
		[o_getPreviousTasksCount_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getFutureTasksCount_1 = [SUPOperationMetaData createOperationMetaData:11:(SUPString)@"getFutureTasksCount":[SUPDataType forName:@"com.sybase.persistence.QueryResultSet"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getFutureTasksCount_current_time = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"current_time":[SUPDataType forName:@"string?"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_getFutureTasksCount_current_time];
			o_getFutureTasksCount_1.parameters = parameters_list;
	 	}
		[o_getFutureTasksCount_1 setIsStatic:YES];
		[o_getFutureTasksCount_1 setIsCreate:NO];
		[o_getFutureTasksCount_1 setIsUpdate:NO];
		[o_getFutureTasksCount_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_refresh_0 = [SUPOperationMetaData createOperationMetaData:12:(SUPString)@"refresh":[SUPDataType forName:@"void"]:true];
		[o_refresh_0 setIsStatic:NO];
		[o_refresh_0 setIsCreate:NO];
		[o_refresh_0 setIsUpdate:NO];
		[o_refresh_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o__pk_0 = [SUPOperationMetaData createOperationMetaData:13:(SUPString)@"_pk":[SUPDataType forName:@"long?"]:true];
		[o__pk_0 setIsStatic:NO];
		[o__pk_0 setIsCreate:NO];
		[o__pk_0 setIsUpdate:NO];
		[o__pk_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_submitPending_0 = [SUPOperationMetaData createOperationMetaData:14:(SUPString)@"submitPending":[SUPDataType forName:@"void"]:true];
		[o_submitPending_0 setIsStatic:NO];
		[o_submitPending_0 setIsCreate:NO];
		[o_submitPending_0 setIsUpdate:NO];
		[o_submitPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_cancelPending_0 = [SUPOperationMetaData createOperationMetaData:15:(SUPString)@"cancelPending":[SUPDataType forName:@"void"]:true];
		[o_cancelPending_0 setIsStatic:NO];
		[o_cancelPending_0 setIsCreate:NO];
		[o_cancelPending_0 setIsUpdate:NO];
		[o_cancelPending_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_submitPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:16:(SUPString)@"submitPendingOperations":[SUPDataType forName:@"void"]:true];
		[o_submitPendingOperations_0 setIsStatic:YES];
		[o_submitPendingOperations_0 setIsCreate:NO];
		[o_submitPendingOperations_0 setIsUpdate:NO];
		[o_submitPendingOperations_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_cancelPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:17:(SUPString)@"cancelPendingOperations":[SUPDataType forName:@"void"]:true];
		[o_cancelPendingOperations_0 setIsStatic:YES];
		[o_cancelPendingOperations_0 setIsCreate:NO];
		[o_cancelPendingOperations_0 setIsUpdate:NO];
		[o_cancelPendingOperations_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getSynchronizationParameters_0 = [SUPOperationMetaData createOperationMetaData:18:(SUPString)@"getSynchronizationParameters":[SUPDataType forName:@"MBO_getTasksSynchronizationParameters"]:true];
		[o_getSynchronizationParameters_0 setIsStatic:YES];
		[o_getSynchronizationParameters_0 setIsCreate:NO];
		[o_getSynchronizationParameters_0 setIsUpdate:NO];
		[o_getSynchronizationParameters_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_save_0 = [SUPOperationMetaData createOperationMetaData:19:(SUPString)@"save":[SUPDataType forName:@"void"]:true];
		[o_save_0 setIsStatic:NO];
		[o_save_0 setIsCreate:NO];
		[o_save_0 setIsUpdate:NO];
		[o_save_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findWithQuery_1 = [SUPOperationMetaData createOperationMetaData:20:(SUPString)@"findWithQuery":[SUPDataType forName:@"MBO_getTasks*"]:true];
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
 		SUPOperationMetaData* o_getSize_1 = [SUPOperationMetaData createOperationMetaData:21:(SUPString)@"getSize":[SUPDataType forName:@"int"]:true];
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
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:21];
 		[operations addThis:o_update_2];
 		[operations addThis:o_create_2];
 		[operations addThis:o_findAll_0];
 		[operations addThis:o_findByPrimaryKey_1];
 		[operations addThis:o_getTodayTasks_1];
 		[operations addThis:o_getPreviousTasks_0];
 		[operations addThis:o_getFutureTasks_1];
 		[operations addThis:o_getCurrentTask_1];
 		[operations addThis:o_getTodayTasksCount_1];
 		[operations addThis:o_getPreviousTasksCount_0];
 		[operations addThis:o_getFutureTasksCount_1];
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
		self.table = @"odmobile_1_20_mbo_gettasks";
		self.synchronizationGroup = @"TasksSG";

		SUPIndexMetaData *i_findByPrimaryKeyIndex = [[[SUPIndexMetaData alloc] init] autorelease];
		i_findByPrimaryKeyIndex.name = @"findByPrimaryKeyIndex";
		[i_findByPrimaryKeyIndex.attributes add:a_TASK_ID];
	
		[self.indexList add:i_findByPrimaryKeyIndex];
			
		[self.keyList add:a_surrogateKey];


    }
    return self;
}
@end