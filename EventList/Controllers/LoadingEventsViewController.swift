//
//  ELLoadingEventsViewController.swift
//  EventList
//
//  Created by Mathieu LANOY on 12/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

class LoadingEventsViewController: LoadingViewController {

    @IBOutlet weak var cv_events: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        cv_events.delegate = self
        cv_events.dataSource = self
        cv_events.isScrollEnabled = false
        cv_events.register(UINib(nibName: EventCell.identifier, bundle: nil), forCellWithReuseIdentifier: EventCell.identifier)
        cv_events.register(UINib(nibName: EventHeaderView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: EventHeaderView.identifier)
        cv_events.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
    }
}

extension LoadingEventsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath)
        (cell as! EventCell).displayPlaceholder()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EventHeaderView.identifier, for: indexPath) as! EventHeaderView
            headerView.displayPlaceHolder()
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}


extension LoadingEventsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return EventCell.size(referenceWidth: self.cv_events.bounds.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0.0, 0.0, 30.0, 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return EventHeaderView.size(referenceWidth: self.cv_events.bounds.width)
    }
}
