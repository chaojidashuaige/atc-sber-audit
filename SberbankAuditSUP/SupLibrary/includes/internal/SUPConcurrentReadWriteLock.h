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

/*!
 @class SUPConcurrentReadWriteLock
 @abstract   This is a different class from SUPReadWriteLock.
 @discussion This lock class has the following properties:
 
 - Multiple threads may have a read lock simultaneously, up to a maximum determined by the maxReaders property.
 - Only one thread may have a write lock, and read threads can have read lock while the write lock is active.
 - Write thread can get write lock if there is no other write lock has been granted.
 - Requests for the lock are queued and processed in the order received, to avoid starvation of reader or writer threads.
 - The lock is recursive; a thread may have nested lock/unlock calls.
 - The recursive property has one restriction: if a thread first read locks, then attempts to write lock without first fully unlocking, an exception will be thrown.
 
 Author : janeyang
 */

#import "SUPReadWriteLockManager.h"

@interface SUPConcurrentReadWriteLock : NSObject<SUPReadWriteLockManager>
{
@private
    int32_t _maxReaders;
    NSMutableArray *_threads;
    NSMutableArray *_threadsWaiting;
    NSObject *_writeLockedBy;
    NSCondition *_condition;
}
/*
 * @property
 * @abstract The maximum number of threads allowed to have a read lock simultaneously.
 * @discussion Default value is -1 (no limit)
 *
 */
@property(readwrite,assign, nonatomic) int32_t maxReaders;
/*
 * @property
 * @abstract Internal property, not for external use.
 *
 */
@property(readwrite,retain,nonatomic) NSCondition *condition;
/*
 * @property
 * @abstract Internal property, not for external use.
 *
 */
@property(readwrite,retain,nonatomic) NSMutableArray *threads;
/*
 * @property
 * @abstract Internal property, not for external use.
 *
 */
@property(readwrite,retain,nonatomic) NSMutableArray *threadsWaiting;
/*
 * @property
 * @abstract Internal property, not for external use.
 *
 */
@property(readwrite,retain, nonatomic) NSObject *writeLockedBy;

- (SUPConcurrentReadWriteLock*)init;
- (void)dealloc;

/*
 * @method
 * @abstract Acquire a read lock.  The caller will block until the lock is acquired.
 */
- (void)readLock;
/*
 * @method
 * @abstract Acquire a write lock.  The caller will block until the lock is acquired.
 * @discussion If the calling thread's outermost lock is a read lock, this method throws an exception.
 * @throws NSException
 */
- (void)writeLock;

/*
 * @method
 * @abstract Unlock the most recent lock made by the calling thread.
 * @discussion If the calling thread has no lock, this method throws an exception.
 * @throws NSException
 */
- (void)unlock;
@end
