#import "FLNativeView.h"

@implementation FLNativeViewFactory {
  NSObject<FlutterBinaryMessenger>* _messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
  return [[FLNativeView alloc] initWithFrame:frame
                              viewIdentifier:viewId
                                   arguments:args
                             binaryMessenger:_messenger];
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}
@end

@implementation FLNativeView {
  UIView* _view;
}

- (double)displayRefreshRate {
  CADisplayLink* display_link = [CADisplayLink displayLinkWithTarget:self
                                                            selector:@selector(onDisplayLink:)];
  display_link.paused = YES;
  double preferredFPS = display_link.preferredFramesPerSecond;

  // From Docs:
  // The default value for preferredFramesPerSecond is 0. When this value is 0, the preferred
  // frame rate is equal to the maximum refresh rate of the display, as indicated by the
  // maximumFramesPerSecond property.
  if (preferredFPS != 0) {
    return preferredFPS;
  }

  return [UIScreen mainScreen].maximumFramesPerSecond;
}

- (void)onDisplayLink:(CADisplayLink*)link {
  // no-op.
}

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  if (self = [super init]) {
    _view = [[UIView alloc] init];
    _view.backgroundColor = [UIColor colorWithHue:drand48()
                                       saturation:1.0
                                       brightness:1.0
                                            alpha:1.0];

    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 40)];
    label1.text = [NSString stringWithFormat:@"PlatformView (id: %lld, maximum FPS: %.0f)", viewId,
                                            [self displayRefreshRate]];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.adjustsFontSizeToFitWidth = YES;
    label1.textColor = [UIColor whiteColor];
    [_view addSubview:label1];

    UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 300, 40)];
    NSDictionary<NSString*, id>* dict = args;
    NSString *creationParams = @"";
    for (NSString *key in dict) {
      NSString *str = [NSString stringWithFormat:@"%@: %@ ", key, [dict objectForKey:key]];
      creationParams = [creationParams stringByAppendingString: str];
    }

    label2.text = creationParams;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.adjustsFontSizeToFitWidth = YES;
    label2.textColor = UIColor.whiteColor;
    [_view addSubview:label2];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [_view addGestureRecognizer:tapGesture];
  }

  return self;
}

- (UIView*)view {
  return _view;
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
      _view.backgroundColor = [UIColor colorWithHue:drand48()
                                        saturation:1.0
                                        brightness:1.0
                                             alpha:1.0];
    }
}

@end
