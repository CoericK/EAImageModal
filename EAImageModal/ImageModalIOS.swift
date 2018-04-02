import Foundation

 public class ImageModalIOS: NSObject {
    
    public typealias CBClosure = ()->Void;

    var imageModalView : ImageModalView!
    
    public func setFrame(frame: CGRect){
        self.imageModalView = ImageModalView(frame: frame)
        
    }
    public func setImage(url: String){
        self.imageModalView.setImageToShow(url: URL(string: url)!)
    }
    
    public func setImage(url: String, cb: @escaping CBClosure) {
        self.setImage(url: url)
        self.imageModalView.setCallback(cb);
    }
    
    public func getView() -> UIView{
        return self.imageModalView;
    }
}
