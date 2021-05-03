//
//  DetailMovieViewController.swift
//  MovieSpot
//
//  Created by Anang Nugraha on 30/04/21.
//

import UIKit

class DetailMovieViewController: UIViewController {
    @IBOutlet weak var ivMovieBackdrop: UIImageView!
    @IBOutlet weak var cvCast: UICollectionView!
    var movieTitle: String = ""
    var movieId: Int = 0
    private var movieServices: MovieService! = MovieService()
    private var casts: [CastModel] = []{
        didSet{
            DispatchQueue.main.async {
                self.cvCast.reloadData()
            }
        }
    }
    func createLayout() -> UICollectionViewCompositionalLayout  {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.1)
            ),
            subitem: item, count: 4)
        
        
        group.interItemSpacing = .fixed(5)
        
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(500))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.interGroupSpacing = 5
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieTitle
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 75, height: 75)
        cvCast.collectionViewLayout = layout
        let nib = UINib(nibName: "\(CastCollectionViewCell.self)", bundle: nil)
        cvCast.register(nib, forCellWithReuseIdentifier: "\(CastCollectionViewCell.self)")
        cvCast.register(DetailHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeaderCollectionReusableView.identifier)
        cvCast.delegate = self
        cvCast.dataSource = self
        cvCast.frame = view.bounds
        cvCast.collectionViewLayout = createLayout()
        
        movieServices.getMovieCredits(movieId: movieId) { (cast: [CastModel]?) in
            self.casts = cast!
        } onError: { (e: String?) in
            self.showToast(message: e ?? "", font: .systemFont(ofSize: 16.0))
        }

       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind:kind, withReuseIdentifier: DetailHeaderCollectionReusableView.identifier, for: indexPath) as! DetailHeaderCollectionReusableView
        movieServices.getMovieDetail(movieId: movieId) { (detail: MovieDetailModel?) in
            if let movieDetail = detail{
                DispatchQueue.main.async {
                    header.configure(with: movieDetail)
                }
            }
        } onError: { (e: String?) in
            self.showToast(message: e ?? "", font: .systemFont(ofSize: 16.0))
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 200)
    }
    

}

extension DetailMovieViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.showToast(message: "\(casts[indexPath.row].name ?? "")", font: .systemFont(ofSize: 16.0))
    }
}

extension DetailMovieViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as! CastCollectionViewCell
        cell.configure(with: casts[indexPath.item])
        return cell
    }
}

extension DetailMovieViewController:    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
    }
}

extension DetailMovieViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
