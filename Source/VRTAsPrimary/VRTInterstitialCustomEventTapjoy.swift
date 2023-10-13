
// Tapjoy Banner Adapter, Vrtcal as Primary
import VrtcalSDK
import Tapjoy

class VRTInterstitialCustomEventTapjoy: VRTAbstractInterstitialCustomEvent {
    private var tjPlacement: TJPlacement?
    
    var tjPlacementVideoDelegatePassthrough = TJPlacementVideoDelegatePassthrough()
    var tjPlacementDelegatePassthrough = TJPlacementDelegatePassthrough()
    
    override func loadInterstitialAd() {
        
        guard let placementName = customEventConfig.thirdPartyAdUnitId(
            customEventLoadDelegate: customEventLoadDelegate
        ) else {
            return
        }
        
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
        tjPlacementVideoDelegatePassthrough.customEventShowDelegate = customEventShowDelegate
        let vc = viewControllerDelegate?.vrtViewControllerForModalPresentation()
        tjPlacement?.showContent(with: vc)
    }
}
