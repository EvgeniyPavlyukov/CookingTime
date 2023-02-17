//
//  LayoutConstants.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 15.02.2023.
//

import UIKit

struct ConstantsCollectionView {
    static let leftDistanceToView: CGFloat = 20
    static let rightDistanceToView: CGFloat = 20
    static let topDistanceToView: CGFloat = 20
    static let bottomDistanceToView: CGFloat = 10
    static let minimumLineSpacing: CGFloat = 30
    static let itemWidth = (UIScreen.main.bounds.width - ConstantsCollectionView.leftDistanceToView - ConstantsCollectionView.rightDistanceToView - (ConstantsCollectionView.minimumLineSpacing / 2))
    static let itemHeight = ((UIScreen.main.bounds.height - ConstantsCollectionView.bottomDistanceToView - ConstantsCollectionView.topDistanceToView) / 2)
}
