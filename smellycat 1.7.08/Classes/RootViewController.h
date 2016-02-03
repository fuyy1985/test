//
//  RootViewController.h
//  smellycat
//
//  Created by apple on 10-11-18.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogUserInfo;
@interface RootViewController : UIViewController {
	UILabel *infoLabel;
	UIProgressView *infoProgress;
	NSTimer *timer;
	NSInteger iTimer;
	NSString *strText;
	LogUserInfo *Validation;
	BOOL isSuccessful;
	BOOL checkNetwork;
    NSMutableArray *gModules;
    
    UIView *login_main;
    UIImageView *login_main_img;
    UIImageView *login_user_img;
    UIButton *login_button;
    UITextField *login_mobile_field;
    UITextField *login_validate_field;
    UIButton *login_send_btn;
    UILabel *login_send_label;
    UIButton *login_resend_btn;
    UILabel *login_resend_label;
    int colockSec;
    NSTimer *mtimer;
}
@property(nonatomic,retain) IBOutlet UILabel *infoLabel;
@property(nonatomic,retain) IBOutlet UIProgressView *infoProgress;

@property(nonatomic,retain) IBOutlet UIView *login_main;
@property(nonatomic,retain) IBOutlet UIImageView *login_main_img;
@property(nonatomic,retain) IBOutlet UIImageView *login_user_img;
@property(nonatomic,retain) IBOutlet UIButton *login_button;
@property(nonatomic,retain) IBOutlet UITextField *login_mobile_field;
@property(nonatomic,retain) IBOutlet UITextField *login_validate_field;
@property(nonatomic,retain) IBOutlet UIButton *login_send_btn;
@property(nonatomic,retain) IBOutlet UILabel *login_send_label;
@property(nonatomic,retain) IBOutlet UIButton *login_resend_btn;
@property(nonatomic,retain) IBOutlet UILabel *login_resend_label;
@property(nonatomic) int colockSec;
@property (nonatomic, retain) NSTimer *mtimer;

@property(nonatomic,retain) NSTimer *timer;
@property(nonatomic) NSInteger iTimer;
@property(nonatomic,retain) NSString *strText;
@property(nonatomic,retain) LogUserInfo *Validation;
@property(nonatomic) BOOL isSuccessful;
@property(nonatomic) BOOL checkNetwork;
@property(nonatomic,retain) NSMutableArray *gModules;
+(id)sharedRT;
-(void)readyToLoginAndBegin;
-(BOOL)checkIsConnect;
-(void)pushSmellyCatView;
-(void)pushSmellyDogView;
-(void)dealWithTimer;
@end
