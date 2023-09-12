//  Converted to Swift 5.8.1 by Swiftify v5.8.26605 - https://swiftify.com/
//Header
import Tapjoy

//Tapjoy Banner Adapter, Vrtcal as Primary

class VRTInterstitialCustomEventTapjoy: VRTAbstractInterstitialCustomEvent, TJPlacementDelegate, TJPlacementVideoDelegate {
    private var tjPlacement: TJPlacement?

    func loadInterstitialAd() {
        let placementName = customEventConfig.thirdPartyCustomEventData["adUnitId"] as? String

        if placementName == nil {
            let error = VRTError(code: VRTErrorCodeCustomEvent, message: "No placementName")
            customEventLoadDelegate.customEventFailedToLoadWithError(error)
            return
        }

        tjPlacement = TJPlacement()
        tjPlacement?.placementName = placementName
        tjPlacement?.delegate = self
        tjPlacement?.videoDelegate = self
        tjPlacement?.requestContent()
    }

    func showInterstitialAd() {
        let vc = viewControllerDelegate.vrtViewControllerForModalPresentation()
        tjPlacement?.showContent(with: vc)
    }

    // MARK: - TJPlacementDelegate

    func requestDidSucceed(_ placement: TJPlacement?) {
        //No VRT Analog
    }

    func requestDidFail(_ placement: TJPlacement?, error: Error?) {
        customEventLoadDelegate.customEventFailedToLoadWithError(error)
    }

    func contentIsReady(_ placement: TJPlacement?) {
        customEventLoadDelegate.customEventLoaded()
    }

    func contentDidAppear(_ placement: TJPlacement?) {
        customEventShowDelegate.customEventDidPresentModal(VRTModalTypeInterstitial)
    }

    func contentDidDisappear(_ placement: TJPlacement?) {
        customEventShowDelegate.customEventDidDismissModal(VRTModalTypeInterstitial)
    }

    func didClick(_ placement: TJPlacement?) {
        customEventShowDelegate.customEventClicked()
    }

    func placement(
        _ placement: TJPlacement?,
        didRequestPurchase request: TJActionRequest?,
        productId: String?
    ) {
        //No VRT Analog
    }

    func placement(
        _ placement: TJPlacement?,
        didRequestReward request: TJActionRequest?,
        itemId: String?,
        quantity: Int
    ) {
        //No VRT Analog
    }

    // MARK: - TJPlacementVideoDelegate

    func videoDidStart(_ placement: TJPlacement?) {
        customEventShowDelegate.customEventVideoStarted()
    }

    func videoDidComplete(_ placement: TJPlacement?) {
        customEventShowDelegate.customEventVideoCompleted()
    }

    func videoDidFail(_ placement: TJPlacement?, error errorMsg: String?) {
        let vrtError = VRTError(code: VRTErrorCodeCustomEvent, message: errorMsg)
        customEventLoadDelegate.customEventFailedToLoadWithError(vrtError)
    }
}

//Dependencies