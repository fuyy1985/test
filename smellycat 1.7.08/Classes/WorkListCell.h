//
//  WorkListCell.h
//  navag
//
//  Created by GPL on 12-12-18.
//
//

#import <UIKit/UIKit.h>

@class WorkInfo;
@interface WorkListCell : UITableViewCell
{
    UILabel *_overLabel;
    
    UILabel *_nmLabel;
    UILabel *_areaLabel;
    UILabel *_para0;
    UILabel *_paraAndValue0;
    UILabel *_para1;
    UILabel *_value1;
    
    WorkInfo *_object;
}
@property (nonatomic,retain) UILabel *overLabel;

@property (nonatomic,retain) UILabel *nmLabel;
@property (nonatomic,retain) UILabel *areaLabel;
@property (nonatomic,retain) UILabel *para0;
@property (nonatomic,retain) UILabel *paraAndValue0;
@property (nonatomic,retain) UILabel *para1;
@property (nonatomic,retain) UILabel *value1;

@property (nonatomic,retain) WorkInfo *object;
-(void)setValue;

@end
