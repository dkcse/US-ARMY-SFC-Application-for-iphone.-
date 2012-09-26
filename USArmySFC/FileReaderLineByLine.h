//
//  FileReaderLineByLine.h
//  USArmySFC
//
//  Created by Deepak Kumar on 19/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileReaderLineByLine : NSObject
{
    unsigned long long currentOffset;
    unsigned long long totalFileLength;
}
@property (nonatomic,strong) NSString *filePath;
@property (nonatomic,strong) NSFileHandle *fileHandle;
@property (nonatomic, copy) NSString * lineDelimiter;
@property (nonatomic) NSUInteger chunkSize;

- (id) initWithFilePath:(NSString *)aPath;

- (NSString *) readLine;
- (NSString *) readTrimmedLine;

@end
