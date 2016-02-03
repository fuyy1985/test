/*
 
 File: SpeakHereViewController.h
 Abstract: View controller for the SpeakHere application
 Version: 2.4
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2009 Apple Inc. All Rights Reserved.
 
 
 */

#import <UIKit/UIKit.h>
#import "SSectionHeaderView.h"

@class SpeakHereController;
@class TFPathInfo;
@class SearchInfoModel;
@interface SpeakSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SSectionHeaderViewDelegate>
{
	IBOutlet SpeakHereController *controller;
    UITableView *_myTable;
    NSMutableArray *_hisc;
    NSMutableArray *_hiscPath;
    BOOL isVirgin;
    UIView *wattingView;
    //水
    NSMutableArray *_waterHisc;
    //雨
    NSMutableArray *_rainHisc;
    //台
    NSMutableArray *_typhoonHisc;
    //工
    NSMutableArray *_projectHisc;
}
@property (nonatomic, retain) IBOutlet UITableView *myTable;
@property (nonatomic, retain) NSMutableArray *hisc;
@property (nonatomic,retain) NSMutableArray *hiscPath;
@property (retain, nonatomic) IBOutlet UIButton *btnRec;
@property (retain, nonatomic) IBOutlet UITextField *texto;
@property (retain,nonatomic) IBOutlet UIView *wattingView;
@property (nonatomic, retain) NSMutableArray *waterHisc;
@property (nonatomic, retain) NSMutableArray *rainHisc;
@property (nonatomic, retain) NSMutableArray *typhoonHisc;
@property (nonatomic, retain) NSMutableArray *projectHisc;

+(id)sharedWork;
- (IBAction)push:(id)sender;
-(void)dealWithData:(NSString*)txt;
-(void)convertSTextToView:(NSString *)str;
-(void)showKeyBoard;
-(void)hideKeyBoard;

-(void)dismissPopover;
-(void)clearSearch:(id)sender;
-(void)addWaitting;
-(void)removeWaitting;
-(void)forWatting:(SearchInfoModel *)myInfo;
-(void)dealWithData:(NSString*)txt;
-(void)dealWithTyPh:(NSString *)dTfid;
-(void)getHistoryTyphoonPath:(TFPathInfo *)item;


@end

