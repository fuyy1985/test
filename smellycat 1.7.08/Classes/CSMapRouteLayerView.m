//
//  CSMapRouteLayerView.m
//  mapLines
//
//  Created by Craig on 4/12/09.
//  Copyright Craig Spitzkoff 2009. All rights reserved.
//

#import "CSMapRouteLayerView.h"
#import <CoreLocation/CoreLocation.h>
#import "typhoonXMLParser.h"
#import "JCImageView.h"

#pragma -
#pragma PIVATE 
@interface CSMapRouteLayerView()
-(void)closeForecastDetailView;
@end

@implementation CSMapRouteLayerView
@synthesize mapView   = _mapView;
@synthesize points    = _points;
@synthesize newTyphoonArray = _newTyphoonArray;
@synthesize foreChinaPoints=_foreChinaPoints;
@synthesize foreHongKongPoints=_foreHongKongPoints;
@synthesize foreTaiWanPoints=_foreTaiWanPoints;
@synthesize foreAmericaPoints=_foreAmericaPoints;
@synthesize foreJapanPoints=_foreJapanPoints;
@synthesize lineColor = _lineColor; 
@synthesize typhoonRings;
@synthesize typhoonForecastV;

-(id) initWithRoute:(NSMutableArray*)Points 
 forNewTyphoonArray:(NSMutableArray *)newTyphoonArray
		  foreChina:(NSMutableArray *)foreChinaPoints 
	   foreHongKong:(NSMutableArray *)foreHongKongPoints
		 foreTaiWan:(NSMutableArray *)foreTaiWanPoints 
		foreAmerica:(NSMutableArray *)foreAmericaPoints 
		  foreJapan:(NSMutableArray *)foreJapanPoints 
			mapView:(MKMapView*)mapView
     withNoNeedMove:(BOOL)needMove;
{
	self = [super initWithFrame:CGRectMake(0, 0, 1024, 696)];
	[self setBackgroundColor:[UIColor clearColor]];
	
	[self setMapView:mapView];
	[self setPoints:Points];
	[self setNewTyphoonArray:newTyphoonArray];
	[self setForeChinaPoints:foreChinaPoints];
	[self setForeHongKongPoints:foreHongKongPoints];
	[self setForeTaiWanPoints:foreTaiWanPoints];
	[self setForeAmericaPoints:foreAmericaPoints];
	[self setForeJapanPoints:foreJapanPoints];

	
	// determine the extents of the trip points that were passed in, and zoom in to that area. 
	CLLocationDegrees maxLat = -90;
	CLLocationDegrees maxLon = -180;
	CLLocationDegrees minLat = 90;
	CLLocationDegrees minLon = 180;
	
	for (int i=0;i<[self.points count]; i++) {
		NSMutableArray *tempSingleArray = [Points objectAtIndex:i]; 
		for(int idx = 0; idx < [tempSingleArray count]; idx++)
		{
			TFPathInfo* pathinfo = [tempSingleArray objectAtIndex:idx];
			if([pathinfo.WD floatValue] > maxLat)
				maxLat = [pathinfo.WD floatValue];
			if([pathinfo.WD floatValue] < minLat)
				minLat = [pathinfo.WD floatValue];
			if([pathinfo.JD floatValue] > maxLon)
				maxLon = [pathinfo.JD floatValue];
			if([pathinfo.JD floatValue] < minLon)
				minLon = [pathinfo.JD floatValue];
		}
		
	}
    
    if (needMove == NO) {
        MKCoordinateRegion region;
        if (maxLat== -90&&maxLon== -180&&minLat== 90&&minLon== 180) {
            region.center.latitude = 49.837982;
            region.center.longitude = 0.000000;
            region.span.latitudeDelta = 139.213562;
            region.span.longitudeDelta = 360.000000;
            
        } else {
            region.center.latitude     = (maxLat + minLat) / 2;
            region.center.longitude    = (maxLon + minLon) / 2;
            region.span.latitudeDelta  = (maxLat - minLat)>25?(maxLat-minLat):25;
            region.span.longitudeDelta = (maxLat - minLat)>40?(maxLat-minLat):40;
        }
        
        [self.mapView setRegion:region];
    }
    
	[self setUserInteractionEnabled:YES];
	[self.mapView addSubview:self];
	
	//init the array
	self.typhoonRings = [[NSMutableArray alloc] init];
    self.typhoonForecastV = [[NSMutableArray alloc] init];
		
	return self;
}


