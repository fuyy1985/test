//
//  SSectionHeaderView.h
//  navag
//
//  Created by GPL on 13-11-11.
//
//

#import <UIKit/UIKit.h>

@protocol SSectionHeaderViewDelegate;

@interface SSectionHeaderView : UIView {
    UILabel *_titleLabel;
    UIButton *_disclosureButton;
    NSInteger _section;
    id <SSectionHeaderViewDelegate> _delegate;
}
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UIButton *disclosureButton;
@property (nonatomic,assign) NSInteger section;
@property (nonatomic,assign) id <SSectionHeaderViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame title:(NSString*)title section:(NSInteger)sectionNumber delegate:(id <SSectionHeaderViewDelegate>)aDelegate withSigleSignal:(BOOL)signal;
-(void)toggleOpenWithUserAction:(BOOL)userAction;
@end

@protocol SSectionHeaderViewDelegate <NSObject>
@optional
-(void)sectionHeaderView:(SSectionHeaderView *)sectionHeaderView sectionOpened:(NSInteger)section;
-(void)sectionHeaderView:(SSectionHeaderView *)sectionHeaderView sectionClosed:(NSInteger)section;
@end