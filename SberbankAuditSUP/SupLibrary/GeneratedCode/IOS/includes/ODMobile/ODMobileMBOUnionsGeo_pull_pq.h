#import "sybase_sup.h"

#import "SUPClassWithMetaData.h"
#import "SUPAbstractROEntity.h"


@class SUPEntityMetaDataRBS;
@class SUPEntityDelegate;
@class SUPClassMetaDataRBS;

// public interface declaration, can be used by application. 
/*!
 @class ODMobileMBOUnionsGeo_pull_pq
 @abstract This class is part of package "ODMobile:1.21"
 @discussion Generated by Sybase Unwired Platform, compiler version 2.1.3.358
*/

@interface ODMobileMBOUnionsGeo_pull_pq : SUPAbstractROEntity<SUPClassWithMetaData>
{
@private
    NSString* _username;
    NSString* _remoteId;
    NSString* _LON_DELTAParam;
    NSString* _LAT_DELTAParam;
    NSString* _LATParam;
    NSString* _LONParam;
    int64_t _id;
}

@property(retain,nonatomic) NSString* username;
@property(retain,nonatomic) NSString* remoteId;
@property(retain,nonatomic) NSString* LON_DELTAParam;
@property(retain,nonatomic) NSString* LAT_DELTAParam;
@property(retain,nonatomic) NSString* LATParam;
@property(retain,nonatomic) NSString* LONParam;
@property(assign,nonatomic) int64_t id_;

+ (SUPEntityMetaDataRBS*)metaData;
+ (SUPEntityDelegate *)delegate;
+ (SUPEntityDelegate*) getEntityDelegateForPQ;
/*!
  @method 
  @abstract Sets relationship attributes to null to save memory (they will be retrieved from the DB on the next getter call or property reference)
  @discussion
  @throws SUPPersistenceException
 */
- (void)clearRelationshipObjects;
- (id) init;
- (void)dealloc;
/*!
  @method 
  @abstract Returns the entity for the primary key value passed in, or null if the entity is not found.
  @discussion
  @throws SUPPersistenceException
 */
+ (ODMobileMBOUnionsGeo_pull_pq*)find:(int64_t)id_;
/*!
  @method 
  @abstract Returns the primary key for this entity.
  @discussion
 */
- (int64_t)_pk;
/*!
  @method 
  @abstract Returns the entity for the primary key value passed in; throws an exception if the entity is not found.
  @discussion
  @throws SUPPersistenceException
 */
+ (ODMobileMBOUnionsGeo_pull_pq*)load:(int64_t)id;
/*!
  @method 
  @abstract Returns an SUPObjectList of log records for this entity.
  @discussion
  @throws SUPPersistenceException
 */
- (SUPObjectList*)getLogRecords;
/*!
  @method 
  @abstract Creates a new autoreleased instance of this class
  @discussion
 */
+ (ODMobileMBOUnionsGeo_pull_pq*)getInstance;
/*!
  @method 
  @abstract Return a string description of this entity.
  @discussion
 */
- (NSString*)toString;
/*!
  @method 
  @abstract Return a string description of this entity.
  @discussion
 */
- (NSString*)description;
/*!
  @method 
  @abstract Return a list of ODMobileMBOUnionsGeo_pull_pq objects
  @discussion
  @throws SUPPersistenceException
 */
+ (SUPObjectList*)getPendingObjects;
/*!
  @method 
  @abstract Return a list of ODMobileMBOUnionsGeo_pull_pq objects
  @discussion
  @throws SUPPersistenceException
 */
+ (SUPObjectList*)getPendingObjects:(int32_t)skip take:(int32_t)take;
/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findAll;

/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param skip
  @param take
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findAll:(int32_t)skip take:(int32_t)take;
/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param _username
  @param lON_DELTA
  @param lAT_DELTA
  @param lAT
  @param lON
  @throws SUPPersistenceException
 */

+ (ODMobileMBOUnionsGeo_pull_pq*)findSub:(NSString*)_username withLON_DELTA:(NSString*)lON_DELTA withLAT_DELTA:(NSString*)lAT_DELTA withLAT:(NSString*)lAT withLON:(NSString*)lON;


@end
typedef SUPObjectList ODMobileMBOUnionsGeo_pull_pqList;

// internal methods declaration, only used by generated code.
@interface ODMobileMBOUnionsGeo_pull_pq(internal)


- (SUPJsonObject*)getAttributeJson:(int)id_;
- (void)setAttributeJson:(int)id_:(SUPJsonObject*)value;

-(SUPLong) getAttributeLong:(int)id_;
-(void) setAttributeLong:(int)id_:(SUPLong)v;
-(SUPString) getAttributeNullableString:(int)id_;
-(void) setAttributeNullableString:(int)id_:(SUPString)v;
@end