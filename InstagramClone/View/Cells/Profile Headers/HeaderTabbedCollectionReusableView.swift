//
//  HeaderTabbedCollectionReusableView.swift
//  HeaderTabbedCollectionReusableView
//
//  Created by Nilesh Kumar on 14/02/22.
//

import UIKit

protocol HeaderTabbedCollectionReusableViewDelegate: AnyObject{
    
    func didTappedGridButton()
    func didTappedTagButton()
}

class HeaderTabbedCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderTabbedCollectionReusableView"
    
    public var delegate: HeaderTabbedCollectionReusableViewDelegate?
    
    private var gridButton: UIButton = {
        let gridButton = UIButton()
        gridButton.clipsToBounds = true
        gridButton.tintColor = .systemBlue
        gridButton.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return gridButton
    }()
    
    private var tagButton: UIButton = {
        let tagButton = UIButton()
        tagButton.clipsToBounds = true
        tagButton.tintColor = .lightGray
        tagButton.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return tagButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridButton)
        addSubview(tagButton)
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonSize = height - 8
        let widthSize = (width / 2 - buttonSize) / 2
        gridButton.frame = CGRect(x: widthSize, y: 2, width: buttonSize - 4, height: buttonSize - 4)
        tagButton.frame = CGRect(x: widthSize + width / 2, y: 2, width: buttonSize - 4, height: buttonSize - 4)
    }
    
    private func addTargets(){
        gridButton.addTarget(self, action: #selector(tappedGridButton), for: .touchUpInside)
        tagButton.addTarget(self, action: #selector(tappedTagButton), for: .touchUpInside)
    }
    
    @objc func tappedGridButton(){
        
        gridButton.tintColor = .systemBlue
        tagButton.tintColor = .lightGray
        
        delegate?.didTappedGridButton()
    }
    
    @objc func tappedTagButton(){
        
        gridButton.tintColor = .lightGray
        tagButton.tintColor = .systemBlue
        
        delegate?.didTappedTagButton()
    }
    
}
