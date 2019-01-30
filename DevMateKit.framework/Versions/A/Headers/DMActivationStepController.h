//
//  DMActivationStepController.h
//  DevMateActivations
//
//  Copyright (c) 2012-2018 DevMate Inc. All rights reserved.
//

#import "DMStepController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DMActivationStepController : DMStepController

@property (nonatomic, assign, nullable) IBOutlet NSTextField *licenseCaptionField;
@property (nonatomic, assign, nullable) IBOutlet NSTextField *licenseField;
@property (nonatomic, assign, nullable) IBOutlet NSTextField *descriptionField;
@property (nonatomic, assign, nullable) IBOutlet NSButton *activateButton;
@property (nonatomic, assign, nullable) IBOutlet NSButton *cancelButton;
@property (nonatomic, assign, nullable) IBOutlet NSProgressIndicator *progressIndicator;

- (IBAction)activate:(id _Nullable)sender;
- (IBAction)cancel:(id _Nullable)sender;

@end

NS_ASSUME_NONNULL_END
