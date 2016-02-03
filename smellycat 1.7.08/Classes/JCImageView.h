//
//  JCImageView.h
//  smellycat
//
//  Created by apple on 11-8-19.
//  Copyright 2011Äê Zhejiang Dayu Information Technology Co.,Ltd. All rights reserved.
//

@class TFYBList;
@interface JCImageView : UIImageView 
{
    TFYBList *_ybList;
}
-(TFYBList *)ybList;
-(void)setYbList:(TFYBList*)l;
@end
