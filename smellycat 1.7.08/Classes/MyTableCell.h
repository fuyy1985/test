//
//  MyTableCell.h
//  GovOfQGJ
//
//  Created by DY-XL on 10-5-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface MyTableCell : UITableViewCell {
	
	NSMutableArray *columns;
	bool hideLine;
}
@property(assign) bool hideLine;
- (void)addColumn:(CGFloat)position;

@end
