#import "MyMSFlowChart.h"
#import "MyMFlowChart.h"
#import "WaterXMLParser.h"

@implementation MyMSFlowChart
@synthesize data;
@synthesize valueArray,isValueOK,theMaxValue,theMinValue,theZone,numSquare,heightOfSqure;;
@synthesize initialValueArr,specialDictionary;
- (id)initWithFrame:(CGRect)frame withValue:(NSMutableArray *)vArray withSpecial:(WaterCrossProjectInfo *)info{
	if (self = [super initWithFrame:frame]) {
		// Initialization code
		self.backgroundColor=[UIColor whiteColor];
		//initial the coordinate sys array
		data = [[NSMutableArray alloc] init];
		//"警戒水位" OR "汛限水位" (得到真实的数据对象)
		if (sInfo != info) {
			sInfo = info;
		}
		//06-14 01时,22.01_06-14 02时,22.05_06-14 03时,22.5...and so on （坝顶高程、校核洪水位、警戒水位、当前水位）
		if (vArray != valueArray) {
			self.valueArray = vArray;
		}
		
		//the following element is the Error signal
		isValueOK = YES;
		//initial the date and value array ,here we have an agreement that the num of date/value should be '4'
		initialValueArr = [[NSMutableArray alloc] initWithCapacity:4];
		if ([valueArray count]==4) {
			//Value OK；Go on！
			for (int i = 0; i< 4; i++) {
				NSString *temStr = [valueArray objectAtIndex:i];
                [initialValueArr addObject:temStr];
			}
		} else {
			//DEAL WITH THE ERROR
			isValueOK = NO;
		}
		
		//Identify the MAX ,the MIN, the ZONE,the HEIGHTOFSQURE,the NUMSQUARE
		[self getScaleValue:initialValueArr];
		//Convert the data into coordinate sys data
		MFlow_Point *temP = [[MFlow_Point alloc] initWithX:50 Y:46.0];
		[data addObject:temP];
		[temP release];
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
		for(int i=0; i<[initialValueArr count]; i++)
		{
			float waterV = [[initialValueArr objectAtIndex:i] floatValue];
			float y=238.0 - 1.0*heightOfSqure*(1.0*waterV*1000.0 - 1.0*theMinValue)/(1.0*theZone);
			float x=5.5*i+50;
			MFlow_Point *temPoint = [[MFlow_Point alloc] initWithX:x Y:y];
			[data addObject:temPoint];
			[temPoint release];
		}
		[pool release];
	}
	return self;
}


