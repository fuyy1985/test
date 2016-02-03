//
//  CellControlCell.h
//  navag
//
//  Created by GPL on 12-12-6.
//
//

#import <UIKit/UIKit.h>

@class GPLNAnnotation;
@interface CellControlCell : UITableViewCell
{
    UILabel *_nameLabel;
    UILabel *_areaNameLabel;
    UILabel *_typeLabel;
    UILabel *_distanceLabel;
    UIImageView *_imgView;
    
    GPLNAnnotation *_cellObject;
}
@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UILabel *areaNameLabel;
@property (nonatomic,retain) UILabel *typeLabel;
@property (nonatomic,retain) UILabel *distanceLabel;
@property (nonatomic,retain) UIImageView *imgView;

@property (nonatomic,retain) GPLNAnnotation *cellObject;

-(void)setValue;

@end
