//
//  Location.swift
//  HandsOnProject
//
//  Created by Yundong Lee on 2021/11/22.
//

import Foundation

enum Location{
    case Seoul
    case kyunggi
    case ChungChungNam
    case ChungChungBuk
    case JeonraNam
    case JeonraBuk
    case KungSangNam
    case KungSangBuk
}


struct resultJson: Decodable {
    var isSuccess: Bool
    var code: Int
    var result:result2
}

struct result2: Decodable{
    var userIdx: Int
    var jwt : String
}
//{"isSuccess":true,"code":1000,"message":"ìì²­ì ì±ê³µíììµëë¤.","result":{"userIdx":7,"jwt":"eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWR4Ijo3LCJpYXQiOjE2Mzk3MDM1NjAsImV4cCI6MTY0MTE3NDc4OX0.BQFKIOnmR1Tka-QdGN727IQNyCnvmVdzIYDqnpSy0KU"}}