- (void)drawRect:(CGRect)rect
{
	//Remove the All the Rings
	if ([self.typhoonRings count]>0) {
		for (int i=0; i<[self.typhoonRings count]; i++) {
			UIImageView *temIV = [self.typhoonRings objectAtIndex:i];
			[temIV removeFromSuperview];
		}
		[self.typhoonRings removeAllObjects];
	}
    
    //TODO:REMOVE FORECAST DETAIL VIEW
    [self closeForecastDetailView];

    
    //Remove the All the Forecast points
	if ([self.typhoonForecastV count]>0) {
		for (int i=0; i<[self.typhoonForecastV count]; i++) {
			UIImageView *temIV = [self.typhoonForecastV objectAtIndex:i];
			[temIV removeFromSuperview];
		}
		[self.typhoonForecastV removeAllObjects];
	}
	// only draw our lines if we're not int he moddie of a transition and we 
	// acutally have some points to draw. 
	CGContextRef context = UIGraphicsGetCurrentContext(); 
    
    //draw warning lines
    [self drawTwoWarningLines:context];
    
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 0.3);
	if(!self.hidden && nil != self.points && self.points.count > 0)
	{
        /*
         case "中国":
         colorvalue = "#ff0000";
         break;
         */
		[self drawLine:context withPoints:self.foreChinaPoints withLineColor:[UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] withLineWidth:1.5 withDash:YES];
        /*
         case "中国香港":
         colorvalue = "#fe9104";
         break;
         */
		[self drawLine:context withPoints:self.foreHongKongPoints withLineColor:[UIColor colorWithRed:254/255.0 green:145/255.0 blue:4.0/255.0 alpha:1.0] withLineWidth:1.5 withDash:YES];
        /*
         case "中国台湾":
         colorvalue = "#FF00FF";
         break;
         */
        [self drawLine:context withPoints:self.foreTaiWanPoints withLineColor:[UIColor colorWithRed:255/255.0 green:0/255.0 blue:255/255.0 alpha:1.0] withLineWidth:1.5 withDash:YES];
        /*
         case "美国":
         colorvalue = "#11f7f7";
         break;
         */
        [self drawLine:context withPoints:self.foreAmericaPoints withLineColor:[UIColor colorWithRed:17/255.0 green:247/255.0 blue:247/255.0 alpha:1.0] withLineWidth:1.5 withDash:YES];
        /*
         case "日本":
         colorvalue = "#2BBE00";
         break;
         */
		[self drawLine:context withPoints:self.foreJapanPoints withLineColor:[UIColor colorWithRed:43/255.0 green:190/255.0 blue:0/255.0 alpha:1.0] withLineWidth:1.5 withDash:YES];
        //历史路径
		[self drawLine:context withPoints:self.points withLineColor:[UIColor blackColor] withLineWidth:2.0 withDash:NO];

		for (int j=0; j<self.points.count; j++) 
		{
			//20110508 fix bug add if...continue
			NSMutableArray *temarray2 = [self.points objectAtIndex:j];
			if ([temarray2  count]==0) {
				continue;
			}

			TFPathInfo *tf = [temarray2 objectAtIndex:([temarray2 count]-1)];
			CLLocationCoordinate2D location;
			location.latitude = [tf.WD floatValue];
			location.longitude = [tf.JD floatValue];
			CGPoint point = [_mapView convertCoordinate:location toPointToView:self];
			
			CLLocationCoordinate2D location7;
			location7.latitude = location.latitude;
			location7.longitude = location.longitude + [tf.radius7 floatValue]/(111.323*cos(location.latitude*M_PI/180));
			CGPoint point7 = [_mapView convertCoordinate:location7 toPointToView:self];
			[self drawRound:context withBeginP:point withEndP:point7];
			
			CLLocationCoordinate2D location10;
			location10.latitude = location.latitude;
			location10.longitude = location.longitude + [tf.radius10 floatValue]/(111.323*cos(location.latitude*M_PI/180));
			CGPoint point10 = [_mapView convertCoordinate:location10 toPointToView:self];
			[self drawRound:context withBeginP:point withEndP:point10];
			[self drawImage:@"当前点" withPoint:point];
			
			//Draw the activive typhoon name
			TFList *myList = [_newTyphoonArray objectAtIndex:j];
			NSString *typhoonNM = [myList.cNAME length]>0?myList.cNAME:@"未名命";
			NSString *pointTM = [NSString stringWithString:tf.RQSJ2];
			NSRange rM = [pointTM rangeOfString:@"月"];
			NSRange rD = [pointTM rangeOfString:@"日"];
			NSRange rH = [pointTM rangeOfString:@"时"];
			if (rM.length !=1 || rD.length != 1 || rH.length != 1) {
				pointTM = @"暂无时间信息";
			} else {
				pointTM = [pointTM stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
				pointTM = [pointTM stringByReplacingOccurrencesOfString:@"日" withString:@" "];
			}

			CGContextSetRGBFillColor(context,255.0/255, 255.0/255, 255.0/255, 1.0);
			NSString *typhoonTitle = [NSString stringWithFormat:@"%@(%@)",typhoonNM,pointTM];
			[typhoonTitle drawAtPoint:CGPointMake(point.x+20, point.y) withFont:[UIFont systemFontOfSize:14]];
		}
	}
}


