//
//  SNSnippetArchivingTests.m
//  SNSnippetArchivingTests
//
//  Created by Martin Pilkington on 02/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "SNSnippetArchivingTests.h"
#import <SNSnippetArchiving/SNSnippetArchiving.h>

@interface SNSnippetArchivingTests ()

- (void)_performTestForKey:(NSString *)aKey expectedValues:(NSArray *)aExpectedValues;

@end

@implementation SNSnippetArchivingTests

- (id)initWithInvocation:(NSInvocation *)inv {
	if ((self = [super initWithInvocation:inv])) {
		NSURL *path = [[NSBundle bundleWithIdentifier:@"com.mcubedsw.SNSnippetArchivingTests"] URLForResource:@"Test" withExtension:@"snippet"];
		document = [[NSXMLDocument alloc] initWithContentsOfURL:path options:0 error:nil]; 
	}
	return self;
}

- (void)setUp {
    [super setUp];
	
	NSError *tempError = nil;
	
	snippets = [[SNSnippetReader snippetsFromXMLDocument:document error:&tempError] copy];
	if (!snippets) {
		error = [tempError retain];
	}
	
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    [snippets release], snippets = nil;
	[error release], error = nil;
    [super tearDown];
}


- (void)testSnippetCount {
	STAssertEquals([snippets count], (NSUInteger)4, @"Snippets doesn't contain 4 snippets");
	STAssertNil(error, @"Error is not nil, instead:%@", error);
}

- (void)testSnippetNames {
	[self _performTestForKey:@"name" expectedValues:[NSArray arrayWithObjects:@"Frame initialisers", @"Centre Align Image", @"Test Snippet", @"Category Doxygen Comment", nil]];
}

- (void)testSnippetDescriptions {
	[self _performTestForKey:@"snippetDescription" expectedValues:[NSArray arrayWithObject:@"Hey, this is cool snippet."]];
}

- (void)testSnippetCode {
	NSMutableArray *array = [NSMutableArray array];
	[array addObject:[NSString stringWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.mcubedsw.SNSnippetArchivingTests"] pathForResource:@"frameinitialisers_code" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil]];
	[array addObject:[NSString stringWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.mcubedsw.SNSnippetArchivingTests"] pathForResource:@"centrealignimage_code" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil]];
	[array addObject:[NSString stringWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.mcubedsw.SNSnippetArchivingTests"] pathForResource:@"categorydoxygencomment_code" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil]];
	[array addObject:[NSString stringWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.mcubedsw.SNSnippetArchivingTests"] pathForResource:@"testsnippet_code" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil]];
	
	[self _performTestForKey:@"code" expectedValues:array];
}

- (void)testSnippetLicences {
	SNNamedLink *mitLicence = [[SNNamedLink alloc] initWithName:@"MIT" andURL:[NSURL URLWithString:@"http://www.opensource.org/licenses/mit-license.php"]];
	SNNamedLink *otherLicence = [[SNNamedLink alloc] initWithName:@"Other" andURL:nil];
	[self _performTestForKey:@"licence" expectedValues:[NSArray arrayWithObjects:mitLicence, mitLicence, otherLicence, otherLicence, nil]];
}

- (void)testSnippetLinks {
	SNNamedLink *link11 = [[[SNNamedLink alloc] initWithName:@"source" andURL:[NSURL URLWithString:@"http://someblog.com/cool-code.html"]] autorelease];
	SNNamedLink *link12 = [[[SNNamedLink alloc] initWithName:@"example" andURL:[NSURL URLWithString:@"http://someblog.com/cool-example.html"]] autorelease];
	SNNamedLink *link21 = [[[SNNamedLink alloc] initWithName:@"source" andURL:[NSURL URLWithString:@"http://example.com/snippets.php"]] autorelease];

	[self _performTestForKey:@"links" expectedValues:[NSArray arrayWithObjects:[NSArray arrayWithObjects:link11, link12, nil], [NSArray arrayWithObject:link21], nil]];
}

- (void)testSnippetAuthors {
	[self _performTestForKey:@"authorName" expectedValues:[NSArray arrayWithObjects:@"Coda", @"Xcode", @"John Doe", @"Jane Doe", nil]];
	[self _performTestForKey:@"authorEmail" expectedValues:[NSArray arrayWithObjects:@"john@johndoe.com", @"jane@janedoe.com", nil]];
	[self _performTestForKey:@"authorURL" expectedValues:[NSArray arrayWithObjects:[NSURL URLWithString:@"http://www.johndoe.com/"], [NSURL URLWithString:@"http://www.janedoe.com/"], nil]];
}

- (void)testSnippetTags {
	[self _performTestForKey:@"tags" expectedValues:[NSArray arrayWithObjects:[NSArray arrayWithObject:@"Tag #1"], [NSArray arrayWithObjects:@"Doxygen", @"Comment", nil], nil]];
}

- (void)testSnippetHighlights {
	[self _performTestForKey:@"highlightKey" expectedValues:[NSArray arrayWithObjects:@"objc", @"c", @"html", @"unknown", nil]];
	[self _performTestForKey:@"highlightName" expectedValues:[NSArray arrayWithObjects:@"Objective-C", @"C", @"HTML", @"Obj-PHP", nil]];
}




#pragma -
#pragma Misc

- (void)_performTestForKey:(NSString *)aKey expectedValues:(NSArray *)aExpectedValues {
	NSArray *values = [[snippets valueForKey:aKey] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
		return ![evaluatedObject isKindOfClass:[NSNull class]];
	}]];
	STAssertEquals([values count], [aExpectedValues count], @"There should be %d snippet(s) with values for key '%@'", [aExpectedValues count], aKey);
	for (NSString *value in aExpectedValues) {
		STAssertTrue([values containsObject:value], @"Snippet with value '%@' for key '%@', doesn't exist", value, aKey);
	}
}


@end
