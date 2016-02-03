    //
//  RootViewController.m
//  smellycat
//
//  Created by apple on 10-11-18.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "RootViewController.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>
#import "smellycatViewController.h"
#import "smellydogViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "const.h"
#import "ValidateXMLParser.h"
#import "WebServices.h"
#import "Database.h"
#import "FileManager.h"
#import "GDataXMLNode.h"
#import "ForceUpdateViewController.h"

static RootViewController *me = nil;
@implementation RootViewController
@synthesize infoLabel,infoProgress;
@synthesize timer,iTimer,strText,Validation,isSuccessful,checkNetwork,gModules;
@synthesize login_main,login_main_img,login_user_img,login_button,login_mobile_field,login_validate_field,login_send_btn,login_send_label,login_resend_btn,login_resend_label,colockSec,mtimer;


-(void)viewWillAppear:(BOOL)animated
{
    //隐藏导航条
    self.navigationController.navigationBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification*)note
{
    NSDictionary *dic = note.userInfo;
    [UIView animateWithDuration:[[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.login_main.transform=CGAffineTransformMakeTranslation(0, -95);
    }];}

-(void)keyboardWillHide:(NSNotification*)note
{
    NSDictionary *dic = note.userInfo;
    [UIView animateWithDuration:[[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.login_main.transform = CGAffineTransformIdentity;
    }];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	me = self;
	isSuccessful = NO;
	checkNetwork = YES;
    gModules = [[NSMutableArray alloc]init];
	
	FileManager *config = [[FileManager alloc] init];
	[config createConfigFileIfNeeded];
	[config writeConfigFile:@"areacode" ValueForKey:[NSString stringWithFormat:@"33"]];
	[config writeConfigFile:@"defaultarea" ValueForKey:[NSString stringWithFormat:@"330000"]];
	[config release];
	
	Database *db=[[Database alloc] init];
	[db createEditableCopyOfDatabaseIfNeeded];
	[db release];
	
    //judge if the code exist
    if ([self isHasCodeInPhone] == YES) {
        [self hideLoginView];
        [self readyToLoginAndBeginWithGuid];
    } else {
        [self showLoginView];
    }
}

+(id)sharedRT{
	return me;
}


//1、判断是否有 guid
-(BOOL)isHasCodeInPhone
{
    //查看是否有GUID
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *guid = [defaults objectForKey:@"GUID"];
    return  guid == nil ? NO : YES;
}

//2、隐藏登陆界面
-(void)hideLoginView
{
    //将提示界面和滚动条位置上移
    CGRect labelFrame = self.infoLabel.frame;
    CGRect progressFrame = self.infoProgress.frame;
    if (labelFrame.origin.y == 548) {
        int moveY = 150;
        labelFrame.origin.y -= moveY;
        progressFrame.origin.y -= moveY;
        [self.infoLabel setFrame:labelFrame];
        [self.infoProgress setFrame:progressFrame];
    }
    self.infoProgress.hidden = NO;
    self.login_user_img.hidden = YES;
    self.login_mobile_field.hidden = YES;
    self.login_validate_field.hidden = YES;
    self.login_send_btn.hidden = YES;
    self.login_send_label.hidden = YES;
    self.login_resend_btn.hidden = YES;
    self.login_resend_label.hidden = YES;
    self.login_button.hidden = YES;
}

//3、显示登陆界面(初始)
-(void)showLoginView
{
    //将提示界面和滚动条位置上移
    CGRect labelFrame = self.infoLabel.frame;
    CGRect progressFrame = self.infoProgress.frame;
    if (labelFrame.origin.y == 370) {
        int moveY = 200;
        labelFrame.origin.y += moveY;
        progressFrame.origin.y += moveY;
        [self.infoLabel setFrame:labelFrame];
        [self.infoProgress setFrame:progressFrame];
    }
    self.login_mobile_field.hidden = NO;
    self.login_validate_field.hidden = NO;
    self.login_send_btn.hidden = NO;
    self.login_send_label.hidden = NO;
    self.login_button.hidden = NO;
    self.login_resend_btn.hidden = YES;
    self.login_resend_label.hidden = YES;
    
    login_send_label.text = @"获取验证码";
    login_resend_label.text = @"重新获取(300)";
    infoLabel.text = @"";
    self.mtimer = nil;
    infoProgress.progress = 0;
    infoProgress.hidden = YES;
}

//4.生成随机数
- (NSString *)getTimeNow
{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"%@", timeNow);
    return timeNow;
}

//5.客制化提醒視窗
-(void) showAlertView:(NSString *) meg{
    UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:nil message:meg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alterView show];
}

//6.轉成JSON
-(NSString *)tramformToJSON:(NSDictionary *)dict{
    NSString *json = @"";
    if([NSJSONSerialization isValidJSONObject:dict]){
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        json = [[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        return json;
    }else{
        [self showAlertView:@"转换JSON出错"];
        return nil;
    }
}

//remove all mobile and guid
-(void)removeAllMobileAndGuid
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"GUID"];
    [defaults setObject:nil forKey:@"MOBILE"];
}

//submit
-(IBAction)submitUser:(id)sender
{
    NSString *code = self.login_mobile_field.text;
    NSString *psw = self.login_validate_field.text;
    if ([self isValidateEmail:code] == YES && [psw length] == 6) {
        //当输入的用户名和验证码合法时，进行登陆
        [login_validate_field resignFirstResponder];
        [self readyToLoginAndBeginWithNoGuid];
    } else if ([code length] == 11 && [psw length] == 6) {
        //当输入的用户名和验证码合法时，进行登陆
        [login_validate_field resignFirstResponder];
        [self readyToLoginAndBeginWithNoGuid];
    } else {
        [self showAlertView:@"用户名或验证码不正确！"];
    }
}

