//
//  WorkStaticCell.h
//  navag
//
//  Created by GPL on 12-12-18.
//
//

#import <UIKit/UIKit.h>

@class WorkInfo;
@interface WorkStaticCell : UITableViewCell
{
    UILabel *_typeLabel;
    UILabel *_countLabel;
    UILabel *_para1Label;
    UILabel *_value1Label;
    
    NSString *_unitStr;
    WorkInfo *_object;
}

@property (nonatomic,retain) UILabel *typeLabel;
@property (nonatomic,retain) UILabel *countLabel;
@property (nonatomic,retain) UILabel *para1Label;
@property (nonatomic,retain) UILabel *value1Label;
@property (nonatomic,retain) NSString *unitStr;
@property (nonatomic,retain) WorkInfo *object;
-(void)setValue;

@end
