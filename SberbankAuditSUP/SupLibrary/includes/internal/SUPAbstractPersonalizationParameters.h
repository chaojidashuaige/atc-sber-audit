/*
 
 Copyright (c) Sybase, Inc. 2012  All rights reserved.                                    
 
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
#import "SUPAbstractStructure.h"

@class SUPObjectList;
@class SUPServerPersonalizationDelegate;
@class SUPClientPersonalizationDelegate;
@interface SUPAbstractPersonalizationParameters : SUPAbstractStructure
{
    @protected
    BOOL    hasServerPK;
    BOOL    hasClientPK;
    BOOL    needReload;
    NSString *clientPersonalizationTableName;
}
@property(readwrite, retain, nonatomic) NSString* clientPersonalizationTableName;
@property(readwrite, assign, nonatomic)BOOL hasServerPK;
@property(readwrite, assign, nonatomic)BOOL hasClientPK;
@property(readwrite, assign, nonatomic)BOOL needReload;
@property(readwrite, retain, nonatomic)SUPServerPersonalizationDelegate *serverDelegate;
@property(readwrite, retain, nonatomic)SUPClientPersonalizationDelegate *clientDelegate;
@property(readwrite, retain, nonatomic)NSMutableDictionary *sessions;
@property(readwrite, retain, nonatomic)SUPObjectList *servers;
@property(readwrite, retain, nonatomic)SUPObjectList *clients;

- (id) getValue:(NSString*)pk;
- (id) getDefaultValue:(NSString*)pk;
- (void) load;
-/*abstract*/(NSString*)username;
-/*abstract*/(void)setUsername:(NSString*)username;
-/*abstract*/(NSString*)password;
-/*abstract*/(void)setPassword:(NSString*)password;
- (void) save;
- (void) saveUserNamePassword;
- (NSDictionary*) getAllPersonalizationKeys;
- (void) reset;
- (void) reloadIfNeeded;
@end
