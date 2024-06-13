
// Tapjoy Banner Adapter, Vrtcal as Primary
import VrtcalSDK
import Tapjoy

class VRTInterstitialCustomEventTapjoy: VRTAbstractInterstitialCustomEvent {
    private var tjPlacement: TJPlacement?
    
    var tjPlacementDelegatePassthrough = TJPlacementDelegatePassthrough()
    var tjPlacementVideoDelegatePassthrough = TJPlacementVideoDelegatePassthrough()
    
    override func loadInterstitialAd() {
        VRTLogInfo()
        guard let placementName = customEventConfig.thirdPartyAdUnitId(
            customEventLoadDelegate: customEventLoadDelegate
        ) else {
            return
        }
        VRTLogInfo("placementName: \(placementName)")
        
        tjPlacementVideoDelegatePassthrough.customEventLoadDelegate = customEventLoadDelegate
        
        tjPlacementDelegatePassthrough.customEventShowDelegate = customEventShowDelegate
        tjPlacementDelegatePassthrough.customEventLoadDelegate = customEventLoadDelegate
        tjPlacementDelegatePassthrough.viewControllerDelegate = viewControllerDelegate
        
        tjPlacement = TJPlacement()
        tjPlacement?.placementName = placementName
        tjPlacement?.delegate = tjPlacementDelegatePassthrough
        tjPlacement?.videoDelegate = tjPlacementVideoDelegatePassthrough
        tjPlacement?.requestContent()
    }
    
    override func showInterstitialAd() {
        VRTLogInfo()
        tjPlacementDelegatePassthrough.customEventShowDelegate = customEventShowDelegate
        tjPlacementVideoDelegatePassthrough.customEventShowDelegate = customEventShowDelegate
        let vc = viewControllerDelegate?.vrtViewControllerForModalPresentation()
        tjPlacement?.showContent(with: vc)
    }
}
