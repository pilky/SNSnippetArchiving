//
//  SNSnippetReader.m
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 02/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "SNSnippetReader.h"
#import "SNSnippet.h"

@implementation SNSnippetReader

+ (NSArray *)snippetsFromFileAtPath:(NSString *)aPath error:(NSError **)aError {
	return [self snippetsFromFileAtURL:[NSURL fileURLWithPath:aPath] error:&*aError];
}

+ (NSArray *)snippetsFromFileAtURL:(NSURL *)aURL error:(NSError **)aError {
	NSXMLDocument *doc = [[NSXMLDocument alloc] initWithContentsOfURL:aURL options:0 error:&*aError];
	if (doc) {
		[self snippetsFromXMLDocument:doc error:&*aError];
	}
	
	return nil;
}

+ (NSArray *)snippetsFromXMLDocument:(NSXMLDocument *)aDocument error:(NSError **)aError {
	NSArray *elements = [aDocument nodesForXPath:@"snippets/snippet" error:&*aError];
	if (elements) {
		NSMutableArray *snippets = [NSMutableArray array];
		for (NSXMLElement *element in elements) {
			SNSnippet *snippet = [[SNSnippet alloc] initWithXML:element];
			[snippets addObject:snippet];
			[snippet release];
		}
		return [[snippets copy] autorelease];
	}
	return nil;
}

@end
