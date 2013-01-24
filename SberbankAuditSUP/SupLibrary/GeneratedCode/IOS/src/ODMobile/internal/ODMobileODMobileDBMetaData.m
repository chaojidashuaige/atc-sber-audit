#import "ODMobileODMobileDBMetaData.h"

#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "ODMobileOdObject.h"
#import "ODMobileObjField.h"
#import "ODMobileActivityStatusMBO.h"
#import "ODMobileMBOActivityTemplates.h"
#import "ODMobileMBOBusinessProcess.h"
#import "ODMobileMBOCategoryPrivs.h"
#import "ODMobileMBODimMetrics.h"
#import "ODMobileMBODimQuestionBlocks.h"
#import "ODMobileMBOEmployeesSubordinations.h"
#import "ODMobileMBOObjectTypes.h"
#import "ODMobileMBOProperties.h"
#import "ODMobileMBOSubbranchesGeo.h"
#import "ODMobileMBOTaskBlockMetrics.h"
#import "ODMobileMBOTaskTypesPriv.h"
#import "ODMobileMBOUnionTypes.h"
#import "ODMobileMBOUnions.h"
#import "ODMobileMBOUnionsGeo.h"
#import "ODMobileMBOVisitTypes.h"
#import "ODMobileMBO_Logon.h"
#import "ODMobileMBO_getActivities.h"
#import "ODMobileMBO_getActivityPriorities.h"
#import "ODMobileMBO_getActivityTypes.h"
#import "ODMobileMBO_getCategories.h"
#import "ODMobileMBO_getChecklists.h"
#import "ODMobileMBO_getEmployees.h"
#import "ODMobileMBO_getSubbranchLevels.h"
#import "ODMobileMBO_getSubbranches.h"
#import "ODMobileMBO_getTaskStatuses.h"
#import "ODMobileMBO_getTaskTypes.h"
#import "ODMobileMBO_getTasks.h"
#import "ODMobileLogRecordImpl.h"
#import "ODMobileOperationReplay.h"
#import "ODMobileSISSubscriptionKey.h"
#import "ODMobileSISSubscription.h"
#import "ODMobilePackageProperties.h"
#import "ODMobileChangeLogKey.h"
#import "ODMobileChangeLogImpl.h"
#import "ODMobileOfflineAuthentication.h"
#import "ODMobileMBOCategoryPrivsSynchronizationParameters.h"
#import "ODMobileMBOCategoryPrivs_pull_pq.h"
#import "ODMobileMBOSubbranchesGeoSynchronizationParameters.h"
#import "ODMobileMBOSubbranchesGeo_pull_pq.h"
#import "ODMobileMBOTaskBlockMetricsSynchronizationParameters.h"
#import "ODMobileMBOTaskBlockMetrics_pull_pq.h"
#import "ODMobileMBOTaskTypesPrivSynchronizationParameters.h"
#import "ODMobileMBOTaskTypesPriv_pull_pq.h"
#import "ODMobileMBOUnionsSynchronizationParameters.h"
#import "ODMobileMBOUnions_pull_pq.h"
#import "ODMobileMBOUnionsGeoSynchronizationParameters.h"
#import "ODMobileMBOUnionsGeo_pull_pq.h"
#import "ODMobileMBO_getActivitiesSynchronizationParameters.h"
#import "ODMobileMBO_getActivities_pull_pq.h"
#import "ODMobileMBO_getSubbranchesSynchronizationParameters.h"
#import "ODMobileMBO_getSubbranches_pull_pq.h"
#import "ODMobileMBO_getTasksSynchronizationParameters.h"
#import "ODMobileMBO_getTasks_pull_pq.h"
#import "ODMobileKeyPackageName.h"
#import "ODMobileClientPersonalization.h"
#import "ODMobilePersonalizationParameters.h"
#import "ODMobileKeyGenerator.h"
#import "ODMobileKeyGeneratorPK.h"
#import "ODMobileLocalKeyGenerator.h"
#import "ODMobileLocalKeyGeneratorPK.h"

@implementation ODMobileODMobileDBMetaData

