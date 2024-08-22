import VrtcalSDK
import Tapjoy


class VRTAsPrimaryManager {

    static var singleton = VRTAsPrimaryManager()
    var initialized = false
    
    func initializeThirdParty(
        customEventConfig: VRTCustomEventConfig,
        completionHandler: @escaping (Result<Void,VRTError>) -> ()
    ) {
        VRTLogInfo()
        guard !initialized else {
            completionHandler(.success())
            return
        }
        
        // Require the appId
        guard let sdkKey = customEventConfig.thirdPartyCustomEventDataValue(
            thirdPartyCustomEventKey: .appId
        ).getSuccess(failureHandler: { vrtError in
            completionHandler(.failure(vrtError))
        }) else {
            return
        }
        
        // Enable Debug
        Tapjoy.setDebugEnabled(true)

        // Edit the global privacy singleton
        let tjPrivacyPolicy = Tapjoy.getPrivacyPolicy()
        tjPrivacyPolicy.subjectToGDPRStatus = .false
        tjPrivacyPolicy.userConsentStatus = .true
        tjPrivacyPolicy.belowConsentAgeStatus = .false
        tjPrivacyPolicy.usPrivacy = "1---"

        // Clear observers
        NotificationCenter.default.removeObserver(self)
        
        // Add Observers
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: TJC_CONNECT_SUCCESS),
            object: nil,
            queue: nil
        ) { notification in
            
            self.initialized = true
            
            completionHandler(.success())
            
            // Clear observers
            NotificationCenter.default.removeObserver(self)
        }

        // Add Observers
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: TJC_CONNECT_FAILED),
            object: nil,
            queue: nil
        ) { notification in
            
            let vrtError = VRTError(vrtErrorCode: .customEvent, message: "Notification: \(notification)")
            completionHandler(.failure(vrtError))
            
            // Clear observers
            NotificationCenter.default.removeObserver(self)
        }
        
        // Connect using the sdkKey
        Tapjoy.connect(sdkKey)
    }
}
