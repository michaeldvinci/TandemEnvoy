//
//  User.h
//  Aviato
//
//  Created by Michael Vinci on 3/14/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <foundation/Foundation.h>

@interface User : NSObject {
    NSString *_userID;
    NSString *_userLevel;
    NSString *_userName;
}

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userLevel;
@property (nonatomic, strong) NSString *userName;

+ (User *)sharedUser;

+(id)getInstance;

- (void)setID:(NSString *)userID;
- (NSString *)userID;

- (void)setLevel:(NSString *)userLevel;
- (NSString *)userLevel;

- (void)setName:(NSString *)userName;
- (NSString *)userName;

@end
