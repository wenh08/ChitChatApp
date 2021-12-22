
import UIKit

class AnimationViewController: UIViewController {
   
    @IBOutlet var draggableImageView: UIImageView!
    @IBOutlet var draggableImageViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var draggableImageViewCenterYConstraint: NSLayoutConstraint!
    @IBOutlet var animateFadeButton: UIButton!
    
      private var imageViewDisplayState:  ImageViewDisplayState = .hidden
    
    enum ImageViewDisplayState {
        case visible
        case hidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        draggableImageView.alpha = 0
    }
    
    @IBAction func didPressFade(_ sender: UIButton) {
        let alpha: CGFloat
        let newImageViewDisplayState: ImageViewDisplayState
        let buttonTitle: String
        
        switch imageViewDisplayState {
        case .visible:
            // set new variables for hidden state
            alpha = 0
            newImageViewDisplayState = .hidden
            buttonTitle = "FADE IN"
        case .hidden:
            // set new variables for visible state
            alpha = 1
            newImageViewDisplayState = .visible
            buttonTitle = "FADE OUT"
        }
        
        animateFadeButton.setTitle(buttonTitle, for: .normal)
        
        UIView.animate(withDuration: 1) {
            self.draggableImageView.alpha = alpha
            self.imageViewDisplayState = newImageViewDisplayState
        }
    }
    
    @IBAction func handlePanGesture(_ panGestureReconizer: UIPanGestureRecognizer) {
        switch panGestureReconizer.state {
        case .began:
            print("We will begin moving the image view")
        case .cancelled:
            print("Pan was cancelled")
        case .changed:
            print("Pan was changed -- we will change the image view's frame")
            // Mark: - Movement
            let movement = panGestureReconizer.translation(in: view)
            draggableImageViewCenterXConstraint.constant += movement.x
            draggableImageViewCenterYConstraint.constant += movement.y
            panGestureReconizer.setTranslation(.zero, in: view)
        case .ended:
            print("User has finished moving")
        case .failed:
            print("Failed pan gesture")
        case .possible:
            print("It is possible to pan")
        @unknown default:
            fatalError("Uknown case")
            
        }
    }
}
