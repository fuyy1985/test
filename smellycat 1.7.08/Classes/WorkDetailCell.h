//
//  WorkDetailCell.h
//  navag
//
//  Created by GPL on 13-7-26.
//
//

#import <UIKit/UIKit.h>

@interface WorkDetailCell : UITableViewCell
{
    UILabel *_workKeyLabel;
    UILabel *_workValueLabel;
    UILabel *_workDividorLabel;
    
    NSString *_key;
    NSString *_value;
    
    NSString *_isOver;
}
@property(nonatomic,retain) UILabel *workKeyLabel;
@property(nonatomic,retain) UILabel *workValueLabel;
@property(nonatomic,retain) UILabel *workDividorLabel;

@property(nonatomic,retain) NSString *key;
@property(nonatomic,retain) NSString *value;
@property(nonatomic,retain) NSString *isOver;

- (id)initWithHeight:(NSString *)height;
-(void)setValue;
@end
