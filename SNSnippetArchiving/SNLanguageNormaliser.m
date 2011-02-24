//
//  SNLanguageNormaliser.m
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 08/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "SNLanguageNormaliser.h"
#import "SNConstants.h"

static NSMutableDictionary *languageMap;

@interface SNLanguageNormaliser () 

+ (void)_mapLanguageNames:(NSArray *)names toNormalisedName:(NSString *)aName;
+ (NSString *)_cleanUpName:(NSString *)aName;

@end

@implementation SNLanguageNormaliser

+ (void)initialize {
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"actionscript", @"as3", @"actionscript3", nil] toNormalisedName:SNActionscriptLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"applescript", nil] toNormalisedName:SNApplescriptLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"asm", @"assembly", @"assemblylanguage", nil] toNormalisedName:SNAssemblyLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"bash", @"bashscript", nil] toNormalisedName:SNBashLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"c", nil] toNormalisedName:SNCLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"c++", @"cpp", @"cplusplus", nil] toNormalisedName:SNCPlusPlusLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"css", @"cascadingstylesheet", @"cascadingstylesheets", nil] toNormalisedName:SNCSSLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"csharp", @"c#", nil] toNormalisedName:SNCSharpLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"clojure", nil] toNormalisedName:SNClojureLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"coldfusion", nil] toNormalisedName:SNColdFusionLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"erlang", nil] toNormalisedName:SNErlangLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"go", nil] toNormalisedName:SNGoLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"haskell", nil] toNormalisedName:SNHaskellLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"html", @"hypertextmarkuplanguage", nil] toNormalisedName:SNHTMLLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"javascript", @"js", nil] toNormalisedName:SNJavascriptLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"java", nil] toNormalisedName:SNJavaLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"lisp", @"commonlisp", nil] toNormalisedName:SNLispLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"matlab", nil] toNormalisedName:SNMATLABLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"mysql", nil] toNormalisedName:SNMySQLLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"mssql", @"microsoftsql", @"microsoftsqlserver", nil] toNormalisedName:SNMSSQLLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"objectivec", @"objc", nil] toNormalisedName:SNObjectiveCLanguage]; 
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"objectivej", @"objj", nil] toNormalisedName:SNObjectiveJLanguage]; 
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"pascal", nil] toNormalisedName:SNPascalLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"perl", nil] toNormalisedName:SNPerlLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"php", nil] toNormalisedName:SNPHPLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"postgresql", @"postgre", nil] toNormalisedName:SNPostgreSQLLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"prolog", nil] toNormalisedName:SNPrologLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"python", nil] toNormalisedName:SNPythonLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"ruby", nil] toNormalisedName:SNRubyLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"scala", nil] toNormalisedName:SNScalaLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"smalltalk", nil] toNormalisedName:SNSmalltalkLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"sql", @"structuredquerylanguage", nil] toNormalisedName:SNSQLLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"visualbasic", @"vb", nil] toNormalisedName:SNVisualBasicLanguage];
	[self _mapLanguageNames:[NSArray arrayWithObjects:@"xml", @"extensiblemarkuplanguage", nil] toNormalisedName:SNXMLLanguage];
}

+ (void)_mapLanguageNames:(NSArray *)aNames toNormalisedName:(NSString *)aNormalisedName {
	if (!languageMap) {
		languageMap = [[NSMutableDictionary alloc] init];
	}
	for (NSString *name in aNames) {
		[languageMap setObject:aNormalisedName forKey:name];
	}
}

+ (NSString *)normaliseLanguageWithName:(NSString *)aName {
	NSString *normalisedLang = [languageMap objectForKey:[self _cleanUpName:aName]];
	if (!normalisedLang)
		return SNUnknownLanguage;
	return normalisedLang;
}

+ (NSString *)_cleanUpName:(NSString *)aName {
	NSMutableString *nameToClean = [[aName lowercaseString] mutableCopy];
	[nameToClean replaceOccurrencesOfString:@"-" withString:@"" options:0 range:NSMakeRange(0, [nameToClean length])];
	[nameToClean replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [nameToClean length])];
	return [[nameToClean copy] autorelease];
}

@end
