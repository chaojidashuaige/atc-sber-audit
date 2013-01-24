#import "ODMobileLoggerImpl.h"
#import "ODMobileLogRecordImpl.h"
#import "ODMobileKeyGenerator.h"

@implementation ODMobileLoggerImpl

- (id<SUPLogRecord>)createRealLogRecord
{
	ODMobileLogRecordImpl *log = [ODMobileLogRecordImpl getInstance];
	log.messageId = [ODMobileKeyGenerator generateId];
	log.requestId = [NSString stringWithFormat:@"%lld",log.messageId];
    log.timestamp = [NSDate dateWithTimeIntervalSinceNow:0];
	log.code = 9999;
	log.component = @"ODMobileDB";
	return log;
}


@end