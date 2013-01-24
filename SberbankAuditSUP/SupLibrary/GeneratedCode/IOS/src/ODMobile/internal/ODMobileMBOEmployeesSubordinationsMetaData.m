#import "ODMobileMBOEmployeesSubordinationsMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "ODMobileMBOEmployeesSubordinations.h"
#import "SUPOperationMap.h"
#import "ODMobileODMobileDB.h"
#import "SUPDataType.h"

@implementation ODMobileMBOEmployeesSubordinationsMetaData

+ (ODMobileMBOEmployeesSubordinationsMetaData*)getInstance
{
    return [[[ODMobileMBOEmployeesSubordinationsMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 10;
		self.name = @"MBOEmployeesSubordinations";
		self.klass = [ODMobileMBOEmployeesSubordinations class];
 		self.allowPending = YES;;

		self.isClientOnly = NO;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_BUSINESS_PROCESS_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			32:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"BUSINESS_PROCESS_ID":@"":@"a":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_BUSINESS_PROCESS_ID setColumn:@"a"];
		SUPAttributeMetaDataRBS* a_CELL_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			33:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"CELL_ID":@"":@"b":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_CELL_ID setColumn:@"b"];
		SUPAttributeMetaDataRBS* a_EMPLOYEE_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			34:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"EMPLOYEE_ID":@"":@"c":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_EMPLOYEE_ID setColumn:@"c"];
		SUPAttributeMetaDataRBS* a_PARENT_CELL_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			35:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"PARENT_CELL_ID":@"":@"d":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_PARENT_CELL_ID setColumn:@"d"];
		SUPAttributeMetaDataRBS* a_SUBBRANCH_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			36:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"SUBBRANCH_ID":@"":@"e":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_SUBBRANCH_ID setColumn:@"e"];
		SUPAttributeMetaDataRBS* a_UNION_ID = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			37:
			[SUPDataType forName:@"string?"]:@"varchar(80)":@"UNION_ID":@"":@"f":
			@"":80:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_UNION_ID setColumn:@"f"];
		SUPAttributeMetaDataRBS* a_CATEGORIES = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			38:
			[SUPDataType forName:@"string?"]:@"varchar(1200)":@"CATEGORIES":@"":@"g":
			@"":1200:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_CATEGORIES setColumn:@"g"];
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
			39:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"surrogateKey":@"":@"h":
			@"":-1:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_GLOBAL:
			NO:SUPPersonalizationType_None:NO];
		[a_surrogateKey setColumn:@"h"];
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
 		
		[attributes addThis:a_BUSINESS_PROCESS_ID];
		[attributes addThis:a_CELL_ID];
		[attributes addThis:a_EMPLOYEE_ID];
		[attributes addThis:a_PARENT_CELL_ID];
		[attributes addThis:a_SUBBRANCH_ID];
		[attributes addThis:a_UNION_ID];
		[attributes addThis:a_CATEGORIES];
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

 		SUPOperationMetaData* o_getByEmployeeId_2 = [SUPOperationMetaData createOperationMetaData:1:(SUPString)@"getByEmployeeId":[SUPDataType forName:@"MBOEmployeesSubordinations*"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getByEmployeeId_employeeId = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"employeeId":[SUPDataType forName:@"string?"]];
	 		SUPParameterMetaData* p_getByEmployeeId_businessProcessId = [SUPParameterMetaData createParameterMetaData:2:(SUPString)@"businessProcessId":[SUPDataType forName:@"string?"]];
 			parameters_list = [SUPObjectList listWithCapacity:2];
			[parameters_list addThis:p_getByEmployeeId_employeeId];
			[parameters_list addThis:p_getByEmployeeId_businessProcessId];
			o_getByEmployeeId_2.parameters = parameters_list;
	 	}
		[o_getByEmployeeId_2 setIsStatic:YES];
		[o_getByEmployeeId_2 setIsCreate:NO];
		[o_getByEmployeeId_2 setIsUpdate:NO];
		[o_getByEmployeeId_2 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getByCellId_1 = [SUPOperationMetaData createOperationMetaData:2:(SUPString)@"getByCellId":[SUPDataType forName:@"MBOEmployeesSubordinations*"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getByCellId_cellId = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"cellId":[SUPDataType forName:@"string?"]];
 			parameters_list = [SUPObjectList listWithCapacity:1];
			[parameters_list addThis:p_getByCellId_cellId];
			o_getByCellId_1.parameters = parameters_list;
	 	}
		[o_getByCellId_1 setIsStatic:YES];
		[o_getByCellId_1 setIsCreate:NO];
		[o_getByCellId_1 setIsUpdate:NO];
		[o_getByCellId_1 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getBySubbranchId_2 = [SUPOperationMetaData createOperationMetaData:3:(SUPString)@"getBySubbranchId":[SUPDataType forName:@"MBOEmployeesSubordinations*"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getBySubbranchId_subbranchId = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"subbranchId":[SUPDataType forName:@"string?"]];
	 		SUPParameterMetaData* p_getBySubbranchId_busunessProcessId = [SUPParameterMetaData createParameterMetaData:2:(SUPString)@"busunessProcessId":[SUPDataType forName:@"string?"]];
 			parameters_list = [SUPObjectList listWithCapacity:2];
			[parameters_list addThis:p_getBySubbranchId_subbranchId];
			[parameters_list addThis:p_getBySubbranchId_busunessProcessId];
			o_getBySubbranchId_2.parameters = parameters_list;
	 	}
		[o_getBySubbranchId_2 setIsStatic:YES];
		[o_getBySubbranchId_2 setIsCreate:NO];
		[o_getBySubbranchId_2 setIsUpdate:NO];
		[o_getBySubbranchId_2 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_getByUnionId_2 = [SUPOperationMetaData createOperationMetaData:4:(SUPString)@"getByUnionId":[SUPDataType forName:@"MBOEmployeesSubordinations*"]:true];
	  	{
			SUPObjectList *parameters_list = nil;
	 		SUPParameterMetaData* p_getByUnionId_unionId = [SUPParameterMetaData createParameterMetaData:1:(SUPString)@"unionId":[SUPDataType forName:@"string?"]];
	 		SUPParameterMetaData* p_getByUnionId_businessProcessId = [SUPParameterMetaData createParameterMetaData:2:(SUPString)@"businessProcessId":[SUPDataType forName:@"string?"]];
 			parameters_list = [SUPObjectList listWithCapacity:2];
			[parameters_list addThis:p_getByUnionId_unionId];
			[parameters_list addThis:p_getByUnionId_businessProcessId];
			o_getByUnionId_2.parameters = parameters_list;
	 	}
		[o_getByUnionId_2 setIsStatic:YES];
		[o_getByUnionId_2 setIsCreate:NO];
		[o_getByUnionId_2 setIsUpdate:NO];
		[o_getByUnionId_2 setIsDelete:NO]; 		
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
 		SUPOperationMetaData* o_findWithQuery_1 = [SUPOperationMetaData createOperationMetaData:12:(SUPString)@"findWithQuery":[SUPDataType forName:@"MBOEmployeesSubordinations*"]:true];
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
 		[operations addThis:o_getByEmployeeId_2];
 		[operations addThis:o_getByCellId_1];
 		[operations addThis:o_getBySubbranchId_2];
 		[operations addThis:o_getByUnionId_2];
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
		self.table = @"odmobile_1_20_mboemployeessubordinations";
		self.synchronizationGroup = @"DIMSG";

			
		[self.keyList add:a_surrogateKey];


    }
    return self;
}
@end