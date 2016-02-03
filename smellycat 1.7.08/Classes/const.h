/* About Tag
 1、the water list table's tag is 120
 2、the year list table's tag is 111
 3、rainListTable's tag is 112
 4、About yearlistpickview original frame  0,38,363,77
 5、>=250...<10(118,117,116,115,114,113)
 6、the water list_河道－122、水库－121、堰闸－123、潮位－124；
 7、the project list 水库－131、堤防132、海堤（塘）133、水闸134、电站135
 8、addWebScroll-- uiimageview of horn' s tag--- 5678
 9、latestTyphoonInfo local file name——latestTyphoon.plist
 10、the above line data:key-台风、value－NSDictionary
 11、the around list 水库－141 水闸－142 电站－143 海塘－144 堤防－145 泵站－146
 12、aroundTable's tag is 110
 */
//
//  const.h
//  smellycat
//
//  Created by apple on 10-10-30.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "UIDeviceHardWare.h"

//the same as iphone 
#define NUMPAGE 9
#define WORK_NUMPAGE 7
#define ServerMain @"pda.zjwater.gov.cn"
#define ServerBackup @"pda.zjfx.gov.cn"
#define MainServerURLPath @"DataCenterAuth/AuthService.asmx"
#define TMP NSTemporaryDirectory()
#define SYSTEMNM @"浙江实时汛情系统"
#define SYSTEMID @"S0099"
#define VERSIONID @"2.0.05"
#define PUBLICDATE @"2015年05月15日"

#define FMAINSERVER @"http://pdafx1.zjwater.gov.cn/DataCenterAuth/AuthService.asmx"
#define FNAME [[UIDevice currentDevice] name]
#define FMODEL [UIDeviceHardware platformString]
#define FVERSION [UIDeviceHardware platformString]
#define FOPERATIONNUMBER [[UIDevice currentDevice] systemVersion]

#define VERSIONCOUNT @"3"