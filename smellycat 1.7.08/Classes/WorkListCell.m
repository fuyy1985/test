//
//  WorkListCell.m
//  navag
//
//  Created by GPL on 12-12-18.
//
//

#import "WorkListCell.h"
#import "WorkXMLParser.h"


#define OVERLABEL_OVER_FRAME CGRectMake(15,5.5,17,17)
#define OVERLABEL_NORMAL_FRAME CGRectZero
#define NAMELABEL_OVER_FRAME CGRectMake(35,5.5,200,18)
#define NAMELABEL_NORMAL_FRAME CGRectMake(15, 5, 200, 18)
#define IMAGE_OVER [UIImage imageNamed:@"project_over"]


@implementation WorkListCell
@synthesize nmLabel = _nmLabel;
@synthesize areaLabel = _areaLabel;
@synthesize para0 = _para0;
@synthesize paraAndValue0 = _paraAndValue0;
@synthesize para1 = _para1;
@synthesize value1 = _value1;
@synthesize object = _object;

- (void)dealloc
{
    [_nmLabel release];
    [_areaLabel release];
    [_para0 release];
    [_paraAndValue0 release];
    [_para1 release];
    [_value1 release];
    
    [_object release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TABLECELL_BG"]];
        //默认隐藏
        CGRect overFrame = CGRectZero;
        _overLabel = [[UILabel alloc] initWithFrame:overFrame];
        _overLabel.textColor = [UIColor clearColor];
        _overLabel.backgroundColor = [UIColor clearColor];
        _overLabel.hidden = YES;
        [self addSubview:_overLabel];
        
        CGRect nameFrame = CGRectMake(15, 5, 197, 18);
        _nmLabel = [[UILabel alloc] initWithFrame:nameFrame];
        _nmLabel.font = [UIFont systemFontOfSize:15.0];
        _nmLabel.backgroundColor = [UIColor clearColor];
        _nmLabel.textColor = [UIColor blackColor];
        _nmLabel.textAlignment = UITextAlignmentLeft;
        [self addSubview:_nmLabel];
        
        CGRect areaFrame = CGRectMake(215, 5, 55, 18);
        _areaLabel = [[UILabel alloc] initWithFrame:areaFrame];
        _areaLabel.font = [UIFont systemFontOfSize:15.0];
        _areaLabel.backgroundColor = [UIColor clearColor];
        _areaLabel.textColor = [UIColor blackColor];
        _areaLabel.textAlignment = UITextAlignmentLeft;
        [self addSubview:_areaLabel];
        
        CGRect typeFrame = CGRectMake(15, 26, 140, 18);
        _paraAndValue0 = [[UILabel alloc] initWithFrame:typeFrame];
        _paraAndValue0.font = [UIFont systemFontOfSize:13.0];
        _paraAndValue0.backgroundColor = [UIColor clearColor];
        _paraAndValue0.textColor = [UIColor grayColor];
        _paraAndValue0.textAlignment = UITextAlignmentLeft;
        [self addSubview:_paraAndValue0];
        
        CGRect para1Frame = CGRectMake(140, 26, 138, 18);
        _para1 = [[UILabel alloc] initWithFrame:para1Frame];
        _para1.font = [UIFont systemFontOfSize:13.0];
        _para1.backgroundColor = [UIColor clearColor];
        _para1.textColor = [UIColor grayColor];
        _para1.textAlignment = UITextAlignmentRight;
        [self addSubview:_para1];
        
    }
    return self;
}

-(void)setValue;
{
    //处理水情的超不超
    if ([_object.isOver isEqualToString:@"1"]) {
        _overLabel.hidden = NO;
        _overLabel.frame = OVERLABEL_OVER_FRAME;
        _nmLabel.frame=NAMELABEL_OVER_FRAME;
        _overLabel.backgroundColor = [UIColor colorWithPatternImage:IMAGE_OVER];
    } else {
        _overLabel.hidden = NO;
        _overLabel.frame = OVERLABEL_NORMAL_FRAME;
        _nmLabel.frame=NAMELABEL_NORMAL_FRAME;
        _overLabel.backgroundColor = [UIColor clearColor];
    }
    
    _nmLabel.text = _object.ennm;
    _areaLabel.text = _object.dsnm;

    _para0.text = [NSString stringWithFormat:@"%@:",_object.para0];
    if ([_object.unit0 isEqualToString:@"万m³"]&&[_object.value0 intValue]>10000) {
        _paraAndValue0.text = [NSString stringWithFormat:@"%@: %.2f 亿m³",_object.para0,[_object.value0 intValue]/10000.0];
    } else if([_object.unit0 isEqualToString:@"m"]&&[_object.value0 intValue]>1000) {
        _paraAndValue0.text = [NSString stringWithFormat:@"%@: %.2f km",_object.para0,[_object.value0 intValue]/1000.0];
    } else if([_object.unit0 isEqualToString:@"m³/s"]&&[_object.value0 intValue]>10000) {
        _paraAndValue0.text = [NSString stringWithFormat:@"%@: %.2f 万m³/s",_object.para0,[_object.value0 intValue]/10000.0];
    } else if([_object.unit0 isEqualToString:@"KW"]&&[_object.value0 intValue]>10000) {
        _paraAndValue0.text = [NSString stringWithFormat:@"%@: %.2f 万KW",_object.para0,[_object.value0 intValue]/10000.0];
    } else {
        _paraAndValue0.text = [NSString stringWithFormat:@"%@: %d %@",_object.para0,[_object.value0 intValue],_object.unit0];
    }
    
    if([_object.para1 isEqualToString:@"正常蓄水位"]||[_object.para1 isEqualToString:@"装机流量"]) {
        _para1.text = [NSString stringWithFormat:@"%@:%.2f%@",_object.para1,[_object.value1 doubleValue],_object.unit1];
    } else {
        _para1.text = [NSString stringWithFormat:@"%@:%.2f%@",_object.para1,[_object.value1 doubleValue],_object.unit1];
    }
}

@end
