//
//  ViewController.swift
//  SimilarUCScrollDemo
//
//  Created by YueWen on 16/3/4.
//  Copyright © 2016年 YueWen. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIScrollViewDelegate{
    
    var scrollView = UIScrollView()
    var simailarScorllView:YSimailarScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let titles = ["Hello","Objctive-C","Swift","C++","Java"]
        
        //创建滚动视图对象
        let frame = CGRect(x: 0, y: 30, width: self.view.bounds.size.width, height: 40)
        simailarScorllView = YSimailarScrollView(frame: frame)
        
        //设置相关属性
        simailarScorllView.titles = titles
        self.view.addSubview(simailarScorllView)
        
        simailarScorllView.selectTapBlockHandle { (scale) -> Void in
            
            //开始滚动下方的滚动视图
            self.scrollView.contentOffset = CGPoint(x: CGFloat(scale) * self.scrollView.bounds.size.width, y: 0)
            
        }
        
        
        //初始化滚动视图
        scrollView.frame = CGRect(x: 0, y: 70, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 70)
        scrollView.delegate = self;
        scrollView.isPagingEnabled = true
        self.view.addSubview(scrollView)
        
        
        
        //初始化五个视图
        for i in 0 ..< 5
        {
           scrollView.addSubview(createView(i, title: titles[i]))
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(titles.count) * scrollView.bounds.size.width, height: scrollView.bounds.size.height)
    }
    
    
    
    func createView(_ index : Int,title : String) -> UIView
    {
        let view = UIView(frame: CGRect(x: CGFloat(index) * scrollView.bounds.size.width,y: 0,width: scrollView.bounds.size.width,height: scrollView.bounds.size.height))
        
        let label = UILabel(frame: CGRect(x: 10,y: 20,width: 150,height: 30))
        label.textColor = UIColor.purple
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "我是" + title
        view.addSubview(label)
        
        return view
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UIScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        //获取当前的偏移量
        let point = scrollView.contentOffset;
        
        simailarScorllView.sliderSimailarScrollView(point)
    }
    
}

