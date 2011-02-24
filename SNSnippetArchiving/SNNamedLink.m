//
//  SNLink.m
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 02/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "SNNamedLink.h"


@implementation SNNamedLink

@synthesize name, url;

+ (SNNamedLink *)namedLinkWithName:(NSString *)aName andURL:(NSURL *)aURL {
	return [[[self alloc] initWithName:aName andURL:aURL] autorelease];
}

- (id)initWithName:(NSString *)aName andURL:(NSURL *)aURL {
    if ((self = [super init])) {
        name = [aName copy];
		url = [aURL retain];
    }
    
    return self;
}

- (void)dealloc {
	[name release];
	[url release];
    
    [super dealloc];
}

- (BOOL)isEqual:(id)object {
	return ([object isKindOfClass:[SNNamedLink class]] && [name isEqualToString:[object name]] && (!url && ![object url] || [url isEqual:[object url]]));
}

- (NSUInteger)hash {
	return [name hash] + [url hash];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<%@: %p> %@ = %@", [self className], self, name, url];
}

@end
