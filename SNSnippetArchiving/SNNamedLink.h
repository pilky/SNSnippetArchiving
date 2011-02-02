//
//  SNLink.h
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 02/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SNNamedLink : NSObject {
@private
    NSString *name;
	NSURL *url;
}

- (id)initWithName:(NSString *)aName andURL:(NSURL *)aURL;
@property (copy) NSString *name;
@property (retain) NSURL *url;

@end
