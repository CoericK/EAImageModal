import Foundation
import Kingfisher


class ImageModalView: UIView {
    
     public typealias CBClosure = ()->Void;
    
    var contentView: UIView!
    var imageModal: UIImageView!
    var closeButton: UIButton!
    var callbackOnClose: CBClosure!
    var bgAlpha : Float = 0.6
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    public func setImageToShow(url: URL ){
        self.imageModal.kf.indicatorType = .activity
        self.imageModal.kf.setImage(with: url)
    }
    
    public func setCallback(_ cb:@escaping CBClosure){
        self.callbackOnClose = cb;
    }
    
    
    private func setUpView() {

        self.contentView = UIView()
        
        self.contentView.backgroundColor = UIColor.black.withAlphaComponent(CGFloat(bgAlpha))
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint( NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint( NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint( NSLayoutConstraint(item: contentView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint( NSLayoutConstraint(item: contentView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        
        // Image
        self.imageModal  = UIImageView();
        self.contentView.addSubview(self.imageModal)
        self.imageModal.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.imageModal, attribute: NSLayoutAttribute.centerX, relatedBy: .equal, toItem: self.contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.imageModal, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 61))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.imageModal, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -60))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.imageModal, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -20))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.imageModal, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 20))
        self.imageModal.contentMode = UIViewContentMode.scaleAspectFit

        // Button
        self.closeButton = UIButton(type: .custom)
        self.contentView.addSubview(self.closeButton)
        self.closeButton.addTarget(self, action: #selector(removeSelf), for: .touchUpInside)
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
    
    
        if #available(iOS 11.0, *), getDeviceName() == "iPhone X" {
            self.closeButton.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        }else{
            self.contentView.addConstraint(NSLayoutConstraint(item: self.closeButton, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant :36))
        }
        
        
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.closeButton, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant :-16))
        self.closeButton.addConstraint(NSLayoutConstraint(item: self.closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 24))
        self.closeButton.addConstraint(NSLayoutConstraint(item: self.closeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 24))
        self.closeButton.setImage(UIImage(named: "ic_image_modal_close_button"), for: .normal)
        contentView.alpha = 0.0
    }
       
    public override func didMoveToSuperview() {
        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1
            self.contentView.transform = CGAffineTransform.identity
        })
    }
    
    private func getDeviceName() -> String {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return ("iPhone 5 or 5S or 5C")
            case 1334:
                return("iPhone 6/6S/7/8")
            case 1920, 2208:
                return("iPhone 6+/6S+/7+/8+")
            case 2436:
                return("iPhone X")
            default:
                return("unknown")
            }
        }else {
            return "unknown"
        }
    }

    
    @objc private func removeSelf() {
        // Animate removal of view
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.contentView.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
            if(self.callbackOnClose != nil){
                self.callbackOnClose()
            }
            
        }
    }
    
}
