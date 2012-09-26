//
//  FileReaderLineByLine.m
//  USArmySFC
//
//  Created by Deepak Kumar on 19/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FileReaderLineByLine.h"


@interface NSData (DDAdditions)

- (NSRange) rangeOfData_dd:(NSData *)dataToFind;

@end

@implementation NSData (DDAdditions)

- (NSRange) rangeOfData_dd:(NSData *)dataToFind
{    
    const void * bytes = [self bytes];
    NSUInteger length = [self length];
    
    const void * searchBytes = [dataToFind bytes];
    NSUInteger searchLength = [dataToFind length];
    NSUInteger searchIndex = 0;
    
    NSRange foundRange = {NSNotFound, searchLength};
    for (NSUInteger index = 0; index < length; index++) 
    {
        if (((char *)bytes)[index] == ((char *)searchBytes)[searchIndex]) 
        {
            if (foundRange.location == NSNotFound) 
            {
                foundRange.location = index;
            }
            searchIndex++;
            if (searchIndex >= searchLength) 
            {
                return foundRange; 
            }
        } 
        else
        {
            searchIndex = 0;
            foundRange.location = NSNotFound;
        }
    }
    return foundRange;
}

@end


@implementation FileReaderLineByLine


@synthesize lineDelimiter = _lineDelimiter;
@synthesize chunkSize = _chunkSize;
@synthesize fileHandle = _fileHandle;
@synthesize filePath = _filePath;




- (id) initWithFilePath:(NSString *)aPath 
{
    if (self = [super init])
    {
        _fileHandle = [NSFileHandle fileHandleForReadingAtPath:aPath];
        if (_fileHandle == nil) 
        {
            return nil;
        }
        if(aPath == @"/Users/deepakkumar/US SFC/Contacts-Table.csv")
        {
            _lineDelimiter = [[NSString alloc] initWithString:@"\n"];
        }
        else if (aPath == @"/Users/deepakkumar/US SFC/Guidelines_Table.csv")
        {
            _lineDelimiter = [[NSString alloc]initWithString:@";"];
        }
        currentOffset = 0ULL;
        _chunkSize = 10;
        [_fileHandle seekToEndOfFile];
        totalFileLength = [_fileHandle offsetInFile];       
    }
    return self;
}


- (NSString *) readLine 
{
    if (currentOffset >= totalFileLength) 
    {
        return nil; 
    }
    
    NSData *newLineData = [_lineDelimiter dataUsingEncoding:NSUTF16StringEncoding];
    [_fileHandle seekToFileOffset:currentOffset];
    NSMutableData * currentData = [[NSMutableData alloc]init];
    BOOL shouldReadMore = YES;
    
    while (shouldReadMore)
    {
        if (currentOffset >= totalFileLength)
        { 
            break; 
        }
        NSData * chunk = [_fileHandle readDataOfLength:_chunkSize];
        
        NSRange newLineRange = [chunk rangeOfData_dd:newLineData];
        if (newLineRange.location != NSNotFound) 
        {
            //include the length so we can include the delimiter in the string
            chunk = [chunk subdataWithRange:NSMakeRange(0, newLineRange.location+[newLineData length])];
            
            shouldReadMore = NO;
        }
        
        
        [currentData appendData:chunk];
        currentOffset += [chunk length];
    }
    
    
    NSString * line = [[NSString alloc] initWithData:currentData encoding:NSUTF16StringEncoding];
    return line;
}

- (NSString *) readTrimmedLine 
{
    return [[self readLine] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}



@end
