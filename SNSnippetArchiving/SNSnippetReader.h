//
//  SNSnippetReader.h
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 02/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SNSnippetReader : NSObject {
@private
    
}

+ (NSArray *)snippetsFromFileAtPath:(NSString *)aPath error:(NSError **)aError;
+ (NSArray *)snippetsFromFileAtURL:(NSURL *)aURL error:(NSError **)aError;
+ (NSArray *)snippetsFromXMLDocument:(NSXMLDocument *)aDocument error:(NSError **)aError;

@end