-(void) drawLine:(CGContextRef)context withPoints:(NSMutableArray *)Points withLineColor:(UIColor *)mlineColor withLineWidth:(double)mLineWidth withDash:(BOOL)isDash{
	CGContextSetStrokeColorWithColor(context, mlineColor.CGColor);
	CGContextSetLineWidth(context, mLineWidth);
	
	if(isDash)
	{
		const float pattern[2] = {2, 3};
		CGContextSetLineDash(context, 0.0, pattern, 1);
	}
	else
	{
		const float pattern[2] = {0, 0};
		CGContextSetLineDash(context, 0.0, pattern, 0);
	}
	
	for (int i=0;i<Points.count; i++) 
	{
		NSMutableArray *temArray = [Points objectAtIndex:i];
		for(int idx = 0; idx < temArray.count; idx++)
		{
			CLLocationCoordinate2D location;
			
			if ([[temArray objectAtIndex:idx] isKindOfClass:[TFPathInfo class]]) {
				TFPathInfo *tf = [temArray objectAtIndex:idx];
				location.latitude = [tf.WD floatValue];
				location.longitude = [tf.JD floatValue];
			} else if ([[temArray objectAtIndex:idx] isKindOfClass:[TFYBList class]]) {
				TFYBList *tf = [temArray objectAtIndex:idx];
				location.latitude = [tf.wd floatValue];
				location.longitude = [tf.jd floatValue];
			}

			CGPoint point = [_mapView convertCoordinate:location toPointToView:self];
			
			if(idx == 0)
			{
				// move to the first point
				CGContextMoveToPoint(context, point.x, point.y);
			}
			else
			{
				CGContextAddLineToPoint(context, point.x, point.y);
			}

		}

	}
	CGContextStrokePath(context);
	[self drawImages:Points];
}

