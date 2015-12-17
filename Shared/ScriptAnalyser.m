/*
 Copyright (c) 2003-2015, Sveinbjorn Thordarson <sveinbjornt@gmail.com>
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or other
 materials provided with the distribution.
 
 3. Neither the name of the copyright holder nor the names of its contributors may
 be used to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 */

//  This is a class with convenience and analysis methods for the
//  script file types handled by Platypus.

#import "ScriptAnalyser.h"
//#import "NSTask+Description.h"

@implementation ScriptAnalyser

+ (NSArray OF_NSDICTIONARY *)interpreters {
    return @[
             @{ @"Name":        @"Shell",
                @"Path":        @"/bin/sh",
                @"Hello":       @"echo 'Hello, World'",
                @"Suffixes":    @[@".sh", @".command"] },
             
             @{ @"Name":        @"Bash",
                @"Path":        @"/bin/bash",
                @"Hello":       @"echo 'Hello, World'",
                @"Suffixes":    @[@".bash"] },

             @{ @"Name":        @"Csh",
                @"Path":        @"/bin/csh",
                @"Hello":       @"echo 'Hello, World'",
                @"Suffixes":    @[@".csh"] },

             @{ @"Name":        @"Tcsh",
                @"Path":        @"/bin/tcsh",
                @"Hello":       @"echo 'Hello, World'",
                @"Suffixes":    @[@".tcsh"] },

             @{ @"Name":        @"Ksh",
                @"Path":        @"/bin/ksh",
                @"Hello":       @"echo 'Hello, World'",
                @"Suffixes":    @[@".ksh"] },

             @{ @"Name":        @"Zsh",
                @"Path":        @"/bin/zsh",
                @"Hello":       @"echo 'Hello, World'",
                @"Suffixes":    @[@".zsh"] },

             @{ @"Name":        @"Env",
                @"Path":        @"/usr/bin/env",
                @"Hello":       @"",
                @"Suffixes":    @[] },

             @{ @"Name":        @"Perl",
                @"Path":        @"/usr/bin/perl",
                @"Hello":       @"print \"Hello, World\\n\";",
                @"Suffixes":    @[@".pl", @".pm"] },
             
             @{ @"Name":        @"Python",
                @"Path":        @"/usr/bin/python",
                @"Hello":       @"print \"Hello, World\"",
                @"Suffixes":    @[@".py", @".python", @".objpy"] },
             
             @{ @"Name":        @"Ruby",
                @"Path":        @"/usr/bin/ruby",
                @"Hello":       @"puts \"Hello, World\";",
                @"Suffixes":    @[@".rb", @".rbx", @".ruby", @".rbw"] },
             
             @{ @"Name":        @"AppleScript",
                @"Path":        @"/usr/bin/osascript",
                @"Hello":       @"display dialog \"Hello, World\" buttons {\"OK\"}",
                @"Suffixes":    @[@".scpt", @".applescript", @".osascript"] },
             
             @{ @"Name":        @"Tcl",
                @"Path":        @"/usr/bin/tclsh",
                @"Hello":       @"puts \"Hello, World\";",
                @"Suffixes":    @[@".tcl"] },
             
             @{ @"Name":        @"Expect",
                @"Path":        @"/usr/bin/expect",
                @"Hello":       @"send \"Hello, world\\n\"",
                @"Suffixes":    @[@".exp", @".expect"] },
             
             @{ @"Name":        @"PHP",
                @"Path":        @"/usr/bin/php",
                @"Hello":       @"<?php\necho \"Hello, World\";\n?>",
                @"Suffixes":    @[@".php", @".php3", @".php4", @".php5", @".php6", @".phtml"] },
             
             @{ @"Name":        @"Swift",
                @"Path":        @"/usr/bin/swift",
                @"Hello":       @"print(\"Hello, World\")",
                @"Suffixes":    @[@".swift"] },
             
             @{ @"Name":        @"Other...",
                @"Path":        @"",
                @"Hello":       @"",
                @"Suffixes":    @[] }
    ];
}

#pragma mark -

+ (NSArray OF_NSSTRING *)arrayOfInterpreterValuesForKey:(NSString *)key {
    NSArray *interpreters = [ScriptAnalyser interpreters];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in interpreters) {
        [arr addObject:dict[key]];
    }
    return [arr copy];
}

