//
//  VRTInterstitialCustomEventTapjoyPassthrough.swift
//  Vrtcal-Tapjoy-Adapters
//
//  Created by Scott McCoy on 9/16/23.
//

import Tapjoy
import VrtcalSDK

// Tapjoy Banner Adapter, Vrtcal as Primary
class TJPlacementDelegatePassthrough: NSObject, TJPlacementDelegate {
    
    weak var customEventLoadDelegate: VRTCustomEventLoadDelegate?
    weak var customEventShowDelegate: VRTCustomEventShowDelegate?
    weak var viewControllerDelegate: ViewControllerDelegate?
    
    func requestDidSucceed(_ placement: TJPlacement) {
        VRTLogInfo()
        //No VRT Analog
    }
    
    func requestDidFail(_ placement: TJPlacement, error: Error?) {
        VRTLogInfo()
        customEventLoadDelegate?.customEventFailedToLoad(vrtError: .init(customEventError: error))
    }
    
    func contentIsReady(_ placement: TJPlacement) {
        VRTLogInfo()
        customEventLoadDelegate?.customEventLoaded()
    }
    
    func contentDidAppear(_ placement: TJPlacement) {
        VRTLogInfo()
        customEventShowDelegate?.customEventDidPresentModal(.interstitial)
    }
    
    func contentDidDisappear(_ placement: TJPlacement) {
        VRTLogInfo()
        customEventShowDelegate?.customEventDidDismissModal(.interstitial)
    }
    
    func didClick(_ placement: TJPlacement) {
        VRTLogInfo()
        customEventShowDelegate?.customEventClicked()
    }
    
    func placement(
        _ placement: TJPlacement,
        didRequestPurchase request: TJActionRequest?,
        productId: String?
    ) {
        VRTLogInfo()
        // No VRT Analog
    }
    
    private func placement(
        _ placement: TJPlacement?,
        didRequestReward request: TJActionRequest?,
        itemId: String?,
        quantity: Int
    ) {
        VRTLogInfo()
        // No VRT Analog
    }
}
