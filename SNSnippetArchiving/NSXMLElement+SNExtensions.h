//
//  NSXMLElement+SNExtensions.h
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 02/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSXMLElement (SNExtensions)

- (NSXMLElement *)sn_elementForName:(NSString *)aName;
- (NSXMLNode *)sn_nodeForXPath:(NSString *)xpath error:(NSError **)error;

@end
