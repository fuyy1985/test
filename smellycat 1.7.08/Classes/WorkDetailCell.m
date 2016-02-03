//
//  WorkDetailCell.m
//  navag
//
//  Created by GPL on 13-7-26.
//
//

#import "WorkDetailCell.h"

@implementation WorkDetailCell
@synthesize workKeyLabel = _workKeyLabel;
@synthesize workValueLabel = _workValueLabel;
@synthesize workDividorLabel = _workDividorLabel;

@synthesize key = _key;
@synthesize value = _value;
@synthesize isOver = _isOver;

- (void)dealloc
{
    [_workKeyLabel release];
    [_workValueLabel release];
    [_workDividorLabel release];
    
    [_key release];
    [_value release];
    [_isOver release];
    [super dealloc];
}


- (id)initWithHeight:(NSString *)height
{
    self = [super init];
    if (self) {
        //self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TABLECELL_BG"]]
        int finalHeight = [height integerValue];
        UIColor *color = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
        //key
        _workKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 8, 151+23, finalHeight -16)];
        _workKeyLabel.textAlignment = UITextAlignmentLeft;
        [_workKeyLabel setNumberOfLines:0];
        _workKeyLabel.textAlignment = UITextAlignmentLeft;
        _workKeyLabel.lineBreakMode = UILineBreakModeWordWrap;
        _workKeyLabel.backgroundColor = [UIColor clearColor];
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        _workKeyLabel.font = font;
        _workKeyLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_workKeyLabel];
        //value
        _workValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(163+23, 8, 151-23-44, finalHeight -16)];
        [_workValueLabel setNumberOfLines:0];
        _workValueLabel.textAlignment = UITextAlignmentRight;
        _workValueLabel.lineBreakMode = UILineBreakModeWordWrap;
        _workValueLabel.backgroundColor = [UIColor clearColor];
        _workValueLabel.font = font;
        _workValueLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_workValueLabel];
        //dividor
        _workDividorLabel = [[UILabel alloc] initWithFrame:CGRectMake(159+23, 0, 1, finalHeight)];
        _workDividorLabel.backgroundColor = color;
        
        [self.contentView addSubview:_workDividorLabel];
    }
    return self;
}

-(void)setValue;
{
        //设置值
    _workKeyLabel.text = _key;
    _workValueLabel.text = _value;
    
    if ([_isOver isEqualToString:@"1"]) {
        self.contentView.backgroundColor = [UIColor yellowColor];
    }
}

@end
