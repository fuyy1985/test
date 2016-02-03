//
//  SSectionHeaderView.m
//  navag
//
//  Created by GPL on 13-11-11.
//
//

#import "SSectionHeaderView.h"
#import <QuartzCore/QuartzCore.h>


@implementation SSectionHeaderView
@synthesize titleLabel = _titleLabel;
@synthesize disclosureButton = _disclosureButton;
@synthesize delegate = _delegate;
@synthesize section = _section;


- (void)dealloc
{
    [_titleLabel release];
    [_disclosureButton release];
    [super dealloc];
}

+(Class)layerClass {
    return [CAGradientLayer class];
}

-(id)initWithFrame:(CGRect)frame title:(NSString*)title section:(NSInteger)sectionNumber delegate:(id <SSectionHeaderViewDelegate>)aDelegate withSigleSignal:(BOOL)signal;
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        // Set up the tap gesture recognizer
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOpen:)];
        [self addGestureRecognizer:tapGesture];
        [tapGesture release];
        _delegate = aDelegate;
        self.userInteractionEnabled = YES;
        //Set BackgroundColor
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TABLESECTION_BG"]];
        // Create and configure the title label
        _section = sectionNumber;
        CGRect titleLabelFrame = self.bounds;
        titleLabelFrame.origin.x += 30.0;
        titleLabelFrame.size.width -= 30.0;
        CGRectInset(titleLabelFrame, 0.0, 5.0);
        _titleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
        _titleLabel.text = title;
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
        // Create and configure the disclosure button.
        _disclosureButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _disclosureButton.frame = CGRectMake(6.0, 8.0, 12.0, 11.0);
        [_disclosureButton setImage:[UIImage imageNamed:@"SECTION_PLUS"] forState:UIControlStateNormal];
        [_disclosureButton setImage:[UIImage imageNamed:@"SECTION_MINUS"] forState:UIControlStateSelected];
        [_disclosureButton addTarget:self action:@selector(toggleOpen:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_disclosureButton];
        //如果说一开始就是一类，那么就展开
        if (signal) {
            _disclosureButton.selected = !_disclosureButton.selected;
        }
    }
    return self;
}

-(IBAction)toggleOpen:(id)sender
{
    [self toggleOpenWithUserAction:YES];
}


-(void)toggleOpenWithUserAction:(BOOL)userAction {
    
    // Toggle the disclosure button state.
    _disclosureButton.selected = !_disclosureButton.selected;
    
    // If this was a user action, send the delegate the appropriate message.
    if (userAction) {
        if (_disclosureButton.selected) {
            if ([_delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
                [_delegate sectionHeaderView:self sectionOpened:_section];
            }
        }
        else {
            if ([_delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
                [_delegate sectionHeaderView:self sectionClosed:_section];
            }
        }
    }
}

@end
