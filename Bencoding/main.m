//
//  main.m
//  Bencoding
//
//  Created by Michael Michailidis on 27/02/2014.
//  Copyright (c) 2014 Michael Michailidis. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BencodingParser.h"

static NSString* torrentFilePath = @"/Users/michaelmichailidis/Projects/Bencoding/Bencoding/sample.torrent";

BOOL isNumeric(char c);

int main(int argc, const char * argv[])
{

    @autoreleasepool
    {
        
        NSData* data = [NSData dataWithContentsOfFile:torrentFilePath];
        
        if(!data)
        {
            NSLog(@"WARNING: File was not opened and loaded into the NSData object");
        }
        
        BencodingParser* parser = [BencodingParser parserWithData:data];
        
        if(!parser)
        {
            NSLog(@"WARNING: Bencoding Parser object not created");
        }
        
        
        NSLog(@"%@", parser.rootObject);
       
        
    }
    
    
    return 0;
}


               

