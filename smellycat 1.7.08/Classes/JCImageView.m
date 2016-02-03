//
//  JCImageView.m
//  smellycat
//
//  Created by apple on 11-8-19.
//  Copyright 2011Äê Zhejiang Dayu Information Technology Co.,Ltd. All rights reserved.
//

#import "JCImageView.h"
#import "typhoonXMLParser.h"
#pragma mark -
#pragma mark Private Interface
@interface JCImageView ()
@end

#pragma mark -
@implementation JCImageView

#pragma mark Constructors
- (id) initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
    
    _ybList = [[TFYBList alloc] init];
	
    return self;
}

- (void) dealloc 
{
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors
-(TFYBList *)ybList;
{
    return _ybList;
}
-(void)setYbList:(TFYBList*)l
{
    [l retain];
    [_ybList release];
    _ybList = l;
}
@end
