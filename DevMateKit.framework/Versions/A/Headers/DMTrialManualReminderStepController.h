//
//  DMTrialManualReminderStepController.h
//  DevMateActivations
//
//  Copyright (c) 2014-2018 DevMate Inc. All rights reserved.
//

#import "DMTrialWelcomeStepController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DMTrialManualReminderStepController : DMTrialWelcomeStepController

@property (nonatomic, assign, nullable) IBOutlet NSProgressIndicator *trialProgress;

@end

NS_ASSUME_NONNULL_END