-(void) drawImages:(NSMutableArray*)Points{
	for (int j=0; j<[Points count]; j++) 
	{
		NSMutableArray *temArray1 = [Points objectAtIndex:j];
		for(int idx = 0; idx < temArray1.count; idx++)
		{
			CLLocationCoordinate2D location;
			NSString *type;
            TFYBList *forecastInfo;
			if ([[temArray1 objectAtIndex:idx] isKindOfClass:[TFPathInfo class]]) {
				TFPathInfo *tf = [temArray1 objectAtIndex:idx];
				location.latitude = [tf.WD floatValue];
				location.longitude = [tf.JD floatValue];
				type = tf.type;
			} else if ([[temArray1 objectAtIndex:idx] isKindOfClass:[TFYBList class]]) {
				forecastInfo = [temArray1 objectAtIndex:idx];
				location.latitude = [forecastInfo.wd floatValue];
				location.longitude = [forecastInfo.jd floatValue];
				type = @"预报";
			}
			CGPoint point = [_mapView convertCoordinate:location toPointToView:self];
			point.x -= 2;
			point.y -= 2;
			if ([type isEqualToString:@"预报"]==YES && idx ==0) {
				//In this case ,do nothing
            }else if ([type isEqualToString:@"预报"]==YES && idx >0){
				[self drawImages:point withForecastInfo:forecastInfo withIndex:idx];
			}else {
				[self drawImage:type withPoint:point];
			}
		}
	}
}

//draw the point except the forecast point
-(void)drawImage:(NSString *)type withPoint:(CGPoint)point{
	
	NSString *symbol=[NSString stringWithString:@"预报_previous.gif"];

	if([type compare:@"热带低压"] == NSOrderedSame){
		symbol=@"热带低压.gif";
	}else if([type compare:@"热带风暴"] == NSOrderedSame){
		symbol=@"热带风暴.gif";
	}else if([type compare:@"强热带风暴"] == NSOrderedSame){
		symbol=@"强热带风暴.gif";
	}else if([type compare:@"台风"] == NSOrderedSame){
		symbol=@"台风.gif";
	}else if([type compare:@"强台风"] == NSOrderedSame){
		symbol=@"强台风.gif";
	}else if([type compare:@"超强台风"] == NSOrderedSame){
		symbol=@"超强台风.gif";
	}else {
		symbol=@"预报_previous.gif";
	}
	
	//animate typhoon	
	if([type compare:@"当前点"] == NSOrderedSame){
		UIImageView *tfImage = [[UIImageView alloc] initWithFrame:CGRectMake(point.x-13, point.y-13, 27, 27)];
		tfImage.animationImages =  [NSArray arrayWithObjects:    
									[UIImage imageNamed:@"typhoon1.png"],
									[UIImage imageNamed:@"typhoon2.png"], nil];
		tfImage.animationDuration = 0.45f;
		tfImage.animationRepeatCount = 0;
		[tfImage startAnimating];
		[self addSubview:tfImage];
		[self.typhoonRings addObject:tfImage];
		[tfImage release];
	} else {
		UIImage *image = [UIImage imageNamed:symbol];
		[image drawAtPoint:point];
	}

}


