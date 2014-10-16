//
//  ServerNotification.h
//  Chatify
//
//  Created by Friedrich Ewald on 11/10/14.
//  Copyright (c) 2014 Friedrich Ewald. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketIO.h"


@protocol ChatifyDelegate <NSObject>
@optional
- (void) receivedUserOnlineTotal:(NSString*)message;
- (void) receivedError:(NSError*)error;
- (void) gotConnection;
@end

@interface ServerNotification : NSObject <SocketIODelegate>
{
    //__weak id<SocketIODelegate> _delegate;
    __strong id<ChatifyDelegate> _delegateChatify;
}

@property (strong) SocketIO *socketIO;
//@property (strong) id<ChatifyDelegate> delegateChatify;
- (void) connect;
- (id<ChatifyDelegate>) delegateChatify;
- (void) setDelegateChatify:(id<ChatifyDelegate>)newDelegateChatify;

@end


