import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showHud(hudType: HudType){
        hideHud()
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        switch hudType {
        case .loading:
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.label.text = "Loading"
        case .error(let value):
            loadingNotification.minShowTime = .init(3)
            loadingNotification.mode = MBProgressHUDMode.text
            loadingNotification.label.text = value
        }
    }
    
    func hideHud(){
        MBProgressHUD.hide(for: view, animated: true)
    }
}
