//
//  CHProgressHUD.h
//  CHProgressHUDDemo
//
//  Created by Chausson on 16/4/8.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol CHProgressHUDDelegate;


typedef NS_ENUM(NSInteger, CHProgressHUDMode) {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    CHActivityIndicator,
    /** Shows a custom view */
    CHCustomView,
    CHRotateCustomView,
    /** Shows only labels */
    CHActivityText, // 显示文本和菊花
    CHPlainText// 显示纯文本
    
};
#if NS_BLOCKS_AVAILABLE
typedef void (^CHProgressHUDCompletionBlock)();
#endif
@interface CHProgressHUD : UIView
/**
 * Quick use hud with mode and parameters only CHProgressHUDModeActivityText and CHProgressHUDModePlainText needs text
 */
+ (void)showPlainText:(NSString *)text;

+ (void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;

+ (void)showAnimated:(BOOL)animated completionBlock:(CHProgressHUDCompletionBlock)completion;

+ (void)show:(BOOL)animated; // show HUD if labelText is not nil mode will be set CHProgressHUDModeActivityText

+ (void)hide:(BOOL)animated;

+ (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay
                            completionBlock:(CHProgressHUDCompletionBlock)completion;

+ (void)hideWithText:(NSString *)text animated:(BOOL)animated;

+ (void)hide:(BOOL)animated text:(NSString *)text
                            afterDelay:(NSTimeInterval)delay
                            completionBlock:(CHProgressHUDCompletionBlock)completion;

/**
 * Please use CHProgressHUD Method Setup CutomView , it is only support one customView.
 */
+ (void)setCustomView:(UIView *)customView;
/**
 * The HUD style depend on mode .
 */
+ (void)setMode:(CHProgressHUDMode )mode;
/**
 *  Changed HUD of background .
 */
+ (void)setColor:(UIColor *)color;
/**
 *  Changed CornerRadius  of HUD .Defaults to 10.0.
 */
+ (void)setCornerRadius:(float)cornerRadius;
/**
 *  Changed LabelFont of HUD TEXT IN  CHProgressHUDModeText .Defaults is 13font.
 */
+ (void)setLabelFont:(UIFont *)labelFont;
/**
 *  Changed LabelColor of HUD TEXT IN  CHProgressHUDModeText .Defaults is white.
 */
+ (void)setLabelColor:(UIColor *)labelColor;
/**
 *  Changed HUD  of ActivityIndicatorColor .Defaults is White Color;
 */
+ (void)setActivityIndicatorColor:(UIColor *)color;
/**
 *  Changed HUD  of opacity. Defaults to 0.8 (80% opacity).
 */
+ (void)setOpacity:(float)opacity;
/**
 * the labelText will be showed in CHProgressHUDModeText
 * The  defults line is 2.
 */
+ (void)setLabelText:(NSString *)labelText;
/**
 * the Label DurationTime defult is 1.5
 */
+ (void)setTextDuration:(NSTimeInterval )time;
/**
 * The  defults margin is 20.0f.deprecated on this version
 */
+ (void)setMargin:(CGFloat)margin NS_DEPRECATED_IOS(2_0, 9_0);
@end
