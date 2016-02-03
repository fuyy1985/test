//
//  TyphoonListPopovers.h
//  smellycat
//
//  Created by apple on 10-9-25.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFList;
@interface TyphoonListPopovers : UIViewController {
	NSMutableArray *hiscPath;
	NSInteger parserSelection;
	NSString *myTitle;
	UILabel *myTitleLab;
}

@property (nonatomic, retain) NSMutableArray *hiscPath;
@property (nonatomic,retain) NSString *myTitle;
@property (nonatomic,retain) IBOutlet UILabel *myTitleLab;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withList:(NSMutableArray *)tfList withTYphoonInfo:(TFList *)typhoonInfo withInfo:(NSString *)cInfo;
-(IBAction)dismissPopover:(id)sender;

@end
