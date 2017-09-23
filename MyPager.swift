//
//  MyPager.swift
//  XiangQianJinApp
//
//  Created by boois on 2017/9/2.
//  Copyright © 2017年 xiangqianjin. All rights reserved.
//

import UIKit


class MyPagerData{
    public var image = ""
    public var click : ((_ image: String)->())?
    init(image:String,click:((_ image: String)->())?) {
        self.image = image
        self.click = click
    }
}

class MyPager:UIView ,UICollectionViewDataSource,UICollectionViewDelegate {
//    public var scrollView : UIScrollView?
    public var gridView : UICollectionView?
    public var pageCtrl : UIPageControl?
    public var dotColor : UIColor = UIColor.lightGray
    public var atvDotColor : UIColor = UIColor.orange
    public var data : [MyPagerData] = []
    public var autoPlay = true
    var timer:Timer!
    public override init(frame: CGRect){
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        __init()
//        if self.data.count != 0 { render() }
    }
    func __init(){
        if pageCtrl != nil {return}
        timerstart()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:self.frame.width,height:self.frame.height+10 )
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal;
        gridView = UICollectionView(frame: CGRect(x: 0, y:0, width: self.bounds.width, height: self.bounds.height),collectionViewLayout:layout)
        gridView?.register(UINib(nibName:"MyPagerCell",bundle:nil), forCellWithReuseIdentifier: "cell")
        gridView?.isPagingEnabled = true
        gridView?.delegate = self
        gridView?.dataSource = self
        
        self.addSubview(gridView!)
        pageCtrl = UIPageControl(frame: CGRect(x: 0, y: self.bounds.height-20, width: self.bounds.width, height:20))
        pageCtrl?.numberOfPages = data.count
        pageCtrl?.currentPage = 0
        pageCtrl?.pageIndicatorTintColor = dotColor
        pageCtrl?.currentPageIndicatorTintColor = atvDotColor
        self.addSubview(pageCtrl!)
        
    }
    func countDown(){
        if self.pageCtrl?.currentPage == self.data.count - 1 {
            self.pageCtrl?.currentPage = 0
            self.gridView?.setContentOffset(CGPoint(x:0,y:0), animated: true)
        }else{
            self.pageCtrl?.currentPage = self.pageCtrl!.currentPage + 1
            self.gridView?.setContentOffset(CGPoint(x:gridView!.bounds.width * CGFloat(self.pageCtrl!.currentPage),y:0), animated: true)
        }
    }
    public func render(){
//        self.subviews.map({(subview: AnyObject) -> AnyObject in
//            subview.removeFromSuperview()
//            return subview
        //        })
        
        
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let img = cell.viewWithTag(99) as? UIImageView
//        let label = cell.viewWithTag(88) as? UILabel
        img?.image = UIImage(named:self.data[indexPath.row].image)
//        label?.text = self.data[indexPath.row].Txt
//        label?.textColor = self.data[indexPath.row].TxtColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //self.data[indexPath.row].click?(collectionView,indexPath)
        //pageCtrl?.currentPage = indexPath.row
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView){
        let currentPage = (Int)(scrollView.contentOffset.x) / (Int)(self.frame.size.width);
        self.pageCtrl?.currentPage = currentPage;//将上述的滚动视图页数重新赋给当前视图页数,进行分页
    }
    
    var isStart = false
    var isStartOk = false
    func timerstart(){
        if !autoPlay {return}
        timer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true, block: { (timer) in
            self.countDown()
        })
    }
    
    // 暂停计时
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
          if !autoPlay {return}
//        if isStartOk == false { return }
//        print ("暂停了")
//        isStart = false
//        self.timer.fireDate = NSDate.distantFuture
        timer.invalidate()
    }
    
    // 重新开始计时
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        timerstart()
//        if isStart  { return }
//        print ("开始了")
//        self.perform(#selector(timerstart), with: nil, afterDelay: 2.5)
//        isStart = true
    }

}
