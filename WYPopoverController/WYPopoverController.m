/*
 Version 0.1.1
 
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

#import "WYPopoverController.h"
#import <objc/runtime.h>

@interface WYPopoverArea : NSObject
{
}

@property (nonatomic, assign) WYPopoverArrowDirection arrowDirection;
@property (nonatomic, assign) CGSize areaSize;
@property (nonatomic, assign, readonly) NSUInteger priority;
@property (nonatomic, assign, readonly) CGFloat value;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark
#pragma mark - WYPopoverArea

@implementation WYPopoverArea

@synthesize arrowDirection;
@synthesize areaSize;
@synthesize priority;
@synthesize value;

- (NSString*)description
{
    NSString* direction = @"";
    
    if (arrowDirection == WYPopoverArrowDirectionUp)
    {
        direction = @"UP";
    }
    else if (arrowDirection == WYPopoverArrowDirectionDown)
    {
        direction = @"DOWN";
    }
    else if (arrowDirection == WYPopoverArrowDirectionLeft)
    {
        direction = @"LEFT";
    }
    else if (arrowDirection == WYPopoverArrowDirectionRight)
    {
        direction = @"RIGHT";
    }
    
    return [NSString stringWithFormat:@"%@ [ %f x %f ]", direction, areaSize.width, areaSize.height];
}

- (NSUInteger)priority
{
    NSUInteger result = 0;
    
    if (arrowDirection == WYPopoverArrowDirectionRight)
    {
        result = 1;
    }
    else if (arrowDirection == WYPopoverArrowDirectionLeft)
    {
        result = 2;
    }
    else if (arrowDirection == WYPopoverArrowDirectionUp)
    {
        result = 3;
    }
    else if (arrowDirection == WYPopoverArrowDirectionDown)
    {
        result = 4;
    }
    
    return result;
}

- (CGFloat)value
{
    CGFloat result = 0;
    
    if (areaSize.width > 0 && areaSize.height > 0)
    {
        CGFloat w1 = ceilf(areaSize.width / 10.0);
        CGFloat h1 = ceilf(areaSize.height / 10.0);
        
        result = (w1 * h1);
    }
    
    return result;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIImage (WYPopover)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark
#pragma mark - UIImage (WYPopover)

@implementation UIImage (WYPopover)

static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color size:CGSizeMake(8, 8) cornerRadius:0];
}

+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius
{
    CGFloat min = edgeSizeFromCornerRadius(cornerRadius);
    
    CGSize minSize = CGSizeMake(min, min);
    
    return [self imageWithColor:color size:minSize cornerRadius:cornerRadius];
}

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)aSize
               cornerRadius:(CGFloat)cornerRadius
{
    CGRect rect = CGRectMake(0, 0, aSize.width, aSize.height);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface WYPopoverInnerView : UIView
{
}

@property (nonatomic, strong) UIColor *strokeColor;

@property (nonatomic, strong) UIColor *gradientTopColor;
@property (nonatomic, strong) UIColor *gradientBottomColor;
@property (nonatomic, assign) CGFloat  gradientHeight;
@property (nonatomic, assign) CGFloat  gradientTopPosition;

@property (nonatomic, strong) UIColor *innerShadowColor;
@property (nonatomic, assign) CGSize   innerShadowOffset;
@property (nonatomic, assign) CGFloat  innerShadowBlurRadius;
@property (nonatomic, assign) CGFloat  innerCornerRadius;

@property (nonatomic, assign) CGFloat  navigationBarHeight;
@property (nonatomic, assign) BOOL     wantsDefaultContentAppearance;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark
#pragma mark - WYPopoverInnerView

@implementation WYPopoverInnerView

@synthesize strokeColor;

@synthesize gradientTopColor;
@synthesize gradientBottomColor;
@synthesize gradientHeight;
@synthesize gradientTopPosition;

@synthesize innerShadowColor;
@synthesize innerShadowOffset;
@synthesize innerShadowBlurRadius;
@synthesize innerCornerRadius;

@synthesize navigationBarHeight;
@synthesize wantsDefaultContentAppearance;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Gradient Declarations
    NSArray* fillGradientColors = [NSArray arrayWithObjects:
                                   (id)gradientTopColor.CGColor,
                                   (id)gradientBottomColor.CGColor, nil];
    CGFloat fillGradientLocations[] = {0, 1};
    CGGradientRef fillGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)fillGradientColors, fillGradientLocations);
    
    //// innerRect Drawing
    CGFloat barHeight = (wantsDefaultContentAppearance == NO) ? navigationBarHeight : 0;
    CGFloat cornerRadius = (wantsDefaultContentAppearance == NO) ? innerCornerRadius : 0;
    
    CGRect innerRect = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + barHeight, CGRectGetWidth(rect) , CGRectGetHeight(rect) - barHeight);
    
    UIBezierPath* rectPath = [UIBezierPath bezierPathWithRect:innerRect];
    
    UIBezierPath* roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:innerRect cornerRadius:cornerRadius];
    
    if (wantsDefaultContentAppearance == NO)
    {
        CGContextSaveGState(context);
        
        [rectPath appendPath:roundedRectPath];
        rectPath.usesEvenOddFillRule = YES;
        [rectPath addClip];
        
        CGContextDrawLinearGradient(context, fillGradient,
                                    CGPointMake(0, -gradientTopPosition),
                                    CGPointMake(0, -gradientTopPosition + gradientHeight),
                                    0);
        
        CGContextRestoreGState(context);
    }

    UIBezierPath* inRoundedRectPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(innerRect, 0.5, 0.5) cornerRadius:cornerRadius];
    
    CGContextSaveGState(context);
    
    if (wantsDefaultContentAppearance == NO)
    {
        [roundedRectPath addClip];
        CGContextSetShadowWithColor(context, innerShadowOffset, innerShadowBlurRadius, innerShadowColor.CGColor);
    }
    
    [self.strokeColor setStroke];
    inRoundedRectPath.lineWidth = 1;
    [inRoundedRectPath stroke];
    CGContextRestoreGState(context);

    CGGradientRelease(fillGradient);
    CGColorSpaceRelease(colorSpace);
}

- (void)dealloc
{
    strokeColor = nil;
    innerShadowColor = nil;
    gradientTopColor = nil;
    gradientBottomColor = nil;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol WYPopoverOverlayViewDelegate;

@interface WYPopoverOverlayView : UIView

@property(nonatomic, assign) id <WYPopoverOverlayViewDelegate> delegate;
@property(nonatomic, assign) BOOL testHits;
@property(nonatomic, unsafe_unretained) NSArray *passthroughViews;

@end


////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark
#pragma mark - WYPopoverOverlayViewDelegate

@protocol WYPopoverOverlayViewDelegate <NSObject>

@optional
- (void)popoverOverlayView:(WYPopoverOverlayView*)overlayView didTouchAtPoint:(CGPoint)point;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark
#pragma mark - WYPopoverOverlayView

@implementation WYPopoverOverlayView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* oneTouch = [touches anyObject];
    //UIView *touchView = [oneTouch view];
    
    //if (touchView == self || [touchView isDescendantOfView:self] == NO)
    {
        if ([self.delegate respondsToSelector:@selector(popoverOverlayView:didTouchAtPoint:)])
        {
            [self.delegate popoverOverlayView:self didTouchAtPoint:[oneTouch locationInView:self]];
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.testHits)
    {
        return NO;
    }
    
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == self)
    {
        self.testHits = YES;
        UIView *superHitView = [self.superview hitTest:point withEvent:event];
        self.testHits = NO;
        
        if ([self isPassthroughView:superHitView])
        {
            return superHitView;
        }
    }
    
    return view;
}

- (BOOL)isPassthroughView:(UIView *)view
{
	if (view == nil)
    {
		return NO;
	}
	
	if ([self.passthroughViews containsObject:view])
    {
		return YES;
	}
	
	return [self isPassthroughView:view.superview];
}

@end


////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface WYPopoverBackgroundView ()
{
    WYPopoverInnerView* innerView;
    CGSize contentSize;
}

@property (nonatomic, assign) WYPopoverArrowDirection arrowDirection;

@property (nonatomic, strong) UIView  *contentView;

@property (nonatomic, assign) CGFloat  arrowOffset;
@property (nonatomic, assign) CGFloat  navigationBarHeight;

@property (nonatomic, assign) BOOL wantsDefaultContentAppearance;

@property (nonatomic, assign, readonly) UIEdgeInsets outerShadowInsets;

- (id)initWithContentSize:(CGSize)contentSize;

- (CGRect)outerRect;
- (CGRect)innerRect;
- (CGRect)arrowRect;

- (CGRect)outerRect:(CGRect)rect arrowDirection:(WYPopoverArrowDirection)aArrowDirection;
- (CGRect)innerRect:(CGRect)rect arrowDirection:(WYPopoverArrowDirection)aArrowDirection;
- (CGRect)arrowRect:(CGRect)rect arrowDirection:(WYPopoverArrowDirection)aArrowDirection;

- (BOOL)isTouchedAtPoint:(CGPoint)point;

- (NSString*)colorToHexString:(UIColor*)color;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark
#pragma mark - WYPopoverBackgroundView

@implementation WYPopoverBackgroundView

@synthesize tintColor;

@synthesize strokeColor;
@synthesize fillTopColor;
@synthesize fillBottomColor;
@synthesize glossShadowColor;
@synthesize glossShadowOffset;
@synthesize glossShadowBlurRadius;
@synthesize borderWidth;
@synthesize arrowBase;
@synthesize arrowHeight;
@synthesize outerShadowColor;
@synthesize outerShadowBlurRadius;
@synthesize outerShadowOffset;
@synthesize outerCornerRadius;
@synthesize innerShadowColor;
@synthesize innerShadowBlurRadius;
@synthesize innerShadowOffset;
@synthesize innerCornerRadius;
@synthesize viewContentInsets;

@synthesize arrowDirection;
@synthesize contentView;
@synthesize arrowOffset;
@synthesize navigationBarHeight;
@synthesize wantsDefaultContentAppearance;
@synthesize outerShadowInsets;

+ (void)load
{
    @autoreleasepool {
        [[self appearance] setTintColor:nil];
        [[self appearance] setArrowBase:42];
        [[self appearance] setArrowHeight:18];
        
        [[self appearance] setStrokeColor:nil];
        [[self appearance] setFillTopColor:nil];
        [[self appearance] setFillBottomColor:nil];
        
        [[self appearance] setGlossShadowColor:nil];
        [[self appearance] setGlossShadowOffset:CGSizeMake(0, 1.5)];
        [[self appearance] setGlossShadowBlurRadius:0];
        
        [[self appearance] setOuterShadowColor:[UIColor colorWithWhite:0 alpha:0.75]];
        [[self appearance] setOuterShadowBlurRadius:8];
        [[self appearance] setOuterShadowOffset:CGSizeMake(0, 2)];
        [[self appearance] setOuterCornerRadius:8];
        
        [[self appearance] setInnerShadowColor:[UIColor colorWithWhite:0 alpha:0.75]];
        [[self appearance] setInnerShadowBlurRadius:2];
        [[self appearance] setInnerShadowOffset:CGSizeMake(0, 1)];
        [[self appearance] setInnerCornerRadius:6];
        
        [[self appearance] setViewContentInsets:UIEdgeInsetsMake(3, 0, 0, 0)];
        
        [[self appearance] setBorderWidth:6];
    }
}

- (id)initWithContentSize:(CGSize)aContentSize
{
    self = [super initWithFrame:CGRectMake(0, 0, aContentSize.width, aContentSize.height)];
    
    if (self != nil)
    {
        contentSize = aContentSize;
        self.autoresizesSubviews = NO;
        self.backgroundColor = [UIColor clearColor];
        
        self.arrowDirection = WYPopoverArrowDirectionDown;
        self.arrowOffset = 0;
        self.navigationBarHeight = 0;
    }
    
    return self;
}

- (UIEdgeInsets)outerShadowInsets
{
    UIEdgeInsets result = UIEdgeInsetsMake(outerShadowBlurRadius, outerShadowBlurRadius, outerShadowBlurRadius, outerShadowBlurRadius);
    
    result.top -= self.outerShadowOffset.height;
    result.bottom += self.outerShadowOffset.height;
    result.left -= self.outerShadowOffset.width;
    result.right += self.outerShadowOffset.width;
    
    return result;
}

- (void)setArrowOffset:(CGFloat)value
{
    CGFloat coef = 1;
    
    if (value != 0)
    {
        coef = value / ABS(value);
        
        value = ABS(value);
        
        CGRect outerRect = [self outerRect];
        
        CGFloat delta = self.outerCornerRadius + self.arrowBase / 2;
        
        outerRect = CGRectInset(outerRect, delta, delta);
        
        if (arrowDirection == WYPopoverArrowDirectionUp || arrowDirection == WYPopoverArrowDirectionDown)
        {
            value += coef * self.outerShadowOffset.width;
            value = MIN(value, CGRectGetWidth(outerRect) / 2);
        }
        
        if (arrowDirection == WYPopoverArrowDirectionLeft || arrowDirection == WYPopoverArrowDirectionRight)
        {
            value += coef * self.outerShadowOffset.height;
            value = MIN(value, CGRectGetHeight(outerRect) / 2);
        }
    }
    else
    {
        if (arrowDirection == WYPopoverArrowDirectionUp || arrowDirection == WYPopoverArrowDirectionDown)
        {
            value += self.outerShadowOffset.width;
        }
        
        if (arrowDirection == WYPopoverArrowDirectionLeft || arrowDirection == WYPopoverArrowDirectionRight)
        {
            value += self.outerShadowOffset.height;
        }
    }
    
    arrowOffset = value * coef;
}

- (void)setContentView:(UIView *)value
{
    if (value != contentView)
    {
        contentView = value;
        [self addSubview:contentView];
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize result = size;
    
    result.width += 2 * (borderWidth + outerShadowBlurRadius);
    result.height += borderWidth + 2 * outerShadowBlurRadius;
    
    if (navigationBarHeight == 0)
    {
        result.height += borderWidth;
    }
    
    if (arrowDirection == WYPopoverArrowDirectionUp || arrowDirection == WYPopoverArrowDirectionDown)
    {
        result.height += arrowHeight;
    }
    
    if (arrowDirection == WYPopoverArrowDirectionLeft || arrowDirection == WYPopoverArrowDirectionRight)
    {
        result.width += arrowHeight;
    }
    
    return result;
}

- (void)sizeToFit
{
    CGSize size = [self sizeThatFits:contentSize];
    self.bounds = CGRectMake(0, 0, size.width, size.height);
}

- (void)layoutSubviews
{
    if (contentView == nil) return;
    
    CGRect innerRect = [self innerRect];
    
    contentView.frame = innerRect;
    
    if (innerView == nil)
    {
        innerView = [[WYPopoverInnerView alloc] initWithFrame:innerRect];
        [self addSubview:innerView];
    }
    
    innerView.gradientTopColor = self.fillTopColor;
    innerView.gradientBottomColor = self.fillBottomColor;
    
    innerView.strokeColor = self.strokeColor;
    
    innerView.innerShadowColor = innerShadowColor;
    innerView.innerShadowOffset = innerShadowOffset;
    innerView.innerCornerRadius = self.innerCornerRadius;
    innerView.innerShadowBlurRadius = innerShadowBlurRadius;
    
    innerView.navigationBarHeight = navigationBarHeight;
    innerView.gradientHeight = self.frame.size.height - 2 * outerShadowBlurRadius;
    innerView.gradientTopPosition = contentView.frame.origin.y - self.outerShadowInsets.top;
    
    innerView.wantsDefaultContentAppearance = wantsDefaultContentAppearance;
    
    [self bringSubviewToFront:innerView];
    
    innerView.frame = innerRect;
    
    
    
    [innerView setNeedsDisplay];
}

#pragma mark Overrides

- (CGFloat)innerCornerRadius
{
    CGFloat result = innerCornerRadius;
    
    if (borderWidth == 0)
    {
        result = 0;
    }
    
    return result;
}

- (CGSize)outerShadowOffset
{
    CGSize result = outerShadowOffset;
    
    result.width = MIN(result.width, outerShadowBlurRadius);
    result.height = MIN(result.height, outerShadowBlurRadius);
    
    return result;
}

- (UIColor*)strokeColor
{
    UIColor* result = strokeColor;
    
    if (result == nil)
    {
        UIColor *baseColor = self.fillTopColor;
        
        CGFloat baseColorRGBA[4];
        [baseColor getRed: &baseColorRGBA[0] green: &baseColorRGBA[1] blue: &baseColorRGBA[2] alpha: &baseColorRGBA[3]];
        
        result = [UIColor colorWithRed: (baseColorRGBA[0] * 0.7) green: (baseColorRGBA[1] * 0.7) blue: (baseColorRGBA[2] * 0.7) alpha: 1];
    }
    
    return result;
}

- (UIColor*)glossShadowColor
{
    UIColor* result = glossShadowColor;
    
    if (result == nil)
    {
        UIColor *baseColor = self.fillTopColor;
        
        CGFloat baseColorRGBA[4];
        [baseColor getRed: &baseColorRGBA[0] green: &baseColorRGBA[1] blue: &baseColorRGBA[2] alpha: &baseColorRGBA[3]];
        
        result = [UIColor colorWithRed: (baseColorRGBA[0] * 0.3 + 0.7) green: (baseColorRGBA[1] * 0.3 + 0.7) blue: (baseColorRGBA[2] * 0.3 + 0.7) alpha: 0.5];
    }
    
    return result;
}

- (UIColor*)fillTopColor
{
    UIColor* result = fillTopColor;
    
    if (result == nil)
    {
        UIColor *baseColor = tintColor;
        
        if (baseColor == nil)
        {
            baseColor = WYPOPOVER_DEFAULT_TINT_COLOR;
        }
        
        result = baseColor;
    }
    
    return result;
}

- (UIColor*)fillBottomColor
{
    UIColor* result = fillBottomColor;
    
    if (result == nil)
    {
        UIColor *baseColor = self.fillTopColor;
        
        CGFloat baseColorHSBA[4];
        [baseColor getHue: &baseColorHSBA[0] saturation: &baseColorHSBA[1] brightness: &baseColorHSBA[2] alpha: &baseColorHSBA[3]];
        
        result = [UIColor colorWithHue: baseColorHSBA[0] saturation: baseColorHSBA[1] brightness: 0.3 alpha:1];
    }
    
    return result;
}

#pragma mark Drawing

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Gradient Declarations
    NSArray* fillGradientColors = [NSArray arrayWithObjects:
                                   (id)self.fillTopColor.CGColor,
                                   (id)self.fillBottomColor.CGColor, nil];
    CGFloat fillGradientLocations[] = {0, 1};
    CGGradientRef fillGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)fillGradientColors, fillGradientLocations);
    
    // Frames
    CGRect outerRect = [self outerRect:rect arrowDirection:self.arrowDirection];
    outerRect = CGRectInset(outerRect, 0.5, 0.5);
    
    // Inner Path
    CGMutablePathRef outerPathRef = CGPathCreateMutable();
    
    CGPathMoveToPoint(outerPathRef, NULL, CGRectGetMinX(outerRect) + outerCornerRadius, CGRectGetMinY(outerRect));
    
    if (arrowDirection == WYPopoverArrowDirectionUp)
    {
        CGPathAddLineToPoint(outerPathRef, NULL, CGRectGetMidX(outerRect) + arrowOffset - arrowBase / 2, CGRectGetMinY(outerRect));
        CGPathAddLineToPoint(outerPathRef, NULL, CGRectGetMidX(outerRect) + arrowOffset, CGRectGetMinY(outerRect) - arrowHeight);
        CGPathAddLineToPoint(outerPathRef, NULL, CGRectGetMidX(outerRect) + arrowOffset + arrowBase / 2, CGRectGetMinY(outerRect));
        
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMaxX(outerRect), CGRectGetMinY(outerRect), CGRectGetMaxX(outerRect), CGRectGetMaxY(outerRect), outerCornerRadius);
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMaxX(outerRect), CGRectGetMaxY(outerRect), CGRectGetMinX(outerRect), CGRectGetMaxY(outerRect), outerCornerRadius);
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMinX(outerRect), CGRectGetMaxY(outerRect), CGRectGetMinX(outerRect), CGRectGetMinY(outerRect), outerCornerRadius);
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMinX(outerRect), CGRectGetMinY(outerRect), CGRectGetMaxX(outerRect), CGRectGetMinY(outerRect), outerCornerRadius);
    }
    
    if (arrowDirection == WYPopoverArrowDirectionDown)
    {
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMaxX(outerRect), CGRectGetMinY(outerRect), CGRectGetMaxX(outerRect), CGRectGetMaxY(outerRect), outerCornerRadius);
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMaxX(outerRect), CGRectGetMaxY(outerRect), CGRectGetMinX(outerRect), CGRectGetMaxY(outerRect), outerCornerRadius);
        
        CGPathAddLineToPoint(outerPathRef, NULL, CGRectGetMidX(outerRect) + arrowOffset + arrowBase / 2, CGRectGetMaxY(outerRect));
        CGPathAddLineToPoint(outerPathRef, NULL, CGRectGetMidX(outerRect) + arrowOffset, CGRectGetMaxY(outerRect) + arrowHeight);
        CGPathAddLineToPoint(outerPathRef, NULL, CGRectGetMidX(outerRect) + arrowOffset - arrowBase / 2, CGRectGetMaxY(outerRect));
        
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMinX(outerRect), CGRectGetMaxY(outerRect), CGRectGetMinX(outerRect), CGRectGetMinY(outerRect), outerCornerRadius);
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMinX(outerRect), CGRectGetMinY(outerRect), CGRectGetMaxX(outerRect), CGRectGetMinY(outerRect), outerCornerRadius);
    }
    
    if (arrowDirection == WYPopoverArrowDirectionLeft)
    {
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMaxX(outerRect), CGRectGetMinY(outerRect), CGRectGetMaxX(outerRect), CGRectGetMaxY(outerRect), outerCornerRadius);
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMaxX(outerRect), CGRectGetMaxY(outerRect), CGRectGetMinX(outerRect), CGRectGetMaxY(outerRect), outerCornerRadius);
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMinX(outerRect), CGRectGetMaxY(outerRect), CGRectGetMinX(outerRect), CGRectGetMinY(outerRect), outerCornerRadius);
        
        CGPathAddLineToPoint(outerPathRef, NULL, CGRectGetMinX(outerRect), CGRectGetMidY(outerRect) + arrowOffset + arrowBase / 2);
        CGPathAddLineToPoint(outerPathRef, NULL, CGRectGetMinX(outerRect) - arrowHeight, CGRectGetMidY(outerRect) + arrowOffset);
        CGPathAddLineToPoint(outerPathRef, NULL, CGRectGetMinX(outerRect), CGRectGetMidY(outerRect) + arrowOffset - arrowBase / 2);
        
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMinX(outerRect), CGRectGetMinY(outerRect), CGRectGetMaxX(outerRect), CGRectGetMinY(outerRect), outerCornerRadius);
    }
    
    if (arrowDirection == WYPopoverArrowDirectionRight)
    {
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMaxX(outerRect), CGRectGetMinY(outerRect), CGRectGetMaxX(outerRect), CGRectGetMaxY(outerRect), outerCornerRadius);
        
        CGPathAddLineToPoint(outerPathRef, NULL, CGRectGetMaxX(outerRect), CGRectGetMidY(outerRect) + arrowOffset - arrowBase / 2);
        CGPathAddLineToPoint(outerPathRef, NULL, CGRectGetMaxX(outerRect) + arrowHeight, CGRectGetMidY(outerRect) + arrowOffset);
        CGPathAddLineToPoint(outerPathRef, NULL, CGRectGetMaxX(outerRect), CGRectGetMidY(outerRect) + arrowOffset + arrowBase / 2);
        
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMaxX(outerRect), CGRectGetMaxY(outerRect), CGRectGetMinX(outerRect), CGRectGetMaxY(outerRect), outerCornerRadius);
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMinX(outerRect), CGRectGetMaxY(outerRect), CGRectGetMinX(outerRect), CGRectGetMinY(outerRect), outerCornerRadius);
        CGPathAddArcToPoint(outerPathRef, NULL, CGRectGetMinX(outerRect), CGRectGetMinY(outerRect), CGRectGetMaxX(outerRect), CGRectGetMinY(outerRect), outerCornerRadius);
    }
    
    CGPathCloseSubpath(outerPathRef);
    
    UIBezierPath* outerRectPath = [UIBezierPath bezierPathWithCGPath:outerPathRef];
    
    CGContextSaveGState(context);
    {
        CGContextSetShadowWithColor(context, self.outerShadowOffset, outerShadowBlurRadius, outerShadowColor.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [outerRectPath addClip];
        CGRect outerRectBounds = CGPathGetPathBoundingBox(outerRectPath.CGPath);
        CGContextDrawLinearGradient(context, fillGradient,
                                    CGPointMake(CGRectGetMidX(outerRectBounds), CGRectGetMinY(outerRectBounds)),
                                    CGPointMake(CGRectGetMidX(outerRectBounds), CGRectGetMaxY(outerRectBounds)),
                                    0);
        CGContextEndTransparencyLayer(context);
    }
    CGContextRestoreGState(context);
    
    ////// outerRect Inner Shadow
    CGRect outerRectBorderRect = CGRectInset([outerRectPath bounds], -glossShadowBlurRadius, -glossShadowBlurRadius);
    outerRectBorderRect = CGRectOffset(outerRectBorderRect, -glossShadowOffset.width, -glossShadowOffset.height);
    outerRectBorderRect = CGRectInset(CGRectUnion(outerRectBorderRect, [outerRectPath bounds]), -1, -1);
    
    UIBezierPath* outerRectNegativePath = [UIBezierPath bezierPathWithRect: outerRectBorderRect];
    [outerRectNegativePath appendPath: outerRectPath];
    outerRectNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = glossShadowOffset.width + round(outerRectBorderRect.size.width);
        CGFloat yOffset = glossShadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    glossShadowBlurRadius,
                                    self.glossShadowColor.CGColor);
        
        [outerRectPath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(outerRectBorderRect.size.width), 0);
        [outerRectNegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [outerRectNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    [self.strokeColor setStroke];
    outerRectPath.lineWidth = 1;
    [outerRectPath stroke];
    
    //// Cleanup
    CFRelease(outerPathRef);
    CGGradientRelease(fillGradient);
    CGColorSpaceRelease(colorSpace);
}

#pragma mark Private

- (NSString*)colorToHexString:(UIColor*)color
{
    CGFloat rFloat, gFloat, bFloat, aFloat;
    int r, g, b, a;
    [color getRed:&rFloat green:&gFloat blue:&bFloat alpha:&aFloat];
    
    r = (int)(255.0 * rFloat);
    g = (int)(255.0 * gFloat);
    b = (int)(255.0 * bFloat);
    a = (int)(255.0 * aFloat);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x",r,g,b,a];
}

- (CGRect)outerRect
{
    return [self outerRect:self.bounds arrowDirection:self.arrowDirection];
}

- (CGRect)innerRect
{
    return [self innerRect:self.bounds arrowDirection:self.arrowDirection];
}

- (CGRect)arrowRect
{
    return [self arrowRect:self.bounds arrowDirection:self.arrowDirection];
}

- (CGRect)outerRect:(CGRect)rect arrowDirection:(WYPopoverArrowDirection)aArrowDirection
{
    CGRect result = rect;
    
    if (aArrowDirection == WYPopoverArrowDirectionUp || arrowDirection == WYPopoverArrowDirectionDown)
    {
        result.size.height -= arrowHeight;
        
        if (aArrowDirection == WYPopoverArrowDirectionUp)
        {
            result = CGRectOffset(result, 0, arrowHeight);
        }
    }
    
    if (aArrowDirection == WYPopoverArrowDirectionLeft || arrowDirection == WYPopoverArrowDirectionRight)
    {
        result.size.width -= arrowHeight;
        
        if (aArrowDirection == WYPopoverArrowDirectionLeft)
        {
            result = CGRectOffset(result, arrowHeight, 0);
        }
    }
    
    result = CGRectInset(result, outerShadowBlurRadius, outerShadowBlurRadius);
    result.origin.x -= self.outerShadowOffset.width;
    result.origin.y -= self.outerShadowOffset.height;
    
    return result;
}

- (CGRect)innerRect:(CGRect)rect arrowDirection:(WYPopoverArrowDirection)aArrowDirection
{
    CGRect result = [self outerRect:rect arrowDirection:aArrowDirection];
    
    result.origin.x += borderWidth;
    result.origin.y += 0;
    result.size.width -= 2 * borderWidth;
    result.size.height -= borderWidth;
    
    if (navigationBarHeight == 0 || wantsDefaultContentAppearance)
    {
        result.origin.y += borderWidth;
        result.size.height -= borderWidth;
    }
    
    result.origin.x += viewContentInsets.left;
    result.origin.y += viewContentInsets.top;
    result.size.width = result.size.width - viewContentInsets.left - viewContentInsets.right;
    result.size.height = result.size.height - viewContentInsets.top - viewContentInsets.bottom;
    
    if (borderWidth > 0)
    {
        result = CGRectInset(result, -1, -1);
    }
    
    return result;
}

- (CGRect)arrowRect:(CGRect)rect arrowDirection:(WYPopoverArrowDirection)aArrowDirection
{
    CGRect result = CGRectZero;
    
    if (arrowHeight > 0)
    {
        result.size = CGSizeMake(arrowBase, arrowHeight);
        
        if (aArrowDirection == WYPopoverArrowDirectionLeft || arrowDirection == WYPopoverArrowDirectionRight)
        {
            result.size = CGSizeMake(arrowHeight, arrowBase);
        }
        
        CGRect outerRect = [self outerRect:rect arrowDirection:aArrowDirection];
        
        if (aArrowDirection == WYPopoverArrowDirectionDown)
        {
            result.origin.x = CGRectGetMidX(outerRect) - result.size.width / 2 + arrowOffset;
            result.origin.y = CGRectGetMaxY(outerRect);
        }
        
        if (aArrowDirection == WYPopoverArrowDirectionUp)
        {
            result.origin.x = CGRectGetMidX(outerRect) - result.size.width / 2 + arrowOffset;
            result.origin.y = CGRectGetMinY(outerRect) - result.size.height;
        }
        
        if (aArrowDirection == WYPopoverArrowDirectionRight)
        {
            result.origin.x = CGRectGetMaxX(outerRect);
            result.origin.y = CGRectGetMidY(outerRect) - result.size.height / 2 + arrowOffset;
        }
        
        if (aArrowDirection == WYPopoverArrowDirectionLeft)
        {
            result.origin.x = CGRectGetMinX(outerRect) - result.size.width;
            result.origin.y = CGRectGetMidY(outerRect) - result.size.height / 2 + arrowOffset;
        }
    }
    
    return result;
}

- (BOOL)isTouchedAtPoint:(CGPoint)point
{
    BOOL result = NO;
    
    CGRect outerRect = [self outerRect];
    CGRect arrowRect = [self arrowRect];
    
    result = (CGRectContainsPoint(outerRect, point) || CGRectContainsPoint(arrowRect, point));
    
    return result;
}

#pragma mark Memory Management

- (void)dealloc
{
    contentView = nil;
    innerView = nil;
    
    tintColor = nil;
    strokeColor = nil;
    fillTopColor = nil;
    fillBottomColor = nil;
    glossShadowColor = nil;
    outerShadowColor = nil;
    innerShadowColor = nil;
}

@end


////////////////////////////////////////////////////////////////////////////

@interface WYPopoverController () <WYPopoverOverlayViewDelegate>
{
    UIViewController* viewController;
    CGRect rect;
    UIView* inView;
    WYPopoverOverlayView* overlayView;
    WYPopoverBackgroundView* containerView;
    WYPopoverArrowDirection permittedArrowDirections;
    BOOL animated;
    BOOL generatingDeviceOrientationNotifications;
}

@property (nonatomic, assign) CGFloat           navigationBarHeight;
@property (nonatomic, strong, readonly) UIView *rootView;
@property (nonatomic, assign, readonly) CGRect  rootViewFrame;

- (void)dismissPopoverAnimated:(BOOL)animated callDelegate:(BOOL)callDelegate;

- (WYPopoverArrowDirection)arrowDirectionForRect:(CGRect)aRect
                                          inView:(UIView*)aView
                                     contentSize:(CGSize)contentSize
                                     arrowHeight:(CGFloat)arrowHeight
                        permittedArrowDirections:(WYPopoverArrowDirection)arrowDirections;

- (CGSize)sizeForRect:(CGRect)aRect
               inView:(UIView*)aView
          arrowHeight:(CGFloat)arrowHeight
       arrowDirection:(WYPopoverArrowDirection)arrowDirection;

@end

////////////////////////////////////////////////////////////////////////////

#pragma mark
#pragma mark - WYPopoverController

@implementation WYPopoverController

@synthesize delegate;
@synthesize passthroughViews;
@synthesize wantsDefaultContentAppearance;
@synthesize isPopoverVisible;
@synthesize popoverLayoutMargins;

- (id)initWithContentViewController:(UIViewController *)aViewController
{
    self = [super init];
    
    if (self)
    {
        viewController = aViewController;
        popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    return self;
}

- (BOOL)isPopoverVisible
{
    BOOL result = (overlayView != nil);
    return result;
}

- (UIView *)rootView
{
    UIWindow *result = [[UIApplication sharedApplication] keyWindow];
    
    if (result.subviews.count > 0)
    {
        result = [result.subviews objectAtIndex:0];
    }

    return result;
}

- (CGRect)rootViewFrame
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    UIInterfaceOrientation orienation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGRect result = screenBounds;
    
    CGFloat statusBarHeight = statusBarFrame.size.height;
    
    if (UIDeviceOrientationIsLandscape(orienation))
    {
        result.size.width = screenBounds.size.height;
        result.size.height = screenBounds.size.width;
        statusBarHeight = statusBarFrame.size.width;
    }
    
    result.size.height -= statusBarHeight;
    
    
    UIViewController* rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        result.origin.y = statusBarHeight;
    }
    
    return result;
}

- (void)presentPopover
{    
    CGRect rootViewFrame = self.rootViewFrame;
    
    CGRect viewFrame = [overlayView convertRect:rect fromView:inView];
    
    UIView* contentView = viewController.view;
    CGSize contentViewSize = viewController.contentSizeForViewInPopover;
    
    CGRect containerFrame = CGRectZero;
    CGFloat minX, maxX, minY, maxY = 0;
    CGSize minContainerSize = WYPOPOVER_MIN_POPOVER_SIZE;
    CGFloat offset = 0;
    CGSize containerViewSize = CGSizeZero;
    WYPopoverArrowDirection arrowDirection = WYPopoverArrowDirectionUnknown;
    
    overlayView.frame = rootViewFrame;
    containerView.navigationBarHeight = self.navigationBarHeight;
    containerView.wantsDefaultContentAppearance = wantsDefaultContentAppearance;
    contentView.bounds = CGRectMake(0, 0, contentViewSize.width, contentViewSize.height);
    
    minX = popoverLayoutMargins.left;
    maxX = rootViewFrame.size.width - popoverLayoutMargins.right;
    minY = popoverLayoutMargins.top;
    maxY = rootViewFrame.size.height - popoverLayoutMargins.bottom;
    
    // Which direction ?
    //
    arrowDirection = [self arrowDirectionForRect:rect inView:inView contentSize:contentViewSize arrowHeight:containerView.arrowHeight permittedArrowDirections:permittedArrowDirections];
    
    // Position of the popover
    //
    minX -= containerView.outerShadowInsets.left;
    maxX += containerView.outerShadowInsets.right;
    minY -= containerView.outerShadowInsets.top;
    maxY += containerView.outerShadowInsets.bottom;
    
    if (arrowDirection == WYPopoverArrowDirectionDown)
    {
        containerView.arrowDirection = WYPopoverArrowDirectionDown;
        containerViewSize = [containerView sizeThatFits:contentViewSize];
        
        containerFrame = CGRectZero;
        containerFrame.size = containerViewSize;
        containerFrame.size.width = MIN(maxX - minX, containerFrame.size.width);
        containerFrame.size.height = MIN(maxY - minY, containerFrame.size.height);
        
        containerView.frame = containerFrame;
        
        containerView.center = CGPointMake(viewFrame.origin.x + viewFrame.size.width / 2, viewFrame.origin.y + viewFrame.size.height / 2);
        
        containerFrame = containerView.frame;
        
        offset = 0;
        
        if (containerFrame.origin.x < minX)
        {
            offset = minX - containerFrame.origin.x;
            containerFrame.origin.x = minX;
            offset = -offset;
        }
        else if (containerFrame.origin.x + containerFrame.size.width > maxX)
        {
            offset = (containerView.frame.origin.x + containerView.frame.size.width) - maxX;
            containerFrame.origin.x -= offset;
        }
        
        containerView.arrowOffset = offset;
        offset = containerView.frame.size.height / 2 + viewFrame.size.height / 2 - containerView.outerShadowInsets.bottom;
        
        containerFrame.origin.y -= offset;
        
        if (containerFrame.origin.y < minY)
        {
            offset = minY - containerFrame.origin.y;
            containerFrame.size.height -= offset;
            
            if (containerFrame.size.height < minContainerSize.height)
            {
                // popover is overflowing
                offset -= (minContainerSize.height - containerFrame.size.height);
                containerFrame.size.height = minContainerSize.height;
            }
            
            containerFrame.origin.y += offset;
        }
    }
    
    if (arrowDirection == WYPopoverArrowDirectionUp)
    {
        containerView.arrowDirection = WYPopoverArrowDirectionUp;
        containerViewSize = [containerView sizeThatFits:contentViewSize];
        
        containerFrame = CGRectZero;
        containerFrame.size = containerViewSize;
        containerFrame.size.width = MIN(maxX - minX, containerFrame.size.width);
        containerFrame.size.height = MIN(maxY - minY, containerFrame.size.height);
        
        containerView.frame = containerFrame;
        
        containerView.center = CGPointMake(viewFrame.origin.x + viewFrame.size.width / 2, viewFrame.origin.y + viewFrame.size.height / 2);
        
        containerFrame = containerView.frame;
        
        offset = 0;
        
        if (containerFrame.origin.x < minX)
        {
            offset = minX - containerFrame.origin.x;
            containerFrame.origin.x = minX;
            offset = -offset;
        }
        else if (containerFrame.origin.x + containerFrame.size.width > maxX)
        {
            offset = (containerView.frame.origin.x + containerView.frame.size.width) - maxX;
            containerFrame.origin.x -= offset;
        }
        
        containerView.arrowOffset = offset;
        offset = containerView.frame.size.height / 2 + viewFrame.size.height / 2 - containerView.outerShadowInsets.top;
        
        containerFrame.origin.y += offset;
        
        if (containerFrame.origin.y + containerFrame.size.height > maxY)
        {
            offset = (containerFrame.origin.y + containerFrame.size.height) - maxY;
            containerFrame.size.height -= offset;
            
            if (containerFrame.size.height < minContainerSize.height)
            {
                // popover is overflowing
                containerFrame.size.height = minContainerSize.height;
            }
        }
    }
    
    if (arrowDirection == WYPopoverArrowDirectionRight)
    {
        containerView.arrowDirection = WYPopoverArrowDirectionRight;
        containerViewSize = [containerView sizeThatFits:contentViewSize];
        
        containerFrame = CGRectZero;
        containerFrame.size = containerViewSize;
        containerFrame.size.width = MIN(maxX - minX, containerFrame.size.width);
        containerFrame.size.height = MIN(maxY - minY, containerFrame.size.height);
        
        containerView.frame = containerFrame;
        
        containerView.center = CGPointMake(viewFrame.origin.x + viewFrame.size.width / 2, viewFrame.origin.y + viewFrame.size.height / 2);
        
        containerFrame = containerView.frame;
        
        offset = containerView.frame.size.width / 2 + viewFrame.size.width / 2 - containerView.outerShadowInsets.right;
        
        containerFrame.origin.x -= offset;
        
        if (containerFrame.origin.x < minX)
        {
            offset = minX - containerFrame.origin.x;
            containerFrame.size.width -= offset;
            
            if (containerFrame.size.width < minContainerSize.width)
            {
                // popover is overflowing
                offset -= (minContainerSize.width - containerFrame.size.width);
                containerFrame.size.width = minContainerSize.width;
            }
            
            containerFrame.origin.x += offset;
        }
        
        offset = 0;
        
        if (containerFrame.origin.y < minY)
        {
            offset = minY - containerFrame.origin.y;
            containerFrame.origin.y = minY;
            offset = -offset;
        }
        else if (containerFrame.origin.y + containerFrame.size.height > maxY)
        {
            offset = (containerView.frame.origin.y + containerView.frame.size.height) - maxY;
            containerFrame.origin.y -= offset;
        }
        
        containerView.arrowOffset = offset;
    }
    
    if (arrowDirection == WYPopoverArrowDirectionLeft)
    {
        containerView.arrowDirection = WYPopoverArrowDirectionLeft;
        containerViewSize = [containerView sizeThatFits:contentViewSize];
        
        containerFrame = CGRectZero;
        containerFrame.size = containerViewSize;
        containerFrame.size.width = MIN(maxX - minX, containerFrame.size.width);
        containerFrame.size.height = MIN(maxY - minY, containerFrame.size.height);
        containerView.frame = containerFrame;
        
        containerView.center = CGPointMake(viewFrame.origin.x + viewFrame.size.width / 2, viewFrame.origin.y + viewFrame.size.height / 2);
        
        containerFrame = containerView.frame;
        
        offset = containerView.frame.size.width / 2 + viewFrame.size.width / 2 - containerView.outerShadowInsets.left;
        
        containerFrame.origin.x += offset;
        
        if (containerFrame.origin.x + containerFrame.size.width > maxX)
        {
            offset = (containerFrame.origin.x + containerFrame.size.width) - maxX;
            containerFrame.size.width -= offset;
            
            if (containerFrame.size.width < minContainerSize.width)
            {
                // popover is overflowing
                containerFrame.size.width = minContainerSize.width;
            }
        }
        
        offset = 0;
        
        if (containerFrame.origin.y < minY)
        {
            offset = minY - containerFrame.origin.y;
            containerFrame.origin.y = minY;
            offset = -offset;
        }
        else if (containerFrame.origin.y + containerFrame.size.height > maxY)
        {
            offset = (containerView.frame.origin.y + containerView.frame.size.height) - maxY;
            containerFrame.origin.y -= offset;
        }
        
        containerView.arrowOffset = offset;
    }
    
    containerView.contentView = contentView;
    
    // Set position & Redraw
    //
    containerView.frame = containerFrame;
    
    [containerView setNeedsDisplay];
    [containerView setNeedsLayout];
    
    // default content appearance ?
    //
    if (wantsDefaultContentAppearance == NO)
    {
        if ([viewController isKindOfClass:[UINavigationController class]])
        {
            [((UINavigationController*)viewController).navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
            
            [((UINavigationController*)viewController).navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsLandscapePhone];
        }
    }
    
    if (generatingDeviceOrientationNotifications == NO)
    {
        generatingDeviceOrientationNotifications = YES;
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    
    if (animated)
    {
        containerView.alpha = 0;
        containerView.hidden = NO;
        
        [viewController viewWillAppear:YES];
        
        [UIView animateWithDuration:WYPOPOVER_DEFAULT_ANIMATION_DURATION animations:^{
            containerView.alpha = 1;
        } completion:^(BOOL finished) {
            [viewController viewDidAppear:YES];
        }];
    }
    else
    {
        [viewController viewWillAppear:NO];
        [viewController viewDidAppear:NO];
    }
}

- (void)presentPopoverFromRect:(CGRect)aRect inView:(UIView *)aView permittedArrowDirections:(WYPopoverArrowDirection)arrowDirections animated:(BOOL)aAnimated
{
    NSAssert((arrowDirections != WYPopoverArrowDirectionUnknown), @"WYPopoverArrowDirection must not be UNKNOWN");
    
    rect = aRect;
    inView = aView;
    permittedArrowDirections = arrowDirections;
    animated = aAnimated;
    
    if (overlayView == nil)
    {
        overlayView = [[WYPopoverOverlayView alloc] initWithFrame:self.rootViewFrame];
        overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayView.autoresizesSubviews = NO;
        overlayView.userInteractionEnabled = YES;
        overlayView.backgroundColor = WYPOPOVER_DEFAULT_OVERLAY_COLOR;
        
        overlayView.delegate = self;
        
        overlayView.passthroughViews = passthroughViews;
        [self.rootView addSubview:overlayView];
        
        containerView = [[WYPopoverBackgroundView alloc] initWithContentSize:viewController.contentSizeForViewInPopover];
        containerView.hidden = animated;
        [overlayView addSubview:containerView];
        
        // Workaround => iOS (<6) => wait next run loop in order to get correct UIAPPEARANCE_SELECTOR values
        [self performSelector:@selector(presentPopover) withObject:nil afterDelay:0.0];
    }
    else
    {
        [self presentPopover];
    }
}

- (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(WYPopoverArrowDirection)arrowDirections animated:(BOOL)aAnimated
{
    UIView *itemView = [item valueForKey:@"view"];
    arrowDirections = WYPopoverArrowDirectionDown | WYPopoverArrowDirectionUp;
    [self presentPopoverFromRect:itemView.bounds inView:itemView permittedArrowDirections:arrowDirections animated:aAnimated];
}

- (void)dismissPopoverAnimated:(BOOL)aAnimated
{
    [self dismissPopoverAnimated:aAnimated callDelegate:NO];
}

- (void)dismissPopoverAnimated:(BOOL)aAnimated callDelegate:(BOOL)callDelegate
{
    if (overlayView == nil) return;
    
    void (^completionBlock)(BOOL);
          
    completionBlock = ^(BOOL finished) {
        
        if (generatingDeviceOrientationNotifications == YES)
        {
            generatingDeviceOrientationNotifications = NO;
            
            [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
        }
        
        [containerView removeFromSuperview];
        [overlayView removeFromSuperview];
        containerView = nil;
        overlayView = nil;
        inView = nil;
        viewController = nil;
        passthroughViews = nil;
        
        [viewController viewDidDisappear:aAnimated];
        
        if (callDelegate)
        {
            if (delegate && [delegate respondsToSelector:@selector(popoverControllerDidDismiss:)])
            {
                [delegate popoverControllerDidDismiss:self];
            }
        }
    };
    
    if (aAnimated)
    {
        [viewController viewWillDisappear:YES];
        
        [UIView animateWithDuration:WYPOPOVER_DEFAULT_ANIMATION_DURATION animations:^{
            containerView.alpha = 0;
        } completion:^(BOOL finished) {
            completionBlock(finished);
        }];
    }
    else
    {
        [viewController viewWillDisappear:NO];
        completionBlock(YES);
    }
}

- (CGFloat)navigationBarHeight
{
    CGFloat result = 0;
    
    if ([viewController isKindOfClass:[UINavigationController class]])
    {        
        UINavigationController* navigationController = (UINavigationController*)viewController;
        result = navigationController.navigationBar.bounds.size.height;
    }
    
    return result;
}

#pragma mark WYPopoverOverlayViewDelegate

- (void)popoverOverlayView:(WYPopoverOverlayView*)aOverlayView didTouchAtPoint:(CGPoint)aPoint
{
    BOOL isTouched = [containerView isTouchedAtPoint:[containerView convertPoint:aPoint fromView:aOverlayView]];
    
    if (!isTouched && delegate && [delegate respondsToSelector:@selector(popoverControllerShouldDismiss:)])
    {
        BOOL shouldDismiss = [delegate popoverControllerShouldDismiss:self];
        
        if (shouldDismiss)
        {
            [self dismissPopoverAnimated:animated callDelegate:YES];
        }
    }
}

#pragma mark Private

- (WYPopoverArrowDirection)arrowDirectionForRect:(CGRect)aRect
                                          inView:(UIView*)aView
                                     contentSize:(CGSize)contentSize
                                     arrowHeight:(CGFloat)arrowHeight
                        permittedArrowDirections:(WYPopoverArrowDirection)arrowDirections
{
    WYPopoverArrowDirection result = WYPopoverArrowDirectionUnknown;
    
    NSMutableArray* areas = [NSMutableArray arrayWithCapacity:0];
    WYPopoverArea* area;
    
    if ((arrowDirections & WYPopoverArrowDirectionDown) == WYPopoverArrowDirectionDown)
    {
        area = [[WYPopoverArea alloc] init];
        area.areaSize = [self sizeForRect:aRect inView:aView arrowHeight:arrowHeight arrowDirection:WYPopoverArrowDirectionDown];
        area.arrowDirection = WYPopoverArrowDirectionDown;
        [areas addObject:area];
    }
    
    if ((arrowDirections & WYPopoverArrowDirectionUp) == WYPopoverArrowDirectionUp)
    {
        area = [[WYPopoverArea alloc] init];
        area.areaSize = [self sizeForRect:aRect inView:aView arrowHeight:arrowHeight arrowDirection:WYPopoverArrowDirectionUp];
        area.arrowDirection = WYPopoverArrowDirectionUp;
        [areas addObject:area];
    }
    
    if ((arrowDirections & WYPopoverArrowDirectionLeft) == WYPopoverArrowDirectionLeft)
    {
        area = [[WYPopoverArea alloc] init];
        area.areaSize = [self sizeForRect:aRect inView:aView arrowHeight:arrowHeight arrowDirection:WYPopoverArrowDirectionLeft];
        area.arrowDirection = WYPopoverArrowDirectionLeft;
        [areas addObject:area];
    }
    
    if ((arrowDirections & WYPopoverArrowDirectionRight) == WYPopoverArrowDirectionRight)
    {
        area = [[WYPopoverArea alloc] init];
        area.areaSize = [self sizeForRect:aRect inView:aView arrowHeight:arrowHeight arrowDirection:WYPopoverArrowDirectionRight];
        area.arrowDirection = WYPopoverArrowDirectionRight;
        [areas addObject:area];
    }
    
    NSIndexSet* indexes = [areas indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        WYPopoverArea* area = (WYPopoverArea*)obj;
        
        BOOL result = (area.areaSize.width > 0 && area.areaSize.height > 0);
        
        return result;
    }];
    
    areas = [NSMutableArray arrayWithArray:[areas objectsAtIndexes:indexes]];
    
    [areas sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        WYPopoverArea* area1 = (WYPopoverArea*)obj1;
        WYPopoverArea* area2 = (WYPopoverArea*)obj2;
        
        CGFloat val1 = area1.value;
        CGFloat val2 = area2.value;
        
        NSComparisonResult result = NSOrderedSame;
        
        if (val1 > val2)
        {
            result = NSOrderedAscending;
        }
        else if (val1 < val2)
        {
            result = NSOrderedDescending;
        }
        
        return result;
    }];
    
    for (NSUInteger i = 0; i < [areas count]; i++)
    {
        WYPopoverArea* area = (WYPopoverArea*)[areas objectAtIndex:i];
        
        if (area.areaSize.width >= contentSize.width)
        {
            result = area.arrowDirection;
            break;
        }
    }
    
    if (result == WYPopoverArrowDirectionUnknown)
    {
        result = ((WYPopoverArea*)[areas objectAtIndex:0]).arrowDirection;
    }
    
    return result;
}

- (CGSize)sizeForRect:(CGRect)aRect
               inView:(UIView*)aView
          arrowHeight:(CGFloat)arrowHeight
       arrowDirection:(WYPopoverArrowDirection)arrowDirection
{
    CGRect rootViewFrame = self.rootViewFrame;
    CGRect viewFrame = [overlayView convertRect:rect fromView:inView];
    CGFloat minX, maxX, minY, maxY = 0;
    
    minX = popoverLayoutMargins.left;
    maxX = rootViewFrame.size.width - popoverLayoutMargins.right;
    minY = popoverLayoutMargins.top;
    maxY = rootViewFrame.size.height - popoverLayoutMargins.bottom;
    
    CGSize result = CGSizeZero;
    
    if (arrowDirection == WYPopoverArrowDirectionLeft)
    {
        result.width = maxX - (viewFrame.origin.x + viewFrame.size.width);
        result.width -= arrowHeight;
        result.height = maxY - minY;
    }
    else if (arrowDirection == WYPopoverArrowDirectionRight)
    {
        result.width = viewFrame.origin.x - minX;
        result.width -= arrowHeight;
        result.height = maxY - minY;
    }
    else if (arrowDirection == WYPopoverArrowDirectionDown)
    {
        result.width = maxX - minX;
        result.height = viewFrame.origin.y - minY;
        result.height -= arrowHeight;
    }
    else if (arrowDirection == WYPopoverArrowDirectionUp)
    {
        result.width = maxX - minX;
        result.height = maxY - (viewFrame.origin.y + viewFrame.size.height);
        result.height -= arrowHeight;
    }
    
    return result;
}

#pragma mark Selectors

- (void)orientationChanged:(NSNotification*)notification
{
    if ([viewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController* navigationController = (UINavigationController*)viewController;
        
        if (navigationController.navigationBarHidden == NO)
        {
            // Bug Fix : Workaround => Force navigationBar to redraw properly
            //
            navigationController.navigationBarHidden = YES;
            navigationController.navigationBarHidden = NO;
        }
    }
    
    [self presentPopoverFromRect:rect inView:inView permittedArrowDirections:permittedArrowDirections animated:animated];
}

#pragma mark Memory management

- (void)dealloc
{
    containerView = nil;
    overlayView.delegate = nil;
    overlayView = nil;
    inView = nil;
    viewController = nil;
    passthroughViews = nil;
}

@end
