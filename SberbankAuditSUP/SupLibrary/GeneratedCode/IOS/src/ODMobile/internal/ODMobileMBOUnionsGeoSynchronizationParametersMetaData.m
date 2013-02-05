#import "ODMobileMBOUnionsGeoSynchronizationParametersMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPObjectList.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "ODMobileMBOUnionsGeoSynchronizationParameters.h"
#import "SUPOperationMap.h"
#import "ODMobileODMobileDB.h"
#import "SUPDataType.h"

@implementation ODMobileMBOUnionsGeoSynchronizationParametersMetaData

+ (ODMobileMBOUnionsGeoSynchronizationParametersMetaData*)getInstance
{
    return [[[ODMobileMBOUnionsGeoSynchronizationParametersMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 49;
		self.name = @"MBOUnionsGeoSynchronizationParameters";
		self.klass = [ODMobileMBOUnionsGeoSynchronizationParameters class];
 		self.allowPending = NO;;

		self.isClientOnly = YES;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_LON_DELTA = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			976:
			[SUPDataType forName:@"string?"]:@"varchar(48)":@"LON_DELTA":@"":@"LON_DELTA":
			@"":48:0:0:
			@"null":YES:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			YES:SUPPersonalizationType_None:NO];
		[a_LON_DELTA setColumn:@"LON_DELTA"];
		SUPAttributeMetaDataRBS* a_LON_DELTAUserDefined = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			977:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"LON_DELTAUserDefined":@"":@"LON_DELTAUserDefined":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_LON_DELTAUserDefined setColumn:@"LON_DELTAUserDefined"];
		SUPAttributeMetaDataRBS* a_LAT_DELTA = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			978:
			[SUPDataType forName:@"string?"]:@"varchar(48)":@"LAT_DELTA":@"":@"LAT_DELTA":
			@"":48:0:0:
			@"null":YES:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			YES:SUPPersonalizationType_None:NO];
		[a_LAT_DELTA setColumn:@"LAT_DELTA"];
		SUPAttributeMetaDataRBS* a_LAT_DELTAUserDefined = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			979:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"LAT_DELTAUserDefined":@"":@"LAT_DELTAUserDefined":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_LAT_DELTAUserDefined setColumn:@"LAT_DELTAUserDefined"];
		SUPAttributeMetaDataRBS* a_LAT = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			980:
			[SUPDataType forName:@"string?"]:@"varchar(48)":@"LAT":@"":@"LAT":
			@"":48:0:0:
			@"null":YES:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			YES:SUPPersonalizationType_None:NO];
		[a_LAT setColumn:@"LAT"];
		SUPAttributeMetaDataRBS* a_LATUserDefined = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			981:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"LATUserDefined":@"":@"LATUserDefined":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_LATUserDefined setColumn:@"LATUserDefined"];
		SUPAttributeMetaDataRBS* a_LON = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			982:
			[SUPDataType forName:@"string?"]:@"varchar(48)":@"LON":@"":@"LON":
			@"":48:0:0:
			@"null":YES:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			YES:SUPPersonalizationType_None:NO];
		[a_LON setColumn:@"LON"];
		SUPAttributeMetaDataRBS* a_LONUserDefined = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			983:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"LONUserDefined":@"":@"LONUserDefined":
			@"":-1:0:0:
			@"false":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_LONUserDefined setColumn:@"LONUserDefined"];
		SUPAttributeMetaDataRBS* a_size_sp = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			985:
			[SUPDataType forName:@"int"]:@"integer":@"size_sp":@"":@"size_sp":
			@"":-1:0:0:
			@"4":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_size_sp setColumn:@"size_sp"];
		SUPAttributeMetaDataRBS* a_user_sp = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			984:
			[SUPDataType forName:@"string"]:@"varchar(300)":@"user_sp":@"":@"user_sp":
			@"":300:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_user_sp setColumn:@"user_sp"];
 		
		[attributes addThis:a_LON_DELTA];
		[attributes addThis:a_LON_DELTAUserDefined];
		[attributes addThis:a_LAT_DELTA];
		[attributes addThis:a_LAT_DELTAUserDefined];
		[attributes addThis:a_LAT];
		[attributes addThis:a_LATUserDefined];
		[attributes addThis:a_LON];
		[attributes addThis:a_LONUserDefined];
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
		self.table = @"co_odmobile_1_21_mbounionsgeosp";
		self.synchronizationGroup = @"";

			
		[self.keyList add:a_user_sp];


    }
    return self;
}
@end