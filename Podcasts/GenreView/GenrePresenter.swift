//  Created by Maxos on 4/29/23.

import Foundation

protocol GenresView: AnyObject {
    func display(_ genre: [Genre])
    func goToNextPage()
}

class GenrePresenter {
    weak var view: GenresViewController?
    var router: MyRouter?
    
    func onRefresh() {
       let request = URLRequest(url: URL(string: "https://listen-api-test.listennotes.com/api/v2/genres")!)
       let session = URLSession(configuration: .default)

       let task = session.dataTask(with: request) { data, _, error in
           guard let data = data else { return }
           do {
               let result = try JSONDecoder().decode(GenresResult.self, from: data)
               
               DispatchQueue.main.async {
                   self.view?.display(result.genres)
               }
           } catch {
               DispatchQueue.main.async {
                   print(error)
               }
           }
       }
       task.resume()
   }
    
    func onSelect(_ genre: Genre) {
        view?.goToNextPage()
    }
    
    func cellTapped(with id: Int) {
        router?.showNextScreen(with: id)
    }
}
