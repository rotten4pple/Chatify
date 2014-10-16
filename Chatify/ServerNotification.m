//
//  ServerNotification.m
//  Chatify
//
//  Created by Friedrich Ewald on 11/10/14.
//  Copyright (c) 2014 Friedrich Ewald. All rights reserved.
//

#import "ServerNotification.h"

@implementation ServerNotification

- (id) init {
    self = [super init];
    if (self != nil) {
        _socketIO = [[SocketIO alloc] initWithDelegate:self];
    }
    return self;
}

- (void) connect {
    // Connect to the WebSocket Host
    [_socketIO connectToHost:@"192.168.0.14" onPort:8080];
}

- (id) delegateChatify {
    return _delegateChatify;
}

- (void) setDelegateChatify:(id)newDelegateChatify {
    _delegateChatify = newDelegateChatify;
}

- (void) socketIODidConnect:(SocketIO *)socket {
    if ([_delegateChatify respondsToSelector:@selector(gotConnection)]) {
        [_delegateChatify gotConnection];
    }
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"Event received >>>>>>>>>>>>>>>>>>>>>");
    NSMutableArray *data = [NSJSONSerialization JSONObjectWithData:[packet.data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    if ([data count] >= 1) {
        NSString *event = [data objectAtIndex:0];
        if ([event isEqualToString:@"system_message"]) {
            // Handle the system messages
            NSDictionary *dict = [data objectAtIndex:1];
            
            NSString *type = [dict valueForKey:@"type"];
            NSString *message = [dict valueForKey:@"message"];
            
            if ([type isEqualToString:@"user_online_total"]) {
                if ([_delegateChatify respondsToSelector:@selector(receivedUserOnlineTotal:)]) {
                    [_delegateChatify receivedUserOnlineTotal: message];
                }
                //_UserOnlineLabel.text = [NSString stringWithFormat: @"%@ user online", message];
            } else if ([type isEqualToString:@"user_connected"]) {
                
            } else if ([type isEqualToString:@"user_created"]) {
                
            } else if ([type isEqualToString:@"user_found_partner"]) {
                
            } else if ([type isEqualToString:@"user_looking_partner"]) {
                
            } else if ([type isEqualToString:@"error"]) {
                
            } else if ([type isEqualToString:@"user_name_check"]) {
                NSLog(@"%@", type);
            } else {
                NSLog(@"Unknown Type in system message: %@", type);
            }
            NSLog(@"system_message");
        } else if ([event isEqualToString:@"user_info"]) {
            NSLog(@"user_info");
        } else if ([event isEqualToString:@"switch_partner"]) {
            NSLog(@"switch_partner");
        } else if ([event isEqualToString:@"chat_message"]) {
            NSLog(@"chat_message");
        }
    }
    NSLog(@"didReceiveEvent >>> data: %@", packet.data);
}

- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet
{
    NSLog(@"didReceiveMessage >>> data: %@", packet.data);
}

- (void) socketIO:(SocketIO *)socket onError:(NSError *)error {
    NSLog(@"receivedError ()");
    if ([_delegateChatify respondsToSelector:@selector(receivedError:)]) {
        [_delegateChatify receivedError:error];
    }
}
@end
