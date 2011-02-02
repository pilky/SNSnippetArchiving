//
//  SNSnippetArchiving.m
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 02/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "SNSnippetWriter.h"


@implementation SNSnippetWriter

+ (BOOL)writeSnippets:(NSArray *)aSnippets toFileAtPath:(NSString *)aPath error:(NSError **)aError {
	return [self writeSnippets:aSnippets toFileAtURL:[NSURL fileURLWithPath:aPath] error:&*aError];
}


+ (BOOL)writeSnippets:(NSArray *)aSnippets toFileAtURL:(NSURL *)aURL error:(NSError **)aError {
	return NO;
}

@end
