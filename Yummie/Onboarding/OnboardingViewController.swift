//
//  OnboardingViewController.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 17/10/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    private var slides: [OnboardingSlide] = [
        OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures.", image: UIImage(named: "slide1")!),
        OnboardingSlide(title: "World-Class Chefs", description: "Our dishes are prepared by only the best.", image: UIImage(named: "slide2")!),
        OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.", image: UIImage(named: "slide3")!),
    ]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.id)
//        cv.isPagingEnabled = false
        cv.showsHorizontalScrollIndicator = false
        cv.automaticallyAdjustsScrollIndicatorInsets = true
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .systemRed
        pageControl.allowsContinuousInteraction = true
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.numberOfPages = 3
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.backgroundColor = .systemGray
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        configureConstraints()
        actions()

    }
    
    private func actions() {
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    @objc func didTapNextButton() {
        //última "página"
        if currentPage == slides.count - 1 {
            let vc = UINavigationController(rootViewController: HomeViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -40),
            
            nextButton.widthAnchor.constraint(equalToConstant: view.frame.width - 240),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            pageControl.widthAnchor.constraint(equalTo: nextButton.widthAnchor)
        
        ])
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.id, for: indexPath) as! OnboardingCollectionViewCell
        
        let model = slides[indexPath.row]
        cell.setup(model)
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    
}
