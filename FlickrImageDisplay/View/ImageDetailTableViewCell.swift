import Foundation
import UIKit
import Kingfisher

class ImageDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var displayImageDesc: UILabel!
    
    func setData(_ imageDetail: ImageDetail) {
        displayImageDesc.text = imageDetail.title
        let url = URL(string: imageDetail.url)
        displayImage.kf.setImage(with:url)
    }

}
