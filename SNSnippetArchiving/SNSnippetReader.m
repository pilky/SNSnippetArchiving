//
//  SNSnippetReader.m
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 02/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "SNSnippetReader.h"
#import "SNSnippet.h"
#import "SNLanguageNormaliser.h"
#import "SNNamedLink.h"

@interface SNSnippetReader ()

+ (NSArray *)_snippetsFromOldCCPSnippetFileAtURL:(NSURL *)aURL error:(NSError **)aError;

@end

@implementation SNSnippetReader

+ (NSArray *)snippetsFromFileAtPath:(NSString *)aPath error:(NSError **)aError {
	return [self snippetsFromFileAtURL:[NSURL fileURLWithPath:aPath] error:&*aError];
}

+ (NSArray *)snippetsFromFileAtURL:(NSURL *)aURL error:(NSError **)aError {
	NSXMLDocument *doc = [[[NSXMLDocument alloc] initWithContentsOfURL:aURL options:0 error:&*aError] autorelease];
	if (!doc)
		return nil;
	
	if ([[doc nodesForXPath:@"plist" error:NULL] count]) {
		return [self _snippetsFromOldCCPSnippetFileAtURL:aURL error:&*aError];
	}
	
	return [self snippetsFromXMLDocument:doc error:&*aError];
}

+ (NSArray *)snippetsFromXMLDocument:(NSXMLDocument *)aDocument error:(NSError **)aError {
	NSArray *elements = [aDocument nodesForXPath:@"snippets/snippet" error:&*aError];
	if (!elements) 
		return nil;
	
	NSMutableArray *snippets = [NSMutableArray array];
	for (NSXMLElement *element in elements) {
		SNSnippet *snippet = [[SNSnippet alloc] initWithXML:element];
		[snippets addObject:snippet];
		[snippet release];
	}
	return [[snippets copy] autorelease];
}

+ (NSArray *)_snippetsFromOldCCPSnippetFileAtURL:(NSURL *)aURL error:(NSError **)aError {
	NSArray *snippets = [NSArray arrayWithContentsOfURL:aURL];
	if (![snippets count]) {
		NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Snippet file is empty" forKey:NSLocalizedDescriptionKey];
		if (aError != NULL) {
			*aError = [NSError errorWithDomain:SNErrorDomain code:1 userInfo:userInfo];
		}
		return nil;
	}
	
	NSMutableArray *returnSnippets = [NSMutableArray array];
	for (NSDictionary *snippetDict in snippets) {
		SNSnippet *snippet = [[SNSnippet alloc] init];
		
		[snippet setName:[snippetDict objectForKey:@"name"]];
		[snippet setCode:[snippetDict objectForKey:@"code"]];
		[snippet setLicence:[SNNamedLink namedLinkWithName:[snippetDict objectForKey:@"licence"] andURL:nil]];
		
		NSString *highlightKey = [SNLanguageNormaliser normaliseLanguageWithName:[snippetDict objectForKey:@"language"]];
		[snippet setHighlightKey:highlightKey];
		[snippet setHighlightName:[snippetDict objectForKey:@"language"]];
		[snippet setSnippetDescription:[snippetDict objectForKey:@"snippetDescription"]];
		[snippet setTags:[[snippetDict objectForKey:@"tags"] componentsSeparatedByString:@","]];
		
		[returnSnippets addObject:snippet];
		[snippet release];
	}
	return [[returnSnippets copy] autorelease];
}

@end
