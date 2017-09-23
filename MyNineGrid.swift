//
//  MyNineGrid.swift
//  HengChengHui
//
//  Created by boois on 2017/6/22.
//  Copyright © 2017年 boois. All rights reserved.
//

import UIKit

class MyNineGridCell{
    var Img:String = ""
    var Txt:String = ""
    var TxtColor:UIColor = UIColor.black
    var Click:((_ collectionView: UICollectionView,_ indexPath: IndexPath)->())?
    
    init(Img:String,Txt:String,TxtColor:UIColor,Click:((_ collectionView: UICollectionView,_ indexPath: IndexPath)->())?) {
        self.Img = Img
        self.Txt = Txt
        self.TxtColor = TxtColor
        self.Click = Click
    }
}

class MyNineGrid:UICollectionView ,UICollectionViewDataSource,UICollectionViewDelegate{
   
    var data:[MyNineGridCell] = []
    func setData(data:[MyNineGridCell]){
        self.data = data
        self.reloadData()
        lo()
    }
    var is_lo = false
    func doit(){
        self.register(UINib(nibName: "IconTxtCell", bundle: nil), forCellWithReuseIdentifier: "IconTxtCell")
        self.dataSource = self
        self.delegate = self

    }
    func lo(){
        let layout = UICollectionViewFlowLayout()
        let cell_w = (self.frame.width-10)/3
        layout.itemSize = CGSize(width:cell_w-2,height:cell_w )
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.collectionViewLayout = layout
        is_lo = true
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        doit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.data.count != 0 { lo() }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doit()
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconTxtCell", for: indexPath)
        let img = cell.viewWithTag(99) as? UIImageView
        let label = cell.viewWithTag(88) as? UILabel
        img?.image = UIImage(named:self.data[indexPath.row].Img)
        label?.text = self.data[indexPath.row].Txt
        label?.textColor = self.data[indexPath.row].TxtColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.data[indexPath.row].Click?(collectionView,indexPath)
    }

    
}
