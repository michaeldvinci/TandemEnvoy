//
//  User.h
//  Aviato
//
//  Created by Michael Vinci on 3/14/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <foundation/Foundation.h>

@interface User : NSObject {
    NSString *_userName;
    NSString *_userID;
}

@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong) NSString *userID;

+(id)getInstance;

- (void)setName:(NSString *)userName;
- (NSString *)userName;

- (void)setID:(NSString *)userID;
- (NSString *)userID;

@end
