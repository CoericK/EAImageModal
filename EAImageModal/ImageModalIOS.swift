import Foundation

 public class ImageModalIOS: NSObject {

    var imageModalView : ImageModalView!
    
    public func setFrame(frame: CGRect){
        self.imageModalView = ImageModalView(frame: frame)
        
    }
    public func setImage(url: String){
        print(url)
        self.imageModalView.setImageToShow(url: URL(string: url)!)
    }
    
    public func getView() -> UIView{
        return self.imageModalView;
    }
}
