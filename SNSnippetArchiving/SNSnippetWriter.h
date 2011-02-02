//
//  SNSnippetArchiving.h
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 02/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SNSnippetWriter : NSObject {
@private
    
}

+ (BOOL)writeSnippets:(NSArray *)aSnippets toFileAtPath:(NSString *)aPath error:(NSError **)aError;
+ (BOOL)writeSnippets:(NSArray *)aSnippets toFileAtURL:(NSURL *)aURL error:(NSError **)aError;

@end
