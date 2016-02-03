//
//  CellControlCell.m
//  navag
//
//  Created by GPL on 12-12-6.
//
//

#import "CellControlCell.h"
#import "GPLNAnnotation.h"

@implementation CellControlCell
@synthesize nameLabel = _nameLabel;
@synthesize areaNameLabel = _areaNameLabel;
@synthesize typeLabel = _typeLabel;
@synthesize distanceLabel = _distanceLabel;
@synthesize cellObject = _cellObject;
@synthesize imgView = _imgView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TABLECELL_BG"]];
        CGRect nameFrame = CGRectMake(15, 3, 200, 18);
        _nameLabel = [[UILabel alloc] initWithFrame:nameFrame];
        _nameLabel.font = [UIFont systemFontOfSize:15.0];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = UITextAlignmentLeft;
        [self addSubview:_nameLabel];
        
        CGRect areaFrame = CGRectMake(260-35, 3, 55, 18);
        _areaNameLabel = [[UILabel alloc] initWithFrame:areaFrame];
        _areaNameLabel.font = [UIFont systemFontOfSize:15.0];
        _areaNameLabel.backgroundColor = [UIColor clearColor];
        _areaNameLabel.textColor = [UIColor blackColor];
        _areaNameLabel.textAlignment = UITextAlignmentLeft;
        [self addSubview:_areaNameLabel];
        
        CGRect typeFrame = CGRectMake(15, 26, 200, 18);
        _typeLabel = [[UILabel alloc] initWithFrame:typeFrame];
        _typeLabel.font = [UIFont systemFontOfSize:13.0];
        _typeLabel.backgroundColor = [UIColor clearColor];
        _typeLabel.textColor = [UIColor grayColor];
        _typeLabel.textAlignment = UITextAlignmentLeft;
        [self addSubview:_typeLabel];
        
        CGRect arrowFrame = CGRectMake(240-33, 29, 12, 12);
        _imgView = [[UIImageView alloc] initWithFrame:arrowFrame];
        _imgView.image = [UIImage imageNamed:@"arrow_around_plus.png"];
        [self addSubview:_imgView];
        
        CGRect distanceFrame = CGRectMake(260-35, 26, 55, 18);
        _distanceLabel = [[UILabel alloc] initWithFrame:distanceFrame];
        _distanceLabel.font = [UIFont systemFontOfSize:13.0];
        _distanceLabel.backgroundColor = [UIColor clearColor];
        _distanceLabel.textColor = [UIColor redColor];
        _distanceLabel.textAlignment = UITextAlignmentLeft;
        [self addSubview:_distanceLabel];

    }
    return self;
}

-(void)setValue;
{
    _nameLabel.text = _cellObject.ennm;
    _areaNameLabel.text = _cellObject.dsnm;
    
    if ([_cellObject.unit1 isEqualToString:@"万m³"]&&[_cellObject.value1 intValue]>10000) {
        _typeLabel.text = [NSString stringWithFormat:@"%@●%@%.2f亿m³",_cellObject.grnm,_cellObject.property1,[_cellObject.value1 intValue]/10000.0];
    } else if([_cellObject.unit1 isEqualToString:@"m"]&&[_cellObject.value1 intValue]>1000) {
        _typeLabel.text = [NSString stringWithFormat:@"%@●%@%.2fkm",_cellObject.grnm,_cellObject.property1,[_cellObject.value1 intValue]/1000.0];
    } else if ([_cellObject.unit1 isEqualToString:@"m³/s"]&&[_cellObject.value1 intValue]>10000) {
        _typeLabel.text = [NSString stringWithFormat:@"%@●%@%.2f万m³/s",_cellObject.grnm,_cellObject.property1,[_cellObject.value1 intValue]/10000.0];
    } else if ([_cellObject.unit1 isEqualToString:@"KW"]&&[_cellObject.value1 intValue]>10000) {
        _typeLabel.text = [NSString stringWithFormat:@"%@●%@%.2f万KW",_cellObject.grnm,_cellObject.property1,[_cellObject.value1 intValue]/10000.0];
    } else {
       _typeLabel.text = [NSString stringWithFormat:@"%@●%@%.2f%@",_cellObject.grnm,_cellObject.property1,[_cellObject.value1 doubleValue],_cellObject.unit1];
    }
        
    _distanceLabel.text = _cellObject.distance;
    _imgView.transform = CGAffineTransformMakeRotation(_cellObject.angle);
}

- (void)dealloc
{
    [_nameLabel release];
    [_areaNameLabel release];
    [_typeLabel release];
    [_distanceLabel release];
    [_imgView release];
    [_cellObject release];
    [super dealloc];
}

@end
