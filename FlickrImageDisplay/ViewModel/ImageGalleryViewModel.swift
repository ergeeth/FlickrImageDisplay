import Foundation
import Combine

protocol ImageGalleryViewModelType {
    var stateBinding: Published<ViewState>.Publisher { get }
    var imageDetailsCount:Int { get }
    var imageDetails:[ImageDetail] { get }
    func search(request: Request)
}

final class ImageGalleryViewModel: ImageGalleryViewModelType {
    
    var stateBinding: Published<ViewState>.Publisher{ $state }
    
    private let networkManager:Networkable
    private var cancellables:Set<AnyCancellable> = Set()
    
    @Published  var state: ViewState = .none
    
    var imageDetails: [ImageDetail] = []
    
    var imageDetailsCount: Int {
        return imageDetails.count
    }
    
    init(networkManager:Networkable) {
        self.networkManager = networkManager
    }
    
    func search(request: Request) {
        
        state = ViewState.loading
        let publisher = networkManager.doApiCall(apiRequest: request)
        
        let cancelable = publisher.sink { [weak self ]completion in
            switch completion {
            case .finished:
                break
            case .failure(_):
                self?.imageDetails = []
                self?.state = ViewState.error("Network Not Availale")
            }
        } receiveValue: { [weak self] images in
            self?.imageDetails = images
            self?.state = ViewState.finishedLoading
        }
        self.cancellables.insert(cancelable)
    }
    
    
    deinit {
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
    
    
}