//draw two warning lines
-(void)drawTwoWarningLines:(CGContextRef)context
{
    /*-SHANGHAI
     24小时坐标点：(34,127), (22,127), (14,110) 
     48小时坐标点：(34,132),(22,132),(14,125),(14,109);
     */
    /*-OFFICIAL
     24小时坐标点：(34,127), (22,127), (15,110) 
     48小时坐标点：(34,132),(22,132),(15,125),(15,110);
     */
    /*-OFFICIAL 2014
     24小时坐标点：(34,127), (22,127), (18,120)，(11,120)，(4.5,113)，(0,105)，
     48小时坐标点：(34,132),(15,132),(0,120),(0,105);
     */
    //TODO: DRAW YELLOW 24 WARNING LINE
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1);
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(34, 127);
    CGPoint point = [_mapView convertCoordinate:location toPointToView:self];
    CGContextMoveToPoint(context, point.x, point.y);
    location = CLLocationCoordinate2DMake(22, 127);
    point = [_mapView convertCoordinate:location toPointToView:self];
    CGContextAddLineToPoint(context, point.x, point.y);
    location = CLLocationCoordinate2DMake(18, 120);
    point = [_mapView convertCoordinate:location toPointToView:self];
    CGContextAddLineToPoint(context, point.x, point.y);
    location = CLLocationCoordinate2DMake(11, 120);
    point = [_mapView convertCoordinate:location toPointToView:self];
    CGContextAddLineToPoint(context, point.x, point.y);
    location = CLLocationCoordinate2DMake(4.5, 113);
    point = [_mapView convertCoordinate:location toPointToView:self];
    CGContextAddLineToPoint(context, point.x, point.y);
    location = CLLocationCoordinate2DMake(0, 105);
    point = [_mapView convertCoordinate:location toPointToView:self];
    CGContextAddLineToPoint(context, point.x, point.y);
    CGContextStrokePath(context);
    
    //TODO: DRAW BLUE 48 WARNING LINE
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1);
    location = CLLocationCoordinate2DMake(34, 132);
    point = [_mapView convertCoordinate:location toPointToView:self];
    CGContextMoveToPoint(context, point.x, point.y);
    location = CLLocationCoordinate2DMake(15, 132);
    point = [_mapView convertCoordinate:location toPointToView:self];
    CGContextAddLineToPoint(context, point.x, point.y);
    location = CLLocationCoordinate2DMake(0, 120);
    point = [_mapView convertCoordinate:location toPointToView:self];
    CGContextAddLineToPoint(context, point.x, point.y);
    location = CLLocationCoordinate2DMake(0, 105);
    point = [_mapView convertCoordinate:location toPointToView:self];
    CGContextAddLineToPoint(context, point.x, point.y);
    CGContextStrokePath(context);
    
    //TODO:DRAW WARNING WORDS
    CGContextSetRGBFillColor(context, 1.0, 1.0, 0.0, 1.0);
    location = CLLocationCoordinate2DMake(29.5, 127);
    point = [_mapView convertCoordinate:location toPointToView:self];
    [@"24小时警戒线" drawInRect:CGRectMake(point.x, point.y, 12, 120) withFont:[UIFont systemFontOfSize:10.0f] lineBreakMode:UILineBreakModeCharacterWrap];
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0); 
    location = CLLocationCoordinate2DMake(29.5, 132);
    point = [_mapView convertCoordinate:location toPointToView:self];
    [@"48小时警戒线" drawInRect:CGRectMake(point.x, point.y, 12, 120) withFont:[UIFont systemFontOfSize:10.0f] lineBreakMode:UILineBreakModeCharacterWrap];
}

-(NSString *)createViewTag:(NSString *)s withTFID:(NSString *)tfId withIndex:(NSInteger)index
{
    //TFID:201101 + TM:11 + USEDINDEX: 101
    NSInteger usedIndex = 100+index;
    if ([s isEqualToString:@"美国"]) {
        return [NSString stringWithFormat:@"%@11%d",tfId,usedIndex];
    } else if ([s isEqualToString:@"日本"]) {
        return [NSString stringWithFormat:@"%@12%d",tfId,usedIndex];
    } else if ([s isEqualToString:@"台湾"]) {
        return [NSString stringWithFormat:@"%@13%d",tfId,usedIndex];
    } else if ([s isEqualToString:@"香港"]) {
        return [NSString stringWithFormat:@"%@14%d",tfId,usedIndex];
    } else if ([s isEqualToString:@"中国"]) {
        return [NSString stringWithFormat:@"%@15%d",tfId,usedIndex];
    } else
        return [NSString stringWithFormat:@"%@10%d",tfId,usedIndex];
}

-(void)drawImages:(CGPoint )point withForecastInfo:(TFYBList *)ybL withIndex:(NSInteger)index
{
    //TODO:Create a test ImageView
    NSString *tmInt = [self createViewTag:ybL.TM withTFID:ybL.tfID withIndex:index];
    JCImageView *myImageView = [[JCImageView alloc] initWithFrame:CGRectMake(point.x-7, point.y-7, 19, 19)];
    [myImageView setYbList:ybL];
    myImageView.image = [UIImage imageNamed:@"预报.gif"];
    myImageView.tag = [tmInt intValue];
    myImageView.userInteractionEnabled = YES;
    myImageView.multipleTouchEnabled = YES;
    
    //TODO:Add the gestures
    UITapGestureRecognizer *tabGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(responseTheTestImageView:)];
    tabGestureRecognizer.numberOfTapsRequired = 1;
    tabGestureRecognizer.numberOfTouchesRequired = 1;
    [myImageView addGestureRecognizer:tabGestureRecognizer];
    [tabGestureRecognizer release];
    
    [self addSubview:myImageView];//ADDSUBIVEW
    [self.typhoonForecastV addObject:myImageView];//ADDARRAY
    [myImageView release];
}

