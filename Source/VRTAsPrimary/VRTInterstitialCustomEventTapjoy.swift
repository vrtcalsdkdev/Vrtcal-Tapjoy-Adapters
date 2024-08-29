
// Tapjoy Banner Adapter, Vrtcal as Primary
import VrtcalSDK
import Tapjoy

class VRTInterstitialCustomEventTapjoy: VRTAbstractInterstitialCustomEvent {
    private var tjPlacement: TJPlacement?
    
    var tjPlacementDelegatePassthrough = TJPlacementDelegatePassthrough()
    
    override func loadInterstitialAd() {
        VRTLogInfo()
        
        VRTAsPrimaryManager.singleton.initializeThirdParty(
            customEventConfig: customEventConfig
        ) { result in
            switch result {
            case .success():
                self.finishLoadingInterstitial()
            case .failure(let vrtError):
                self.customEventLoadDelegate?.customEventFailedToLoad(vrtError: vrtError)
            }
        }
    }
    
    func finishLoadingInterstitial() {
        
        guard let placementName = customEventConfig.thirdPartyCustomEventDataValueOrFailToLoad(
            thirdPartyCustomEventKey: ThirdPartyCustomEventKey.adUnitId,
            customEventLoadDelegate: customEventLoadDelegate
        ) else {
            return
        }
        
        VRTLogInfo("placementName: \(placementName)")
        
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
