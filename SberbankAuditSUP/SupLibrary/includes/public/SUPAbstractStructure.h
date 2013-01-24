/*
 
 Copyright (c) Sybase, Inc. 2012   All rights reserved.                                    
 
 In addition to the license terms set out in the Sybase License Agreement for 
 the Sybase Unwired Platform ("Program"), the following additional or different 
 rights and accompanying obligations and restrictions shall apply to the source 
 code in this file ("Code").  Sybase grants you a limited, non-exclusive, 
 non-transferable, revocable license to use, reproduce, and modify the Code 
 solely for purposes of (i) maintaining the Code as reference material to better
 understand the operation of the Program, and (ii) development and testing of 
 applications created in connection with your licensed use of the Program.  
 The Code may not be transferred, sold, assigned, sublicensed or otherwise 
 conveyed (whether by operation of law or otherwise) to another party without 
 Sybase's prior written consent.  The following provisions shall apply to any 
 modifications you make to the Code: (i) Sybase will not provide any maintenance
 or support for modified Code or problems that result from use of modified Code;
 (ii) Sybase expressly disclaims any warranties and conditions, express or 
 implied, relating to modified Code or any problems that result from use of the 
 modified Code; (iii) SYBASE SHALL NOT BE LIABLE FOR ANY LOSS OR DAMAGE RELATING
 TO MODIFICATIONS MADE TO THE CODE OR FOR ANY DAMAGES RESULTING FROM USE OF THE 
 MODIFIED CODE, INCLUDING, WITHOUT LIMITATION, ANY INACCURACY OF DATA, LOSS OF 
 PROFITS OR DIRECT, INDIRECT, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES, EVEN
 IF SYBASE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; (iv) you agree 
 to indemnify, hold harmless, and defend Sybase from and against any claims or 
 lawsuits, including attorney's fees, that arise from or are related to the 
 modified Code or from use of the modified Code. 
 
 */

#import <Foundation/Foundation.h>
#import "SUPEntityMetaDataRBS.h"
#import "sybase_sup.h"
#import "SUPOperationMetaData.h"
#import "SUPAttributeMetaDataRBS.h"

@interface SUPAbstractStructure : NSObject
{
    @protected
    // Metadata defines the concrete subclass this abstract entity represents.
    SUPEntityMetaDataRBS*	  _classMetaData;
    BOOL                  _isNew;
    BOOL                  _isDirty;
    BOOL                  _isDeleted;
}
@property (readwrite, retain, nonatomic) SUPEntityMetaDataRBS*	  classMetaData;
/** Returns true if this entity is new (i.e. has not yet been created in the database). */
@property(readwrite, assign, nonatomic) BOOL isNew;

/** Returns true if this entity was loaded from the database and was subsequently modified (in memory), but the change has not yet been saved to the database. */
@property(readwrite, assign, nonatomic) BOOL isDirty;

/** Returns true if this entity was loaded from the database and was subsequently deleted. */
@property(readwrite, assign, nonatomic) BOOL isDeleted;

- (id) init;
- (id)getClassDelegate;
-(void)setClassDelegate: (id)newClassDelegate;
- (void)copyAll:(id)entity;

- (void) dealloc;
-(NSString*)getAttributeValueToString:(SUPAttributeMetaDataRBS *)amd;
@end

@interface SUPAbstractStructure (internal)
- (SUPLong)getAttributeLong:(int)ind;
- (void)setAttributeLong:(int)ind:(SUPLong)value;
- (int)getAttributeInt:(int)ind;
- (void)setAttributeInt:(int)ind:(int)value;
- (SUPString)getAttributeString:(int)ind;
- (void)setAttributeString:(int)ind:(SUPString)value;
- (SUPBoolean)getAttributeBoolean:(int)ind;
- (void)setAttributeBoolean:(int)ind:(SUPBoolean)value;
- (SUPChar)getAttributeChar:(int)ind;
- (void)setAttributeChar:(int)ind:(SUPChar)value;
- (SUPDouble)getAttributeDouble:(int)ind;
- (void)setAttributeDouble:(int)ind:(SUPDouble)v;
- (SUPShort)getAttributeShort:(int)ind;
- (void)setAttributeShort:(int)ind:(SUPShort)v;
- (SUPFloat)getAttributeFloat:(int)ind;
- (void)setAttributeFloat:(int)ind:(SUPFloat)v;
- (SUPByte)getAttributeByte:(int)ind;
- (void)setAttributeByte:(int)ind:(SUPByte)v;
- (SUPDate)getAttributeDate:(int)ind;
- (void)setAttributeDate:(int)ind:(SUPDate)v;
- (SUPBinary) getAttributeBinary:(int)ind;
- (void)setAttributeBinary:(int)ind:(SUPBinary)v;
- (SUPTime)getAttributeTime:(int)ind;
- (void)setAttributeTime:(int)ind:(SUPTime)v;
- (SUPDateTime)getAttributeDateTime:(int)ind;
- (void)setAttributeDateTime:(int)ind:(SUPDateTime)v;
- (SUPDecimal)getAttributeDecimal:(int)ind;
- (void)setAttributeDecimal:(int)ind:(SUPDecimal)v;
- (SUPInteger)getAttributeInteger:(int)ind;
- (void)setAttributeInteger:(int)ind:(SUPInteger)v;

