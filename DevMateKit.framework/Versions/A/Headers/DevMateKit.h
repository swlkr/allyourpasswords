//
//  DevMateKit.h
//  DevMateKit
//
//  Copyright (c) 2014-2018 DevMate Inc. All rights reserved.
//

#if __has_feature(modules)
@import Cocoa;
#else
#import <Cocoa/Cocoa.h>
#endif

#import "DevMateTracking.h"
#import "DevMateIssues.h"
#import "DevMateFeedback.h"
#import "DevMateActivations.h"

// If you are using your own copy of Sparkle.framework just define
// USED_CUSTOM_SPARKLE_FRAMEWORK macro.
#ifndef USED_CUSTOM_SPARKLE_FRAMEWORK
#import "DevMateSparkle.h"
#endif

#import "DevMateInlines.h"

NS_ASSUME_NONNULL_BEGIN

// ! LOGGING
// to see all DevMate debug logs in consol add environment varialble DM_ENABLE_DEBUG_LOGGING_ALL with value YES

@interface DevMateKit : NSObject

/*! @brief Setup user name and email that will be shown in feedback and issues dialog.
    @discussion This values will be set up only for shared controllers.
    @param userName User name.
    @param userEmail User email.
*/
+ (void)setupDefaultUserName:(NSString *_Nullable)userName
                   userEmail:(NSString *_Nullable)userEmail;

/*! @brief Setup custom log files for sending them with user feedback or issue reporter.
    @discussion This value will be set up only for Feedback and Issue shared controllers.
    @param logFileURLs array with NSURL objects.
 */
+ (void)setupCustomLogFileURLs:(NSArray *_Nullable)logFileURLs;

/*! @brief Easy way to send tracking report.
    @param infoProvider Info provider for tracking reporter.
    @param delegate delegate for tracking reporter
*/
+ (void)sendTrackingReport:(id<DMTrackingReporterInfoProvider> _Nullable)infoProvider
                  delegate:(id<DMTrackingReporterDelegate> _Nullable)delegate;

/*! @brief Easy way to open standard feedback dialog.
    @param delegate delegate for feedback controller.
    @param mode show window mode for feedback dialog.
*/
+ (void)showFeedbackDialog:(id<DMFeedbackControllerDelegate> _Nullable)delegate
                    inMode:(DMFeedbackMode)mode;

/*! @brief Easy way to setup all necessary to handle exception and crash issues.
    @param delegate delegate for issues controller.
    @param shouldReport pass \p YES to open standard issues dialog for unhadled issue reports if such exists.
*/
+ (void)setupIssuesController:(id<DMIssuesControllerDelegate> _Nullable)delegate
     reportingUnhandledIssues:(BOOL)shouldReport;

/*! @brief Easy way to initialize time trial.
    @param delegate delegate for standard trial controller.
    @param trialTime trial time interval.
*/
+ (void)setupTimeTrial:(id<DMActivationControllerDelegate> _Nullable)delegate
      withTimeInterval:(NSTimeInterval)trialTime;

/*! @brief  Easy way to initialize manual trial.
    @param delegate delegate for standard trial controller.
    @param callbacks manual trial callbacks.
*/
+ (void)setupManualTrial:(id<DMActivationControllerDelegate> _Nullable)delegate
      withTrialCallbacks:(DMTrialCallbacks)callbacks;

/*! @brief Easy way to run standard activation dialog.
    @discussion Will be used standard trial controller if initialized of sahred activation controller.
    @param delegate delegate for activation controller.
    @param mode show window mode for activation controller.
*/
+ (void)runActivationDialog:(id<DMActivationControllerDelegate> _Nullable)delegate
                     inMode:(DMActivationMode)mode;

#ifndef  USED_CUSTOM_SPARKLE_FRAMEWORK
/*! @brief Easy way to run standard updates check.
    @param delegate delegate for Sparkle updater object.
    @param checkBeta flag that says if updater should also check for new public beta versions.
    @param inTestMode flag that says if updater should check versions that have testing status (DevMate distribution page).
*/
+ (void)checkForUpdates:(id _Nullable)delegate
       includeBetaCheck:(BOOL)checkBeta
             inTestMode:(BOOL)inTestMode;
#endif // USED_CUSTOM_SPARKLE_FRAMEWORK

@end

NS_ASSUME_NONNULL_END