//传入4个值进行计算
- (void)getScaleValue:(NSArray *)temOnlyVArray{
	float theMaxValueF =0;
	float theMinValueF=1000;
	theZone = 1;
	numSquare = 11;
	heightOfSqure = 21.0;
	BOOL isFirstIn = YES;
	
	//first Array;
	if (isValueOK) {
		for (int j = 0; j< [temOnlyVArray count]; j++) {
			//we have an agreement that if the valueStr isequaltostring as "--", abandon it
			NSString *temStr = [temOnlyVArray objectAtIndex:j];
			if ([temStr isEqualToString:@"--"]) {
				continue;
			}
			float temV = [temStr floatValue];
			if (isFirstIn) {
				theMaxValueF = temV;
				theMinValueF = temV;
				isFirstIn = NO;
			} else {
				theMaxValueF = (temV > theMaxValueF)?temV:theMaxValueF;
				theMinValueF = (temV< theMinValueF)?temV:theMinValueF;
			}
		}
	} else {
		//DEAL WITH THE ERROR
		theMaxValueF =10;
		theMinValueF=1;
	}
	
	//if the data is all '--'
	if (isFirstIn) {
		theMaxValueF =10;
		theMinValueF=1;
	}
		
	theMaxValue = theMaxValueF*1000;
	theMinValue = theMinValueF*1000;
	
	int theZoneF = (theMaxValue - theMinValue)/10;
	
	if (theZoneF<=100) {
		theZone = 100;
	}else if (theZoneF>100&&theZoneF<=200) {
		theZone = 200;
	}else if (theZoneF>200&&theZoneF<=500) {
		theZone = 500;
	}else if (theZoneF>500&&theZoneF<=1000) {
		theZone = 1000;
	}else if (theZoneF>1000&&theZoneF<=2000) {
		theZone = 2000;
	}else if (theZoneF>2000&&theZoneF<=5000) {
		theZone = 5000;
	}else if (theZoneF>5000&&theZoneF<=10000) {
		theZone = 10000;
	}else if (theZoneF>10000&&theZoneF<=20000) {
		theZone = 20000;
	}else if (theZoneF>20000&&theZoneF<=40000) {
		theZone = 40000;
	}else if (theZoneF>40000&&theZoneF<=50000) {
		theZone = 50000;
	}else {
		theZone = 80000;
	}
	
	//find the most suitable coordinate system
	int reallyMaxV = ceil(1.0*theMaxValueF*1000/theZone);
	int reallyMinV = floor(1.0*theMinValueF*1000/theZone);
	int reallyHoldSqureNum = reallyMaxV- reallyMinV;
	
	if (theZone == 500) {
		reallyHoldSqureNum+=1;
	}
	
	[self checkHowToSetTheDrawZone:reallyHoldSqureNum];
	
	//in some statement,remove the point of .XX
	int hundredRemainder=theMinValue%1000;
	int tenRemainder = hundredRemainder%100;
	if(theMinValue<0){
		if(theZone==500)
		{
			theMinValue = theMinValue - hundredRemainder-theZone*2;
		} else if (theZone>500) {
			theMinValue = theMinValue - hundredRemainder-theZone;
		}else {
			theMinValue = theMinValue - tenRemainder-theZone;
		}
	}else {
		if(theZone==500){
			theMinValue = theMinValue - abs(hundredRemainder);
		} else if(theZone>500) {
			theMinValue = theMinValue - abs(hundredRemainder);
		} else {
			theMinValue = theMinValue - abs(tenRemainder);
		}
	}
	//while the dagerous line is closed to the bottom line, set the suitable space of the bottom
	if (isValueOK&&((theMinValueF*1000.0)-theMinValue)<theZone)
	{
		if (theZone==500) {
			theMinValue = theMinValue -theMinValue%theZone - theZone*2;
		}else {
			theMinValue = theMinValue -theMinValue%theZone - theZone;
		}
	}else {
		if (theZone==500){
			reallyHoldSqureNum-=1;
			[self checkHowToSetTheDrawZone:reallyHoldSqureNum];
		}
	}
	
	//if the data is all '--'
	if (isFirstIn) {
		theMinValue=0;
	}
}

-(void)checkHowToSetTheDrawZone:(int)temReallyHoldSqureNum{
    if (temReallyHoldSqureNum<=4) {
		numSquare = 6;
		heightOfSqure = 38;
	} else if (temReallyHoldSqureNum==5) {
		numSquare = 7;
		heightOfSqure = 33;
	} else if (temReallyHoldSqureNum==6) {
		numSquare = 8;
		heightOfSqure = 29;
	} else if (temReallyHoldSqureNum==7) {
		numSquare = 9;
		heightOfSqure = 26;
	} else if (temReallyHoldSqureNum==8) {
		numSquare = 10;
		heightOfSqure = 23;
	} else if (temReallyHoldSqureNum==9) {
		numSquare = 11;
		heightOfSqure = 21;
	} else {
		numSquare = 13;
		heightOfSqure = 18;
	}
}

