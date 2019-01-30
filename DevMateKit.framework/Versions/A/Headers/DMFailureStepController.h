//
//  DMFailureStepController.h
//  DevMateActivations
//
//  Copyright (c) 2012-2018 DevMate Inc. All rights reserved.
//

#import "DMStepController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DMFailureStepController : DMStepController

@property (retain, nullable) NSError *activationError;

@property (nonatomic, assign, nullable) IBOutlet NSTextField *errorDescriptionField;
@property (nonatomic, assign, nullable) IBOutlet NSButton *tryAgainButton;
@property (nonatomic, assign, nullable) IBOutlet NSButton *cancelButton;

- (IBAction)tryAgainActivation:(id _Nullable)sender;
- (IBAction)cancelActivation:(id _Nullable)sender;

@end

NS_ASSUME_NONNULL_END
