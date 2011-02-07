//
//  M3TemporarySnippet.m
//  M3SnippetManager
//
//  Created by Martin Pilkington on 01/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "SNSnippet.h"
#import "NSXMLElement+SNExtensions.h"
#import "SNNamedLink.h"

@implementation SNSnippet

@synthesize name, snippetDescription, links, authorName, authorEmail, authorURL, licence, tags, code, highlightKey, highlightName;

+ (NSString *)normaliseLanguageWithName:(NSString *)aName {
	return aName;
}


- (id)initWithXML:(NSXMLElement *)aXMLElement {
	if ((self = [super init])) {
		name = [[[aXMLElement sn_elementForName:@"name"] stringValue] copy];
		snippetDescription = [[[aXMLElement sn_elementForName:@"description"] stringValue] copy];
		code = [[[aXMLElement sn_elementForName:@"code"] stringValue] copy];
		authorName = [[[aXMLElement sn_nodeForXPath:@"author/name" error:NULL] stringValue] copy];
		authorEmail = [[[aXMLElement sn_nodeForXPath:@"author/email" error:NULL] stringValue] copy];
		
		NSString *authorLink = [[[aXMLElement sn_nodeForXPath:@"author/link" error:NULL] stringValue] copy];
		if (authorLink) {
			authorURL = [[NSURL URLWithString:authorLink] retain];
		}
		
		NSXMLElement *licenceElement = [aXMLElement sn_elementForName:@"license"];
		NSURL *licenceURL = nil;
		if ([licenceElement attributeForLocalName:@"link" URI:nil]) {
			licenceURL = [NSURL URLWithString:[[licenceElement attributeForLocalName:@"link" URI:nil] stringValue]];
		}
		licence = [[SNNamedLink alloc] initWithName:[licenceElement stringValue] 
											 andURL:licenceURL];
		
		
		NSArray *tagElements = [aXMLElement nodesForXPath:@"tags/tag" error:NULL];
		if ([tagElements count]) {
			tags = [[tagElements valueForKey:@"stringValue"] copy];
		}
		
		
		NSMutableArray *linksArray = [NSMutableArray array];;
		for (NSXMLElement *element in [aXMLElement nodesForXPath:@"links/link" error:NULL]) {
			NSString *nameString = [[element sn_elementForName:@"name"] stringValue];
			NSString *urlString = [[element sn_elementForName:@"url"] stringValue];
			if ([urlString length]) {
				SNNamedLink *link = [[SNNamedLink alloc] initWithName:nameString andURL:[NSURL URLWithString:urlString]];
				[linksArray addObject:link];
				[link release];
			}
		}
		if ([linksArray count]) {
			links = [linksArray copy];
		}
		
		NSXMLElement *highlightElement = [aXMLElement sn_elementForName:@"highlight"];
		highlightName = [[highlightElement stringValue] copy];
		highlightKey = [[[highlightElement attributeForLocalName:@"key" URI:nil] stringValue] copy];
	}
	return self;
}

- (void)dealloc {
	[name release];
	[snippetDescription release];
	[links release];
	[authorName release];
	[authorEmail release];
	[authorURL release];
	[licence release];
	[tags release];
	[code release];
	[super dealloc];
}


- (NSXMLElement *)xmlRepresentation {
	return nil;
}


- (NSString *)description {
	return [NSString stringWithFormat:@"<%@:%p> '%@'", [self className], self, [self name]];
}

@end
