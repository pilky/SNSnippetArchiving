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

@synthesize name, snippetDescription, links, authorName, authorEmail, authorURL, licence, tags, code;

- (id)initWithXML:(NSXMLElement *)aXMLElement {
	if ((self = [super init])) {
		name = [[[aXMLElement sn_elementForName:@"name"] stringValue] copy];
		snippetDescription = [[[aXMLElement sn_elementForName:@"description"] stringValue] copy];
		code = [[[aXMLElement sn_elementForName:@"code"] stringValue] copy];
		
		NSXMLElement *licenceElement = [aXMLElement sn_elementForName:@"license"];
		NSURL *licenceURL = nil;
		if ([licenceElement attributeForLocalName:@"link" URI:nil]) {
			licenceURL = [NSURL URLWithString:[[licenceElement attributeForLocalName:@"link" URI:nil] stringValue]];
		}
		licence = [[SNNamedLink alloc] initWithName:[licenceElement stringValue] 
											 andURL:licenceURL];
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
