//
//  DMTrackingReporter.h
//  DevMateTracking
//
//  Copyright (c) 2013-2018 DevMate Inc. All rights reserved.
//

#if __has_feature(modules)
@import Foundation;
#else
#import <Foundation/Foundation.h>
#endif

#import "DMTrackingBase.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DMTrackingReporterInfoProvider;
@protocol DMTrackingReporterDelegate;

@interface DMTrackingReporter : NSObject

- (instancetype)initWithInfoProvider:(id <DMTrackingReporterInfoProvider>)infoProvider;
+ (instancetype)reporterWithInfoProvider:(id <DMTrackingReporterInfoProvider>)infoProvider;

@property (readonly, nullable) id <DMTrackingReporterInfoProvider> infoProvider;
@property (assign, nullable) id <DMTrackingReporterDelegate> delegate;

// Passing NO as async parameter is not recommended while calling method from main thread/queue
- (void)sendReport:(BOOL)async;

@end

@protocol DMTrackingReporterInfoProvider <NSObject>
@optional

- (NSUInteger)applicationLaunchCount:(DMTrackingReporter *)reporter;
- (BOOL)isApplicationFirstInstall:(DMTrackingReporter *)reporter;
- (DMAppActivationStatus)applicationActivationStatus:(DMTrackingReporter *)reporter;
- (DMAppTrialValue)applicationTrialValue:(DMTrackingReporter *)reporter;

@end

@protocol DMTrackingReporterDelegate <NSObject>
@optional

- (void)trackingReporter:(DMTrackingReporter *)reporter didFinishSendingReportWithSuccess:(BOOL)success;

@end

NS_ASSUME_NONNULL_END
