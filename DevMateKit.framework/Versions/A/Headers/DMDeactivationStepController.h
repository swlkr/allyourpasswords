//
//  DMDeactivationStepController.h
//  DevMateActivations
//
//  Copyright (c) 2015-2018 DevMate Inc. All rights reserved.
//

#import "DMStepController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DMDeactivationStepController : DMStepController

@property (retain, nullable) NSError *deactivationError;

@property (nonatomic, assign, nullable) IBOutlet NSTextField *errorDescriptionField;
@property (nonatomic, assign, nullable) IBOutlet NSButton *confirmButton;

- (IBAction)confirmAction:(id _Nullable)sender;

@end

NS_ASSUME_NONNULL_END
