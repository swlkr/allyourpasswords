//
//  DMWelcomeStepController.h
//  DevMateActivations
//
//  Copyright (c) 2012-2018 DevMate Inc. All rights reserved.
//

#import "DMStepController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DMWelcomeStepController : DMStepController

@property (nonatomic, assign, nullable) IBOutlet NSTextField *welcomeDescriptionField;
@property (nonatomic, assign, nullable) IBOutlet NSButton *continueButton;
@property (nonatomic, assign, nullable) IBOutlet NSButton *cancelButton;
@property (nonatomic, assign, nullable) IBOutlet NSButton *getLicenseButton;

- (IBAction)continueActivation:(id _Nullable)sender;
- (IBAction)cancelActivation:(id _Nullable)sender;

//! By default action will open https://devmate.io/gostore/... webpage
- (IBAction)openWebStore:(id _Nullable)sender;

//! Will open embedded FastSpring store if delegate implements necessary methods or just call -openWebStore: method
- (IBAction)getLicense:(id _Nullable)sender;

@end

NS_ASSUME_NONNULL_END
