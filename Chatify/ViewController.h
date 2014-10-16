//
//  ViewController.h
//  Chatify
//
//  Created by Friedrich Ewald on 02/10/14.
//  Copyright (c) 2014 Friedrich Ewald. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"
#import "ServerNotification.h"

@interface ViewController : UIViewController <ChatifyDelegate>

@property (strong) ServerNotification *noti1;
@property (strong, nonatomic) IBOutlet UITextField *NameLabel;
@property (strong, nonatomic) IBOutlet UIButton *StartButton;
@property (strong, nonatomic) IBOutlet UILabel *UserOnlineLabel;
@property (strong, nonatomic) IBOutlet UILabel *serverOnlineLabel;

- (IBAction)StartButtonTapped:(id)sender;
- (IBAction)NameValueChanged:(id)sender;
- (IBAction)NameEditingChanged:(id)sender;


@end