+ (NSArray OF_NSSTRING *)interpreterDisplayNames {
    return [ScriptAnalyser arrayOfInterpreterValuesForKey:@"Name"];
}

+ (NSArray OF_NSSTRING *)interpreterPaths {
    return [ScriptAnalyser arrayOfInterpreterValuesForKey:@"Path"];
}

#pragma mark - Mapping

+ (NSString *)interpreterPathForDisplayName:(NSString *)displayName {
    NSArray OF_NSDICTIONARY *interpreters = [ScriptAnalyser interpreters];
    for (NSDictionary *infoDict in interpreters) {
        if ([infoDict[@"Name"] isEqualToString:displayName]) {
            return infoDict[@"Path"];
        }
    }
    return @"";
}

+ (NSString *)displayNameForInterpreterPath:(NSString *)interpreterPath {
    NSArray OF_NSDICTIONARY *interpreters = [ScriptAnalyser interpreters];
    for (NSDictionary *infoDict in interpreters) {
        if ([infoDict[@"Path"] isEqualToString:interpreterPath]) {
            return infoDict[@"Name"];
        }
    }
    return @"";
}

+ (NSString *)helloWorldProgramForDisplayName:(NSString *)displayName {
    NSArray OF_NSDICTIONARY *interpreters = [ScriptAnalyser interpreters];
    for (NSDictionary *infoDict in interpreters) {
        if ([infoDict[@"Name"] isEqualToString:displayName]) {
            return infoDict[@"Hello"];
        }
    }
    return @"";
}

#pragma mark - File suffixes

+ (NSString *)interpreterPathForFilenameSuffix:(NSString *)fileName {
    NSArray OF_NSDICTIONARY *interpreters = [ScriptAnalyser interpreters];
    for (NSDictionary *infoDict in interpreters) {
        NSArray *suffixes = infoDict[@"Suffixes"];
        for (NSString *suffix in suffixes) {
            if ([fileName hasSuffix:suffix]) {
                return infoDict[@"Path"];
            }
        }
    }
    return nil;
}

+ (NSString *)filenameSuffixForInterpreterPath:(NSString *)interpreterPath {
    NSArray OF_NSDICTIONARY *interpreters = [ScriptAnalyser interpreters];
    for (NSDictionary *infoDict in interpreters) {
        if ([infoDict[@"Path"] isEqualToString:interpreterPath]) {
            return infoDict[@"Suffixes"];
        }
    }
    return nil;
}

#pragma mark - Script file convenience methods

+ (NSArray OF_NSSTRING *)parseInterpreterInScriptFile:(NSString *)path {
    
    // get the first line of the script
    NSString *script = [NSString stringWithContentsOfFile:path encoding:DEFAULT_TEXT_ENCODING error:nil];
    NSArray *lines = [script componentsSeparatedByString:@"\n"];
    if ([lines count] == 0) {
        // empty file
        return @[@""];
    }
    NSString *firstLine = lines[0];

    // if shorter than 2 chars, it can't possibly be a shebang line
    if ([firstLine length] <= 2 || ([[firstLine substringToIndex:2] isEqualToString:@"#!"] == NO)) {
        return @[@""];
    }
    
    NSString *interpreterCmd = [firstLine substringFromIndex:2];
    
    // get everything that follows after the #!
    // seperate it by whitespaces, in order not to get also the params to the interpreter
    NSMutableArray *interpreterAndArgs = [[interpreterCmd componentsSeparatedByString:@" "] mutableCopy];
    
    // if shebang interpreter is not an absolute path or doestn't exist, we
    // check if the binary name is the same as one of our preset interpreters
    NSString *parsedPath = interpreterAndArgs[0];
    if ([parsedPath hasPrefix:@"/"] == NO || [FILEMGR fileExistsAtPath:parsedPath] == NO) {
        NSArray *paths = [ScriptAnalyser interpreterPaths];
        for (NSString *p in paths) {
            if ([[p lastPathComponent] isEqualToString:[parsedPath lastPathComponent]]) {
                interpreterAndArgs[0] = p;
            }
        }
    }
    
    // remove all empty strings in array
    for (int i = [interpreterAndArgs count]-1; i > 0; i--) {
        NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimmedStr = [interpreterAndArgs[i] stringByTrimmingCharactersInSet:set];
        
        if ([trimmedStr isEqualToString:@""]) {
            [interpreterAndArgs removeObjectAtIndex:i];
        } else {
            interpreterAndArgs[i] = trimmedStr;
        }
    }
    return interpreterAndArgs; // return array w. interpreter path + arguments
}