- (void)drawRect:(CGRect)rect {
    //create the context to draw
	CGContextRef context=UIGraphicsGetCurrentContext();
    
    //画整体背景
    CGContextSetRGBFillColor(context, 217.0/255.0, 243.0/255.0, 255.0/255.0, 1.0);
    CGContextAddRect(context, CGRectMake(0, 0, 480, 268));
    CGContextFillPath(context);
    
    //坐标相对原先水位X偏移量
    float coordinateX = 50;
    //坐标相对原先水位Y偏移量
    float coordinateY = -44;  //这个坐标值是指heightOfSqure和topReferenceLinePlus变化时相对移动的距离
    //当前点
    MFlow_Point *nowPoint = [data objectAtIndex:4];
    //坝顶高程
    MFlow_Point *damPoint = [data objectAtIndex:1];
    //警戒水位
    MFlow_Point *jjPoint = [data objectAtIndex:3];
    //校核洪水位
    MFlow_Point *xxhsPoint = [data objectAtIndex:2];
    
    //当前水位覆盖 改色
    CGContextSetRGBFillColor(context, 78.0/255.0, 216.0/255.0, 255.0/255.0, 1.0);
    CGContextAddRect(context, CGRectMake(50.0+coordinateX, nowPoint.y, 430, 268-nowPoint.y));
    CGContextFillPath(context);
        
    CGPoint leftTopPoint = CGPointMake(50, damPoint.y);
    [self drawPolygon:context inThePoint:leftTopPoint];
    
	//INITIAL POINT(TOP-LEFT,ZERO,BOTTOM-RIGHT)  最高就是大坝顶部
	CGPoint  yArrow = CGPointMake(coordinateX + 50, damPoint.y);
	CGPoint zeroPoint = CGPointMake(coordinateX + 50, 238+30);

	//identify the X-Y Sys line color
	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
	CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
	CGContextSetLineWidth(context, 1);
	
	//draw the Y-->Zero
	CGContextMoveToPoint(context, yArrow.x,yArrow.y);
	CGContextAddLineToPoint(context, zeroPoint.x, zeroPoint.y);
	CGContextClosePath(context);
    
	CGContextStrokePath(context);
    CGContextFillPath(context);
	
	//draw the line which parallel the X
    //topReferenceLinePlus———纠正平行X轴的线
	float topReferenceLinePlus = 0.0;
	if (numSquare==6) {
		topReferenceLinePlus = -3;
	}else if (numSquare==7) {
		topReferenceLinePlus = 0;
	}else if (numSquare==8) {
		topReferenceLinePlus = -1;
	}else if (numSquare==9) {
		topReferenceLinePlus = -3;
	}else if (numSquare==10) {
		topReferenceLinePlus = 1;
	}else if (numSquare==11) {
		topReferenceLinePlus = 0;
	}else if (numSquare==13) {
		topReferenceLinePlus = -3;
	}
	CGContextSetLineWidth(context, 0.3);
	for(int i=0;i<=numSquare;i++){
		CGContextMoveToPoint(context, 47.0+coordinateX, coordinateY+51.0+topReferenceLinePlus+heightOfSqure*i);
		CGContextAddLineToPoint(context, 50.0+coordinateX,coordinateY+51.0+topReferenceLinePlus+heightOfSqure*i);
		CGContextStrokePath(context);
	}
	
	//draw the Y' Value
	int topYInt = (numSquare*theZone+theMinValue);
	float topY = topYInt/1000.0;
	int valueLength = [[NSString stringWithFormat:@"%.1f",topY] length];
	if (valueLength==4) {
		valueLength =7;
	} else if (valueLength==3) {
		valueLength =14;
	}else {
		valueLength = 0;
	}

	for(int i=0;i<(numSquare+1);i++){
		NSString *value;
		//while the value has a simbol of '-'
		float theV = (float)(topY-i*theZone/1000.0);
		int theMinus = 0;
		if(theV<0) theMinus = -6;
		//当刻度高于坝顶高程时
        float coY = coordinateY+45.0+topReferenceLinePlus+heightOfSqure*i;
        if (coY < damPoint.y) {
            continue;
        }
		if((topYInt-i*theZone)==0&&isValueOK==YES)
        {
			[@"0" drawAtPoint:CGPointMake(24.0+valueLength+theMinus+coordinateX,coY) withFont:[UIFont boldSystemFontOfSize:11]];
        }
		
		if(numSquare!=6&&numSquare!=8&&numSquare!=10&&i%2==0)continue;
		if(numSquare==8&&i%2!=0)continue;
		if(numSquare==10&&i%2!=0)continue;
		if (theZone>=500&&theMinValue%1000==0) {
			value = [NSString stringWithFormat:@"%d",(int)(topY-i*theZone/1000.0)];
			if ([value isEqualToString:@"0"]==NO||isValueOK==NO) {
				[value drawAtPoint:CGPointMake(24.0+valueLength+theMinus+coordinateX,coY) withFont:[UIFont systemFontOfSize:11]];
			}
		}else {
			value = [NSString stringWithFormat:@"%.1f",(float)(topY-i*theZone/1000.0)];
			if ([value isEqualToString:@"0.0"]==NO && [value isEqualToString:@"-0.0"]==NO) {
				[value drawAtPoint:CGPointMake(14+valueLength+theMinus+coordinateX,coY) withFont:[UIFont systemFontOfSize:11]];
			}
		}
	}
		
    //不循环了
    //画顶部坝顶高程处覆盖
    CGContextSetRGBFillColor(context, 217.0/255.0, 243.0/255.0, 255.0/255.0, 1.0);
    CGContextAddRect(context, CGRectMake(0, 0, 480, damPoint.y-1));
    CGContextFillPath(context);
    //全局位置
    float bdgcBeginX = 55;
    float xxswBeginX = 125;
    float dqswBeginX = 360;
    //坝顶高程
    CGContextSetRGBFillColor(context, 0,0,0, 1.0);
    NSString *bdgc= [NSString stringWithFormat:@"%@ m",sInfo.bdgc];
    [bdgc drawAtPoint:CGPointMake(bdgcBeginX,damPoint.y-15) withFont:[UIFont boldSystemFontOfSize:11]];
    //材料类型、结构类型
    NSString *bxString = [NSString stringWithFormat:@"%@/%@",sInfo.bxcl,sInfo.bxjg];
    [bxString drawAtPoint:CGPointMake(bdgcBeginX-35,252) withFont:[UIFont boldSystemFontOfSize:11]];
    if (sInfo.jjsw !=nil ) {
        //汛限水位   红色
        CGContextSetRGBStrokeColor(context, 1 ,0 ,0, 1);
        CGContextSetLineWidth(context, 0.7);
        CGContextMoveToPoint(context, 37.0+coordinateX, jjPoint.y);
        CGContextAddLineToPoint(context, 480, jjPoint.y);
        CGContextStrokePath(context);
        //汛限水位标注
        [self drawDangerousLine:context inThePoint:CGPointMake(xxswBeginX, jjPoint.y)];
        //RED TOP_RIGHT VALUE
        CGContextSetRGBFillColor(context, 1,0,0, 1.0);
        NSString *xxsw= [NSString stringWithFormat:@"%@ (汛限水位)",sInfo.jjsw];
        [xxsw drawAtPoint:CGPointMake(xxswBeginX+7,jjPoint.y-13) withFont:[UIFont boldSystemFontOfSize:11]];
    }
    if (sInfo.xhhsw !=nil) {
        //校核洪水位 黄色   255
        CGContextSetRGBStrokeColor(context, 1,0,0,1);
        CGContextSetLineWidth(context, 0.7);
        CGContextMoveToPoint(context, 37.0+coordinateX, xxhsPoint.y);
        CGContextAddLineToPoint(context, 245, xxhsPoint.y);
        CGContextStrokePath(context);
        //校核洪水位标注
        [self drawXHHSWLine:context inThePoint:CGPointMake(xxswBeginX, xxhsPoint.y)];
        //RED TOP_RIGHT VALUE
        CGContextSetRGBFillColor(context, 1,0,0,1);
        NSString *xhhsw= [NSString stringWithFormat:@"%@ (校核洪水位)",sInfo.xhhsw];
        [xhhsw drawAtPoint:CGPointMake(xxswBeginX+7,xxhsPoint.y-13) withFont:[UIFont boldSystemFontOfSize:11]];
    }
    //当前水位标注   深蓝色(前面画了)
    [self drawDQSWLine:context inThePoint:CGPointMake(dqswBeginX, nowPoint.y)];
    //RED TOP_RIGHT VALUE
    CGContextSetRGBFillColor(context, 0,0,1, 1.0);
    NSArray *timeArray = [sInfo.cjsj componentsSeparatedByString:@"-"];
    NSString *timeVergin = [timeArray objectAtIndex:2];
    NSString *timeFinal = [timeVergin stringByReplacingOccurrencesOfString:@" " withString:@"日"];
    float dqswFloat = [sInfo.dqsw floatValue];
    float jjswFloat = [sInfo.jjsw floatValue];
    NSString *showCase;
    if (sInfo.jjsw != nil) {
        //还是蓝色 改色 黑
        CGContextSetRGBFillColor(context, 0,0,0, 1.0);
        [sInfo.dqsw drawAtPoint:CGPointMake(dqswBeginX+7,nowPoint.y-13) withFont:[UIFont boldSystemFontOfSize:11]];
        CGSize dqswSize = [sInfo.dqsw sizeWithFont:[UIFont boldSystemFontOfSize:11]];
        if (dqswFloat > jjswFloat) {
            CGContextSetRGBFillColor(context, 1,0,0, 1.0);
            showCase = [NSString stringWithFormat:@" (+%.2f)",(dqswFloat - jjswFloat)];
        } else {
            showCase = [NSString stringWithFormat:@" (%.2f)",(dqswFloat - jjswFloat)];
        }
        [showCase drawAtPoint:CGPointMake(dqswBeginX+7+dqswSize.width,nowPoint.y-13) withFont:[UIFont boldSystemFontOfSize:11]];
    } else {
        [sInfo.dqsw drawAtPoint:CGPointMake(dqswBeginX+7,nowPoint.y-13) withFont:[UIFont boldSystemFontOfSize:11]];
    }
    CGContextSetRGBFillColor(context, 0,0,0, 1.0);
    NSString *addTime = [NSString stringWithFormat:@"%@时",timeFinal];
    [addTime drawAtPoint:CGPointMake(dqswBeginX+7,nowPoint.y-26) withFont:[UIFont boldSystemFontOfSize:11]];
}

