//
//  BencodingParser.m
//  Bencoding
//
//  Created by Michael Michailidis on 28/02/2014.
//  Copyright (c) 2014 Michael Michailidis. All rights reserved.
//

#import "BencodingParser.h"
#import <ctype.h>

@interface BencodingParser ()
{
    size_t _currentIndex;
    char _currentChar;
    
    size_t _length;
    const char* _bytes;
    
    NSData* _data;
    
    id _rootObject;
    
    NSString* _currentKey;
}

@property (nonatomic) size_t currentIndex;


@end

@implementation BencodingParser

@synthesize data = _data;
@synthesize rootObject = _rootObject;

+ (id) parserWithData:(NSData*)data
{
    return [[self alloc] initWithData:data];
}

- (id) initWithData:(NSData*)data
{
    if(self = [super init])
    {
        _data = data;
        
        _bytes = (char*)_data.bytes;
        _length = _data.length;
        
        
        self.currentIndex = 0; // get the first char (usually 'd')
        
        _rootObject = [self parseObject];
        
    }
    return self;
}


-(id)parseObject
{
    
    id object = nil;
    
    switch (_currentChar)
    {
            
        case '0': // is numeric (string)
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
            object = [self parseDataString];
            break;
            
        case 'd': // is dictionary
            object = [self parseDictionary];
            break;
            
        case 'l':
            object = [self parseList];
            break;
            
        case 'i':
            object = [self parseInteger];
            break;
            
            
    }
    
    return object;
}


#pragma mark - Parse Objects

-(int)parseNumericValue
{
    
    assert(isdigit(_currentChar));
    
    int number = 0;
    
    while (isdigit(_currentChar))
    {
        number *= 10;
        number += (_currentChar - '0');
        
        self.currentIndex++;
    }
    
    
    return number;

}


-(id)parseDataString
{
    
    int string_length = [self parseNumericValue];
    
    
    unsigned char* stringPtr = malloc(string_length); // +1 for nil temrination
    
    
    
    for (int i = 0; i < string_length; i++)
    {
        self.currentIndex++; // eat up ':' and go to the first
        stringPtr[i] = _currentChar;
        
    }
    
    id object = nil;
    
    NSData* data = [[NSData alloc] initWithBytes:stringPtr length:string_length];
    
    
    NSString* string = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
    
    if(string)
        object = string;
    else
        object = data;
    
    free(stringPtr);
    
    self.currentIndex++;
    
    //NSLog(@"S: \"%@\" - _currentChar = %d", string, (_currentChar - '0'));
    
    return object;
}



-(NSDictionary*)parseDictionary
{
    assert(_currentChar == 'd');
    
    
    
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
    
    
    self.currentIndex++; // eat up 'd' and get to begin parsing
    
    while (_currentChar != 'e')
    {
        
        
        _currentKey = [self parseDataString];
        
        NSString* value = [self parseObject];
        
        [dictionary setObject:value forKey:_currentKey];
        
        
    }
    
    self.currentIndex++; // eat up 'e'
    
    return dictionary;
    
}

-(NSNumber*)parseInteger
{
    
    assert(_currentChar == 'i');
    
    self.currentIndex++; // eat up 'i'
    
    NSNumber* parsedNumber = [NSNumber numberWithInt:[self parseNumericValue]];
    
    self.currentIndex++; // eat up 'e'
    
    return parsedNumber;
}

-(NSArray*)parseList
{
    assert(_currentChar == 'l');
    
    self.currentIndex++; // eat up 'l'
    
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    while (_currentChar != 'e')
    {
        
        NSString* value = [self parseObject];
        
        [array addObject:value];
        
        
    }
    
    self.currentIndex++;
    
    return array;
}

#pragma mark - 

-(void)setCurrentIndex:(size_t)currentIndex
{
    _currentIndex = currentIndex;
    _currentChar = _bytes[_currentIndex];
}



@end
