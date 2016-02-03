//
//  SectionControlInfo.h
//  navag
//
//  Created by GPL on 13-11-11.
//
//

#import <Foundation/Foundation.h>

@class SSectionHeaderView;
@class SearchSectionInfo;
@interface SectionControlInfo : NSObject {
	
}
@property (assign) BOOL open;
@property (retain) SearchSectionInfo* sectioninfo;
@property (retain) SSectionHeaderView* headerView;
@property (nonatomic,retain,readonly) NSMutableArray *rowHeights;
- (NSUInteger)countOfRowHeights;
- (id)objectInRowHeightsAtIndex:(NSUInteger)idx;
- (void)insertObject:(id)anObject inRowHeightsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRowHeightsAtIndex:(NSUInteger)idx;
- (void)replaceObjectInRowHeightsAtIndex:(NSUInteger)idx withObject:(id)anObject;
- (void)getRowHeights:(id *)buffer range:(NSRange)inRange;
- (void)insertRowHeights:(NSArray *)rowHeightArray atIndexes:(NSIndexSet *)indexes;
- (void)removeRowHeightsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceRowHeightsAtIndexes:(NSIndexSet *)indexes withRowHeights:(NSArray *)rowHeightArray;

@end

