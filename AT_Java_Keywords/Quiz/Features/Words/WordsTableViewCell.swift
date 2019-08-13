//
//  WordsTableViewCell.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 08/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import UIKit

class WordsTableViewCell: UITableViewCell {
    
    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.words.body.font
        return label
    }()
    
    private lazy var lineSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: WordsTableViewCell.className)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(wordLabel)
        contentView.addSubview(lineSeparator)
        
        NSLayoutConstraint.activate([
            wordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            wordLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            lineSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineSeparator.heightAnchor.constraint(equalToConstant: 1),
            lineSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
    public func configure(word: String) {
        wordLabel.text = word
    }
    
}
