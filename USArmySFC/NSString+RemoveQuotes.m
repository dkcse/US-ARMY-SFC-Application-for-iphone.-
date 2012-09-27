//
//  NSString+RemoveQuotes.m
//  USArmySFC
//
//  Created by Deepak Kumar on 27/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+RemoveQuotes.h"

@implementation NSString (RemoveQuotes)

- (NSString *)stringByRemoveLeadingAndTrailingQuotes
{
	NSString *newString = [self copy];
	newString = [newString substringFromIndex:1];
	newString = [newString substringToIndex:newString.length - 1];
	return newString;
}

@end
