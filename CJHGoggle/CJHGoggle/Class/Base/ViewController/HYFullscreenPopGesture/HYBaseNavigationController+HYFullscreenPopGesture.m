//
//  HYBaseNavigationController+HYFullscreenPopGesture.m
//  Direction
//
//  Created by 耿建峰 on 17/7/17.
//  Copyright © 2017年 gengjf. All rights reserved.
//

#import "HYBaseNavigationController+HYFullscreenPopGesture.h"
#import <objc/runtime.h>

@interface _HYFullscreenPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation _HYFullscreenPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    
    // Ignore when no view controller is pushed into the navigation stack.
    if (self.navigationController.viewControllers.count <= 1) {
        
        return NO;
    }
    
    // Ignore when the active view controller doesn't allow interactive pop.
    UIViewController *topViewController = self.navigationController.viewControllers.lastObject;
    
    if (topViewController.hy_interactivePopDisabled) {
        
        return NO;
    }
    
    // Ignore when the beginning location is beyond max allowed initial distance to left edge.
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    
    CGFloat maxAllowedInitialDistance = topViewController.hy_interactivePopMaxAllowedInitialDistanceToLeftEdge;
    
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        
        return NO;
    }

    // Ignore pan gesture when the navigation controller is currently in transition.
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        
        return NO;
    }
    
    // Prevent calling the handler when the gesture begins in an opposite direction.
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    
    if (translation.x <= 0) {
        
        return NO;
    }
    
    return YES;
}

@end

typedef void (^_HYViewControllerWillAppearInjectBlock)(UIViewController *viewController, BOOL animated);

@interface UIViewController (HYFullscreenPopGesturePrivate)

@property (nonatomic, copy) _HYViewControllerWillAppearInjectBlock hy_willAppearInjectBlock;

@end

@implementation UIViewController (HYFullscreenPopGesturePrivate)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(hy_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (success) {
            
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else {
            
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)hy_viewWillAppear:(BOOL)animated {
    
    // Forward to primary implementation.
    [self hy_viewWillAppear:animated];
    
    if (self.hy_willAppearInjectBlock) {
        
        self.hy_willAppearInjectBlock(self, animated);
    }
}

- (_HYViewControllerWillAppearInjectBlock)hy_willAppearInjectBlock {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_willAppearInjectBlock:(_HYViewControllerWillAppearInjectBlock)block {
    
    objc_setAssociatedObject(self, @selector(hy_willAppearInjectBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@implementation HYBaseNavigationController (HYFullscreenPopGesture)

+ (void)load {
    
    // Inject "-pushViewController:animated:"
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        SEL originalSelector = @selector(pushViewController:animated:);
        SEL swizzledSelector = @selector(hy_pushViewController:animated:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (success) {
            
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else {
            
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)hy_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.hy_fullscreenPopGestureRecognizer]) {
        
        // Add our own gesture recognizer to where the onboard screen edge pan gesture recognizer is attached to.
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.hy_fullscreenPopGestureRecognizer];

        // Forward the gesture events to the private handler of the onboard gesture recognizer.
        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        self.hy_fullscreenPopGestureRecognizer.delegate = self.hy_popGestureRecognizerDelegate;
        [self.hy_fullscreenPopGestureRecognizer addTarget:internalTarget action:internalAction];

        // Disable the onboard gesture recognizer.
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // Handle perferred navigation bar appearance.
    [self hy_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
    
    // Forward to primary implementation.
    if (![self.viewControllers containsObject:viewController]) {
        
        [self hy_pushViewController:viewController animated:animated];
    }
}

- (void)hy_setupViewControllerBasedNavigationBarAppearanceIfNeeded:(UIViewController *)appearingViewController {
    
    if (!self.hy_viewControllerBasedNavigationBarAppearanceEnabled) {
        
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    _HYViewControllerWillAppearInjectBlock block = ^(UIViewController *viewController, BOOL animated) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (strongSelf) {
            
            [strongSelf setNavigationBarHidden:viewController.hy_prefersNavigationBarHidden animated:animated];
        }
    };
    
    // Setup will appear inject block to appearing view controller.
    // Setup disappearing view controller as well, because not every view controller is added into
    // stack by pushing, maybe by "-setViewControllers:".
    appearingViewController.hy_willAppearInjectBlock = block;
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    
    if (disappearingViewController && !disappearingViewController.hy_willAppearInjectBlock) {
        
        disappearingViewController.hy_willAppearInjectBlock = block;
    }
}

- (_HYFullscreenPopGestureRecognizerDelegate *)hy_popGestureRecognizerDelegate {
    
    _HYFullscreenPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);

    if (!delegate) {
        
        delegate = [[_HYFullscreenPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return delegate;
}

- (UIPanGestureRecognizer *)hy_fullscreenPopGestureRecognizer {
    
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);

    if (!panGestureRecognizer) {
        
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return panGestureRecognizer;
}

- (BOOL)hy_viewControllerBasedNavigationBarAppearanceEnabled {
    
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    
    if (number) {
        
        return number.boolValue;
    }
    
    self.hy_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    
    return YES;
}

- (void)setHy_viewControllerBasedNavigationBarAppearanceEnabled:(BOOL)enabled {
    
    SEL key = @selector(hy_viewControllerBasedNavigationBarAppearanceEnabled);
    objc_setAssociatedObject(self, key, @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIViewController (HYFullscreenPopGesture)

- (BOOL)hy_interactivePopDisabled {
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setHy_interactivePopDisabled:(BOOL)disabled {
    
    objc_setAssociatedObject(self, @selector(hy_interactivePopDisabled), @(disabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hy_prefersNavigationBarHidden {
    
    BOOL bRe = [objc_getAssociatedObject(self, _cmd) boolValue];
    
    return bRe;
}

- (void)setHy_prefersNavigationBarHidden:(BOOL)hidden {
    
    objc_setAssociatedObject(self, @selector(hy_prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)hy_interactivePopMaxAllowedInitialDistanceToLeftEdge {
    
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
    
}

- (void)setHy_interactivePopMaxAllowedInitialDistanceToLeftEdge:(CGFloat)distance {
    
    SEL key = @selector(hy_interactivePopMaxAllowedInitialDistanceToLeftEdge);
    objc_setAssociatedObject(self, key, @(MAX(0, distance)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
