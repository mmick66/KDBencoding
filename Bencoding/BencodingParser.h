//
//  BencodingParser.h
//  Bencoding
//
//  Created by Michael Michailidis on 28/02/2014.
//  Copyright (c) 2014 Michael Michailidis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BencodingParser : NSObject

+ (id) parserWithData:(NSData*)data;

- (id) initWithData:(NSData*)data;

@property (nonatomic, readonly) NSData* data;
@property (nonatomic, readonly) id rootObject;

// object getters

@property (nonatomic, readonly) NSString* announce;

@property (nonatomic, readonly) NSArray* announceList;

@property (nonatomic, readonly) NSString* comment;
@property (nonatomic, readonly) NSDate* creationDate;
@property (nonatomic, readonly) NSString* createdBy;

@property (nonatomic, readonly) BOOL isPrivate;

@end
