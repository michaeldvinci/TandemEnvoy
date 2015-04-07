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
    NSString *_userName;
}

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;

+ (User *)getInstance;

- (void)setID:(NSString *)userID;
- (NSString *)userID;

- (void)setName:(NSString *)userName;
- (NSString *)userName;

@end
