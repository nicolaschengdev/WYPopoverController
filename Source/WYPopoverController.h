//
//  WYPopoverController.h
//
//  Created by Nicolas CHENG on 13/08/13.
//  Copyright (c) 2013 WHYERS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WYPOPOVER_DEFAULT_TINT_COLOR        [UIColor colorWithRed:55.f/255.f green:63.f/255.f blue:71.f/255.f alpha:1.f]
#define WYPOPOVER_DEFAULT_OVERLAY_COLOR     [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.f]

#define WYPOPOVER_MIN_POPOVER_SIZE          CGSizeMake(200, 100)

typedef NS_OPTIONS(NSUInteger, WYPopoverArrowDirection) {
    WYPopoverArrowDirectionUp = 1UL << 0,
    WYPopoverArrowDirectionDown = 1UL << 1,
    WYPopoverArrowDirectionLeft = 1UL << 2,
    WYPopoverArrowDirectionRight = 1UL << 3,
    WYPopoverArrowDirectionAny = WYPopoverArrowDirectionUp | WYPopoverArrowDirectionDown | WYPopoverArrowDirectionLeft | WYPopoverArrowDirectionRight,
    WYPopoverArrowDirectionUnknown = NSUIntegerMax
};

@interface WYPopoverBackgroundView : UIView <UIAppearance>
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

@property (nonatomic, strong) UIColor *innerShadowColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat  innerShadowBlurRadius UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize   innerShadowOffset UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat  innerCornerRadius UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) UIEdgeInsets viewContentInsets UI_APPEARANCE_SELECTOR;

@end

////////////////////////////////////////////////////////////////////////////////////////

@protocol WYPopoverControllerDelegate;

@interface WYPopoverController : NSObject <UIAppearanceContainer>
{
}

@property (nonatomic, assign) id <WYPopoverControllerDelegate> delegate;

@property (nonatomic, copy) NSArray *passthroughViews;

@property (nonatomic, assign) BOOL wantsDefaultContentAppearance;
@property (nonatomic, assign) UIEdgeInsets popoverLayoutMargins;

@property (nonatomic, assign, readonly) BOOL isPopoverVisible;

- (id)initWithContentViewController:(UIViewController *)viewController;

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(WYPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

- (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(WYPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

- (void)dismissPopoverAnimated:(BOOL)animated;

@end

////////////////////////////////////////////////////////////////////////////////////////

@protocol WYPopoverControllerDelegate <NSObject>
@optional

- (BOOL)popoverControllerShouldDismiss:(WYPopoverController *)popoverController;
- (void)popoverControllerDidDismiss:(WYPopoverController *)popoverController;

@end
