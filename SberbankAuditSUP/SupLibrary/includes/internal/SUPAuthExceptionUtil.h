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

#import <Foundation/Foundation.h>
#import "SUPSynchronizeException.h"

#ifndef AUTHENTICATION_VALUES
#define AUTHENTICATION_VALUES
#define PACKAGE_DISABED_CODE 3000
#define UPGRADE_NOT_FINISH_CODE 3001
#define PV_NOT_COMPATIBLE_CODE 3002
#define APP_PACKAGE_NOT_MATCH_CODE 3003
#define APP_CONN_NOT_MATCH_CODE 3004
#define APP_CONN_LOCKED 3005
#define FAILURE_CODE_TOKEN_VALIDATION_ERROR 3006
#define FAILURE_CODE_IMPERSONATION_ERROR 3007
#define PACKAGE_DISABLED_MSG @"Package is disabled on server."
#define UPGRADE_NOT_FINISH_MSG @"The server upgrade is not finished."
#define PV_NOT_COMPATIBLE_MSG @"The client's protocol version is bigger than the server's protocol version"
#define APP_PACKAGE_NOT_MATCH_MSG @"The application doesn't match with the package"
#define APP_CONN_NOT_MATCH_MSG @"The application connection doesn't match with the application id"
#define APP_CONN_LOCKED_MSG @"The application connection is locked"
#define FAILURE_CODE_TOKEN_VALIDATION_ERROR_MSG @"Authentication failed because the token validation failed"
#define FAILURE_CODE_IMPERSONATION_ERROR_MSG @"Authentication failed because the username does not match the specified token/certificate"
#endif

@interface SUPAuthExceptionUtil : NSObject
+ (void) checkAuthValueAfterSync: (int)authValue:(SUPSynchronizeException*)ex;
@end
