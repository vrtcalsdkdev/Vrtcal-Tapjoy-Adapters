
// Tapjoy Banner Adapter, Vrtcal as Primary
import VrtcalSDK
import Tapjoy

class VRTInterstitialCustomEventTapjoy: VRTAbstractInterstitialCustomEvent {
    private var tjPlacement: TJPlacement?
    
    var tjPlacementVideoDelegatePassthrough = TJPlacementVideoDelegatePassthrough()
    var tjPlacementDelegatePassthrough = TJPlacementDelegatePassthrough()
    
    override func loadInterstitialAd() {
        
        guard let placementName = customEventConfig.thirdPartyAppId(
            customEventLoadDelegate: customEventLoadDelegate
        ) else {
            return
        }
        
        tjPlacementVideoDelegatePassthrough.customEventLoadDelegate = customEventLoadDelegate
        tjPlacementVideoDelegatePassthrough.customEventShowDelegate = customEventShowDelegate
        
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
        let vc = viewControllerDelegate?.vrtViewControllerForModalPresentation()
        tjPlacement?.showContent(with: vc)
    }
}
