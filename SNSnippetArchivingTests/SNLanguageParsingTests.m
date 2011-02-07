//
//  SNLanguageParsingTests.m
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 07/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "SNLanguageParsingTests.h"


@implementation SNLanguageParsingTests

- (void)testObjectiveC {
	NSArray *input = [NSArray arrayWithObjects:@"", nil];
	for (NSString *language in input) {
		STAssertTrue([[SNSnippet normaliseLanguageWithName:language] isEqualToString:SNObjectiveCLanguage], @"");
	}
}

@end
