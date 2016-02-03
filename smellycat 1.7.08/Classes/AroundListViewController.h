//
//  AroundListViewController.h
//  smellycat
//
//  Created by GPL on 13-3-11.
//
//

#import <UIKit/UIKit.h>

@interface AroundListViewController : UITableViewController<UINavigationControllerDelegate>
{
    NSMutableArray *_contentArray;
    NSInteger _totalNum;
    NSInteger _pageNo;
    UINavigationController *_navigationController;
    BOOL _hasLoaded;
    NSInteger _typeNm;
}
@property (nonatomic,retain) NSMutableArray *contentArray;
@property (nonatomic,assign) NSInteger totalNum;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,retain) UINavigationController *navigationController;
@property (nonatomic,assign) BOOL hasLoaded;
@property (nonatomic,assign) NSInteger typeNm;

- (void)getDataOnNewThread;
-(void)showAlertView;

@end
