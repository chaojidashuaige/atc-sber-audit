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
#import "SUPAbstractStructure.h"
#import "sybase_sup.h"
#import "SUPLocalEntityDelegate.h"
#import "SUPEntityDelegate.h"
#import "SUPStatementWrapper.h"

#define OP_CREATE           0
#define OP_UPDATE           1
#define OP_DELETE           2
#define OP_SAVE             3
#define OP_SUBMIT_PENDING   4
#define OP_UPDATE_STATUS    5
#define OP_UPDATE_REPLAY_COUNTER    6
#define OP_CANCEL_PENDING   7
#define OP_REPLAY_FAILURE   8
#define OP_CANCEL_OS_PENDING    9

@class SUPEntityDelegate;
@interface SUPAbstractLocalEntity : SUPAbstractStructure
{
    
}
- (void)save;
- (void)refresh;
- (void) create;
- (void) update;
- (void) delete;
- (void)setEntityDelegate:(SUPEntityDelegate*)newEntityDelegate;
- (SUPObjectList*) getChildren:(SUPRelationshipMetaData*) amd:(BOOL)pendingOnly:(BOOL)enableSubmitOnly;
@end
@interface SUPAbstractLocalEntity (internal)
- (SUPLocalEntityDelegate*)getEntityDelegate;
//- (void)setEntityDeletgate:(SUPEntityDelegate*)newEntityDelegate;
- (int)bindToStatement:(id<SUPStatementWrapper>) sw withAttribute:(SUPAttributeMetaDataRBS *)amd atIndex:(NSInteger)index;
- (void)bindCUD:(id<SUPStatementWrapper>) sw withType:(int)type;
- (id)cloneAll;
- (SUPString)generateCreateStatement;
- (SUPString)getCreateSQL;
- (SUPString)generateUpdateStatement;
- (SUPString)getUpdateSQL;
- (SUPString)generateDeleteStatement;
- (SUPString)getDeleteSQL;
- (void) cascadeSave;
- (void) cascadeDelete;
- (void)cascadeOpToChild:(int) opType withData:(id)data withEntity:(SUPAbstractLocalEntity*)childMBO;
- (BOOL)cascade:(int)opType :(id)data;
- (void) createCore;
- (void) updateCore;
- (void) deleteCore;
- (id) i_pk;
- (SUPString) keyToString;
- (void) bindNames:(SUPStringList*)names withResultSet:(id<SUPResultSetWrapper>)rs;
- (void) bindAttributes:(SUPObjectList*)attrList withResultSet:(id<SUPResultSetWrapper>)rs skipLazyLoad:(BOOL)skipLazyLoad;
-(void) writeJson:(SUPJsonObject*)obj;
- (void)writeJsonAssociation:(SUPJsonObject *) obj:(SUPRelationshipMetaData *) relationship;
- (BOOL) isUserDefinedInPK:(SUPAttributeMetaDataRBS*)amd;
- (void) refreshSelfOnly;
-(SUPQuery*) combineChildrenQuery:(SUPQuery*)query :(SUPStringList*)keys;
@end
