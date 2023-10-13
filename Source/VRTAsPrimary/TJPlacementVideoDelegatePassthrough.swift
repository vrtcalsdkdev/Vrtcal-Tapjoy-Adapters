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
        VRTLogInfo()
        customEventShowDelegate?.customEventVideoStarted()
    }

    func videoDidComplete(_ placement: TJPlacement) {
        VRTLogInfo()
        customEventShowDelegate?.customEventVideoCompleted()
    }

    func videoDidFail(
        _ placement: TJPlacement,
        error errorMsg: String?
    ) {
        VRTLogInfo("error: \(String(describing: errorMsg))")
        let vrtError = VRTError(
            vrtErrorCode: .customEvent,
            message: errorMsg ?? ""
        )
        customEventLoadDelegate?.customEventFailedToLoad(vrtError: vrtError)
    }
}
