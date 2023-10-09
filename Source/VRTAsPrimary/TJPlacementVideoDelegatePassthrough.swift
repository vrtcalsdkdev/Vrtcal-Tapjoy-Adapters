//
//  Passthrough.swift
//  Vrtcal-Tapjoy-Adapters
//
//  Created by Scott McCoy on 9/16/23.
//

// Tapjoy Banner Adapter, Vrtcal as Primary
import VrtcalSDK
import Tapjoy

class TJPlacementVideoDelegatePassthrough: NSObject, TJPlacementVideoDelegate {

    weak var customEventLoadDelegate: VRTCustomEventLoadDelegate?
    weak var customEventShowDelegate: VRTCustomEventShowDelegate?
    
    func videoDidStart(_ placement: TJPlacement) {
        customEventShowDelegate?.customEventVideoStarted()
    }

    func videoDidComplete(_ placement: TJPlacement) {
        customEventShowDelegate?.customEventVideoCompleted()
    }

    func videoDidFail(
        _ placement: TJPlacement,
        error errorMsg: String?
    ) {
        let vrtError = VRTError(
            vrtErrorCode: .customEvent,
            message: errorMsg ?? ""
        )
        customEventLoadDelegate?.customEventFailedToLoad(vrtError: vrtError)
    }
}
