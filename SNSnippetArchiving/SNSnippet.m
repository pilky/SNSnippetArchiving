//
//  M3TemporarySnippet.m
//  M3SnippetManager
//
//  Created by Martin Pilkington on 01/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "SNSnippet.h"
#import "NSXMLElement+SNExtensions.h"

@implementation SNSnippet

@synthesize name, snippetDescription, links, authorName, authorEmail, authorURL, licence, licenceURL, tags, code;

- (id)initWithXML:(NSXMLElement *)aXMLElement {
	if ((self = [super init])) {
		name = [[[aXMLElement sn_elementForName:@"name"] stringValue] copy];
		snippetDescription = [[[aXMLElement sn_elementForName:@"description"] stringValue] copy];
		code = [[[aXMLElement sn_elementForName:@"code"] stringValue] copy];
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
	[licenceURL release];
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
