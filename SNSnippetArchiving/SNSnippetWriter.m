//
//  SNSnippetArchiving.m
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 02/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "SNSnippetWriter.h"
#import "SNSnippet.h"

@interface SNSnippetWriter () 

+ (NSString *)_generateXMLForSnippets:(NSArray *)aSnippets;

@end


@implementation SNSnippetWriter

+ (BOOL)writeSnippets:(NSArray *)aSnippets toFileAtPath:(NSString *)aPath error:(NSError **)aError {
	return [self writeSnippets:aSnippets toFileAtURL:[NSURL fileURLWithPath:aPath] error:&*aError];
}


+ (BOOL)writeSnippets:(NSArray *)aSnippets toFileAtURL:(NSURL *)aURL error:(NSError **)aError {
	NSString *xmlString = [self _generateXMLForSnippets:aSnippets];
	return [xmlString writeToURL:aURL atomically:YES encoding:NSUTF8StringEncoding error:&*aError];
}

+ (NSString *)_generateXMLForSnippets:(NSArray *)aSnippets {
	NSXMLElement *snippetsElement = [NSXMLNode elementWithName:@"snippets"];
	for (SNSnippet *snippet in aSnippets) {
		[snippetsElement addChild:[snippet xmlRepresentation]];
	}
	
	NSXMLDocument *document = [NSXMLDocument documentWithRootElement:snippetsElement];
	[document setCharacterEncoding:@"UTF-8"];
	[document setDocumentContentKind:NSXMLDocumentXMLKind];
	return [document XMLStringWithOptions:NSXMLNodePrettyPrint|NSXMLDocumentIncludeContentTypeDeclaration];
}

@end