//利用正则表达式验证
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//无guid:开始计时器
-(void)readyToLoginAndBeginWithNoGuid
{
	isSuccessful = NO;
	self.timer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(dealWithNoGuidTimer) userInfo:nil repeats:YES];
	iTimer = 0;
    [timer fire];
}

//无guid：计时器方法
-(void)dealWithNoGuidTimer
{
    FileManager *config;
    NSString *baseURL = @"http://m.zjwater.gov.cn/datacenterauth/authservice.asmx/";
    switch (iTimer) {
		case 0:
			strText = @"正在登录系统......";
			infoProgress.progress = 0.1;
            infoProgress.hidden = NO;
			break;
		case 1:
			if ([self checkIsConnect]==YES) {
                strText = @"已检测到网络,正在验证用户...";
                infoProgress.progress = 0.2;
            }else{
                strText = @"登录失败！未能检测到网络。";
                infoProgress.progress = 1.0;
                UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"请打开WIFI或者3G网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];
                [myAlert show];
                [timer invalidate];
            }
            break;
        case 2:
        {
            //sign in
            NSString *methodNmCount = @"UserRegister";
            NSString *paramCount = [NSString stringWithFormat:@"%@|%@",self.login_validate_field.text,SYSTEMID];
            NSURL *urlCount = [WebServices getNNRestUrl:baseURL Function:methodNmCount Parameter:paramCount withMobile:self.login_mobile_field.text];
            //NSString *nsurl2 = [NSString stringWithFormat:@"%@/UserRegister?mobile=%@&VerificationCode=%@&systemId=%@&deviceType=%@",FMAINSERVER,self.login_mobile_field.text,self.login_validate_field.text,SYSTEMID,FMODEL];
            //nsurl2 = [nsurl2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //NSURL *nsurl = [NSURL URLWithString:nsurl2];
            NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlCount];
            NSURLResponse *response = nil;
            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
            //解析
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
            //获取根节点（Users）
            GDataXMLElement *rootElement = [doc rootElement];
            NSString *ret = rootElement.stringValue;
            /*
             1，成功；
             2，成功,待审核；
             -1000：服务异常；
             -1001:，用户名或手机号码已存在；
             -1002，注册失败；
             -1005,验证码失效
             */
            if ([ret isEqualToString:@"1"] || [ret isEqualToString:@"-1001"]) {
                //注册成功（下一步，生成随机码注册）
                infoProgress.progress = 0.3;
                strText = @"用户验证成功，正在验证安全码信息...";
            } else {
                if ([ret isEqualToString:@"-1005"]){
                    //验证码错误(提醒)
                    strText = @"验证码错误,-105";
                } else if ([ret isEqualToString:@"-1000"]){
                    //服务异常(提醒)
                    strText = @"服务异常,-100";
                } else if ([ret isEqualToString:@"-1002"]){
                    //注册失败(提醒)
                    strText = @"注册失败,-102";
                } else {
                    //未知错误(提醒)
                    strText = @"未知错误,-104";
                }
                //sign error
                infoProgress.progress = 1.0;
                [timer invalidate];
            }
        }
            break;
        case 3:
        {
            //new create guid
            NSString *guid = [self getTimeNow];
            /*
             mobile 手机号码；
             guid:随机码；
             systemId：系统编码；
             devicdType：设备类型（可传入iphone，ipad，android）
             */
            //生成随机码
            NSString *methodNmCount = @"GuidRegister";
            NSString *paramCount = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",guid,SYSTEMID,VERSIONID,FMODEL,FNAME];
            NSURL *urlCount = [WebServices getNNRestUrl:baseURL Function:methodNmCount Parameter:paramCount withMobile:self.login_mobile_field.text];
            //NSString *nsurl2 = [[NSString alloc] initWithFormat:@"%@/GuidRegister?mobile=%@&guid=%@&systemId=%@&devicdType=%@",FMAINSERVER,self.login_mobile_field.text,guid,SYSTEMID,FMODEL];
            //nsurl2 = [nsurl2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //NSURL *nsurl = [[NSURL alloc]initWithString:nsurl2];
            NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlCount];
            NSURLResponse *response = nil;
            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
            //解析
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
            //获取根节点（Users）
            GDataXMLElement *rootElement = [doc rootElement];
            NSString *ret = rootElement.stringValue;
            /*
             1，成功；
             -1000：服务异常；
             -1001:，用户名或手机号码已存在；
             -1002，注册失败；
             -1003,手机号码不能为空；
             -1004，手机号码错误
             -1007
             */
            if ([ret isEqualToString:@"1"] || [ret isEqualToString:@"-1001"]) {
                //注册成功（下一步，生成随机码注册）
                infoProgress.progress = 0.3;
                strText = @"用户验证成功，正在验证安全码信息...";
                //注册成功(将串号写入本地作为保存后，开始登录UserAuthWithGUID)
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                NSString *name = @"GUID";
                [defaults setObject:guid forKey:name];
                //mobile
                [defaults setObject:self.login_mobile_field.text forKey:@"MOBILE"];
            } else {
                //error
                if ([ret isEqualToString:@"-1000"]){
                    //服务异常
                    strText = @"服务异常,-200";
                } else if ([ret isEqualToString:@"-1002"]){
                    //注册失败
                    strText = @"注册失败,-202";
                } else if ([ret isEqualToString:@"-1003"]){
                    //用户名不能为空
                    strText = @"用户名不能为空";
                } else if ([ret isEqualToString:@"-1004"]){
                    //用户名错误
                    strText = @"用户名错误,-203";
                } else if ([ret isEqualToString:@"-1007"]){
                    //注册数量超过限制
                    strText = @"注册超限,-207";
                } else {
                    //未知错误
                    strText = @"未知错误,-204";
                }
                //sign error
                infoProgress.progress = 1.0;
                [timer invalidate];
            }
        }
            break;
        case 4:
            //user auth with guid
        {
            /*
             mobile 手机号码；
             guid:随机码；
             systemId：系统编码；
             devicdType：设备类型（可传入iphone，ipad，android）
             */
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            NSString *guid = [defaults objectForKey:@"GUID"];
            //生成随机码
            NSString *methodNmCount = @"UserAuth";
            NSString *paramCount = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",guid,SYSTEMID,FNAME,VERSIONID,FOPERATIONNUMBER];
            NSURL *urlCount = [WebServices getNRestUrl:baseURL Function:methodNmCount Parameter:paramCount];
            //NSString *nsurl2 = [[NSString alloc] initWithFormat:@"%@/UserAuthWithGUID?&guid=%@&systemId=%@&deviceType=%@&version=%@",FMAINSERVER,guid,SYSTEMID,FMODEL,VERSIONID];
            //nsurl2 = [nsurl2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //NSURL *nsurl = [[NSURL alloc]initWithString:nsurl2];
            NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlCount];
            NSURLResponse *response = nil;
            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
            //解析
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
            //获取根节点（Users）
            GDataXMLElement *rootElement = [doc rootElement];
            /*
             1，成功；
             2，成功,待审核；
             -300:用户信息验证异常
             -311:帐户禁用
             -312:应用禁用
             -313:guid禁用
             -314:审核不通过
             -315:ifval非0、1
             -316:审核中 系统无公众模版
             -999:真的异常了
             */
            
            NSArray *items  = [rootElement nodesForXPath:@"//Table" error:nil];
            if ([items count] == 1) {
                GDataXMLElement *ele = [items objectAtIndex:0];
                //ifval
                GDataXMLElement *nameElement1 = [[ele elementsForName:@"ifval"] objectAtIndex:0];
                NSString *retIfVal = [nameElement1 stringValue];
                if ([retIfVal isEqualToString:@"1"]== YES) {
                    LogUserInfo *val = [[LogUserInfo alloc] init];
                    val.ifval = retIfVal;
                    //username
                    GDataXMLElement *nameElement2 = [[ele elementsForName:@"username"] objectAtIndex:0];
                    val.username = [nameElement2 stringValue];
                    //state
                    GDataXMLElement *nameElement3 = [[ele elementsForName:@"state"] objectAtIndex:0];
                    val.state = [nameElement3 stringValue];
                    //template_id
                    GDataXMLElement *nameElement4 = [[ele elementsForName:@"template_id"] objectAtIndex:0];
                    val.mtemplateid = [nameElement4 stringValue];
                    //template_name
                    GDataXMLElement *nameElement5 = [[ele elementsForName:@"template_name"] objectAtIndex:0];
                    val.mtemplatename = [nameElement5 stringValue];
                    //template_area
                    GDataXMLElement *nameElement6 = [[ele elementsForName:@"template_area"] objectAtIndex:0];
                    val.mtemplatearea = [nameElement6 stringValue];
                    //template_alias
                    GDataXMLElement *nameElement7 = [[ele elementsForName:@"template_alias"] objectAtIndex:0];
                    val.mtemplatealias = [nameElement7 stringValue];
                    //areacode
                    GDataXMLElement *nameElement8 = [[ele elementsForName:@"areacode"] objectAtIndex:0];
                    val.areacode = [nameElement8 stringValue];
                    //iscompel
                    GDataXMLElement *nameElement9 = [[ele elementsForName:@"iscompel"] objectAtIndex:0];
                    val.iscompel = [nameElement9 stringValue];
                    //versioncount
                    GDataXMLElement *nameElement10 = [[ele elementsForName:@"versioncount"] objectAtIndex:0];
                    val.versioncount = [nameElement10 stringValue];
                    self.Validation = val;
                    [val release];
                    //写入配置文件
                    config=[FileManager alloc];
                    [config writeConfigFile:@"ifval" ValueForKey:[NSString stringWithFormat:@"%@",Validation.ifval]];
                    if(Validation.username == nil || Validation.username == @"")
                        Validation.username = @"尊敬的用户";
                    [config writeConfigFile:@"username" ValueForKey:[NSString stringWithFormat:@"%@",Validation.username]];
                    [config writeConfigFile:@"state" ValueForKey:[NSString stringWithFormat:@"%@",Validation.state]];
                    [config writeConfigFile:@"templateid" ValueForKey:[NSString stringWithFormat:@"%@",Validation.mtemplateid]];
                    [config writeConfigFile:@"templatename" ValueForKey:[NSString stringWithFormat:@"%@",Validation.mtemplatename]];
                    if(Validation.mtemplatealias == nil || Validation.mtemplatealias == @"")
                        Validation.mtemplatealias = SYSTEMNM;
                    [config writeConfigFile:@"templatealias" ValueForKey:[NSString stringWithFormat:@"%@",Validation.mtemplatealias]];
                    [config writeConfigFile:@"templatearea" ValueForKey:[NSString stringWithFormat:@"%@",Validation.mtemplatearea]];
                    //new
                    [config writeConfigFile:@"versioncount" ValueForKey:[NSString stringWithFormat:@"%@",Validation.versioncount]];
                    [config writeConfigFile:@"iscompel" ValueForKey:[NSString stringWithFormat:@"%@",Validation.iscompel]];
                    [config release];
                    //强制更新放在这里
                    if ([[Validation.iscompel lowercaseString] isEqualToString:@"true"]) {
                        strText = @"系统版本更新，请立即更新！";
                        infoProgress.progress = 1.0;
                        [timer invalidate];
                        [self pushUpdateView];
                    }
                    strText = @"用户信息获取正常，获取模版信息中...";
                    infoProgress.progress = 0.4;
                } else if([retIfVal isEqualToString:@"-311"]== YES) {
                    strText = @"登陆异常,-311";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else if([retIfVal isEqualToString:@"-312"]== YES) {
                    strText = @"登陆异常,-312";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else if([retIfVal isEqualToString:@"-313"]== YES) {
                    strText = @"登陆异常,-313";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else if([retIfVal isEqualToString:@"-314"]== YES) {
                    strText = @"登陆异常,-314";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else if([retIfVal isEqualToString:@"-315"]== YES) {
                    strText = @"登陆异常,-315";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else if([retIfVal isEqualToString:@"-316"]== YES) {
                    strText = @"登陆异常,-316";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else if([retIfVal isEqualToString:@"-300"]== YES) {
                    strText = @"登陆异常,-300";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else  {
                    strText = @"登陆异常,-310";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                }
                /*
                 //跳转至登陆界面 代码
                 [self showAlertView:@"授权码失效，请重新验证"];
                 [self showLoginView];
                 [self removeAllMobileAndGuid];
                 infoProgress.progress = 1.0;
                 [timer invalidate];
                 */
                //当用户的
            } else {
                //登录服务异常
                strText = @"用户验证服务异常,-300";
                infoProgress.progress = 1.0;
                [timer invalidate];
            }
        }
            break;
        case 5:
        {
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            NSString *guid = [defaults objectForKey:@"GUID"];
            config=[[FileManager alloc] init];
			baseURL = @"http://m.zjwater.gov.cn/datacenterauth/authservice.asmx/";
			[config release];
			NSURL *countURL2 = [WebServices getNRestUrl:baseURL Function:@"GetDataServiceUrl" Parameter:[NSString stringWithFormat:@"%@|%@",guid,SYSTEMID]];
			//parse XML
			rootModuleXMLParser *paser2=[[rootModuleXMLParser alloc] init];
			[paser2 parseXMLFileAtURL:countURL2 parseError:nil];
			[paser2 release];
            
            if([gModules count] == 2||[gModules count] == 5){
                strText = [NSString stringWithString:@"配置信息获取成功..."];
                infoProgress.progress = 0.8;
                config=[[FileManager alloc] init];
                for(int i=0; i<[gModules count]; i++)
                {
                    ModuleInfo *module = [gModules objectAtIndex:i];
                    if([module.func isEqualToString:@"雨情-ipad"]){
                        [config writeConfigFile:@"mRain" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smRain" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmRain" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmRain" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }else if([module.func isEqualToString:@"水情-ipad"]){
                        [config writeConfigFile:@"mWater" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smWater" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmWater" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmWater" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }else if([module.func isEqualToString:@"工情-ipad"]){
                        [config writeConfigFile:@"mWork" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smWork" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmWork" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmWork" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }else if([module.func isEqualToString:@"台风路径ipad"]){
                        [config writeConfigFile:@"mTyphoon" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smTyphoon" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmTyphoon" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmTyphoon" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }else if([module.func isEqualToString:@"卫星云图ipad"]){
                        [config writeConfigFile:@"mCloud" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smCloud" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmCloud" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmCloud" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }
                }
                [config release];
			}
			else
			{
                strText = @"获取模板失败,-401";
                infoProgress.progress = 1.0;
                [timer invalidate];
            }
        }
            break;
        case 6:
            config = [[FileManager alloc] init];
            NSString *myUserNm = [config getValue:@"username"];
            [config release];
            strText = [NSString stringWithFormat:@"%@，欢迎您使用iPad版防汛系统！",myUserNm];
            infoProgress.progress = 0.9;
            break;
        case 7:
            strText = @"进入系统......";
			infoProgress.progress = 1.0;
			[timer invalidate];
            if ([Validation.mtemplateid isEqualToString:@"SSXQ"]&&[Validation.mtemplatename isEqualToString:@"实时汛情"]) {
                [self pushSmellyCatView];
            }else{
                [self pushSmellyDogView];
            }
			break;
	}
	if (iTimer<8) {
		infoLabel.text = strText;
        iTimer++;
	}
}

//有guid:开始计时器
-(void)readyToLoginAndBeginWithGuid
{
	isSuccessful = NO;
	timer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(dealWithGuidTimer) userInfo:nil repeats:YES];
	iTimer = 0;
}

//有guid：计时器方法
-(void)dealWithGuidTimer{
    FileManager *config;
    NSString *baseURL = @"http://m.zjwater.gov.cn/datacenterauth/authservice.asmx/";
    switch (iTimer) {
		case 0:
			strText = @"正在登录系统......";
			infoProgress.progress = 0.1;
            infoProgress.hidden = NO;
			break;
		case 1:
			if ([self checkIsConnect]==YES) {
                strText = @"已检测到网络,正在验证用户...";
                infoProgress.progress = 0.2;
            }else{
                strText = @"登录失败！未能检测到网络。";
                infoProgress.progress = 1.0;
                UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"请打开WIFI或者3G网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];
                [myAlert show];
                [timer invalidate];
            }
            break;
        case 2:
            //user auth with guid
        {
            /*
             mobile 手机号码；
             guid:随机码；
             systemId：系统编码；
             devicdType：设备类型（可传入iphone，ipad，android）
             */
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            NSString *guid = [defaults objectForKey:@"GUID"];
            //生成随机码
            /*
             4.用户验证
             DataSet UserAuth(string key)
             key组成：guid&systemId&deviceName|version
             参数:guid 随机码， systemId,系统编码 deviceName，设备名称 version 当前版本号
             */
            NSString *methodNmCount = @"UserAuth";
            NSString *paramCount = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",guid,SYSTEMID,FNAME,VERSIONID,FOPERATIONNUMBER];
            NSURL *urlCount = [WebServices getNRestUrl:baseURL Function:methodNmCount Parameter:paramCount];
            //NSString *nsurl2 = [[NSString alloc] initWithFormat:@"%@/UserAuthWithGUID?&guid=%@&systemId=%@&deviceType=%@&version=%@",FMAINSERVER,guid,SYSTEMID,FMODEL,VERSIONID];
            //nsurl2 = [nsurl2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //NSURL *nsurl = [[NSURL alloc]initWithString:nsurl2];
            NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlCount];
            NSURLResponse *response = nil;
            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                                 returningResponse:&response
                                                             error:&error];
            //解析
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
            //获取根节点（Users）
            GDataXMLElement *rootElement = [doc rootElement];
            /*
             1，成功；
             2，成功,待审核；
             -300:用户信息验证异常
             -311:帐户禁用
             -312:应用禁用
             -313:guid禁用
             -314:审核不通过
             -315:ifval非0、1
             -316:审核中 系统无公众模版
             -999:真的异常了
             */
                    
            NSArray *items  = [rootElement nodesForXPath:@"//Table" error:nil];
            if ([items count] == 1) {
                GDataXMLElement *ele = [items objectAtIndex:0];
                //ifval
                GDataXMLElement *nameElement1 = [[ele elementsForName:@"ifval"] objectAtIndex:0];
                NSString *retIfVal = [nameElement1 stringValue];
                if ([retIfVal isEqualToString:@"1"]== YES) {
                    LogUserInfo *val = [[LogUserInfo alloc] init];
                    val.ifval = retIfVal;
                    //username
                    GDataXMLElement *nameElement2 = [[ele elementsForName:@"username"] objectAtIndex:0];
                    val.username = [nameElement2 stringValue];
                    //state
                    GDataXMLElement *nameElement3 = [[ele elementsForName:@"state"] objectAtIndex:0];
                    val.state = [nameElement3 stringValue];
                    //template_id
                    GDataXMLElement *nameElement4 = [[ele elementsForName:@"template_id"] objectAtIndex:0];
                    val.mtemplateid = [nameElement4 stringValue];
                    //template_name
                    GDataXMLElement *nameElement5 = [[ele elementsForName:@"template_name"] objectAtIndex:0];
                    val.mtemplatename = [nameElement5 stringValue];
                    //template_area
                    GDataXMLElement *nameElement6 = [[ele elementsForName:@"template_area"] objectAtIndex:0];
                    val.mtemplatearea = [nameElement6 stringValue];
                    //template_alias
                    GDataXMLElement *nameElement7 = [[ele elementsForName:@"template_alias"] objectAtIndex:0];
                    val.mtemplatealias = [nameElement7 stringValue];
                    //areacode
                    GDataXMLElement *nameElement8 = [[ele elementsForName:@"areacode"] objectAtIndex:0];
                    val.areacode = [nameElement8 stringValue];
                    //iscompel
                    GDataXMLElement *nameElement9 = [[ele elementsForName:@"iscompel"] objectAtIndex:0];
                    val.iscompel = [nameElement9 stringValue];
                    //versioncount
                    GDataXMLElement *nameElement10 = [[ele elementsForName:@"versioncount"] objectAtIndex:0];
                    val.versioncount = [nameElement10 stringValue];
                    self.Validation = val;
                    [val release];
                    //写入配置文件
                    config=[FileManager alloc];
                    [config writeConfigFile:@"ifval" ValueForKey:[NSString stringWithFormat:@"%@",Validation.ifval]];
                    if(Validation.username == nil || Validation.username == @"")
                        Validation.username = @"尊敬的用户";
                    [config writeConfigFile:@"username" ValueForKey:[NSString stringWithFormat:@"%@",Validation.username]];
                    [config writeConfigFile:@"state" ValueForKey:[NSString stringWithFormat:@"%@",Validation.state]];
                    [config writeConfigFile:@"templateid" ValueForKey:[NSString stringWithFormat:@"%@",Validation.mtemplateid]];
                    [config writeConfigFile:@"templatename" ValueForKey:[NSString stringWithFormat:@"%@",Validation.mtemplatename]];
                    if(Validation.mtemplatealias == nil || Validation.mtemplatealias == @"")
                        Validation.mtemplatealias = SYSTEMNM;
                    [config writeConfigFile:@"templatealias" ValueForKey:[NSString stringWithFormat:@"%@",Validation.mtemplatealias]];
                    [config writeConfigFile:@"templatearea" ValueForKey:[NSString stringWithFormat:@"%@",Validation.mtemplatearea]];
                   
                    //new
                    [config writeConfigFile:@"versioncount" ValueForKey:[NSString stringWithFormat:@"%@",Validation.versioncount]];
                    [config writeConfigFile:@"iscompel" ValueForKey:[NSString stringWithFormat:@"%@",Validation.iscompel]];
                    [config release];
                    //强制更新放在这里
                    if ([[Validation.iscompel lowercaseString] isEqualToString:@"true"]) {
                        strText = @"系统版本更新，请立即更新！";
                        infoProgress.progress = 1.0;
                        [timer invalidate];
                        [self pushUpdateView];
                    }
                    strText = @"用户信息获取正常，获取模版信息中...";
                    infoProgress.progress = 0.4;
                } else if([retIfVal isEqualToString:@"-311"]== YES) {
                    strText = @"登陆异常,-311";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else if([retIfVal isEqualToString:@"-312"]== YES) {
                    strText = @"登陆异常,-312";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else if([retIfVal isEqualToString:@"-313"]== YES) {
                    strText = @"登陆异常,-313";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else if([retIfVal isEqualToString:@"-314"]== YES) {
                    strText = @"登陆异常,-314";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else if([retIfVal isEqualToString:@"-315"]== YES) {
                    strText = @"登陆异常,-315";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else if([retIfVal isEqualToString:@"-316"]== YES) {
                    strText = @"登陆异常,-316";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else if([retIfVal isEqualToString:@"-300"]== YES) {
                    strText = @"登陆异常,-300";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                } else  {
                    strText = @"登陆异常,-310";
                    infoProgress.progress = 1.0;
                    [timer invalidate];
                }
                /*
                 //跳转至登陆界面 代码
                 [self showAlertView:@"授权码失效，请重新验证"];
                 [self showLoginView];
                 [self removeAllMobileAndGuid];
                 infoProgress.progress = 1.0;
                 [timer invalidate];
                 */
                //当用户的
            } else {
                //登录服务异常
                strText = @"用户验证服务异常,-300";
                infoProgress.progress = 1.0;
                [timer invalidate];
            }
        }
            break;
        case 3:
        {
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            NSString *guid = [defaults objectForKey:@"GUID"];
            config=[[FileManager alloc] init];
			baseURL = @"http://m.zjwater.gov.cn/datacenterauth/authservice.asmx/";
			[config release];
			NSURL *countURL2 = [WebServices getNRestUrl:baseURL Function:@"GetDataServiceUrl" Parameter:[NSString stringWithFormat:@"%@|%@",guid,SYSTEMID]];
			//parse XML
			rootModuleXMLParser *paser2=[[rootModuleXMLParser alloc] init];
			[paser2 parseXMLFileAtURL:countURL2 parseError:nil];
			[paser2 release];
            
            if([gModules count] == 2||[gModules count] == 5){
                strText = [NSString stringWithString:@"配置信息获取成功..."];
                infoProgress.progress = 0.8;
                config=[[FileManager alloc] init];
                for(int i=0; i<[gModules count]; i++)
                {
                    ModuleInfo *module = [gModules objectAtIndex:i];
                    if([module.func isEqualToString:@"雨情-ipad"]){
                        [config writeConfigFile:@"mRain" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smRain" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmRain" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmRain" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }else if([module.func isEqualToString:@"水情-ipad"]){
                        [config writeConfigFile:@"mWater" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smWater" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmWater" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmWater" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }else if([module.func isEqualToString:@"工情-ipad"]){
                        [config writeConfigFile:@"mWork" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smWork" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmWork" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmWork" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }else if([module.func isEqualToString:@"台风路径ipad"]){
                        [config writeConfigFile:@"mTyphoon" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smTyphoon" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmTyphoon" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmTyphoon" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }else if([module.func isEqualToString:@"卫星云图ipad"]){
                        [config writeConfigFile:@"mCloud" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smCloud" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmCloud" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmCloud" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }
                }
                [config release];
			}
			else
			{
                strText = @"获取模板失败,-401";
                infoProgress.progress = 1.0;
                [timer invalidate];
            }
        }
            break;
        case 4:
            config = [[FileManager alloc] init];
            NSString *myUserNm = [config getValue:@"username"];
            [config release];
            strText = [NSString stringWithFormat:@"%@，欢迎您使用iPad版防汛系统！",myUserNm];
            infoProgress.progress = 0.9;
            break;
        case 5:
            if (Validation.isNew == YES) {
                strText = [NSString stringWithString:@"已有新版本发布，请您及时更新。进入系统......"];
            } else {
                strText = [NSString stringWithString:@"进入系统......"];
            }
			infoProgress.progress = 1.0;
			[timer invalidate];
            if ([Validation.mtemplateid isEqualToString:@"SSXQ"]&&[Validation.mtemplatename isEqualToString:@"实时汛情"]) {
                [self pushSmellyCatView];
            }else{
                [self pushSmellyDogView];
            }
			break;
	}
	if (iTimer<6) {
		infoLabel.text = strText;
        iTimer++;
	}
}

//获取验证码
-(IBAction)fetchValidateCode:(id)sender;
{
    NSString *mnum = self.login_mobile_field.text;
    if ([mnum length] == 11 || [self isValidateEmail:mnum] == YES) {
        //jump to next field
        [self.login_validate_field becomeFirstResponder];
        NSString *baseURL = @"http://m.zjwater.gov.cn/datacenterauth/authservice.asmx/";
        NSString *methodNmCount = @"GetVerificationCode";
        NSURL *urlCount = [WebServices getNNRestUrl:baseURL Function:methodNmCount Parameter:@"" withMobile:mnum];
        //NSString *nsurl2 = [[NSString alloc] initWithFormat:@"%@/GetVerificationCode?mobile=%@",FMAINSERVER,mnum];
        //NSURL *nsurl = [[NSURL alloc]initWithString:nsurl2];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlCount];
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                             returningResponse:&response
                                                         error:&error];
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:nso completionHandler:<#^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError)handler#>]
        //解析
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
        //获取根节点（Users）
        GDataXMLElement *rootElement = [doc rootElement];
        NSString *ret = rootElement.stringValue;
        /*
         1，成功；
         -1000：服务异常；
         -1001:，用户名或用户名已存在；
         -1002，注册失败；
         -1003,用户名不能为空；
         -1004，用户名错误
         */
        if ([ret isEqualToString:@"1"] || [ret isEqualToString:@"-1001"]) {
            //短信发送成功(改变获取按钮信息，倒计时和重新获取)
            [self beginClock];
        } else if ([ret isEqualToString:@"-1000"]){
            //服务异常
            [self showAlertView: @"服务异常"];
        } else if ([ret isEqualToString:@"-1002"]){
            //注册失败
            [self showAlertView: @"注册失败"];
        } else if ([ret isEqualToString:@"-1003"]){
            //用户名不能为空
            [self showAlertView: @"用户名不能为空"];
        } else if ([ret isEqualToString:@"-1004"]){
            //用户名错误
            [self showAlertView: @"用户名错误"];
        } else {
            //未知错误
            [self showAlertView: @"未知错误"];
        }
    } else {
        [self showAlertView: @"用户名无效"];
    }
}

-(void)beginClock
{
    //hide
    login_send_btn.hidden = YES;
    login_send_label.hidden = YES;
    //show
    login_resend_btn.hidden = NO;
    login_resend_label.hidden = NO;
    //reset time
    colockSec = 300;
    self.mtimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(soilColock) userInfo:nil repeats:YES];
    [mtimer fire];
}

//验证码倒计时
-(void)soilColock
{
    //重新获取(120)
    login_resend_label.text = [NSString stringWithFormat:@"重新获取(%d)",colockSec];
    colockSec--;
    if (colockSec == 0) {
        //stop
        [mtimer invalidate];
        //hide
        login_send_btn.hidden = NO;
        login_send_label.hidden = NO;
        //show
        login_resend_btn.hidden = YES;
        login_resend_label.hidden = YES;
    }
}


-(void)readyToLoginAndBegin
{
	isSuccessful = NO;
	
	timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(dealWithTimer) userInfo:nil repeats:YES];
	iTimer = 0;
}

- (void)getvalidation:(LogUserInfo *)mValue{
	Validation=mValue;
}

- (void)getModule:(ModuleInfo *)mModule{
	[self.gModules addObject:mModule];
}
			 
-(void)dealWithTimer{
    FileManager *config;
    NSString *uPara = [NSString stringWithFormat:@"%@|%@", SYSTEMID, VERSIONID];
    NSString *baseURL;
    
    switch (iTimer) {
		case 0:
			strText = [NSString stringWithString:@"正在登录系统......"];
			infoProgress.progress = 0.1;
			break;
		case 1:
			if ([self checkIsConnect]==YES) {
                strText = [NSString stringWithString:@"已检测到网络,正在请求服务器..."];
                infoProgress.progress = 0.2;
            }else{
                strText = [NSString stringWithString:@"登录失败！未能检测到网络。"];
                infoProgress.progress = 1.0;
                UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"网络连接错误" message:@"请打开WIFI或者3G网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];
                [myAlert show];
                [timer invalidate];
            }
            break;
        case 2:
            config=[[FileManager alloc] init];
            baseURL=[NSString stringWithFormat:@"http://%@/%@/", [config getServerURL:1], MainServerURLPath];
            [config release];
            NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"UserAuth" Parameter:uPara];
            rootXMLParser *paser=[[rootXMLParser alloc] init];
            [paser parseXMLFileAtURL:countURL parseError:nil];		
            [paser release];
            
            //check base on the validate
            if ([Validation.ifval isEqualToString:@"1"]) {
                strText = [NSString stringWithString:@"服务器已连接，正在获取验证信息..."];
                infoProgress.progress = 0.5;
                iTimer++;
                config=[[FileManager alloc] init];
                [config writeConfigFile:@"mainserver" ValueForKey:[NSString stringWithFormat:@"%d",1]];
                [config release];
            }else if([Validation.ifval isEqualToString:@"0"]){
                strText = [NSString stringWithString:@"登录失败！未能连接到服务器。"];
                infoProgress.progress = 1.0;
                UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"未能连接到服务器！" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];
                [myAlert show];
                [timer invalidate];
            }else{
                strText = [NSString stringWithString:@"主服务器连接失败，启用备用服务器..."];
                infoProgress.progress = 0.3;
            }
            break;
        case 3:
            config=[[FileManager alloc] init];
            [config writeConfigFile:@"mainserver" ValueForKey:[NSString stringWithFormat:@"%d",2]];
            baseURL=[NSString stringWithFormat:@"http://%@/%@/", [config getServerURL:2], MainServerURLPath];
            [config release];
            NSURL *countURL1=[WebServices getNRestUrl:baseURL Function:@"UserAuth" Parameter:uPara];
            rootXMLParser *paser1=[[rootXMLParser alloc] init];
            [paser1 parseXMLFileAtURL:countURL1 parseError:nil];		
            [paser1 release];
            
            //check base on the validate
            if ([Validation.ifval isEqualToString:@"1"]) {
                strText = [NSString stringWithString:@"备用服务器已连接，正在获取验证信息..."];
                infoProgress.progress = 0.5;
            }else if([Validation.ifval isEqualToString:@"0"]){
                strText = [NSString stringWithString:@"登录失败！未能连接到服务器。"];
                infoProgress.progress = 1.0;
                UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"未能连接到服务器！" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];
                [myAlert show];
                [timer invalidate];
            }else{
                strText = [NSString stringWithString:@"登录失败！服务器连接失败。"];
                infoProgress.progress = 1.0;
                UIAlertView *myAlert = [[[UIAlertView alloc] initWithTitle:@"服务器连接失败！" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];
                [myAlert show];
                [timer invalidate];
            }
            break;
        case 4:
            strText = [NSString stringWithString:@"验证成功，正在获取配置信息..."];
            infoProgress.progress = 0.6;
            config=[[FileManager alloc] init];
			[config writeConfigFile:@"ifval" ValueForKey:[NSString stringWithFormat:@"%@",Validation.ifval]];
			if(Validation.username == nil || Validation.username == @"")
				Validation.username =[NSString stringWithString:@"尊敬的用户"];
			[config writeConfigFile:@"username" ValueForKey:[NSString stringWithFormat:@"%@",Validation.username]];
			[config writeConfigFile:@"state" ValueForKey:[NSString stringWithFormat:@"%@",Validation.state]];
			[config writeConfigFile:@"templateid" ValueForKey:[NSString stringWithFormat:@"%@",Validation.mtemplateid]];
			[config writeConfigFile:@"templatename" ValueForKey:[NSString stringWithFormat:@"%@",Validation.mtemplatename]];
			if(Validation.mtemplatealias == nil || Validation.mtemplatealias == @"")
				Validation.mtemplatealias = [NSString stringWithString:@"浙江实时汛情系统"];
			[config writeConfigFile:@"templatealias" ValueForKey:[NSString stringWithFormat:@"%@",Validation.mtemplatealias]];
			[config writeConfigFile:@"templatearea" ValueForKey:[NSString stringWithFormat:@"%@",Validation.mtemplatearea]];
			[config release];
           break; 
        case 5:
            config=[[FileManager alloc] init];
			baseURL = @"http://m.zjwater.gov.cn/datacenterauth/authservice.asmx/";
			[config release];
			NSURL *countURL2 = [WebServices getNRestUrl:baseURL Function:@"GetDataServiceUrl" Parameter:[NSString stringWithFormat:@"%@",SYSTEMID]];
			//parse XML
			rootModuleXMLParser *paser2=[[rootModuleXMLParser alloc] init];
			[paser2 parseXMLFileAtURL:countURL2 parseError:nil];		
			[paser2 release];
            
            if([gModules count] == 2||[gModules count] == 5){
                strText = [NSString stringWithString:@"配置信息获取成功..."];
                infoProgress.progress = 0.8;
                config=[[FileManager alloc] init];
                for(int i=0; i<[gModules count]; i++)
                {
                    ModuleInfo *module = [gModules objectAtIndex:i];                    
                    if([module.func isEqualToString:@"雨情-ipad"]){
                        [config writeConfigFile:@"mRain" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smRain" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmRain" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmRain" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }else if([module.func isEqualToString:@"水情-ipad"]){
                        [config writeConfigFile:@"mWater" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smWater" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmWater" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmWater" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }else if([module.func isEqualToString:@"工情-ipad"]){
                        [config writeConfigFile:@"mWork" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smWork" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmWork" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmWork" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }else if([module.func isEqualToString:@"台风路径ipad"]){
                        [config writeConfigFile:@"mTyphoon" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smTyphoon" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmTyphoon" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmTyphoon" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }else if([module.func isEqualToString:@"卫星云图ipad"]){
                        [config writeConfigFile:@"mCloud" ValueForKey:[NSString stringWithFormat:@"%@",module.wip]];
                        [config writeConfigFile:@"smCloud" ValueForKey:[NSString stringWithFormat:@"%@",module.alias]];
                        [config writeConfigFile:@"cmCloud" ValueForKey:[NSString stringWithFormat:@"%@",module.ipcode]];
                        [config writeConfigFile:@"fmCloud" ValueForKey:[NSString stringWithFormat:@"%@",module.funcid]];
                    }
                }
                [config release];
			}
			else
			{
                strText = [NSString stringWithString:@"登陆失败！获取模板失败。"];
                infoProgress.progress = 1.0;
                [timer invalidate];
            }
            break;
        case 6:
            config = [[FileManager alloc] init];
            NSString *myUserNm = [config getValue:@"username"];
            [config release];
            strText = [NSString stringWithFormat:@"%@，欢迎您使用iPad版防汛系统！",myUserNm];
            infoProgress.progress = 0.9;
            break;
        case 7:
            if (Validation.isNew == YES) {
                strText = [NSString stringWithString:@"已有新版本发布，请您及时更新。进入系统......"];
            } else {
                strText = [NSString stringWithString:@"进入系统......"];
            }
			infoProgress.progress = 1.0;
			[timer invalidate];
            if ([Validation.mtemplateid isEqualToString:@"SSXQ"]&&[Validation.mtemplatename isEqualToString:@"实时汛情"]) {
                [self pushSmellyCatView];
            }else{
                [self pushSmellyDogView];
            }
			break;
	}
	
	if (iTimer<9) {
		infoLabel.text = strText;
        iTimer++;
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight) {
		return YES;
	}else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
		return YES;
	}else {
		return NO;
	}	
}

-(BOOL)checkIsConnect{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
	
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
	
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
	
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
	
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
	
    NSURL *testURL = [NSURL URLWithString:@"http://pda.zjfx.gov.cn11111/"];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
    NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:self];
	
    return ((isReachable && !needsConnection) || nonWiFi) ? (testConnection ? YES : NO) : NO;
	//return (testConnection ? YES : NO);
}

-(void)pushSmellyCatView{
    //judge if the user is validate or invalidate, give the user as different view
	isSuccessful = YES;
	NSUInteger nextIndex = [[self.view subviews] count];
	smellycatViewController *mytestview = [[smellycatViewController alloc] initWithNibName:@"smellycatViewController" bundle:nil];
	[self.view insertSubview:mytestview.view atIndex:nextIndex];
	CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	animation.type = kCATransitionPush;
	animation.subtype = kCATransitionFromBottom;
	[mytestview.view.layer addAnimation:animation forKey:@"animation"];
}

-(void)pushUpdateView{
    //judge if the user is validate or invalidate, give the user as different view
	isSuccessful = YES;
	NSUInteger nextIndex = [[self.view subviews] count];
    ForceUpdateViewController *mytestview = [[ForceUpdateViewController alloc] initWithNibName:@"ForceUpdateViewController" bundle:nil];
	[self.view insertSubview:mytestview.view atIndex:nextIndex];
	CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	animation.type = kCATransitionPush;
	animation.subtype = kCATransitionFromBottom;
	[mytestview.view.layer addAnimation:animation forKey:@"animation"];
}

-(void)pushSmellyDogView{
    //judge if the user is validate or invalidate, give the user as different view
	isSuccessful = YES;
	NSUInteger nextIndex = [[self.view subviews] count];
	smellydogViewController *mytestview = [[smellydogViewController alloc] initWithNibName:@"smellydogViewController" bundle:nil];
	[self.view insertSubview:mytestview.view atIndex:nextIndex];
	CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	animation.type = kCATransitionPush;
	animation.subtype = kCATransitionFromBottom;
	[mytestview.view.layer addAnimation:animation forKey:@"animation"];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.infoLabel = nil;
	self.infoProgress = nil;
}

- (void)dealloc {
    [gModules release];
	[Validation release];
	[strText release];
	[timer release];
	[infoLabel release];
	[infoProgress release];
    
    [login_main release];
    [login_main_img release];
    [login_user_img release];
    [login_button release];
    [login_mobile_field release];
    [login_validate_field release];
    [login_send_btn release];
    [login_send_label release];
    [login_resend_btn release];
    [login_resend_label release];
    [mtimer release];
    [super dealloc];
}


@end
