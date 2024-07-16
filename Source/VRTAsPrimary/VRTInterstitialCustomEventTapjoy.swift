
// Tapjoy Banner Adapter, Vrtcal as Primary
import VrtcalSDK
import Tapjoy

class VRTInterstitialCustomEventTapjoy: VRTAbstractInterstitialCustomEvent {
    private var tjPlacement: TJPlacement?
    
    var tjPlacementDelegatePassthrough = TJPlacementDelegatePassthrough()
    
    override func loadInterstitialAd() {
        VRTLogInfo()
        guard let placementName = customEventConfig.thirdPartyAdUnitId(
            customEventLoadDelegate: customEventLoadDelegate
        ) else {
            return
        }
        VRTLogInfo("placementName: \(placementName)")
        
        tjPlacementDelegatePassthrough.customEventShowDelegate = customEventShowDelegate
        tjPlacementDelegatePassthrough.customEventLoadDelegate = customEventLoadDelegate
        tjPlacementDelegatePassthrough.viewControllerDelegate = viewControllerDelegate
        
        tjPlacement = TJPlacement()
        tjPlacement?.placementName = placementName
        tjPlacement?.delegate = tjPlacementDelegatePassthrough
        tjPlacement?.requestContent()
    }
    
    override func showInterstitialAd() {
        VRTLogInfo()
        tjPlacementDelegatePassthrough.customEventShowDelegate = customEventShowDelegate
        let vc = viewControllerDelegate?.vrtViewControllerForModalPresentation()
        tjPlacement?.showContent(with: vc)
    }
}
