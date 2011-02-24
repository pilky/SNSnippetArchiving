//
//  SNLanguageNormaliserTests.m
//  SNSnippetArchiving
//
//  Created by Martin Pilkington on 08/02/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "SNLanguageNormaliserTests.h"
#import <SNSnippetArchiving/SNSnippetArchiving.h>

@interface SNLanguageNormaliserTests () 

- (void)_performTestWithNames:(NSArray *)aNames normalisedName:(NSString *)aNormalisedName;

@end


@implementation SNLanguageNormaliserTests

- (void)testActionscriptNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Actionscript", @"actionscript", @"ActionScript", @"AS3", @"Actionscript 3", @"ActionScript 3", nil] normalisedName:SNActionscriptLanguage];
}

- (void)testApplescriptNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Applescript", @"AppleScript", @"applescript", nil] normalisedName:SNApplescriptLanguage];
}

- (void)testAssemblyNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"ASM", @"asm", @"Assembly", @"Assembly Language", nil] normalisedName:SNAssemblyLanguage];
}

- (void)testBashNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"bash", @"Bash", @"Bash Script", @"bash script", nil] normalisedName:SNBashLanguage];
}

- (void)testCNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"C", @"c", nil] normalisedName:SNCLanguage];
}

- (void)testCPlusPlusNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"C++", @"c++", @"cpp", @"CPP", @"C Plus Plus", @"Cplusplus", nil] normalisedName:SNCPlusPlusLanguage];
}

- (void)testCSSNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"CSS", @"css", @"Cascading Style Sheets", @"Cascading Stylesheets", @"cascading stylesheet", @"cascading style sheet", nil] normalisedName:SNCSSLanguage];
}

- (void)testCSharpNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"C#", @"c-sharp", @"c sharp", @"csharp", @"c#", nil] normalisedName:SNCSharpLanguage];
}

- (void)testClojureNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"clojure", @"Clojure", nil] normalisedName:SNClojureLanguage];
}

- (void)testColdFusionNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Coldfusion", @"ColdFusion", @"Cold Fusion", nil] normalisedName:SNColdFusionLanguage];
}

- (void)testErlangNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Erlang", @"erlang", nil] normalisedName:SNErlangLanguage];
}

- (void)testGoNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"go", @"Go", nil] normalisedName:SNGoLanguage];
}

- (void)testHaskellNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Haskell", @"haskell", nil] normalisedName:SNHaskellLanguage];
}

- (void)testHTMLNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"html", @"HTML", @"hypertext markup language", @"HyperText markup language", @"hyper-text markup language", nil] normalisedName:SNHTMLLanguage];
}

- (void)testJavascriptNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"JS", @"Javascript", @"java script", @"java-script", @"JavaScript", nil] normalisedName:SNJavascriptLanguage];
}

- (void)testJavaNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Java", @"java", nil] normalisedName:SNJavaLanguage];
}

- (void)testLispNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Lisp", @"lisp", @"Common Lisp", @"common lisp", @"common-lisp", @"commonlisp", nil] normalisedName:SNLispLanguage];
}

- (void)testMATLABNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"MATLAB", @"matlab", nil] normalisedName:SNMATLABLanguage];
}

- (void)testMySQLNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"MySQL", @"mysql", @"my sql", nil] normalisedName:SNMySQLLanguage];
}

- (void)testMSSQLNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"MSSQL", @"mssql", @"ms sql", @"ms-sql", @"Microsoft SQL", @"MicroSoft SQL Server", nil] normalisedName:SNMSSQLLanguage];
}

- (void)testObjectiveCNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Objective-C", @"objective-c", @"objective c", @"Obj-C", @"obj c", @"obj-c", nil] normalisedName:SNObjectiveCLanguage];
}
 
- (void)testObjectiveJNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Objective-J", @"objective-j", @"objective j", @"Obj-J", @"obj j", @"obj-j", nil] normalisedName:SNObjectiveJLanguage];
}
 
- (void)testPascalNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"pascal", @"Pascal", nil] normalisedName:SNPascalLanguage];
}

- (void)testPerlNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"perl", @"Perl", nil] normalisedName:SNPerlLanguage];
}

- (void)testPHPNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"PHP", @"php", nil] normalisedName:SNPHPLanguage];
}

- (void)testPostgreSQLNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"PostgreSQL", @"Postgre SQL", @"postgre-sql", @"Postgre", @"postgre", nil] normalisedName:SNPostgreSQLLanguage];
}

- (void)testPrologNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Prolog", @"ProLog", @"prolog", nil] normalisedName:SNPrologLanguage];
}

- (void)testPythonNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Python", @"python", nil] normalisedName:SNPythonLanguage];
}

- (void)testRubyNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Ruby", @"ruby", nil] normalisedName:SNRubyLanguage];
}

- (void)testScalaNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"scala", @"Scala", nil] normalisedName:SNScalaLanguage];
}

- (void)testSmalltalkNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"Smalltalk", @"small talk", @"SmallTalk", @"smalltalk", nil] normalisedName:SNSmalltalkLanguage];
}

- (void)testSQLNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"SQL", @"sql", @"structured query language", nil] normalisedName:SNSQLLanguage];
}

- (void)testVisualBasicNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"VB", @"Visual Basic", @"VisualBasic", @"visual basic", @"Visual BASIC", nil] normalisedName:SNVisualBasicLanguage];
}

- (void)testXMLNormalisation {
	[self _performTestWithNames:[NSArray arrayWithObjects:@"XML", @"xml", @"Extensible Markup Language", nil] normalisedName:SNXMLLanguage];
}



- (void)_performTestWithNames:(NSArray *)aNames normalisedName:(NSString *)aNormalisedName {
	for (NSString *name in aNames) {
		STAssertTrue([[SNLanguageNormaliser normaliseLanguageWithName:name] isEqualToString:aNormalisedName], @"Language string %@ does not normalise to %@", name, aNormalisedName);
	}
}

@end