+ (ODMobileODMobileDBMetaData*)getInstance
{
    return [[[ODMobileODMobileDBMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 0;
		self.databaseName = @"ODMobileODMobileDB";
		self.packageName = @"ODMobile";

		SUPObjectList *classList = [SUPObjectList listWithCapacity:64];
		[classList addThis:[ODMobileOdObject metaData]];
		[ODMobileOdObject delegate];
		[classList addThis:[ODMobileObjField metaData]];
		[ODMobileObjField delegate];
		[classList addThis:[ODMobileActivityStatusMBO metaData]];
		[ODMobileActivityStatusMBO delegate];
		[classList addThis:[ODMobileMBOActivityTemplates metaData]];
		[ODMobileMBOActivityTemplates delegate];
		[classList addThis:[ODMobileMBOBusinessProcess metaData]];
		[ODMobileMBOBusinessProcess delegate];
		[classList addThis:[ODMobileMBOCategoryPrivs metaData]];
		[ODMobileMBOCategoryPrivs delegate];
		[classList addThis:[ODMobileMBODimMetrics metaData]];
		[ODMobileMBODimMetrics delegate];
		[classList addThis:[ODMobileMBODimQuestionBlocks metaData]];
		[ODMobileMBODimQuestionBlocks delegate];
		[classList addThis:[ODMobileMBOEmployeesSubordinations metaData]];
		[ODMobileMBOEmployeesSubordinations delegate];
		[classList addThis:[ODMobileMBOObjectTypes metaData]];
		[ODMobileMBOObjectTypes delegate];
		[classList addThis:[ODMobileMBOProperties metaData]];
		[ODMobileMBOProperties delegate];
		[classList addThis:[ODMobileMBOSubbranchesGeo metaData]];
		[ODMobileMBOSubbranchesGeo delegate];
		[classList addThis:[ODMobileMBOTaskBlockMetrics metaData]];
		[ODMobileMBOTaskBlockMetrics delegate];
		[classList addThis:[ODMobileMBOTaskTypesPriv metaData]];
		[ODMobileMBOTaskTypesPriv delegate];
		[classList addThis:[ODMobileMBOUnionTypes metaData]];
		[ODMobileMBOUnionTypes delegate];
		[classList addThis:[ODMobileMBOUnions metaData]];
		[ODMobileMBOUnions delegate];
		[classList addThis:[ODMobileMBOUnionsGeo metaData]];
		[ODMobileMBOUnionsGeo delegate];
		[classList addThis:[ODMobileMBOVisitTypes metaData]];
		[ODMobileMBOVisitTypes delegate];
		[classList addThis:[ODMobileMBO_Logon metaData]];
		[ODMobileMBO_Logon delegate];
		[classList addThis:[ODMobileMBO_getActivities metaData]];
		[ODMobileMBO_getActivities delegate];
		[classList addThis:[ODMobileMBO_getActivityPriorities metaData]];
		[ODMobileMBO_getActivityPriorities delegate];
		[classList addThis:[ODMobileMBO_getActivityTypes metaData]];
		[ODMobileMBO_getActivityTypes delegate];
		[classList addThis:[ODMobileMBO_getCategories metaData]];
		[ODMobileMBO_getCategories delegate];
		[classList addThis:[ODMobileMBO_getChecklists metaData]];
		[ODMobileMBO_getChecklists delegate];
		[classList addThis:[ODMobileMBO_getEmployees metaData]];
		[ODMobileMBO_getEmployees delegate];
		[classList addThis:[ODMobileMBO_getSubbranchLevels metaData]];
		[ODMobileMBO_getSubbranchLevels delegate];
		[classList addThis:[ODMobileMBO_getSubbranches metaData]];
		[ODMobileMBO_getSubbranches delegate];
		[classList addThis:[ODMobileMBO_getTaskStatuses metaData]];
		[ODMobileMBO_getTaskStatuses delegate];
		[classList addThis:[ODMobileMBO_getTaskTypes metaData]];
		[ODMobileMBO_getTaskTypes delegate];
		[classList addThis:[ODMobileMBO_getTasks metaData]];
		[ODMobileMBO_getTasks delegate];
		[classList addThis:[ODMobileLogRecordImpl metaData]];
		[ODMobileLogRecordImpl delegate];
		[classList addThis:[ODMobileOperationReplay metaData]];
		[ODMobileOperationReplay delegate];
		[classList addThis:[ODMobileSISSubscriptionKey metaData]];
		[ODMobileSISSubscriptionKey delegate];
		[classList addThis:[ODMobileSISSubscription metaData]];
		[ODMobileSISSubscription delegate];
		[classList addThis:[ODMobilePackageProperties metaData]];
		[ODMobilePackageProperties delegate];
		[classList addThis:[ODMobileChangeLogKey metaData]];
		[ODMobileChangeLogKey delegate];
		[classList addThis:[ODMobileChangeLogImpl metaData]];
		[ODMobileChangeLogImpl delegate];
		[classList addThis:[ODMobileOfflineAuthentication metaData]];
		[ODMobileOfflineAuthentication delegate];
		[classList addThis:[ODMobileMBOCategoryPrivsSynchronizationParameters metaData]];
		[ODMobileMBOCategoryPrivsSynchronizationParameters delegate];
		[classList addThis:[ODMobileMBOCategoryPrivs_pull_pq metaData]];
		[ODMobileMBOCategoryPrivs_pull_pq delegate];
		[classList addThis:[ODMobileMBOSubbranchesGeoSynchronizationParameters metaData]];
		[ODMobileMBOSubbranchesGeoSynchronizationParameters delegate];
		[classList addThis:[ODMobileMBOSubbranchesGeo_pull_pq metaData]];
		[ODMobileMBOSubbranchesGeo_pull_pq delegate];
		[classList addThis:[ODMobileMBOTaskBlockMetricsSynchronizationParameters metaData]];
		[ODMobileMBOTaskBlockMetricsSynchronizationParameters delegate];
		[classList addThis:[ODMobileMBOTaskBlockMetrics_pull_pq metaData]];
		[ODMobileMBOTaskBlockMetrics_pull_pq delegate];
		[classList addThis:[ODMobileMBOTaskTypesPrivSynchronizationParameters metaData]];
		[ODMobileMBOTaskTypesPrivSynchronizationParameters delegate];
		[classList addThis:[ODMobileMBOTaskTypesPriv_pull_pq metaData]];
		[ODMobileMBOTaskTypesPriv_pull_pq delegate];
		[classList addThis:[ODMobileMBOUnionsSynchronizationParameters metaData]];
		[ODMobileMBOUnionsSynchronizationParameters delegate];
		[classList addThis:[ODMobileMBOUnions_pull_pq metaData]];
		[ODMobileMBOUnions_pull_pq delegate];
		[classList addThis:[ODMobileMBOUnionsGeoSynchronizationParameters metaData]];
		[ODMobileMBOUnionsGeoSynchronizationParameters delegate];
		[classList addThis:[ODMobileMBOUnionsGeo_pull_pq metaData]];
		[ODMobileMBOUnionsGeo_pull_pq delegate];
		[classList addThis:[ODMobileMBO_getActivitiesSynchronizationParameters metaData]];
		[ODMobileMBO_getActivitiesSynchronizationParameters delegate];
		[classList addThis:[ODMobileMBO_getActivities_pull_pq metaData]];
		[ODMobileMBO_getActivities_pull_pq delegate];
		[classList addThis:[ODMobileMBO_getSubbranchesSynchronizationParameters metaData]];
		[ODMobileMBO_getSubbranchesSynchronizationParameters delegate];
		[classList addThis:[ODMobileMBO_getSubbranches_pull_pq metaData]];
		[ODMobileMBO_getSubbranches_pull_pq delegate];
		[classList addThis:[ODMobileMBO_getTasksSynchronizationParameters metaData]];
		[ODMobileMBO_getTasksSynchronizationParameters delegate];
		[classList addThis:[ODMobileMBO_getTasks_pull_pq metaData]];
		[ODMobileMBO_getTasks_pull_pq delegate];
		[classList addThis:[ODMobileKeyPackageName metaData]];
		[ODMobileKeyPackageName delegate];
		[classList addThis:[ODMobileClientPersonalization metaData]];
		[ODMobileClientPersonalization delegate];
		[classList addThis:[ODMobilePersonalizationParameters metaData]];
		[ODMobilePersonalizationParameters delegate];
		[classList addThis:[ODMobileKeyGenerator metaData]];
		[ODMobileKeyGenerator delegate];
		[classList addThis:[ODMobileKeyGeneratorPK metaData]];
		[ODMobileKeyGeneratorPK delegate];
		[classList addThis:[ODMobileLocalKeyGenerator metaData]];
		[ODMobileLocalKeyGenerator delegate];
		[classList addThis:[ODMobileLocalKeyGeneratorPK metaData]];
		[ODMobileLocalKeyGeneratorPK delegate];
		self.classList = classList;
		SUPClassMap *classMap = [SUPClassMap getInstance];
		[classMap setClasses:classList];
		self.classMap = classMap;

		SUPObjectList *entityList = [SUPObjectList listWithCapacity:55];
		[entityList addThis:[ODMobileActivityStatusMBO metaData]];
		[ODMobileActivityStatusMBO delegate];
		[entityList addThis:[ODMobileMBOActivityTemplates metaData]];
		[ODMobileMBOActivityTemplates delegate];
		[entityList addThis:[ODMobileMBOBusinessProcess metaData]];
		[ODMobileMBOBusinessProcess delegate];
		[entityList addThis:[ODMobileMBOCategoryPrivs metaData]];
		[ODMobileMBOCategoryPrivs delegate];
		[entityList addThis:[ODMobileMBODimMetrics metaData]];
		[ODMobileMBODimMetrics delegate];
		[entityList addThis:[ODMobileMBODimQuestionBlocks metaData]];
		[ODMobileMBODimQuestionBlocks delegate];
		[entityList addThis:[ODMobileMBOEmployeesSubordinations metaData]];
		[ODMobileMBOEmployeesSubordinations delegate];
		[entityList addThis:[ODMobileMBOObjectTypes metaData]];
		[ODMobileMBOObjectTypes delegate];
		[entityList addThis:[ODMobileMBOProperties metaData]];
		[ODMobileMBOProperties delegate];
		[entityList addThis:[ODMobileMBOSubbranchesGeo metaData]];
		[ODMobileMBOSubbranchesGeo delegate];
		[entityList addThis:[ODMobileMBOTaskBlockMetrics metaData]];
		[ODMobileMBOTaskBlockMetrics delegate];
		[entityList addThis:[ODMobileMBOTaskTypesPriv metaData]];
		[ODMobileMBOTaskTypesPriv delegate];
		[entityList addThis:[ODMobileMBOUnionTypes metaData]];
		[ODMobileMBOUnionTypes delegate];
		[entityList addThis:[ODMobileMBOUnions metaData]];
		[ODMobileMBOUnions delegate];
		[entityList addThis:[ODMobileMBOUnionsGeo metaData]];
		[ODMobileMBOUnionsGeo delegate];
		[entityList addThis:[ODMobileMBOVisitTypes metaData]];
		[ODMobileMBOVisitTypes delegate];
		[entityList addThis:[ODMobileMBO_Logon metaData]];
		[ODMobileMBO_Logon delegate];
		[entityList addThis:[ODMobileMBO_getActivities metaData]];
		[ODMobileMBO_getActivities delegate];
		[entityList addThis:[ODMobileMBO_getActivityPriorities metaData]];
		[ODMobileMBO_getActivityPriorities delegate];
		[entityList addThis:[ODMobileMBO_getActivityTypes metaData]];
		[ODMobileMBO_getActivityTypes delegate];
		[entityList addThis:[ODMobileMBO_getCategories metaData]];
		[ODMobileMBO_getCategories delegate];
		[entityList addThis:[ODMobileMBO_getChecklists metaData]];
		[ODMobileMBO_getChecklists delegate];
		[entityList addThis:[ODMobileMBO_getEmployees metaData]];
		[ODMobileMBO_getEmployees delegate];
		[entityList addThis:[ODMobileMBO_getSubbranchLevels metaData]];
		[ODMobileMBO_getSubbranchLevels delegate];
		[entityList addThis:[ODMobileMBO_getSubbranches metaData]];
		[ODMobileMBO_getSubbranches delegate];
		[entityList addThis:[ODMobileMBO_getTaskStatuses metaData]];
		[ODMobileMBO_getTaskStatuses delegate];
		[entityList addThis:[ODMobileMBO_getTaskTypes metaData]];
		[ODMobileMBO_getTaskTypes delegate];
		[entityList addThis:[ODMobileMBO_getTasks metaData]];
		[ODMobileMBO_getTasks delegate];
		[entityList addThis:[ODMobileLogRecordImpl metaData]];
		[ODMobileLogRecordImpl delegate];
		[entityList addThis:[ODMobileOperationReplay metaData]];
		[ODMobileOperationReplay delegate];
		[entityList addThis:[ODMobileSISSubscription metaData]];
		[ODMobileSISSubscription delegate];
		[entityList addThis:[ODMobilePackageProperties metaData]];
		[ODMobilePackageProperties delegate];
		[entityList addThis:[ODMobileChangeLogImpl metaData]];
		[ODMobileChangeLogImpl delegate];
		[entityList addThis:[ODMobileOfflineAuthentication metaData]];
		[ODMobileOfflineAuthentication delegate];
		[entityList addThis:[ODMobileMBOCategoryPrivsSynchronizationParameters metaData]];
		[ODMobileMBOCategoryPrivsSynchronizationParameters delegate];
		[entityList addThis:[ODMobileMBOCategoryPrivs_pull_pq metaData]];
		[ODMobileMBOCategoryPrivs_pull_pq delegate];
		[entityList addThis:[ODMobileMBOSubbranchesGeoSynchronizationParameters metaData]];
		[ODMobileMBOSubbranchesGeoSynchronizationParameters delegate];
		[entityList addThis:[ODMobileMBOSubbranchesGeo_pull_pq metaData]];
		[ODMobileMBOSubbranchesGeo_pull_pq delegate];
		[entityList addThis:[ODMobileMBOTaskBlockMetricsSynchronizationParameters metaData]];
		[ODMobileMBOTaskBlockMetricsSynchronizationParameters delegate];
		[entityList addThis:[ODMobileMBOTaskBlockMetrics_pull_pq metaData]];
		[ODMobileMBOTaskBlockMetrics_pull_pq delegate];
		[entityList addThis:[ODMobileMBOTaskTypesPrivSynchronizationParameters metaData]];
		[ODMobileMBOTaskTypesPrivSynchronizationParameters delegate];
		[entityList addThis:[ODMobileMBOTaskTypesPriv_pull_pq metaData]];
		[ODMobileMBOTaskTypesPriv_pull_pq delegate];
		[entityList addThis:[ODMobileMBOUnionsSynchronizationParameters metaData]];
		[ODMobileMBOUnionsSynchronizationParameters delegate];
		[entityList addThis:[ODMobileMBOUnions_pull_pq metaData]];
		[ODMobileMBOUnions_pull_pq delegate];
		[entityList addThis:[ODMobileMBOUnionsGeoSynchronizationParameters metaData]];
		[ODMobileMBOUnionsGeoSynchronizationParameters delegate];
		[entityList addThis:[ODMobileMBOUnionsGeo_pull_pq metaData]];
		[ODMobileMBOUnionsGeo_pull_pq delegate];
		[entityList addThis:[ODMobileMBO_getActivitiesSynchronizationParameters metaData]];
		[ODMobileMBO_getActivitiesSynchronizationParameters delegate];
		[entityList addThis:[ODMobileMBO_getActivities_pull_pq metaData]];
		[ODMobileMBO_getActivities_pull_pq delegate];
		[entityList addThis:[ODMobileMBO_getSubbranchesSynchronizationParameters metaData]];
		[ODMobileMBO_getSubbranchesSynchronizationParameters delegate];
		[entityList addThis:[ODMobileMBO_getSubbranches_pull_pq metaData]];
		[ODMobileMBO_getSubbranches_pull_pq delegate];
		[entityList addThis:[ODMobileMBO_getTasksSynchronizationParameters metaData]];
		[ODMobileMBO_getTasksSynchronizationParameters delegate];
		[entityList addThis:[ODMobileMBO_getTasks_pull_pq metaData]];
		[ODMobileMBO_getTasks_pull_pq delegate];
		[entityList addThis:[ODMobileClientPersonalization metaData]];
		[ODMobileClientPersonalization delegate];
		[entityList addThis:[ODMobileKeyGenerator metaData]];
		[ODMobileKeyGenerator delegate];
		[entityList addThis:[ODMobileLocalKeyGenerator metaData]];
		[ODMobileLocalKeyGenerator delegate];
		self.entityList = entityList;
	    SUPEntityMap *entityMap = [SUPEntityMap getInstance];
    	[entityMap setEntities:entityList];
	    self.entityMap = entityMap;
		SUPObjectList *attributes = [SUPObjectList listWithCapacity:7];
		self.name = @"ODMobileDB";
 
       	// Handle attributes
 		self.attributes = attributes;;
 		
 		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
    	[attributeMap setAttributes:attributes];
    	self.attributeMap = attributeMap;

 		// Handle operations
 		int operation_counter = 0;
 		operation_counter++;
 		SUPOperationMetaData* o_createDatabase_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"createDatabase":[SUPDataType forName:@"void"]:true];
 		[o_createDatabase_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_cleanAllData_1 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"cleanAllData":[SUPDataType forName:@"void"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_cleanAllData_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"boolean"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_cleanAllData_p0];
 			o_cleanAllData_1.parameters = parameters_list;
 		}
 		[o_cleanAllData_1 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_cleanAllData_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"cleanAllData":[SUPDataType forName:@"void"]:true];
 		[o_cleanAllData_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_getSyncUsername_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"getSyncUsername":[SUPDataType forName:@"string"]:true];
 		[o_getSyncUsername_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_loginToSync_2 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"loginToSync":[SUPDataType forName:@"void"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_loginToSync_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_counter++;
 			SUPParameterMetaData* p_loginToSync_p1 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p1":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_loginToSync_p0];
 			[parameters_list addThis:p_loginToSync_p1];
 			o_loginToSync_2.parameters = parameters_list;
 		}
 		[o_loginToSync_2 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_onlineLogin_2 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"onlineLogin":[SUPDataType forName:@"void"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_onlineLogin_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_counter++;
 			SUPParameterMetaData* p_onlineLogin_p1 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p1":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_onlineLogin_p0];
 			[parameters_list addThis:p_onlineLogin_p1];
 			o_onlineLogin_2.parameters = parameters_list;
 		}
 		[o_onlineLogin_2 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_offlineLogin_2 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"offlineLogin":[SUPDataType forName:@"boolean"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_offlineLogin_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_counter++;
 			SUPParameterMetaData* p_offlineLogin_p1 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p1":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_offlineLogin_p0];
 			[parameters_list addThis:p_offlineLogin_p1];
 			o_offlineLogin_2.parameters = parameters_list;
 		}
 		[o_offlineLogin_2 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_synchronize_1 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"synchronize":[SUPDataType forName:@"void"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_synchronize_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_synchronize_p0];
 			o_synchronize_1.parameters = parameters_list;
 		}
 		[o_synchronize_1 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_submitPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"submitPendingOperations":[SUPDataType forName:@"void"]:true];
 		[o_submitPendingOperations_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_synchronize_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"synchronize":[SUPDataType forName:@"void"]:true];
 		[o_synchronize_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_submitPendingOperations_1 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"submitPendingOperations":[SUPDataType forName:@"void"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_submitPendingOperations_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_submitPendingOperations_p0];
 			o_submitPendingOperations_1.parameters = parameters_list;
 		}
 		[o_submitPendingOperations_1 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_cancelPendingOperations_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"cancelPendingOperations":[SUPDataType forName:@"void"]:true];
 		[o_cancelPendingOperations_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_submitLogRecords_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"submitLogRecords":[SUPDataType forName:@"void"]:true];
 		[o_submitLogRecords_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_deleteDatabase_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"deleteDatabase":[SUPDataType forName:@"void"]:true];
 		[o_deleteDatabase_0 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_isSynchronized_1 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"isSynchronized":[SUPDataType forName:@"boolean"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_isSynchronized_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_isSynchronized_p0];
 			o_isSynchronized_1.parameters = parameters_list;
 		}
 		[o_isSynchronized_1 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_getLastSynchronizationTime_1 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"getLastSynchronizationTime":[SUPDataType forName:@"dateTime"]:true];
  		{
 			int parameters_counter=0;
 			SUPObjectList *parameters_list = nil;
 			parameters_counter++;
 			SUPParameterMetaData* p_getLastSynchronizationTime_p0 = [SUPParameterMetaData createParameterMetaData:parameters_counter:(SUPString)@"p0":[SUPDataType forName:@"string"]];
 			parameters_list = [SUPObjectList listWithCapacity:parameters_counter];
 			[parameters_list addThis:p_getLastSynchronizationTime_p0];
 			o_getLastSynchronizationTime_1.parameters = parameters_list;
 		}
 		[o_getLastSynchronizationTime_1 setIsStatic:YES];
 		operation_counter++;
 		SUPOperationMetaData* o_getPersonalizationParameters_0 = [SUPOperationMetaData createOperationMetaData:operation_counter:(SUPString)@"getPersonalizationParameters":[SUPDataType forName:@"PersonalizationParameters"]:true];
 		[o_getPersonalizationParameters_0 setIsStatic:YES];
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:operation_counter];
 		[operations addThis:o_createDatabase_0];
 		[operations addThis:o_cleanAllData_1];
 		[operations addThis:o_cleanAllData_0];
 		[operations addThis:o_getSyncUsername_0];
 		[operations addThis:o_loginToSync_2];
 		[operations addThis:o_onlineLogin_2];
 		[operations addThis:o_offlineLogin_2];
 		[operations addThis:o_synchronize_1];
 		[operations addThis:o_submitPendingOperations_0];
 		[operations addThis:o_synchronize_0];
 		[operations addThis:o_submitPendingOperations_1];
 		[operations addThis:o_cancelPendingOperations_0];
 		[operations addThis:o_submitLogRecords_0];
 		[operations addThis:o_deleteDatabase_0];
 		[operations addThis:o_isSynchronized_1];
 		[operations addThis:o_getLastSynchronizationTime_1];
 		[operations addThis:o_getPersonalizationParameters_0];
 		self.operations = operations;
 		
		SUPOperationMap *operationMap = [SUPOperationMap getInstance];
		[operationMap setOperations:operations];
		self.operationMap = operationMap;

		SUPStringList *publications = [SUPStringList getInstance];
		NSMutableDictionary *publicationsToEntities = [[[NSMutableDictionary alloc] init] autorelease];
		[publications add:@"LogonSG"];
		SUPObjectList *LogonSGEntities = [SUPObjectList getInstance];
		[LogonSGEntities add:[ODMobileMBO_Logon metaData]];
		[LogonSGEntities add:[ODMobileChangeLogImpl metaData]];
		[LogonSGEntities add:[ODMobileLogRecordImpl metaData]];
		[LogonSGEntities add:[ODMobileOperationReplay metaData]];
		[LogonSGEntities add:[ODMobileSISSubscription metaData]];
		[LogonSGEntities add:[ODMobilePackageProperties metaData]];
		[LogonSGEntities add:[ODMobileKeyGenerator metaData]];
		[publicationsToEntities setObject:LogonSGEntities forKey:@"LogonSG"];
		
		[publications add:@"TasksSG"];
		SUPObjectList *TasksSGEntities = [SUPObjectList getInstance];
		[TasksSGEntities add:[ODMobileMBO_getTasks metaData]];
		[TasksSGEntities add:[ODMobileMBO_getActivities metaData]];
		[TasksSGEntities add:[ODMobileMBOTaskBlockMetrics metaData]];
		[TasksSGEntities add:[ODMobileChangeLogImpl metaData]];
		[TasksSGEntities add:[ODMobileLogRecordImpl metaData]];
		[TasksSGEntities add:[ODMobileOperationReplay metaData]];
		[TasksSGEntities add:[ODMobileSISSubscription metaData]];
		[TasksSGEntities add:[ODMobilePackageProperties metaData]];
		[TasksSGEntities add:[ODMobileMBOTaskBlockMetrics_pull_pq metaData]];
		[TasksSGEntities add:[ODMobileMBO_getActivities_pull_pq metaData]];
		[TasksSGEntities add:[ODMobileMBO_getTasks_pull_pq metaData]];
		[TasksSGEntities add:[ODMobileKeyGenerator metaData]];
		[publicationsToEntities setObject:TasksSGEntities forKey:@"TasksSG"];
		
		[publications add:@"DIMSG"];
		SUPObjectList *DIMSGEntities = [SUPObjectList getInstance];
		[DIMSGEntities add:[ODMobileMBO_getTaskTypes metaData]];
		[DIMSGEntities add:[ODMobileMBO_getTaskStatuses metaData]];
		[DIMSGEntities add:[ODMobileActivityStatusMBO metaData]];
		[DIMSGEntities add:[ODMobileMBO_getActivityTypes metaData]];
		[DIMSGEntities add:[ODMobileMBO_getCategories metaData]];
		[DIMSGEntities add:[ODMobileMBO_getActivityPriorities metaData]];
		[DIMSGEntities add:[ODMobileMBO_getEmployees metaData]];
		[DIMSGEntities add:[ODMobileMBO_getSubbranchLevels metaData]];
		[DIMSGEntities add:[ODMobileMBO_getChecklists metaData]];
		[DIMSGEntities add:[ODMobileMBOTaskTypesPriv metaData]];
		[DIMSGEntities add:[ODMobileMBOActivityTemplates metaData]];
		[DIMSGEntities add:[ODMobileMBOCategoryPrivs metaData]];
		[DIMSGEntities add:[ODMobileMBOVisitTypes metaData]];
		[DIMSGEntities add:[ODMobileMBOEmployeesSubordinations metaData]];
		[DIMSGEntities add:[ODMobileMBODimMetrics metaData]];
		[DIMSGEntities add:[ODMobileMBODimQuestionBlocks metaData]];
		[DIMSGEntities add:[ODMobileMBOUnionTypes metaData]];
		[DIMSGEntities add:[ODMobileMBOObjectTypes metaData]];
		[DIMSGEntities add:[ODMobileChangeLogImpl metaData]];
		[DIMSGEntities add:[ODMobileLogRecordImpl metaData]];
		[DIMSGEntities add:[ODMobileOperationReplay metaData]];
		[DIMSGEntities add:[ODMobileSISSubscription metaData]];
		[DIMSGEntities add:[ODMobilePackageProperties metaData]];
		[DIMSGEntities add:[ODMobileMBOCategoryPrivs_pull_pq metaData]];
		[DIMSGEntities add:[ODMobileMBOTaskTypesPriv_pull_pq metaData]];
		[DIMSGEntities add:[ODMobileKeyGenerator metaData]];
		[publicationsToEntities setObject:DIMSGEntities forKey:@"DIMSG"];
		
		[publications add:@"NOT_LOAD"];
		SUPObjectList *NOT_LOADEntities = [SUPObjectList getInstance];
		[NOT_LOADEntities add:[ODMobileMBOBusinessProcess metaData]];
		[NOT_LOADEntities add:[ODMobileChangeLogImpl metaData]];
		[NOT_LOADEntities add:[ODMobileLogRecordImpl metaData]];
		[NOT_LOADEntities add:[ODMobileOperationReplay metaData]];
		[NOT_LOADEntities add:[ODMobileSISSubscription metaData]];
		[NOT_LOADEntities add:[ODMobilePackageProperties metaData]];
		[NOT_LOADEntities add:[ODMobileKeyGenerator metaData]];
		[publicationsToEntities setObject:NOT_LOADEntities forKey:@"NOT_LOAD"];
		
		[publications add:@"GEO"];
		SUPObjectList *GEOEntities = [SUPObjectList getInstance];
		[GEOEntities add:[ODMobileMBOSubbranchesGeo metaData]];
		[GEOEntities add:[ODMobileMBOUnionsGeo metaData]];
		[GEOEntities add:[ODMobileChangeLogImpl metaData]];
		[GEOEntities add:[ODMobileLogRecordImpl metaData]];
		[GEOEntities add:[ODMobileOperationReplay metaData]];
		[GEOEntities add:[ODMobileSISSubscription metaData]];
		[GEOEntities add:[ODMobilePackageProperties metaData]];
		[GEOEntities add:[ODMobileMBOSubbranchesGeo_pull_pq metaData]];
		[GEOEntities add:[ODMobileMBOUnionsGeo_pull_pq metaData]];
		[GEOEntities add:[ODMobileKeyGenerator metaData]];
		[publicationsToEntities setObject:GEOEntities forKey:@"GEO"];
		
		[publications add:@"DIMSG_TASK_REL"];
		SUPObjectList *DIMSG_TASK_RELEntities = [SUPObjectList getInstance];
		[DIMSG_TASK_RELEntities add:[ODMobileMBO_getSubbranches metaData]];
		[DIMSG_TASK_RELEntities add:[ODMobileMBOUnions metaData]];
		[DIMSG_TASK_RELEntities add:[ODMobileChangeLogImpl metaData]];
		[DIMSG_TASK_RELEntities add:[ODMobileLogRecordImpl metaData]];
		[DIMSG_TASK_RELEntities add:[ODMobileOperationReplay metaData]];
		[DIMSG_TASK_RELEntities add:[ODMobileSISSubscription metaData]];
		[DIMSG_TASK_RELEntities add:[ODMobilePackageProperties metaData]];
		[DIMSG_TASK_RELEntities add:[ODMobileMBOUnions_pull_pq metaData]];
		[DIMSG_TASK_RELEntities add:[ODMobileMBO_getSubbranches_pull_pq metaData]];
		[DIMSG_TASK_RELEntities add:[ODMobileKeyGenerator metaData]];
		[publicationsToEntities setObject:DIMSG_TASK_RELEntities forKey:@"DIMSG_TASK_REL"];
		
		[publications add:@"PROPERTIES"];
		SUPObjectList *PROPERTIESEntities = [SUPObjectList getInstance];
		[PROPERTIESEntities add:[ODMobileMBOProperties metaData]];
		[PROPERTIESEntities add:[ODMobileChangeLogImpl metaData]];
		[PROPERTIESEntities add:[ODMobileLogRecordImpl metaData]];
		[PROPERTIESEntities add:[ODMobileOperationReplay metaData]];
		[PROPERTIESEntities add:[ODMobileSISSubscription metaData]];
		[PROPERTIESEntities add:[ODMobilePackageProperties metaData]];
		[PROPERTIESEntities add:[ODMobileKeyGenerator metaData]];
		[publicationsToEntities setObject:PROPERTIESEntities forKey:@"PROPERTIES"];
		
		[publications add:@"unsubscribe"];
		SUPObjectList *unsubscribeEntities = [SUPObjectList getInstance];
		[unsubscribeEntities add:[ODMobileMBOCategoryPrivs_pull_pq metaData]];
		[unsubscribeEntities add:[ODMobileMBOSubbranchesGeo_pull_pq metaData]];
		[unsubscribeEntities add:[ODMobileMBOTaskBlockMetrics_pull_pq metaData]];
		[unsubscribeEntities add:[ODMobileMBOTaskTypesPriv_pull_pq metaData]];
		[unsubscribeEntities add:[ODMobileMBOUnions_pull_pq metaData]];
		[unsubscribeEntities add:[ODMobileMBOUnionsGeo_pull_pq metaData]];
		[unsubscribeEntities add:[ODMobileMBO_getActivities_pull_pq metaData]];
		[unsubscribeEntities add:[ODMobileMBO_getSubbranches_pull_pq metaData]];
		[unsubscribeEntities add:[ODMobileMBO_getTasks_pull_pq metaData]];
		[unsubscribeEntities add:[ODMobileLogRecordImpl metaData]];
		[unsubscribeEntities add:[ODMobileOperationReplay metaData]];
		[unsubscribeEntities add:[ODMobileSISSubscription metaData]];
		[unsubscribeEntities add:[ODMobilePackageProperties metaData]];
		[unsubscribeEntities add:[ODMobileKeyGenerator metaData]];
		[publicationsToEntities setObject:unsubscribeEntities forKey:@"unsubscribe"];
		
		[publications add:@"system"];
		SUPObjectList *systemEntities = [SUPObjectList getInstance];
		[systemEntities add:[ODMobileLogRecordImpl metaData]];
		[systemEntities add:[ODMobileOperationReplay metaData]];
		[systemEntities add:[ODMobileSISSubscription metaData]];
		[systemEntities add:[ODMobilePackageProperties metaData]];
		[systemEntities add:[ODMobileKeyGenerator metaData]];
		[publicationsToEntities setObject:systemEntities forKey:@"system"];
		
		[publications add:@"initialSync"];
		SUPObjectList *initialSyncEntities = [SUPObjectList getInstance];
		[initialSyncEntities add:[ODMobilePackageProperties metaData]];
		[initialSyncEntities add:[ODMobileKeyGenerator metaData]];
		[publicationsToEntities setObject:initialSyncEntities forKey:@"initialSync"];
		
		self.publicationsMap = publicationsToEntities;
		self.publications = publications;
    }
    return self;
}

@end