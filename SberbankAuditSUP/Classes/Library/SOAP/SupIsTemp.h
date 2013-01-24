#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class SupIsTemp_AuthenticationExceptionDetail;
@class SupIsTemp_createActivity;
@class SupIsTemp_createActivityResponse;
@class SupIsTemp_createSimpleActivity;
@class SupIsTemp_createSimpleActivityResponse;
@class SupIsTemp_getSubbranchActivities;
@class SupIsTemp_getSubbranchActivitiesResponse;
@class SupIsTemp_getTask;
@class SupIsTemp_getTaskCounters;
@class SupIsTemp_getTaskCountersResponse;
@class SupIsTemp_getTaskResponse;
@class SupIsTemp_getTasks;
@class SupIsTemp_getTasksResponse;
@class SupIsTemp_getUserActivities;
@class SupIsTemp_getUserActivitiesResponse;
@class SupIsTemp_IllegalArgumentsExceptionDetail;
@class SupIsTemp_InternalExceptionDetail;
@class SupIsTemp_logon;
@class SupIsTemp_logonResponse;
@class SupIsTemp_updateActivity;
@class SupIsTemp_updateActivityResponse;
@class SupIsTemp_updateTask;
@class SupIsTemp_updateTaskResponse;
@class SupIsTemp_Task;
@class SupIsTemp_Activity;
@class SupIsTemp_TaskCounter;
@class SupIsTemp_UserEmployee;
@class SupIsTemp_CheckSummary;
@interface SupIsTemp_AuthenticationExceptionDetail : NSObject {
	
/* elements */
	NSString * message;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_AuthenticationExceptionDetail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * message;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_Activity : NSObject {
	
/* elements */
	NSNumber * activityId;
	NSString * activityName;
	NSNumber * activityTypeId;
	NSString * activityTypeName;
	NSNumber * activityTypeCategoryId;
	NSString * activityTypeCategoryName;
	NSNumber * activityStatusId;
	NSString * activityStatusName;
	NSNumber * activityPriorityId;
	NSString * activityPriorityName;
	NSString * problems;
	NSString * dueDate;
	NSString * timeToFinish;
	NSNumber * creatorEmployeeId;
	NSString * creatorEmployeeFio;
	NSString * creatorEmployeePosition;
	NSString * creatorEmployeeSbName;
	NSString * creatorEmployeeSbLevel;
	NSNumber * responsibleEmployeeId;
	NSString * responsibleEmployeeFio;
	NSString * factEndDate;
	NSString * responsibleDesc;
	NSNumber * inspectorEmployeeId;
	NSString * inspectorEmployeeFio;
	NSString * closeDate;
	NSString * inspectorDesc;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_Activity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * activityId;
@property (retain) NSString * activityName;
@property (retain) NSNumber * activityTypeId;
@property (retain) NSString * activityTypeName;
@property (retain) NSNumber * activityTypeCategoryId;
@property (retain) NSString * activityTypeCategoryName;
@property (retain) NSNumber * activityStatusId;
@property (retain) NSString * activityStatusName;
@property (retain) NSNumber * activityPriorityId;
@property (retain) NSString * activityPriorityName;
@property (retain) NSString * problems;
@property (retain) NSString * dueDate;
@property (retain) NSString * timeToFinish;
@property (retain) NSNumber * creatorEmployeeId;
@property (retain) NSString * creatorEmployeeFio;
@property (retain) NSString * creatorEmployeePosition;
@property (retain) NSString * creatorEmployeeSbName;
@property (retain) NSString * creatorEmployeeSbLevel;
@property (retain) NSNumber * responsibleEmployeeId;
@property (retain) NSString * responsibleEmployeeFio;
@property (retain) NSString * factEndDate;
@property (retain) NSString * responsibleDesc;
@property (retain) NSNumber * inspectorEmployeeId;
@property (retain) NSString * inspectorEmployeeFio;
@property (retain) NSString * closeDate;
@property (retain) NSString * inspectorDesc;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_createActivity : NSObject {
	
/* elements */
	SupIsTemp_Activity * activity;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_createActivity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SupIsTemp_Activity * activity;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_createActivityResponse : NSObject {
	
/* elements */
	NSString * updateActivityReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_createActivityResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * updateActivityReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_createSimpleActivity : NSObject {
	
/* elements */
	NSString * userLogin;
	NSNumber * subbranchId;
	NSString * activityName;
	NSNumber * activityTypeId;
	NSNumber * activityStatusId;
	NSNumber * activityPriorityId;
	NSString * problems;
	NSString * dueDate;
	NSString * attachment;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_createSimpleActivity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * userLogin;
@property (retain) NSNumber * subbranchId;
@property (retain) NSString * activityName;
@property (retain) NSNumber * activityTypeId;
@property (retain) NSNumber * activityStatusId;
@property (retain) NSNumber * activityPriorityId;
@property (retain) NSString * problems;
@property (retain) NSString * dueDate;
@property (retain) NSString * attachment;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_createSimpleActivityResponse : NSObject {
	
/* elements */
	NSString * updateActivityReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_createSimpleActivityResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * updateActivityReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_getSubbranchActivities : NSObject {
	
/* elements */
	NSNumber * subbranchId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_getSubbranchActivities *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * subbranchId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_getSubbranchActivitiesResponse : NSObject {
	
/* elements */
	NSMutableArray *activity;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_getSubbranchActivitiesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addActivity:(SupIsTemp_Activity *)toAdd;
@property (readonly) NSMutableArray * activity;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_getTask : NSObject {
	
/* elements */
	NSString * userLogin;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_getTask *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * userLogin;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_getTaskCounters : NSObject {
	
/* elements */
	NSString * userLogin;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_getTaskCounters *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * userLogin;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_TaskCounter : NSObject {
	
/* elements */
	NSNumber * countToday;
	NSNumber * countNext;
	NSNumber * countPrevious;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_TaskCounter *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * countToday;
@property (retain) NSNumber * countNext;
@property (retain) NSNumber * countPrevious;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_getTaskCountersResponse : NSObject {
	
/* elements */
	SupIsTemp_TaskCounter * counter;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_getTaskCountersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SupIsTemp_TaskCounter * counter;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_Task : NSObject {
	
/* elements */
	NSNumber * taskId;
	NSNumber * taskTypeId;
	NSString * taskTypeName;
	NSNumber * taskStatusId;
	NSString * taskStatusName;
	NSNumber * categoryId;
	NSString * categoryName;
	NSNumber * subbranchId;
	NSString * subbranchName;
	NSString * subbranchAddress;
	NSNumber * subbranchChiefId;
	NSString * subbranchChiefFio;
	NSNumber * creatorEmployeeId;
	NSString * creatorEmployeeFio;
	NSNumber * resourceEmployeeId;
	NSString * resourceEmployeeFio;
	NSString * taskDesc;
	NSString * taskDuration;
	NSString * planStartDate;
	NSString * timeToStart;
	NSString * planEndDate;
	NSString * dueDate;
	NSString * template;
	NSString * previousAnswers;
	NSString * selfResourceEmployeeFio;
	NSString * selfCheckDate;
	NSString * selfCheckType;
	NSNumber * selfPoints;
	NSNumber * selfDispersion;
	NSNumber * selfReduceIndex;
	NSNumber * selfCheckResult;
	NSString * otherResourceEmployeeFio;
	NSString * otherCheckDate;
	NSString * otherCheckType;
	NSNumber * otherPoints;
	NSNumber * otherDispersion;
	NSNumber * otherReduceIndex;
	NSNumber * otherCheckResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_Task *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * taskId;
@property (retain) NSNumber * taskTypeId;
@property (retain) NSString * taskTypeName;
@property (retain) NSNumber * taskStatusId;
@property (retain) NSString * taskStatusName;
@property (retain) NSNumber * categoryId;
@property (retain) NSString * categoryName;
@property (retain) NSNumber * subbranchId;
@property (retain) NSString * subbranchName;
@property (retain) NSString * subbranchAddress;
@property (retain) NSNumber * subbranchChiefId;
@property (retain) NSString * subbranchChiefFio;
@property (retain) NSNumber * creatorEmployeeId;
@property (retain) NSString * creatorEmployeeFio;
@property (retain) NSNumber * resourceEmployeeId;
@property (retain) NSString * resourceEmployeeFio;
@property (retain) NSString * taskDesc;
@property (retain) NSString * taskDuration;
@property (retain) NSString * planStartDate;
@property (retain) NSString * timeToStart;
@property (retain) NSString * planEndDate;
@property (retain) NSString * dueDate;
@property (retain) NSString * template;
@property (retain) NSString * previousAnswers;
@property (retain) NSString * selfResourceEmployeeFio;
@property (retain) NSString * selfCheckDate;
@property (retain) NSString * selfCheckType;
@property (retain) NSNumber * selfPoints;
@property (retain) NSNumber * selfDispersion;
@property (retain) NSNumber * selfReduceIndex;
@property (retain) NSNumber * selfCheckResult;
@property (retain) NSString * otherResourceEmployeeFio;
@property (retain) NSString * otherCheckDate;
@property (retain) NSString * otherCheckType;
@property (retain) NSNumber * otherPoints;
@property (retain) NSNumber * otherDispersion;
@property (retain) NSNumber * otherReduceIndex;
@property (retain) NSNumber * otherCheckResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_getTaskResponse : NSObject {
	
/* elements */
	SupIsTemp_Task * task;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_getTaskResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SupIsTemp_Task * task;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_getTasks : NSObject {
	
/* elements */
	NSString * userLogin;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_getTasks *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * userLogin;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_getTasksResponse : NSObject {
	
/* elements */
	NSMutableArray *task;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_getTasksResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addTask:(SupIsTemp_Task *)toAdd;
@property (readonly) NSMutableArray * task;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_getUserActivities : NSObject {
	
/* elements */
	NSString * userLogin;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_getUserActivities *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * userLogin;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_getUserActivitiesResponse : NSObject {
	
/* elements */
	NSMutableArray *activity;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_getUserActivitiesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addActivity:(SupIsTemp_Activity *)toAdd;
@property (readonly) NSMutableArray * activity;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_IllegalArgumentsExceptionDetail : NSObject {
	
/* elements */
	NSString * message;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_IllegalArgumentsExceptionDetail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * message;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_InternalExceptionDetail : NSObject {
	
/* elements */
	NSString * message;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_InternalExceptionDetail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * message;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_logon : NSObject {
	
/* elements */
	NSString * did;
	NSString * userLogin;
	NSString * userPassword;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_logon *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * did;
@property (retain) NSString * userLogin;
@property (retain) NSString * userPassword;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_UserEmployee : NSObject {
	
/* elements */
	NSNumber * employeeId;
	NSString * employeeFio;
	NSString * employeePosition;
	NSString * employeeSbName;
	NSString * employeeSbLevel;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_UserEmployee *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * employeeId;
@property (retain) NSString * employeeFio;
@property (retain) NSString * employeePosition;
@property (retain) NSString * employeeSbName;
@property (retain) NSString * employeeSbLevel;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_logonResponse : NSObject {
	
/* elements */
	SupIsTemp_UserEmployee * employee;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_logonResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SupIsTemp_UserEmployee * employee;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_updateActivity : NSObject {
	
/* elements */
	NSNumber * activityId;
	NSString * responsibleDesc;
	NSString * inspectorDesc;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_updateActivity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * activityId;
@property (retain) NSString * responsibleDesc;
@property (retain) NSString * inspectorDesc;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_updateActivityResponse : NSObject {
	
/* elements */
	NSString * updateActivityReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_updateActivityResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * updateActivityReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_updateTask : NSObject {
	
/* elements */
	NSNumber * taskId;
	NSNumber * taskStatusId;
	NSString * taskDesc;
	NSString * currentAnswers;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_updateTask *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * taskId;
@property (retain) NSNumber * taskStatusId;
@property (retain) NSString * taskDesc;
@property (retain) NSString * currentAnswers;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_updateTaskResponse : NSObject {
	
/* elements */
	NSString * updateTaskReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_updateTaskResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * updateTaskReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupIsTemp_CheckSummary : NSObject {
	
/* elements */
	NSString * resourceEmployeeFio;
	NSString * checkDate;
	NSString * checkType;
	NSNumber * points;
	NSNumber * dispersion;
	NSNumber * reduceIndex;
	NSNumber * checkResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupIsTemp_CheckSummary *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * resourceEmployeeFio;
@property (retain) NSString * checkDate;
@property (retain) NSString * checkType;
@property (retain) NSNumber * points;
@property (retain) NSNumber * dispersion;
@property (retain) NSNumber * reduceIndex;
@property (retain) NSNumber * checkResult;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xs.h"
#import "SupIsTemp.h"
@class SupIsTempBinding;
@interface SupIsTemp : NSObject {
	
}
+ (SupIsTempBinding *)SupIsTempBinding;
@end
@class SupIsTempBindingResponse;
@class SupIsTempBindingOperation;
@protocol SupIsTempBindingResponseDelegate <NSObject>
- (void) operation:(SupIsTempBindingOperation *)operation completedWithResponse:(SupIsTempBindingResponse *)response;
@end
@interface SupIsTempBinding : NSObject <SupIsTempBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(SupIsTempBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (SupIsTempBindingResponse *)getTaskUsingParameters:(SupIsTemp_getTask *)aParameters ;
- (void)getTaskAsyncUsingParameters:(SupIsTemp_getTask *)aParameters  delegate:(id<SupIsTempBindingResponseDelegate>)responseDelegate;
- (SupIsTempBindingResponse *)getTasksUsingParameters:(SupIsTemp_getTasks *)aParameters ;
- (void)getTasksAsyncUsingParameters:(SupIsTemp_getTasks *)aParameters  delegate:(id<SupIsTempBindingResponseDelegate>)responseDelegate;
- (SupIsTempBindingResponse *)logonUsingParameters:(SupIsTemp_logon *)aParameters ;
- (void)logonAsyncUsingParameters:(SupIsTemp_logon *)aParameters  delegate:(id<SupIsTempBindingResponseDelegate>)responseDelegate;
- (SupIsTempBindingResponse *)updateTaskUsingParameters:(SupIsTemp_updateTask *)aParameters ;
- (void)updateTaskAsyncUsingParameters:(SupIsTemp_updateTask *)aParameters  delegate:(id<SupIsTempBindingResponseDelegate>)responseDelegate;
- (SupIsTempBindingResponse *)getTaskCountersUsingParameters:(SupIsTemp_getTaskCounters *)aParameters ;
- (void)getTaskCountersAsyncUsingParameters:(SupIsTemp_getTaskCounters *)aParameters  delegate:(id<SupIsTempBindingResponseDelegate>)responseDelegate;
- (SupIsTempBindingResponse *)createActivityUsingParameters:(SupIsTemp_createActivity *)aParameters ;
- (void)createActivityAsyncUsingParameters:(SupIsTemp_createActivity *)aParameters  delegate:(id<SupIsTempBindingResponseDelegate>)responseDelegate;
- (SupIsTempBindingResponse *)createSimpleActivityUsingParameters:(SupIsTemp_createSimpleActivity *)aParameters ;
- (void)createSimpleActivityAsyncUsingParameters:(SupIsTemp_createSimpleActivity *)aParameters  delegate:(id<SupIsTempBindingResponseDelegate>)responseDelegate;
- (SupIsTempBindingResponse *)updateActivityUsingParameters:(SupIsTemp_updateActivity *)aParameters ;
- (void)updateActivityAsyncUsingParameters:(SupIsTemp_updateActivity *)aParameters  delegate:(id<SupIsTempBindingResponseDelegate>)responseDelegate;
- (SupIsTempBindingResponse *)getUserActivitiesUsingParameters:(SupIsTemp_getUserActivities *)aParameters ;
- (void)getUserActivitiesAsyncUsingParameters:(SupIsTemp_getUserActivities *)aParameters  delegate:(id<SupIsTempBindingResponseDelegate>)responseDelegate;
- (SupIsTempBindingResponse *)getSubbranchActivitiesUsingParameters:(SupIsTemp_getSubbranchActivities *)aParameters ;
- (void)getSubbranchActivitiesAsyncUsingParameters:(SupIsTemp_getSubbranchActivities *)aParameters  delegate:(id<SupIsTempBindingResponseDelegate>)responseDelegate;
@end
@interface SupIsTempBindingOperation : NSOperation {
	SupIsTempBinding *binding;
	SupIsTempBindingResponse *response;
	id<SupIsTempBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) SupIsTempBinding *binding;
@property (readonly) SupIsTempBindingResponse *response;
@property (nonatomic, assign) id<SupIsTempBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(SupIsTempBinding *)aBinding delegate:(id<SupIsTempBindingResponseDelegate>)aDelegate;
@end
@interface SupIsTempBinding_getTask : SupIsTempBindingOperation {
	SupIsTemp_getTask * parameters;
}
@property (retain) SupIsTemp_getTask * parameters;
- (id)initWithBinding:(SupIsTempBinding *)aBinding delegate:(id<SupIsTempBindingResponseDelegate>)aDelegate
	parameters:(SupIsTemp_getTask *)aParameters
;
@end
@interface SupIsTempBinding_getTasks : SupIsTempBindingOperation {
	SupIsTemp_getTasks * parameters;
}
@property (retain) SupIsTemp_getTasks * parameters;
- (id)initWithBinding:(SupIsTempBinding *)aBinding delegate:(id<SupIsTempBindingResponseDelegate>)aDelegate
	parameters:(SupIsTemp_getTasks *)aParameters
;
@end
@interface SupIsTempBinding_logon : SupIsTempBindingOperation {
	SupIsTemp_logon * parameters;
}
@property (retain) SupIsTemp_logon * parameters;
- (id)initWithBinding:(SupIsTempBinding *)aBinding delegate:(id<SupIsTempBindingResponseDelegate>)aDelegate
	parameters:(SupIsTemp_logon *)aParameters
;
@end
@interface SupIsTempBinding_updateTask : SupIsTempBindingOperation {
	SupIsTemp_updateTask * parameters;
}
@property (retain) SupIsTemp_updateTask * parameters;
- (id)initWithBinding:(SupIsTempBinding *)aBinding delegate:(id<SupIsTempBindingResponseDelegate>)aDelegate
	parameters:(SupIsTemp_updateTask *)aParameters
;
@end
@interface SupIsTempBinding_getTaskCounters : SupIsTempBindingOperation {
	SupIsTemp_getTaskCounters * parameters;
}
@property (retain) SupIsTemp_getTaskCounters * parameters;
- (id)initWithBinding:(SupIsTempBinding *)aBinding delegate:(id<SupIsTempBindingResponseDelegate>)aDelegate
	parameters:(SupIsTemp_getTaskCounters *)aParameters
;
@end
@interface SupIsTempBinding_createActivity : SupIsTempBindingOperation {
	SupIsTemp_createActivity * parameters;
}
@property (retain) SupIsTemp_createActivity * parameters;
- (id)initWithBinding:(SupIsTempBinding *)aBinding delegate:(id<SupIsTempBindingResponseDelegate>)aDelegate
	parameters:(SupIsTemp_createActivity *)aParameters
;
@end
@interface SupIsTempBinding_createSimpleActivity : SupIsTempBindingOperation {
	SupIsTemp_createSimpleActivity * parameters;
}
@property (retain) SupIsTemp_createSimpleActivity * parameters;
- (id)initWithBinding:(SupIsTempBinding *)aBinding delegate:(id<SupIsTempBindingResponseDelegate>)aDelegate
	parameters:(SupIsTemp_createSimpleActivity *)aParameters
;
@end
@interface SupIsTempBinding_updateActivity : SupIsTempBindingOperation {
	SupIsTemp_updateActivity * parameters;
}
@property (retain) SupIsTemp_updateActivity * parameters;
- (id)initWithBinding:(SupIsTempBinding *)aBinding delegate:(id<SupIsTempBindingResponseDelegate>)aDelegate
	parameters:(SupIsTemp_updateActivity *)aParameters
;
@end
@interface SupIsTempBinding_getUserActivities : SupIsTempBindingOperation {
	SupIsTemp_getUserActivities * parameters;
}
@property (retain) SupIsTemp_getUserActivities * parameters;
- (id)initWithBinding:(SupIsTempBinding *)aBinding delegate:(id<SupIsTempBindingResponseDelegate>)aDelegate
	parameters:(SupIsTemp_getUserActivities *)aParameters
;
@end
@interface SupIsTempBinding_getSubbranchActivities : SupIsTempBindingOperation {
	SupIsTemp_getSubbranchActivities * parameters;
}
@property (retain) SupIsTemp_getSubbranchActivities * parameters;
- (id)initWithBinding:(SupIsTempBinding *)aBinding delegate:(id<SupIsTempBindingResponseDelegate>)aDelegate
	parameters:(SupIsTemp_getSubbranchActivities *)aParameters
;
@end
@interface SupIsTempBinding_envelope : NSObject {
}
+ (SupIsTempBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface SupIsTempBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