+ (NSString *)appNameFromScriptFile:(NSString *)path {
    NSString *name = [[path lastPathComponent] stringByDeletingPathExtension];
    
    // replace these common filename word separators w. spaces
    name = [name stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    name = [name stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    // iterate over each word, capitalize and append to app name
    NSArray *words = [name componentsSeparatedByString:@" "];
    NSMutableString *appName = [[NSMutableString alloc] initWithString:@""];
    
    for (NSString *word in words) {
        NSString *capitalizedWord = [word capitalizedString];
        if ([word isEqualTo:words[0]] == FALSE) {
            [appName appendString:@" "];
        }
        [appName appendString:capitalizedWord];
    }
    
    return [NSString stringWithString:appName];
}

+ (NSString *)determineInterpreterPathForScriptFile:(NSString *)filePath {
    NSString *interpreterPath = [ScriptAnalyser parseInterpreterInScriptFile:filePath][0];
    if (interpreterPath != nil && [interpreterPath isEqualToString:@""] == NO) {
        return interpreterPath;
    }
    return [ScriptAnalyser interpreterPathForFilenameSuffix:filePath];
}

#pragma mark - Syntax checking

+ (NSString *)checkSyntaxOfFile:(NSString *)scriptPath usingInterpreterAtPath:(NSString *)suggestedInterpreter {
    if ([FILEMGR fileExistsAtPath:scriptPath] == NO) {
        return [NSString stringWithFormat:@"File does not exist"];
    }
    
    NSString *interpreterPath = suggestedInterpreter;
    
    if (interpreterPath == nil || [interpreterPath isEqualToString:@""]) {
        interpreterPath = [ScriptAnalyser determineInterpreterPathForScriptFile:scriptPath];
        
        if (interpreterPath == nil || [interpreterPath isEqualToString:@""]) {
            return @"Unable to determine script interpreter";
        }
    }
    
    //let's see if the script type is supported for syntax checking
    //if so, we set up the task's launch path as the script interpreter and set the relevant flags and arguments
    NSArray *args;
    if ([interpreterPath isEqualToString:@"/bin/sh"]) {
        args = @[@"-n", scriptPath];
    } else if ([interpreterPath isEqualToString:@"/bin/bash"]) {
        args = @[@"-n", scriptPath];
    } else if ([interpreterPath isEqualToString:@"/bin/zsh"]) {
        args = @[@"-n", scriptPath];
    } else if ([interpreterPath isEqualToString:@"/usr/bin/perl"]) {
        args = @[@"-c", scriptPath];
    } else if ([interpreterPath isEqualToString:@"/usr/bin/ruby"]) {
        args = @[@"-c", scriptPath];
    } else if ([interpreterPath isEqualToString:@"/usr/bin/php"]) {
        args = @[@"-l", scriptPath];
    } else if ([interpreterPath isEqualToString:@"/usr/bin/python"]) {
        args = @[@"-m", @"py_compile", scriptPath];
    } else {
        return [NSString stringWithFormat:@"Syntax Checking is not supported for interpreter %@", interpreterPath];
    }

    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:interpreterPath];
    [task setArguments:args];
    NSPipe *outputPipe = [NSPipe pipe];
    [task setStandardOutput:outputPipe];
    [task setStandardError:outputPipe];
    NSFileHandle *readHandle = [outputPipe fileHandleForReading];
    
    //launch task
    [task launch];
    [task waitUntilExit];
    
    //get output in string
    NSString *outputStr = [[NSString alloc] initWithData:[readHandle readDataToEndOfFile] encoding:DEFAULT_TEXT_ENCODING];

    //if the syntax report string is empty --> no complaints, so we report syntax as OK
    outputStr = [outputStr length] ? outputStr : @"Syntax OK";
    outputStr = [NSString stringWithFormat:@"%@", /*[task humanDescription],*/ outputStr];

    return outputStr;
}

@end
