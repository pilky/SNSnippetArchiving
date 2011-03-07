//
//  SNSnippetWritingTests.m
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 23/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "SNSnippetWritingTests.h"
#import <SNSnippetArchiving/SNSnippetArchiving.h>

@interface SNSnippetWriter (ExposePrivateMethod) 

+ (NSString *)_generateXMLForSnippets:(NSArray *)aSnippets;

@end


@interface SNSnippetWritingTests () 

- (void)_performSingleSnippetTestWithAttributes:(NSDictionary *)aAttributes expectedSnippetString:(NSString *)aSnippetString;

@end


@implementation SNSnippetWritingTests

- (id)initWithInvocation:(NSInvocation *)anInvocation {
	if ((self = [super initWithInvocation:anInvocation])) {
		contentType = [@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" retain];
	}
	return self;
}

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testNoSnippets {
	NSString *outputString = @"<snippets></snippets>";
	NSString *targetString = [NSString stringWithFormat:@"%@%@", contentType, outputString];
	NSString *returnedString = [SNSnippetWriter _generateXMLForSnippets:nil];
	
	STAssertTrue([targetString isEqualToString:returnedString], @"Target string is not correct, instead:%@", returnedString);
}

- (void)testBlankSnippet {
	SNSnippet *snippet = [[SNSnippet alloc] init];
	
	NSString *outputString = @"<snippets>\n    <snippet></snippet>\n</snippets>";
	NSString *targetString = [NSString stringWithFormat:@"%@%@", contentType, outputString];
	NSString *returnedString = [SNSnippetWriter _generateXMLForSnippets:[NSArray arrayWithObject:snippet]];
	
	STAssertTrue([targetString isEqualToString:returnedString], @"Target string is not correct, %@ instead of %@", returnedString, targetString);
}

- (void)testMultipleBlankSnippets {	
	NSString *outputString = @"<snippets>\n    <snippet></snippet>\n    <snippet></snippet>\n    <snippet></snippet>\n</snippets>";
	NSString *targetString = [NSString stringWithFormat:@"%@%@", contentType, outputString];
	NSString *returnedString = [SNSnippetWriter _generateXMLForSnippets:[NSArray arrayWithObjects:[[SNSnippet alloc] init], [[SNSnippet alloc] init], [[SNSnippet alloc] init], nil]];
	
	STAssertTrue([targetString isEqualToString:returnedString], @"Target string is not correct, %@ instead of %@", returnedString, targetString);
}

- (void)testNameSnippet {
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:@"Test Snippet" forKey:@"name"];
	[self _performSingleSnippetTestWithAttributes:attributes expectedSnippetString:@"<name><![CDATA[Test Snippet]]></name>"];
}

- (void)testDescriptionSnippet {
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:@"This awesome snippet gives us unicorns and rainbows" forKey:@"snippetDescription"];
	[self _performSingleSnippetTestWithAttributes:attributes expectedSnippetString:@"<description><![CDATA[This awesome snippet gives us unicorns and rainbows]]></description>"];
}

- (void)testCodeSnippet {
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:@"<?php\n\tprint 'My great idea';\n?>" forKey:@"code"];
	[self _performSingleSnippetTestWithAttributes:attributes expectedSnippetString:@"<code><![CDATA[<?php\n\tprint 'My great idea';\n?>]]></code>"];
}

- (void)testLicenceSnippet {
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:[SNNamedLink namedLinkWithName:@"MIT" andURL:[NSURL URLWithString:@"http://www.opensource.org/licenses/mit-license.php"]] forKey:@"licence"];
	[self _performSingleSnippetTestWithAttributes:attributes expectedSnippetString:@"<license link=\"http://www.opensource.org/licenses/mit-license.php\">MIT</license>"];
	
	attributes = [NSDictionary dictionaryWithObject:[SNNamedLink namedLinkWithName:@"BSD" andURL:nil] forKey:@"licence"];
	[self _performSingleSnippetTestWithAttributes:attributes expectedSnippetString:@"<license>BSD</license>"];
}

- (void)testTagsSnippet {
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"Doxygen", @"Comment", nil] forKey:@"tags"];
	[self _performSingleSnippetTestWithAttributes:attributes expectedSnippetString:@"<tags><tag><![CDATA[Doxygen]]></tag><tag><![CDATA[Comment]]></tag></tags>"];
}

- (void)testAuthorSnippet {
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:@"John Doe", @"authorName", nil];
	[self _performSingleSnippetTestWithAttributes:attributes expectedSnippetString:@"<author><name><![CDATA[John Doe]]></name></author>"];
	
	attributes = [NSDictionary dictionaryWithObjectsAndKeys:@"john@johndoe.com", @"authorEmail", nil];
	[self _performSingleSnippetTestWithAttributes:attributes expectedSnippetString:@"<author><email>john@johndoe.com</email></author>"];
	
	attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSURL URLWithString:@"http://www.johndoe.com"], @"authorURL", nil];
	[self _performSingleSnippetTestWithAttributes:attributes expectedSnippetString:@"<author><link>http://www.johndoe.com</link></author>"];
	
	attributes = [NSDictionary dictionaryWithObjectsAndKeys:@"John Doe", @"authorName", [NSURL URLWithString:@"http://www.johndoe.com"], @"authorURL", @"john@johndoe.com", @"authorEmail", nil];
	[self _performSingleSnippetTestWithAttributes:attributes expectedSnippetString:@"<author><name><![CDATA[John Doe]]></name><email>john@johndoe.com</email><link>http://www.johndoe.com</link></author>"];
}

- (void)testLinksSnippet {
	NSArray *links = [NSArray arrayWithObjects:[SNNamedLink namedLinkWithName:@"Source" andURL:[NSURL URLWithString:@"http://example.com/somecode.html"]], 
					  [SNNamedLink namedLinkWithName:@"Example" andURL:[NSURL URLWithString:@"http://mysite.com/test.php"]], nil];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:links forKey:@"links"];
	
	[self _performSingleSnippetTestWithAttributes:attributes expectedSnippetString:@"<links><link><name><![CDATA[Source]]></name><url>http://example.com/somecode.html</url></link><link><name><![CDATA[Example]]></name><url>http://mysite.com/test.php</url></link></links>"];
}

- (void)testSnippetHighlightXML {
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:@"html", @"highlightKey", @"HTML", @"highlightName", nil];
	[self _performSingleSnippetTestWithAttributes:attributes expectedSnippetString:@"<highlight key=\"html\"><![CDATA[HTML]]></highlight>"];
}

- (void)_performSingleSnippetTestWithAttributes:(NSDictionary *)aAttributes expectedSnippetString:(NSString *)aSnippetString {
	SNSnippet *snippet = [[SNSnippet alloc] init];
	for (NSString *key in aAttributes) {
		[snippet setValue:[aAttributes objectForKey:key] forKey:key];
	}
	
	NSString *targetString = [NSString stringWithFormat:@"<snippet>%@</snippet>", aSnippetString];
	NSString *returnedString = [[snippet xmlRepresentation] XMLString];
	
	STAssertTrue([targetString isEqualToString:returnedString], @"Target string is not correct, %@ instead of %@", returnedString, targetString);
}

@end
