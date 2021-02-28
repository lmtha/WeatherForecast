import UIKit

final class MainNavigationViewController: UINavigationController {
    override public var shouldAutorotate: Bool {
        return visibleViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return visibleViewController?.preferredInterfaceOrientationForPresentation ?? super.preferredInterfaceOrientationForPresentation
    }
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return visibleViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    override var prefersStatusBarHidden: Bool {
        return visibleViewController?.prefersStatusBarHidden ?? super.prefersStatusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return visibleViewController?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = .white
                
        navigationBar.barTintColor = .white
        navigationBar.isTranslucent = false
    }
}

extension UINavigationController {
    var main: MainNavigationViewController? {
        return self as? MainNavigationViewController
    }
}

