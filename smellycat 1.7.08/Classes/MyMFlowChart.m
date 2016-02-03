#import "MyMFlowChart.h"

@implementation MFlow_Point
@synthesize x,y;
-(id)initWithX:(float)xZ Y:(float)yZ{
	x = xZ;
	y = yZ;
	return self;
}
@end

@implementation MyMFlowChart
@synthesize data,delegate;
@synthesize specialArray,valueArray,isValueOK,theMaxValue,theMinValue,theZone,numSquare,heightOfSqure;;
@synthesize dateValueArr,initialValueArr,specialDictionary;
- (id)initWithFrame:(CGRect)frame withValue:(NSMutableArray *)vArray withSpecial:(NSArray *)sArray{
	if (self = [super initWithFrame:frame]) {
		// Initialization code
		self.backgroundColor=[UIColor whiteColor];
		//initial the coordinate sys array
		data = [[NSMutableArray alloc] init];
		//"警戒水位" OR "汛限水位"
		if (sArray != specialArray) {
			specialArray = sArray;
		}
		//06-14 01时,22.01_06-14 02时,22.05_06-14 03时,22.5...and so on
		if (vArray != valueArray) {
			valueArray = vArray;
		}
		
		//the following element is the Error signal
		isValueOK = YES;
		//initial the date and value array ,here we have an agreement that the num of date/value should be '72'
		initialValueArr = [[NSMutableArray alloc] initWithCapacity:72];
		dateValueArr =[[NSMutableArray alloc] initWithCapacity:72];
		if ([valueArray count]==72) {
			//Value OK；Go on！                  
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
			for (int i = 0; i< 72; i++) {
				NSString *temStr = [valueArray objectAtIndex:i];
				NSArray *temArray = [temStr componentsSeparatedByString:@","];
				if ([temArray count]==2) {
					[initialValueArr addObject:[temArray objectAtIndex:1]];
					[dateValueArr addObject:[temArray objectAtIndex:0]];
				}else {
					//ERROR AND JUMP THE CIRCLE                  
					isValueOK = NO;
					break;
				}
			}
			[pool release];
		} else {
			//DEAL WITH THE ERROR
			isValueOK = NO;
		}
		
		//Prepare for the specialvalue---"警戒水位" OR "汛限水位"
		int totalS = 1;
		specialDictionary = [[NSMutableDictionary alloc] initWithCapacity:totalS];
		for (int i = 0; i<[specialArray count]; i++) {
			NSString *temStr = [specialArray objectAtIndex:i];
			NSArray *temArray = [temStr componentsSeparatedByString:@","];
			if ([temArray count]==2) {
				NSString *specialNM = [temArray objectAtIndex:0];
				NSString *specialV = [temArray objectAtIndex:1];
				if ([specialNM isEqualToString:@"汛限水位"]) {
					[specialDictionary setObject:specialV forKey:specialNM];
					break;
				} else if([specialNM isEqualToString:@"警戒水位"])  {
					[specialDictionary setObject:specialV forKey:specialNM];
					break;
				}
			}
		}
		NSArray *specialOnlyValueArr = [specialDictionary allValues];
		
		//Identify the MAX ,the MIN, the ZONE,the HEIGHTOFSQURE,the NUMSQUARE
		[self getScaleValue:initialValueArr withTheSArray:specialOnlyValueArr];
		
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

- (void)getScaleValue:(NSArray *)temOnlyVArray withTheSArray:(NSArray *)temOnlySArray{
	float theMaxValueF =0;
	float theMinValueF=1000;
	theZone = 1;
	numSquare = 11;
	heightOfSqure = 17.0;
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
	
	//second Array——We have an agrement that the special value will have only one object
	float theDangerV =0.0;
	if (isValueOK) {
		for (int j = 0; j< 1; j++) {
			theDangerV = [[temOnlySArray objectAtIndex:j] floatValue];
			if (theDangerV>0) {
				theMaxValueF = theDangerV > theMaxValueF?theDangerV:theMaxValueF;
				theMinValueF = theDangerV< theMinValueF?theDangerV:theMinValueF;
			} else {
				//if this point has not owned the dangerous value, break it!
				break;
			}
		}
	} else {
		//DEAL WITH THE ERROR
		[specialDictionary removeAllObjects];
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
		heightOfSqure = 31;
	} else if (temReallyHoldSqureNum==5) {
		numSquare = 7;
		heightOfSqure = 27;
	} else if (temReallyHoldSqureNum==6) {
		numSquare = 8;
		heightOfSqure = 24;
	} else if (temReallyHoldSqureNum==7) {
		numSquare = 9;
		heightOfSqure = 21;
	} else if (temReallyHoldSqureNum==8) {
		numSquare = 10;
		heightOfSqure = 19;
	} else if (temReallyHoldSqureNum==9) {
		numSquare = 11;
		heightOfSqure = 17;
	} else {
		numSquare = 13;
		heightOfSqure = 14;
	}
}

- (void)drawRect:(CGRect)rect {
	//if data is error, I convert the 0 to the viewcontroller to tell him ,data ERROR
	if(isValueOK==NO)
		[delegate changeTheTitleStatus:self withSignal:0];
	
	//INITIAL POINT(TOP-LEFT,ZERO,BOTTOM-RIGHT) 
	CGPoint  yArrow = CGPointMake(50, 37);
	CGPoint zeroPoint = CGPointMake(50, 238);
	CGPoint xArrow = CGPointMake(459, 238);
	
	//create the context to draw
	CGContextRef context=UIGraphicsGetCurrentContext();
	//identify the X-Y Sys line color
	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
	CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
	CGContextSetLineWidth(context, 1);
	
	//draw the y triangle
	CGContextMoveToPoint(context, yArrow.x-2, yArrow.y+5);
	CGContextAddLineToPoint(context, yArrow.x, yArrow.y);
	CGContextAddLineToPoint(context, yArrow.x+2, yArrow.y+5);
	CGContextFillPath(context);
	//draw the Y-->Zero
	CGContextMoveToPoint(context, yArrow.x,yArrow.y);
	CGContextAddLineToPoint(context, zeroPoint.x, zeroPoint.y);
	CGContextClosePath(context);
	//draw the Zero<--X
	CGContextMoveToPoint(context, xArrow.x, xArrow.y);
	CGContextAddLineToPoint(context, zeroPoint.x, zeroPoint.y);
	//draw theX triangle
	CGContextStrokePath(context);	
	CGContextMoveToPoint(context, xArrow.x-5,xArrow.y-2);
	CGContextAddLineToPoint(context, xArrow.x, xArrow.y);
	CGContextAddLineToPoint(context, xArrow.x-5, xArrow.y+2);
	CGContextFillPath(context);
	//set the unit of the Y in suitable position
	CGContextSetRGBFillColor(context, 0, 0 , 0, 1.0);
	NSString *yR= @"水位(米)";
	[yR drawAtPoint:CGPointMake(12+16,26.0-3) withFont:[UIFont boldSystemFontOfSize:11]];
	
	//draw the line which parallel the X
    //topReferenceLinePlus———纠正平行X轴的线
	float topReferenceLinePlus = 0.0;
	if (numSquare==6) {
		topReferenceLinePlus = 1;
	}else if (numSquare==7) {
		topReferenceLinePlus = -2;
	}else if (numSquare==8) {
		topReferenceLinePlus = -5;
	}else if (numSquare==9) {
		topReferenceLinePlus = -2;
	}else if (numSquare==10) {
		topReferenceLinePlus = -3;
	}else if (numSquare==11) {
		topReferenceLinePlus = -0;
	}else if (numSquare==13) {
		topReferenceLinePlus = 5;
	}
	CGContextSetLineWidth(context, 0.3);
	for(int i=0;i<numSquare;i++){
		CGContextMoveToPoint(context, 50.0, 51.0+topReferenceLinePlus+heightOfSqure*i);
		CGContextAddLineToPoint(context, 446.0,51.0+topReferenceLinePlus+heightOfSqure*i);
		CGContextStrokePath(context);
	}
	
	//draw the line which parallel the Y——画线
	CGContextSetLineWidth(context, 0.3);
	for(int k=0;k<72;k++){	
		if(k%2==0){
			CGContextMoveToPoint(context, 50+5.5*(k+2), 238.0);
			CGContextAddLineToPoint(context, 50+5.5*(k+2), 51+topReferenceLinePlus);
			CGContextStrokePath(context);
		}
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
		
		if((topYInt-i*theZone)==0&&isValueOK==YES)
			[@"0" drawAtPoint:CGPointMake(24.0+valueLength+theMinus,45.0+topReferenceLinePlus+heightOfSqure*i) withFont:[UIFont boldSystemFontOfSize:11]];
		
		if(numSquare!=6&&numSquare!=8&&numSquare!=10&&i%2==0)continue;
		if(numSquare==8&&i%2!=0)continue;
		if(numSquare==10&&i%2!=0)continue;

		//if (theZone>=500&&theMinValue%1000==0&&numSquare!=6) {

		if (theZone>=500&&theMinValue%1000==0) {
			value = [NSString stringWithFormat:@"%d",(int)(topY-i*theZone/1000.0)];
			if ([value isEqualToString:@"0"]==NO||isValueOK==NO) {
				[value drawAtPoint:CGPointMake(24.0+valueLength+theMinus,45.0+topReferenceLinePlus+heightOfSqure*i) withFont:[UIFont systemFontOfSize:11]];
			}
		}else {
			value = [NSString stringWithFormat:@"%.1f",(float)(topY-i*theZone/1000.0)];
			if ([value isEqualToString:@"0.0"]==NO && [value isEqualToString:@"-0.0"]==NO) {
				[value drawAtPoint:CGPointMake(14+valueLength+theMinus,45.0+topReferenceLinePlus+heightOfSqure*i) withFont:[UIFont systemFontOfSize:11]];
			}
		}
	}
	
	//Draw the Special line && Value
	NSString *dangerousNM = @"汛限水位";
	float dangerousLineV = [[specialDictionary objectForKey:@"汛限水位"] floatValue];
	if (dangerousLineV>0?NO:YES) {
		dangerousNM = @"警戒水位";
		dangerousLineV = [[specialDictionary objectForKey:@"警戒水位"] floatValue];
	}
	if(dangerousLineV >0){
		//RED LINE
		CGContextSetRGBStrokeColor(context, 1, 0,0, 1.0); 
		float y=238.0 - 1.0*heightOfSqure*((int)(dangerousLineV*1000.0) - theMinValue)/theZone;
		CGContextSetLineWidth(context, 1.0);
		CGContextMoveToPoint(context,50, y);
		CGContextAddLineToPoint(context,446, y); 
		CGContextStrokePath(context);
		[self drawDangerousLine:context inThePoint:CGPointMake((446-50)/2+50, y)];
		//RED TOP_RIGHT VALUE
		CGContextSetRGBFillColor(context, 0, 0 , 0, 1.0);
		NSString *xxsw= [NSString stringWithFormat:@"%.2f (%@)",dangerousLineV,dangerousNM];
		[xxsw drawAtPoint:CGPointMake((446-50)/2+57,y-13) withFont:[UIFont boldSystemFontOfSize:11]];
	}
	
	//the BOOL isEven to identify the first object's time EVEN or NOT
	BOOL isEven = NO;
	float ifNotEvenPlus = 5.5;
	//if found the latestPoint----NO;
	BOOL hasNotFoundTheLatestPoint = YES;
	//the last useful index or the unkown index
	int nowPointIndex = 1;
	for(int k=0,i=1;k<[dateValueArr count]&&i<[data count];k++,i++){
		NSString *xValue = [self.dateValueArr objectAtIndex:k];
		NSArray *temTArr = [xValue componentsSeparatedByString:@" "];
		
		CGContextSetRGBFillColor(context, 0, 0, 0, 1);
		if ([temTArr count]==2) {			
			NSString *timeValue = [temTArr objectAtIndex:1];
			NSString *eraseTheTime = [timeValue stringByReplacingOccurrencesOfString:@"时" withString:@""];
			int theNumTime = [eraseTheTime intValue];
			//Draw while K==0 OR K== the lastObject
			if(k==0){
				//judge if the firstValue is even
				isEven = theNumTime%2==0?YES:NO;
				ifNotEvenPlus = isEven? 0:ifNotEvenPlus;
			} 
			
			//Find the latest point value and draw it————Title of top center and left side
			if(hasNotFoundTheLatestPoint) {
				NSInteger totalNum = [initialValueArr count];
				NSInteger iUseIndex = totalNum - k-1;
				//Draw the Title of the newest value
				//Judge the latest useful data
				NSString *nowValue;
				NSString *theLatestValue;
				if(iUseIndex >=0){
					nowValue = [initialValueArr objectAtIndex:iUseIndex];
					theLatestValue = [dateValueArr objectAtIndex:iUseIndex];
				}else {
					nowValue = @"--";
					theLatestValue = @"";
					hasNotFoundTheLatestPoint = NO;
				}
				if([nowValue isEqualToString:@"--"]?NO:YES){
					float nowValueF = [nowValue floatValue];
					NSString *xxsw= [NSString stringWithFormat:@"最新水位(%@):",theLatestValue];
					float ifNodangerousPlus = 0.0;
					//Draw the newest value beside the the newest point
					NSString *xxswV;
					if((nowValueF-dangerousLineV)>0&&dangerousLineV>0){
						CGContextSetRGBFillColor(context, 1, 0 , 0, 1.0);
						xxswV= [NSString stringWithFormat:@"%.2f(+%.2f)",nowValueF,(nowValueF-dangerousLineV)];
						ifNodangerousPlus = 0;
					}else if(dangerousLineV==0) {
						CGContextSetRGBFillColor(context, 0, 0 , 1, 1.0);
						xxswV= [NSString stringWithFormat:@"%.2f",nowValueF];
						ifNodangerousPlus = 25;
					} else {
						CGContextSetRGBFillColor(context, 0, 0 , 1, 1.0);
						xxswV= [NSString stringWithFormat:@"%.2f(%.2f)",nowValueF,(nowValueF-dangerousLineV)];
						ifNodangerousPlus = 0;
					}
					[xxswV drawAtPoint:CGPointMake(270+ifNodangerousPlus,24.0-3) withFont:[UIFont boldSystemFontOfSize:14]];
					CGContextSetRGBFillColor(context, 0, 0 , 0, 1.0);
					[xxsw drawAtPoint:CGPointMake(127+ifNodangerousPlus,24.0-3) withFont:[UIFont boldSystemFontOfSize:14]];
					
					//if OK
					hasNotFoundTheLatestPoint = NO;
					//Draw the right side Value
					if(hasNotFoundTheLatestPoint==NO&&(iUseIndex+1)<=([data count]-1))
					{
						NSArray *temTBArray = [theLatestValue componentsSeparatedByString:@" "];
						NSString *temTStr;
						if([temTBArray count]==2){
							temTStr = [temTBArray objectAtIndex:1];
						} else {
							temTStr = @"";
						}
						//draw the value and time
						MFlow_Point *p1=[data objectAtIndex:iUseIndex+1];
						CGContextSetRGBFillColor(context, 0, 0 , 0, 1.0);
						int isCloseToDangerousPlus = 0;
						if(p1.y<58)isCloseToDangerousPlus = 13;
						[temTStr drawAtPoint:CGPointMake(448, p1.y-26+isCloseToDangerousPlus) withFont:[UIFont systemFontOfSize:10]];
						[nowValue drawAtPoint:CGPointMake(448, p1.y-14+isCloseToDangerousPlus) withFont:[UIFont boldSystemFontOfSize:10]];
						
						//draw the point
						CGContextSetRGBFillColor(context,0, 0, 1, 1);
						CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
						CGContextFillEllipseInRect(context, CGRectMake(p1.x-1.8+ifNotEvenPlus, p1.y-1.8, 3.6 , 3.6));
						CGContextStrokePath(context);
					}
				}
			}
			
			CGContextSetRGBFillColor(context,0, 0, 0, 1);
			if(theNumTime%6==0)
			{
				if(theNumTime==0){
					//0时
					[[temTArr objectAtIndex:1] drawAtPoint:CGPointMake(47.5+5.5*k+ifNotEvenPlus,240) withFont:[UIFont systemFontOfSize:11]];
					//06-15
					[[temTArr objectAtIndex:0] drawAtPoint:CGPointMake(47.5+5.5*k+ifNotEvenPlus,253) withFont:[UIFont boldSystemFontOfSize:11]];
					//draw the zeroLine
					[self drawTheZeroLineForTrangleTime:context withCircleK:k inHeight:topReferenceLinePlus isPlus:ifNotEvenPlus];
				}else {
					//others
					float isSmallT = theNumTime<12?46.5:43.5;
					[eraseTheTime drawAtPoint:CGPointMake(isSmallT+5.5*k+ifNotEvenPlus,240) withFont:[UIFont systemFontOfSize:11]];
				}
			}
		} else {
			//If ERROR ,Break the For circle
			break;
		}
		
		//Draw line
		if((i>1&&i<[data count])){
			NSString *temStr0 = [initialValueArr objectAtIndex:nowPointIndex-1];
			NSString *temStr1 = [initialValueArr objectAtIndex:k];
			if([temStr0 isEqualToString:@"--"]==NO){
				if([temStr1 isEqualToString:@"--"]==NO){
					CGContextSetRGBStrokeColor(context, 0 ,0 ,1, 1);
					MFlow_Point *p=[data objectAtIndex:nowPointIndex];
					MFlow_Point *pn=[data objectAtIndex:k+1];
					CGContextSetLineWidth(context, 1.2);
					CGContextMoveToPoint(context, p.x+ifNotEvenPlus, p.y);
					CGContextAddLineToPoint(context, pn.x+ifNotEvenPlus, pn.y);
					CGContextStrokePath(context);
					nowPointIndex = k+1;
				}
			}else {
				nowPointIndex = k;
			}
		}
	}
	
	if(hasNotFoundTheLatestPoint==YES&&isValueOK==YES)
		[delegate changeTheTitleStatus:self withSignal:1];
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
	[dateValueArr release];
	[initialValueArr release];
	[specialDictionary release];
	[super dealloc];
}
@end
