//
//  ELEventsViewController.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

class ELEventsViewController: ELViewController, ELLoadingProtocol {

    //MARK: Attributes
    var indexes:[String] = []
    var events:[String:[ELEventModel]] = [:]
    
    //MARK: IBOutlets
    @IBOutlet weak var cv_events: UICollectionView!
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configure(_ value: (indexes:[String], values:[String: [ELEventModel]])) {
        self.events = value.values
        self.indexes = value.indexes
        view.backgroundColor = .white
        cv_events.delegate = self
        cv_events.dataSource = self
        cv_events.register(UINib(nibName: ELEventCell.identifier, bundle: nil), forCellWithReuseIdentifier: ELEventCell.identifier)
        cv_events.register(UINib(nibName: ELEventHeaderView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ELEventHeaderView.identifier)
        cv_events.reloadData()
    }
}

extension ELEventsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return indexes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = indexes[section]
        if let current_events = events[key] {
            return current_events.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ELEventCell.identifier, for: indexPath)
        let key = indexes[indexPath.section]
        if let event = events[key]?[indexPath.item] {
            (cell as! ELEventCell).display(event: event)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ELEventHeaderView.identifier, for: indexPath) as! ELEventHeaderView
            let key = indexes[indexPath.section]
            headerView.display(title: key)
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}


extension ELEventsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let key = indexes[indexPath.section]
        if let event = events[key]?[indexPath.item] {
            return ELEventCell.size(forEvent: event, referenceWidth: self.cv_events.bounds.width)
        }
        return .zero
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
        return ELEventHeaderView.size(referenceWidth: self.cv_events.bounds.width)
    }
}