-(void)drawPolygon:(CGContextRef)context inThePoint:(CGPoint)leftTopPoint
{
    float horizonalX = 50;
    float horizonalXX = 40;
    CGContextSetRGBFillColor(context, 224.0/255.0, 192.0/255.0, 145.0/255.0, 1.0);
    CGContextMoveToPoint(context, leftTopPoint.x, leftTopPoint.y);
    CGContextAddLineToPoint(context, leftTopPoint.x + horizonalX, leftTopPoint.y);
    CGContextAddLineToPoint(context, leftTopPoint.x + horizonalX, 268);
    CGContextAddLineToPoint(context, leftTopPoint.x-horizonalXX, 268);
    CGContextAddLineToPoint(context, leftTopPoint.x, leftTopPoint.y);
    CGContextFillPath(context);

    CGContextSetRGBStrokeColor(context, 0,0 ,0, 0.6);
    CGContextSetLineWidth(context, 0.5);
    CGContextMoveToPoint(context, leftTopPoint.x, leftTopPoint.y);
    CGContextAddLineToPoint(context, leftTopPoint.x + horizonalX, leftTopPoint.y);
    CGContextAddLineToPoint(context, leftTopPoint.x + horizonalX, 268);
    CGContextAddLineToPoint(context, leftTopPoint.x-horizonalXX, 268);
    CGContextAddLineToPoint(context, leftTopPoint.x, leftTopPoint.y);
    CGContextStrokePath(context);
}