- (SUPNullableInteger)getAttributeNullableInteger:(int)ind;
- (void)setAttributeNullableInteger:(int)ind:(SUPNullableInteger)v;
- (SUPNullableLong)getAttributeNullableLong:(int)ind;
- (void)setAttributeNullableLong:(int)ind:(SUPNullableLong)value;
- (SUPNullableInt)getAttributeNullableInt:(int)ind;
- (void)setAttributeNullableInt:(int)ind:(SUPNullableInt)value;
- (SUPJsonObject *)getAttributeJson:(int)ind;
- (void)setAttributeJson:(int)ind:(NSObject *)value;

- (SUPNullableString)getAttributeNullableString:(int)ind;
- (void)setAttributeNullableString:(int)ind:(SUPNullableString)v;
- (SUPNullableBoolean)getAttributeNullableBoolean:(int)ind;
- (void)setAttributeNullableBoolean:(int)ind:(SUPNullableBoolean)value;
- (SUPNullableChar)getAttributeNullableChar:(int)ind;
- (void)setAttributeNullableChar:(int)ind:(SUPNullableChar)value;
- (SUPNullableDouble)getAttributeNullableDouble:(int)ind;
- (void)setAttributeNullableDouble:(int)ind:(SUPNullableDouble)v;
- (SUPNullableShort)getAttributeNullableShort:(int)ind;
- (void)setAttributeNullableShort:(int)ind:(SUPNullableShort)v;
- (SUPNullableFloat)getAttributeNullableFloat:(int)ind;
- (void)setAttributeNullableFloat:(int)ind:(SUPNullableFloat)v;
- (SUPNullableByte)getAttributeNullableByte:(int)ind;
- (void)setAttributeNullableByte:(int)ind:(SUPNullableByte)v;
- (SUPNullableDate)getAttributeNullableDate:(int)ind;
- (void)setAttributeNullableDate:(int)ind:(SUPNullableDate)v;
- (SUPNullableBinary) getAttributeNullableBinary:(int)ind;
- (void)setAttributeNullableBinary:(int)ind:(SUPNullableBinary) v;
- (SUPNullableTime)getAttributeNullableTime:(int)ind;
- (void)setAttributeNullableTime:(int)ind:(SUPNullableTime)v;
- (SUPNullableDateTime)getAttributeNullableDateTime:(int)ind;
- (void)setAttributeNullableDateTime:(int)ind:(SUPNullableDateTime)v;
- (SUPNullableDecimal)getAttributeNullableDecimal:(int)ind;
- (void)setAttributeNullableDecimal:(int)ind:(SUPNullableDecimal)v;
//- (void)setAttributeNullableNumber:(int)ind:(SUPNu
- (void)readJson:(SUPJsonObject*)json;
- (void)writeJsonAssociation:(SUPJsonObject *) obj:(SUPAttributeMetaDataRBS *) amd;
- (void)writeJson:(SUPJsonObject *)obj;

- (id)getAttributeObject:(int)id_:(BOOL)loadFromDBIfInvalid;
- (id)getAttributeObject:(int)id_;
- (void)setAttributeObject:(int)ind:(id)value;
- (SUPJsonObject *)getAttributeLargeObject:(int)ind  loadFromDB:(BOOL)loadFromDB;
- (void)setAttributeLargeObject:(int)ind:(NSObject *)value;

- (void)setAttributeValue:(NSObject *)o forAttribute:(SUPAttributeMetaDataRBS *)amd;
- (NSObject *)getAttributeValue:(SUPAttributeMetaDataRBS *) amd;
- (id) getDefaultValue:(SUPAttributeMetaDataRBS *) amd;
- (NSObject *)getDefaultKey:(SUPAttributeMetaDataRBS *)amd;
-(NSString*)getAttributeValueToString:(SUPAttributeMetaDataRBS *)amd;
- (void)setAttributeValueUsingString:(NSString*)s forAttribute:(SUPAttributeMetaDataRBS *)amd;
- (NSObject *)invokeOperation:(SUPOperationMetaData *)operationMetaData withArgs:(SUPObjectList *)args;
- (NSString *)toString;
@end
