//
//  DMEmbeddedStoreStepController.h
//  DevMateActivations
//
//  Copyright (c) 2015-2018 DevMate Inc. All rights reserved.
//

#import "DMStepController.h"

NS_ASSUME_NONNULL_BEGIN

@class WebView;

@interface DMEmbeddedStoreStepController : DMStepController

@property (nonatomic, assign, nullable) IBOutlet WebView *storeWebView;
@property (nonatomic, assign, nullable) IBOutlet NSProgressIndicator *loadingProgressIndicator;
@property (nonatomic, retain, nullable) IBOutlet NSButton *secureSessionButton;

@property (nonatomic, assign, nullable) IBOutlet NSView *errorViewContainer;
@property (nonatomic, assign, nullable) IBOutlet NSTextField *errorTitleField;
@property (nonatomic, assign, nullable) IBOutlet NSTextField *errorDescriptionField;
@property (nonatomic, assign, nullable) IBOutlet NSButton *webStoreButton;
@property (nonatomic, assign, nullable) IBOutlet NSButton *tryAgainButton;

- (IBAction)showCertificates:(id _Nullable)sender; // will be sent by secureSessionButton
- (IBAction)reloadStore:(id _Nullable)sender;
- (IBAction)openWebStore:(id _Nullable)sender;
- (IBAction)cancelEmbeddedStore:(id _Nullable)sender;

@end

NS_ASSUME_NONNULL_END
