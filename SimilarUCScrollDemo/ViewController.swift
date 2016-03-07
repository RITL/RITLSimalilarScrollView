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
        let frame = CGRectMake(0, 30, self.view.bounds.size.width, 40)
        simailarScorllView = YSimailarScrollView(frame: frame)
        
        //设置相关属性
        simailarScorllView.titles = titles
        self.view.addSubview(simailarScorllView)
        
        simailarScorllView.selectTapBlockHandle { (scale) -> Void in
            
            //开始滚动下方的滚动视图
            self.scrollView.contentOffset = CGPoint(x: CGFloat(scale) * self.scrollView.bounds.size.width, y: 0)
            
        }
        
        
        //初始化滚动视图
        scrollView.frame = CGRectMake(0, 70, self.view.bounds.size.width, self.view.bounds.size.height - 70)
        scrollView.delegate = self;
        scrollView.pagingEnabled = true
        self.view.addSubview(scrollView)
        
        
        
        //初始化五个视图
        for(var i = 0; i < 5; i++)
        {
           scrollView.addSubview(createView(i, title: titles[i]))
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(titles.count) * scrollView.bounds.size.width, height: scrollView.bounds.size.height)
    }
    
    
    
    func createView(index : Int,title : String) -> UIView
    {
        let view = UIView(frame: CGRectMake(CGFloat(index) * scrollView.bounds.size.width,0,scrollView.bounds.size.width,scrollView.bounds.size.height))
        
        let label = UILabel(frame: CGRectMake(10,20,150,30))
        label.textColor = UIColor.purpleColor()
        label.font = UIFont.systemFontOfSize(14)
        label.text = "我是" + title
        view.addSubview(label)
        
        return view
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UIScrollView Delegate
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        //获取当前的偏移量
        let point = scrollView.contentOffset;
        
        simailarScorllView.sliderSimailarScrollView(point)
    }
    
}

