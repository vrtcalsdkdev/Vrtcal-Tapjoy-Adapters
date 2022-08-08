//Header
#import "VRTInterstitialCustomEventTapjoy.h"

//Dependencies
@import Tapjoy;

@interface VRTInterstitialCustomEventTapjoy() <TJPlacementDelegate, TJPlacementVideoDelegate>
@property TJPlacement *tjPlacement;
@end

@implementation VRTInterstitialCustomEventTapjoy

- (void) loadInterstitialAd {
    NSString *placementName = [self.customEventConfig.thirdPartyCustomEventData objectForKey:@"adUnitId"];
    
    if (placementName == nil) {
        VRTError *error = [VRTError errorWithCode:VRTErrorCodeCustomEvent message:@"No placementName"];
        [self.customEventLoadDelegate customEventFailedToLoadWithError:error];
        return;
    }
    
    self.tjPlacement = [[TJPlacement alloc] init];
    self.tjPlacement.placementName = placementName;
    self.tjPlacement.delegate = self;
    self.tjPlacement.videoDelegate = self;
    [self.tjPlacement requestContent];
}

- (void) showInterstitialAd {
    UIViewController *vc = [self.viewControllerDelegate vrtViewControllerForModalPresentation];
    [self.tjPlacement showContentWithViewController:vc];
}


#pragma mark - TJPlacementDelegate
- (void)requestDidSucceed:(TJPlacement *)placement {
    //No VRT Analog
}

- (void)requestDidFail:(TJPlacement *)placement error:(nullable NSError *)error {
    [self.customEventLoadDelegate customEventFailedToLoadWithError:error];
}

- (void)contentIsReady:(TJPlacement *)placement {
    [self.customEventLoadDelegate customEventLoaded];
}

- (void)contentDidAppear:(TJPlacement *)placement {
    [self.customEventShowDelegate customEventDidPresentModal:VRTModalTypeInterstitial];
}

- (void)contentDidDisappear:(TJPlacement *)placement {
    [self.customEventShowDelegate customEventDidDismissModal:VRTModalTypeInterstitial];
}

- (void)didClick:(TJPlacement *)placement {
    [self.customEventShowDelegate customEventClicked];
}

- (void)placement:(TJPlacement *)placement
didRequestPurchase:(nullable TJActionRequest *)request
        productId:(nullable NSString *)productId {
    //No VRT Analog
}

- (void)placement:(TJPlacement *)placement
 didRequestReward:(nullable TJActionRequest *)request
           itemId:(nullable NSString *)itemId
         quantity:(int)quantity {
    //No VRT Analog
}

#pragma mark - TJPlacementVideoDelegate
- (void)videoDidStart:(TJPlacement *)placement {
    [self.customEventShowDelegate customEventVideoStarted];
}

- (void)videoDidComplete:(TJPlacement *)placement {
    [self.customEventShowDelegate customEventVideoCompleted];
}

- (void)videoDidFail:(TJPlacement *)placement error:(nullable NSString *)errorMsg {
    VRTError *vrtError = [VRTError errorWithCode:VRTErrorCodeCustomEvent message:errorMsg];
    [self.customEventLoadDelegate customEventFailedToLoadWithError:vrtError];
}


@end