-(void)drawRound:(CGContextRef)context withBeginP:(CGPoint)bP withEndP:(CGPoint)eP{
	float punkR = bP.x-eP.x;
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 0.2);
	CGContextBeginPath(context);
	CGContextAddArc(context, bP.x,bP.y, punkR, 0, 2*M_PI, 1);
	CGContextFillPath(context);
}


-(void) dealloc
{
    [typhoonForecastV release];
	[typhoonRings release];
	[_foreChinaPoints release];
	[_foreHongKongPoints release];
	[_foreTaiWanPoints release];
	[_foreAmericaPoints release];
	[_foreJapanPoints release];
	[_points release];
	[_mapView release];
	[_lineColor release];
	[super dealloc];
}


#pragma -
#pragma UITouchMethods
-(void)responseTheTestImageView:(UIGestureRecognizer *)recognizer{
    JCImageView *jV  = (JCImageView*)recognizer.view;
    CGPoint point = CGPointMake(jV.frame.origin.x+1, jV.frame.origin.y+1);
    TFYBList *l = [jV ybList]; 
    //NSLog(@"Guys,I just make it!%f %f %@ %@ %@ %@",point.x,point.y,l.tfID,l.TM,l.RQSJ2,l.YBSJ);
    //TODO:Create the Detail View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(point.x-90+7, point.y-50+7, 182, 49.5)];
    view.tag = 999999999;
    view.backgroundColor = [UIColor clearColor];

    //prepare for backgroundImageViews
    UIImageView *aV = [[UIImageView alloc] initWithFrame:CGRectMake(80, 39.5, 23, 11)];
    aV.image = [UIImage imageNamed:@"tfshow_arrow.png"];
    [view addSubview:aV];
    [aV release];
    UIImageView *lV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 6, 40)];
    lV.image = [UIImage imageNamed:@"tfshow_left.png"];
    [view addSubview:lV];
    [lV release];
    UIImageView *bV = [[UIImageView alloc] initWithFrame:CGRectMake(6, 0, 145, 40)];
    bV.image = [UIImage imageNamed:@"tfshow_body.png"];
    [view addSubview:bV];
    [bV release];
    UIImageView *rV = [[UIImageView alloc] initWithFrame:CGRectMake(151, 0, 6, 40)];
    rV.image = [UIImage imageNamed:@"tfshow_right.png"];
    [view addSubview:rV];
    [rV release];


    //prepare for lable
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(6, 5, 145, 30)];
    lable.textAlignment = UITextAlignmentCenter;
    lable.font = [UIFont boldSystemFontOfSize:16];
    lable.text = [NSString stringWithFormat:@"%@(%@)",l.RQSJ2,l.TM];
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = [UIColor whiteColor];
    [view addSubview:lable];
    [lable release];

    [self addSubview:view];
    [view release];
}

-(void)closeForecastDetailView
{
    UIView *view = (UIView*)[self viewWithTag:999999999];
    if (view.superview !=nil) {
        [view removeFromSuperview];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    [self closeForecastDetailView];
    
    if ([self checkIfTouchOneForecastV:point]==YES) {
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)checkIfTouchOneForecastV:(CGPoint)p
{
    BOOL isInside = NO;
    for (JCImageView *v in typhoonForecastV) {
        if(CGRectContainsPoint(v.frame, p)==YES)
        {
            isInside = YES;
            break;
        }
    }
    return isInside;
}
@end
