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
		[authorLink release];
		
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
	NSXMLElement *snippetElement = [NSXMLNode elementWithName:@"snippet"];
	
	if ([self name]) {
		[snippetElement addChild:[NSXMLElement sn_elementWithName:@"name" cdataContent:[self name]]];
	}
	
	if ([self snippetDescription]) {
		[snippetElement addChild:[NSXMLElement sn_elementWithName:@"description" cdataContent:[self snippetDescription]]];
	}
	
	if ([self code]) {
		[snippetElement addChild:[NSXMLElement sn_elementWithName:@"code" cdataContent:[self code]]];
	}
	
	if ([[self highlightKey] length] || [[self highlightName] length]) {
		NSXMLElement *highlightElement = [NSXMLNode elementWithName:@"highlight"];
		if ([[self highlightKey] length]) {
			[highlightElement addAttribute:[NSXMLNode attributeWithName:@"key" stringValue:[self highlightKey]]];
		}
		if ([[self highlightName] length]) {
			NSXMLNode *textNode = [[NSXMLNode alloc] initWithKind:NSXMLTextKind options:NSXMLNodeIsCDATA];
			[textNode setStringValue:[self highlightName]];
			[highlightElement addChild:textNode];
			[textNode release];
		}
		[snippetElement addChild:highlightElement];
	}
	
	if ([self licence]) {
		NSXMLElement *licenceElement = [NSXMLNode elementWithName:@"license" stringValue:[[self licence] name]];
		if ([[self licence] url]) {
			[licenceElement addAttribute:[NSXMLNode attributeWithName:@"link" stringValue:[[[self licence] url] absoluteString]]];
		}
		[snippetElement addChild:licenceElement];
	}
	
	if ([[self tags] count]) {
		NSXMLElement *tagsElement = [NSXMLNode elementWithName:@"tags"];
		for (NSString *tag in [self tags]) {
			[tagsElement addChild:[NSXMLElement sn_elementWithName:@"tag" cdataContent:tag]];
		}
		[snippetElement addChild:tagsElement];
	}
	
	if ([self authorURL] || [self authorName] || [self authorEmail]) {
		NSXMLElement *authorElement = [NSXMLNode elementWithName:@"author"];
		if ([self authorName]) {
			[authorElement addChild:[NSXMLElement sn_elementWithName:@"name" cdataContent:[self authorName]]];
		}
		
		if ([self authorEmail]) {
			[authorElement addChild:[NSXMLElement elementWithName:@"email" stringValue:[self authorEmail]]];
		}
		
		if ([self authorURL]) {
			[authorElement addChild:[NSXMLElement elementWithName:@"link" stringValue:[[self authorURL] absoluteString]]];
		}
		
		[snippetElement addChild:authorElement];
	}
	
	if ([[self links] count]) {
		NSXMLElement *linksElement = [NSXMLNode elementWithName:@"links"];
		for (SNNamedLink *link in [self links]) {
			NSXMLElement *linkElement = [NSXMLNode elementWithName:@"link"];
			[linkElement addChild:[NSXMLElement sn_elementWithName:@"name" cdataContent:[link name]]];
			[linkElement addChild:[NSXMLNode elementWithName:@"url" stringValue:[[link url] absoluteString]]];
			[linksElement addChild:linkElement];
		}
		[snippetElement addChild:linksElement];
	}
	
	
	return snippetElement;
}


- (NSString *)description {
	return [NSString stringWithFormat:@"<%@:%p> '%@'", [self className], self, [self name]];
}

@end
