/*
 Version 0.1.2
 
 WYPopoverController is available under the MIT license.
 
 Copyright © 2013 Nicolas CHENG
 
 Permission is hereby granted, free of charge, to any person obtaining a copy 
 of this software and associated documentation files (the "Software"), to deal 
 in the Software without restriction, including without limitation the rights 
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
 copies of the Software, and to permit persons to whom the Software is 
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included 
 in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
 PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define WYPOPOVER_DEFAULT_TINT_COLOR            [UIColor colorWithRed:55.f/255.f green:63.f/255.f blue:71.f/255.f alpha:1.f]
#define WYPOPOVER_DEFAULT_OVERLAY_COLOR         [UIColor clearColor]
#define WYPOPOVER_DEFAULT_ANIMATION_DURATION    0.20f
#define WYPOPOVER_MIN_POPOVER_SIZE              CGSizeMake(200, 100)

#define WYPOPOVER_IS_IOS_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define WYPOPOVER_IS_IOS_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define WYPOPOVER_IS_IOS_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define WYPOPOVER_IS_IOS_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define WYPOPOVER_IS_IOS_THAN_OR_EQUAL_TO(v)          ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

typedef NS_OPTIONS(NSUInteger, WYPopoverArrowDirection) {
    WYPopoverArrowDirectionUp = 1UL << 0,
    WYPopoverArrowDirectionDown = 1UL << 1,
    WYPopoverArrowDirectionLeft = 1UL << 2,
    WYPopoverArrowDirectionRight = 1UL << 3,
    WYPopoverArrowDirectionAny = WYPopoverArrowDirectionUp | WYPopoverArrowDirectionDown | WYPopoverArrowDirectionLeft | WYPopoverArrowDirectionRight,
    WYPopoverArrowDirectionUnknown = NSUIntegerMax
};

////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface WYPopoverBackgroundView : UIView
{
}

@property (nonatomic, strong) UIColor *tintColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *strokeColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *fillTopColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *fillBottomColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *glossShadowColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize   glossShadowOffset UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat  glossShadowBlurRadius UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat  borderWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat  arrowBase UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat  arrowHeight UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *outerShadowColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat  outerShadowBlurRadius UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize   outerShadowOffset UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat  outerCornerRadius UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat  minOuterCornerRadius UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *innerShadowColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat  innerShadowBlurRadius UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize   innerShadowOffset UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat  innerCornerRadius UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) UIEdgeInsets viewContentInsets UI_APPEARANCE_SELECTOR;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol WYPopoverControllerDelegate;

@interface WYPopoverController : NSObject
{
}

@property (nonatomic, weak) id <WYPopoverControllerDelegate> delegate;

@property (nonatomic, copy) NSArray *passthroughViews;

@property (nonatomic, assign) BOOL wantsDefaultContentAppearance;
@property (nonatomic, assign) UIEdgeInsets popoverLayoutMargins;
@property (nonatomic, assign, readonly) BOOL isPopoverVisible;
@property (nonatomic, strong, readonly) UIViewController* contentViewController;

- (id)initWithContentViewController:(UIViewController *)viewController;

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(WYPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

- (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(WYPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

- (void)dismissPopoverAnimated:(BOOL)animated;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol WYPopoverControllerDelegate <NSObject>
@optional

- (BOOL)popoverControllerShouldDismiss:(WYPopoverController *)popoverController;
- (void)popoverControllerDidDismiss:(WYPopoverController *)popoverController;

@end

