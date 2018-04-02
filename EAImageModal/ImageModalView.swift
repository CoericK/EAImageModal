import Foundation
import Kingfisher

class ImageModalView: UIView {
    
     public typealias CBClosure = ()->Void;
    
    var contentView: UIView!
    var imageModal: UIImageView!
    var closeButton: UIButton!
    var callbackOnClose: CBClosure!
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    public func setImageToShow(url: URL ){
        self.imageModal.kf.setImage(with: url)
    }
    
    public func setCallback(_ cb:@escaping CBClosure){
        self.callbackOnClose = cb;
    }
    
    public func setUpView(){
        let bundle = Bundle(for: type(of: self))
        self.contentView = UIView()
        self.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        
        addSubview(contentView)
        
        
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        
        
        
        
        
        // Image
        self.imageModal  = UIImageView();
        self.contentView.addSubview(self.imageModal)
        
        self.imageModal.translatesAutoresizingMaskIntoConstraints = false
        self.imageModal.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        self.imageModal.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 61).isActive = true
        self.imageModal.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -60).isActive = true
        self.imageModal.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.imageModal.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.imageModal.contentMode = UIViewContentMode.scaleAspectFill
        
        
        
        
        // Button
        self.closeButton = UIButton(type: .custom)
        self.contentView.addSubview(self.closeButton)
        self.closeButton.addTarget(self, action: #selector(removeSelf), for: .touchUpInside)
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.closeButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        self.closeButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20).isActive = true
        self.closeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.closeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.closeButton.setImage(UIImage(named: "ic_close_modal", in: bundle, compatibleWith: nil), for: .normal)
        
        contentView.alpha = 0.0
        
    }
    

    
    public override func didMoveToSuperview() {
        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1
            self.contentView.transform = CGAffineTransform.identity
        })
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
