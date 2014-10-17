//
//  ChatViewController.h
//  Chatify
//
//  Created by Friedrich Ewald on 02/10/14.
//  Copyright (c) 2014 Friedrich Ewald. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerNotification.h"

@interface ChatViewController : UIViewController <ChatifyDelegate>

@property (strong) ServerNotification *notification;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UIView *AdditionalView;
- (IBAction)CloseTapped:(id)sender;

@end
