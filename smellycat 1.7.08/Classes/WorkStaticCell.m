//
//  WorkStaticCell.m
//  navag
//
//  Created by GPL on 12-12-18.
//
//

#import "WorkStaticCell.h"
#import "WorkXMLParser.h"

@implementation WorkStaticCell
@synthesize typeLabel = _typeLabel;
@synthesize countLabel = _countLabel;
@synthesize para1Label = _para1Label;
@synthesize value1Label = _value1Label;
@synthesize unitStr = _unitStr;
@synthesize object = _object;

- (void)dealloc
{
    [_typeLabel release];
    [_countLabel release];
    [_para1Label release];
    [_value1Label release];
    [_unitStr release];
    [_object release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TABLECELL_BG"]];
        CGRect nameFrame = CGRectMake(45, 5, 150, 18);
        _typeLabel = [[UILabel alloc] initWithFrame:nameFrame];
        _typeLabel.font = [UIFont systemFontOfSize:15.0];
        _typeLabel.backgroundColor = [UIColor clearColor];
        _typeLabel.textColor = [UIColor blackColor];
        _typeLabel.textAlignment = UITextAlignmentLeft;
        [self addSubview:_typeLabel];
        
        CGRect areaFrame = CGRectMake(190, 16, 65, 18);
        _countLabel = [[UILabel alloc] initWithFrame:areaFrame];
        _countLabel.font = [UIFont systemFontOfSize:15.0];
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.textColor = [UIColor blackColor];
        _countLabel.textAlignment = UITextAlignmentRight;
        [self addSubview:_countLabel];
        
        CGRect typeFrame = CGRectMake(25, 26, 155, 18);
        _para1Label = [[UILabel alloc] initWithFrame:typeFrame];
        _para1Label.font = [UIFont systemFontOfSize:13.0];
        _para1Label.backgroundColor = [UIColor clearColor];
        _para1Label.textColor = [UIColor grayColor];
        _para1Label.textAlignment = UITextAlignmentLeft;
        [self addSubview:_para1Label];
    }
    return self;
}

-(void)setValue;
{
    _typeLabel.text = _object.grnm;
    _countLabel.text = [NSString stringWithFormat:@"%@ %@",_object.count,_unitStr];
    if ([_object.unit0 isEqualToString:@"万m³"]&&[_object.value0 intValue]>10000) {
        _para1Label.text = [NSString stringWithFormat:@"%@: %.2f 亿m³",_object.para0,[_object.value0 intValue]/10000.0];
    } else if([_object.unit0 isEqualToString:@"m"]&&[_object.value0 intValue]>1000) {
        _para1Label.text = [NSString stringWithFormat:@"%@: %.2f km",_object.para0,[_object.value0 intValue]/1000.0];
    } else if ([_object.unit0 isEqualToString:@"m³/s"]&&[_object.value0 intValue]>10000) {
        _para1Label.text = [NSString stringWithFormat:@"%@: %.2f 万m³/s",_object.para0,[_object.value0 intValue]/10000.0];
    } else if ([[_object.unit0 lowercaseString] isEqualToString:@"kw"]&&[_object.value0 intValue]>10000) {
        _para1Label.text = [NSString stringWithFormat:@"%@: %.2f 万KW",_object.para0,[_object.value0 intValue]/10000.0];
    } else if ([_object.unit0 isEqualToString:@"万m³"]&&[_object.value0 intValue]>10000) {
        _para1Label.text = [NSString stringWithFormat:@"%@: %.2f 亿m³",_object.para0,[_object.value0 intValue]/10000.0];
    } else {
        _para1Label.text = [NSString stringWithFormat:@"%@: %.2f %@",_object.para0,[_object.value0 doubleValue],_object.unit0];
    }
}

@end
