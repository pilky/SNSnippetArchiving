//
//  NSXMLElement+SNExtensions.m
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 02/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "NSXMLElement+SNExtensions.h"


@implementation NSXMLElement (SNExtensions)

- (NSXMLElement *)sn_elementForName:(NSString *)aName {
	NSArray *elements = [self elementsForName:aName];
	if ([elements count]) {
		return [elements objectAtIndex:0];
	}
	return nil;
}

@end
