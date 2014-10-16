//
//  ViewController.m
//  Chatify
//
//  Created by Friedrich Ewald on 02/10/14.
//  Copyright (c) 2014 Friedrich Ewald. All rights reserved.
//

#import "ViewController.h"
#include <CommonCrypto/CommonDigest.h>
#import "SHA1.h"
#import "ChatViewController.h"
#import "ServerNotification.h"

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _StartButton.enabled = false;
    
    
    //ServerNotification *noti = [[ServerNotification alloc] init];
    _noti1 = [[ServerNotification alloc] init];
    _noti1.delegateChatify = self;
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_noti1 connect];
}


- (void) gotConnection {
    _serverOnlineLabel.text = @"online";
}

- (void) receivedUserOnlineTotal:(NSString *)message {
    _UserOnlineLabel.text = [NSString stringWithFormat:@"%@ user online", message];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)StartButtonTapped:(id)sender {
    UIStoryboard *storyboard = self.storyboard;
    ChatViewController *cvc = [storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
    _noti1.delegateChatify = cvc;
    cvc.notification = _noti1;
    //ChatViewController *cvc = [[ChatViewController alloc] init];
    [self presentViewController:cvc animated:true completion:nil];
    // TODO check if it works
}

- (IBAction)NameValueChanged:(id)sender {
    NSLog(@"%@", _NameLabel.text);
    
}

- (IBAction)NameEditingChanged:(id)sender {
    if (_NameLabel.text.length > 0) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:_NameLabel.text forKey:@"nickname"];
        [_noti1.socketIO sendEvent:@"user_name_check" withData:data];
        _StartButton.enabled = true;
    }
    else {
        _StartButton.enabled = false;
    }
}

- (IBAction)DisconnectButtonTapped:(id)sender {
    NSLog(@"Disconnected");
}

@end
