import Foundation
import UIKit
import Kingfisher

class ImageDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flickImage: UIImageView!
    @IBOutlet weak var imgDesc: UILabel!
    
    func setData(_ imageDetail: ImageDetail) {
        imgDesc.text = imageDetail.title
        let url = URL(string: imageDetail.url)
        flickImage.kf.setImage(with:url)
    }

}
