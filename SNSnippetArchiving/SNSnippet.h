//
//  M3TemporarySnippet.h
//  M3SnippetManager
//
//  Created by Martin Pilkington on 01/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SNNamedLink;
@interface SNSnippet : NSObject {
@private
    NSString *name;
	NSString *snippetDescription;
	NSString *highlightKey;
	NSString *highlightName;
	NSArray *links;
	NSString *authorName;
	NSString *authorEmail;
	NSURL *authorURL;
	SNNamedLink *licence;
	NSArray *tags;
	NSString *code;
}

@property (copy) NSString *name;
@property (copy) NSString *snippetDescription;
@property (copy) NSString *highlightKey;
@property (copy) NSString *highlightName;
@property (copy) NSArray *links;
@property (copy) NSString *authorName;
@property (copy) NSString *authorEmail;
@property (retain) NSURL *authorURL;
@property (retain) SNNamedLink *licence;
@property (copy) NSArray *tags;
@property (copy) NSString *code;

- (id)initWithXML:(NSXMLElement *)aXMLElement;
- (NSXMLElement *)xmlRepresentation;
@end