-(void)drawTheZeroLineForTrangleTime:(CGContextRef)context withCircleK:(int)t inHeight:(float)h isPlus:(float)f{
	//tag line (draw it twice times)
	CGContextSetRGBStrokeColor(context, 0,0 ,0, 1);
	CGContextSetLineWidth(context, 0.3);
	CGContextMoveToPoint(context, 50+5.5*t+f, 238.0);
	CGContextAddLineToPoint(context, 50+5.5*t+f, 51+h);
	CGContextMoveToPoint(context, 50+5.5*t+f, 238.0);
	CGContextAddLineToPoint(context, 50+5.5*t+f, 51+h);
	CGContextStrokePath(context);
}

-(void)drawDangerousLine:(CGContextRef)context inThePoint:(CGPoint)originBottom{
	//origion
	CGPoint originLeft = CGPointMake(originBottom.x-5, originBottom.y-10);
	CGPoint originRight = CGPointMake(originBottom.x+5, originBottom.y-10);
	//draw the line
	CGContextSetRGBStrokeColor(context, 1,0 ,0, 1);
	CGContextSetLineWidth(context, 1);
	CGContextMoveToPoint(context, originBottom.x, originBottom.y);
	CGContextAddLineToPoint(context, originLeft.x, originLeft.y);
	CGContextAddLineToPoint(context, originRight.x, originRight.y);
	CGContextAddLineToPoint(context,originBottom.x,originBottom.y);
	CGContextStrokePath(context);
}

-(void)drawXHHSWLine:(CGContextRef)context inThePoint:(CGPoint)originBottom{
	//origion
	CGPoint originLeft = CGPointMake(originBottom.x-5, originBottom.y-10);
	CGPoint originRight = CGPointMake(originBottom.x+5, originBottom.y-10);
	//draw the line
	CGContextSetRGBStrokeColor(context, 1,0,0,1);
	CGContextSetLineWidth(context, 1);
	CGContextMoveToPoint(context, originBottom.x, originBottom.y);
	CGContextAddLineToPoint(context, originLeft.x, originLeft.y);
	CGContextAddLineToPoint(context, originRight.x, originRight.y);
	CGContextAddLineToPoint(context,originBottom.x,originBottom.y);
	CGContextStrokePath(context);
}

-(void)drawDQSWLine:(CGContextRef)context inThePoint:(CGPoint)originBottom{
	//origion
	CGPoint originLeft = CGPointMake(originBottom.x-5, originBottom.y-10);
	CGPoint originRight = CGPointMake(originBottom.x+5, originBottom.y-10);
	//draw the line 改色
	CGContextSetRGBStrokeColor(context, 0,0 ,0, 1);
	CGContextSetLineWidth(context, 1);
	CGContextMoveToPoint(context, originBottom.x, originBottom.y);
	CGContextAddLineToPoint(context, originLeft.x, originLeft.y);
	CGContextAddLineToPoint(context, originRight.x, originRight.y);
	CGContextAddLineToPoint(context,originBottom.x,originBottom.y);
	CGContextStrokePath(context);
}


- (void)dealloc {
	[data release];
	[initialValueArr release];
	[specialDictionary release];
	[super dealloc];
}
@end
