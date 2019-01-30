//
//  DMTrialWelcomeStepController.h
//  DevMateActivations
//
//  Copyright (c) 2014-2018 DevMate Inc. All rights reserved.
//

#import "DMWelcomeStepController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DMTrialWelcomeStepController : DMWelcomeStepController

@property (nonatomic, assign, nullable) IBOutlet NSButton *startUsingAppButton;

- (IBAction)startUsingApp:(id _Nullable)sender;

@end

NS_ASSUME_NONNULL_END
