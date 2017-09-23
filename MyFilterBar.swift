//
//  MyPager.swift
//  XiangQianJinApp
//
//  Created by boois on 2017/9/2.
//  Copyright © 2017年 xiangqianjin. All rights reserved.
//

import UIKit


class MyFilterBarData{
    public var txt = ""
    public var edige = ""
    public var click : ((_ image: String)->())?
    init(txt:String) {
        self.txt = txt
    }
}

class MyFilterBar:UIView ,UICollectionViewDataSource,UICollectionViewDelegate {
    
    public var gridView : UICollectionView?
    public var data : [MyFilterBarData] = []
    public override init(frame: CGRect){
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        __init()
        super.layoutSubviews()
        //        if self.data.count != 0 { render() }
    }
    func __init(){
        if gridView != nil {return}
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:self.frame.width/4,height:self.frame.height+8)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal;
        gridView = UICollectionView(frame: CGRect(x: 0, y:-1, width: self.frame.width, height: self.frame.height),collectionViewLayout:layout)
        print("self.frame.width",self.frame.width,"self.frame.height",self.frame.height,"layout.itemSize",layout.itemSize.width,layout.itemSize.height)
        gridView?.register(UINib(nibName:"MyFilterCell",bundle:nil), forCellWithReuseIdentifier: "cell")
        gridView?.isPagingEnabled = true
        gridView?.delegate = self
        gridView?.dataSource = self
        gridView?.backgroundColor = UIColor.clear
        
        let v = UIView(frame: CGRect(x:0,y:0,width:200,height:300))
            v.backgroundColor = UIColor.red
        controller2(view: self)?.view.addSubview(v)
        
        gridView?.contentInset = UIEdgeInsets(top: -9, left: 0, bottom: 0, right: 0);
        gridView?.showsHorizontalScrollIndicator = false
        self.addSubview(gridView!)
        
    }
    func controller2(view:UIView)->UIViewController?{
        var next:UIView? = view
        repeat{
            let nextResponder = next?.next
            if (nextResponder?.isKind(of: UIViewController.self))!{
                return (nextResponder as! UIViewController)
            }
            next = next?.superview
        }while next != nil
        return nil
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let label = cell.viewWithTag(88) as? UILabel
        label?.text = self.data[indexPath.row].txt
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView){
      
    }
    
    
    // 暂停计时
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
            }
    
    // 重新开始计时
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
       
    }
    
}
