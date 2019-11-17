//
//  captureViewController.m
//  TT
//
//  Created by fanyin on 2019/11/17.
//  Copyright © 2019 fanyin. All rights reserved.
//

#import "captureViewController.h"
#import "ReactiveObjC.h"
#import "AppDelegate.h"
#import "captureViewAction.h"
#import "captureManager.h"

@interface captureViewController ()
@property (nonatomic, strong) UIView* selectedView;
@end

@implementation captureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//	self.view.backgroundColor = nil;
//	self.view.backgroundColor = [UIColor.redColor alpa]
    // Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
	// 点击选择 view 的手势
	UITapGestureRecognizer *selectionTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sigtap:)];
	[self.view addGestureRecognizer:selectionTapGR];
	
}

- (void)sigtap:(UITapGestureRecognizer *)tap
{
	if (tap.state == UIGestureRecognizerStateRecognized) {
		
		CGPoint tapPointInView = [tap locationInView:self.view];
		CGPoint tapPointInWindow = [self.view convertPoint:tapPointInView toView:nil];
		// Include hidden views in the "viewsAtTapPoint" array so we can show them in the hierarchy list.
//		self.viewsAtTapPoint = [self viewsAtPoint:tapPointInWindow skipHiddenViews:NO];
		
		self.selectedView = [self viewForSelectionAtPoint:tapPointInWindow];
		
		UIColor* c = self.selectedView.backgroundColor ;
		
//		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//			self.selectedView.backgroundColor = c;
//		});
//		self.selectedView.backgroundColor  = UIColor.redColor;
		
		[captureViewAction captureView:self.selectedView];
		
		[self actionForView:self.selectedView];
		
		
		NSLog(@"self.selectedView = %@",self.selectedView);
	}
}

- (void)actionForView:(UIView*)view
{
	Class c = [view class];
	NSLog(@"Class c = %@",c);
	
	NSString *classStr  = NSStringFromClass([view class]);
	NSLog(@"classStr = %@",classStr);
	
	UITableViewCell * cell = [[view superview] superview];
	
	UITableView *table = [[[view superview] superview] superview];
	
	NSIndexPath *indexPath = [table indexPathForCell:cell];

	
	[table performSelector:@selector(_userSelectRowAtPendingSelectionIndexPath:) withObject:indexPath];
	
	
	NSLog(@"123",indexPath);
}



- (UIView *)viewForSelectionAtPoint:(CGPoint)tapPointInWindow
{
	// Select in the window that would handle the touch, but don't just use the result of hitTest:withEvent: so we can still select views with interaction disabled.
	// Default to the the application's key window if none of the windows want the touch.
//	UIWindow *windowForSelection = [[UIApplication sharedApplication] keyWindow];
	
	UIWindow *windowForSelection = [self getWindow];

	
	// Select the deepest visible view at the tap point. This generally corresponds to what the user wants to select.
	return [[self recursivefindSubView:tapPointInWindow inView:windowForSelection findHidden:YES] lastObject];
}


- (UIWindow*)getWindow
{
//	UIWindow *windowForSelection = [[[[[[UIApplication sharedApplication] windows] rac_sequence]
//									  filter:^BOOL(UIWindow*  value) {
//		return value.windowLevel == 10001;
//	}] array] lastObject]  ;
//	return windowForSelection;
	
//	[[UIApplication.sharedApplication windows]
//	 sortedArrayUsingComparator:^NSComparisonResult(UIWindow* obj1, UIWindow* obj2) {
//		 return obj1.windowLevel > obj2.windowLevel ? NSOrderedAscending : NSOrderedDescending;
//	 }];
	
	
	NSArray *windowForSelection = [[[[[[UIApplication sharedApplication] windows] rac_sequence]
									   filter:^BOOL(UIWindow*  value) {
										   return value.windowLevel != campWindowLeve;
									   }] array] sortedArrayUsingComparator:^NSComparisonResult(UIWindow* obj1, UIWindow* obj2) {
										   return obj1.windowLevel > obj2.windowLevel ? NSOrderedAscending : NSOrderedDescending;
									   }];
	
// UIColor* bg = windowForSelection.backgroundColor;
//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//		windowForSelection.backgroundColor = bg;
//	});
//	windowForSelection.backgroundColor = UIColor.redColor;
//
	
	return windowForSelection.firstObject;
	
}


- (NSArray *)viewsAtPoint:(CGPoint)tapPointInWindow skipHiddenViews:(BOOL)skipHidden
{
//	NSMutableArray *views = [NSMutableArray array];
	//    for (UIWindow *window in [PXEViewDebuggerUtility allWindows]) {
	//        // ignore the panel window(tag = 10000)
	//        if (window.tag == PXEViewDebuggerWindowTag) {
	//            break;
	//        }
	//        // Don't include the own window or subviews.
	//        if (window != self.view.window && [window pointInside:tapPointInWindow withEvent:nil]) {
	//            [views addObject:window];
	//            [views addObjectsFromArray:[self recursiveSubviewsAtPoint:tapPointInWindow inView:window skipHiddenViews:skipHidden]];
	//        }
	//    }
	
	
	
//	UIWindow *windowForSelection = [[UIApplication sharedApplication] keyWindow];
//	if (window != self.view.window && [window pointInside:tapPointInWindow withEvent:nil]) {
//		[views addObject:window];
//		[views addObjectsFromArray:[self recursiveSubviewsAtPoint:tapPointInWindow inView:window skipHiddenViews:skipHidden]];
//	}

	
	UIWindow *windowForSelection = [self getWindow];// [[[UIApplication sharedApplication] windows] lastObject];
	
	

	
	NSMutableArray *views = [self recursivefindSubView:tapPointInWindow
	 													   inView:windowForSelection
										   findHidden:skipHidden];
	
	return views;
}



- (NSArray *)recursivefindSubView:(CGPoint)pointInView
							   inView:(UIView *)view
					  findHidden:(BOOL)skipHidden
{
	NSMutableArray *subviewsAtPoint = [NSMutableArray array];
	for (UIView *subview in view.subviews) {
		BOOL isHidden = subview.hidden || subview.alpha < 0.01;
		if (skipHidden && isHidden) {
			continue;
		}
		
		BOOL subviewContainsPoint = CGRectContainsPoint(subview.frame, pointInView);
		if (subviewContainsPoint) {
			[subviewsAtPoint addObject:subview];
		}
		
	
		if (subviewContainsPoint || !subview.clipsToBounds) {
			CGPoint pointInSubview = [view convertPoint:pointInView toView:subview];
			[subviewsAtPoint addObjectsFromArray:[self recursivefindSubView:pointInSubview inView:subview findHidden:skipHidden]];
		}
	}
	return subviewsAtPoint;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
