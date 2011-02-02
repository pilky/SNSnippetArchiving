//
//  M3TemporarySnippet.h
//  M3SnippetManager
//
//  Created by Martin Pilkington on 01/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SNSnippet : NSObject {
@private
    
}

@property (copy) NSString *name;
@property (copy) NSString *snippetDescription;
@property (copy) NSDictionary *links;
@property (copy) NSString *authorName;
@property (copy) NSString *authorEmail;
@property (retain) NSURL *authorURL;
@property (copy) NSString *licence;
@property (retain) NSURL *licenceURL;
@property (copy) NSArray *tags;
@property (copy) NSString *code;

- (id)initWithXML:(NSXMLElement *)aXMLElement;
- (NSXMLElement *)xmlRepresentation;
@end
