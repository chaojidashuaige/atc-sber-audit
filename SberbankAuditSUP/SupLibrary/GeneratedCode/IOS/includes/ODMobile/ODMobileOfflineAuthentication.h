#import "sybase_sup.h"

#import "SUPClassWithMetaData.h"
#import "SUPAbstractLocalEntity.h"
#import "SUPLocalBusinessObject.h"
#import "SUPLocalEntityDelegate.h"


@class SUPEntityMetaDataRBS;
@class SUPLocalEntityDelegate;
@class SUPClassMetaDataRBS;

// public interface declaration, can be used by application. 
/*!
 @class ODMobileOfflineAuthentication
 @abstract This class is part of package "ODMobile:1.21"
 @discussion Generated by Sybase Unwired Platform, compiler version 2.1.3.358
*/

@interface ODMobileOfflineAuthentication : SUPAbstractLocalEntity<SUPLocalBusinessObject, SUPClassWithMetaData>
{
@private
    int32_t _passwordHash;
    NSString* _user;
}

@property(assign,nonatomic) int32_t passwordHash;
@property(retain,nonatomic) NSString* user;

+ (SUPEntityMetaDataRBS*)metaData;
+ (SUPLocalEntityDelegate *)delegate;
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
+ (ODMobileOfflineAuthentication*)find:(NSString*)id_;
/*!
  @method 
  @abstract Returns the primary key for this entity.
  @discussion
 */
- (NSString*)_pk;
/*!
  @method 
  @abstract Returns the entity for the primary key value passed in; throws an exception if the entity is not found.
  @discussion
  @throws SUPPersistenceException
 */
+ (ODMobileOfflineAuthentication*)load:(NSString*)id;
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
+ (ODMobileOfflineAuthentication*)getInstance;
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
  @abstract Return a list of ODMobileOfflineAuthentication objects
  @discussion
  @throws SUPPersistenceException
 */
+ (SUPObjectList*)getPendingObjects;
/*!
  @method 
  @abstract Return a list of ODMobileOfflineAuthentication objects
  @discussion
  @throws SUPPersistenceException
 */
+ (SUPObjectList*)getPendingObjects:(int32_t)skip take:(int32_t)take;


@end
typedef SUPObjectList ODMobileOfflineAuthenticationList;

// internal methods declaration, only used by generated code.
@interface ODMobileOfflineAuthentication(internal)


- (SUPJsonObject*)getAttributeJson:(int)id_;
- (void)setAttributeJson:(int)id_:(SUPJsonObject*)value;

-(SUPString) getAttributeString:(int)id_;
-(void) setAttributeString:(int)id_:(SUPString)v;
-(SUPInt) getAttributeInt:(int)id_;
-(void) setAttributeInt:(int)id_:(SUPInt)v;
@end