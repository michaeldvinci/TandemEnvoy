//
//  User.m
//  Aviato
//
//  Created by Michael Vinci on 3/14/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize userID = _userID;
@synthesize userLevel = _userLevel;
@synthesize userName = _userName;

static User *getInstance = nil;

+ (User *)getInstance {
    if(getInstance == nil){
        getInstance = [[User alloc] init];
    }
    
    return getInstance;
}

-(id)init {
    if(self = [super init]) {
        _userID = @"";
        _userLevel = @"";
    }
    
    return self;
}

- (void)setLevel:(NSString *)level {
    _userLevel = level;
}

- (NSString *)level {
    return _userLevel;
}

- (void)setID:(NSString *)ID {
    _userID = ID;
}

- (NSString *)ID {
    return _userID;
}

- (void)setName:(NSString *)name {
    _userName = name;
}

- (NSString *)name {
    return _userName;
}

@end