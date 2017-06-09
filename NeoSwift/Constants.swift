//
//  Constants.swift
//  Esds Enlight
//
//  Created by esds on 3/4/17.
//  Copyright © 2017 Esds Solutions. All rights reserved.
//

import UIKit

class Constants: NSObject {
    static let REF_WIDTH: CGFloat = 414.0
    static let REF_HEIGHT: CGFloat = 736.0
    
    static let DARK_COLOR = 0xE91B1A
    
    static let GOTHAM_BOOK = "Gotham-Book"
    static let GOTHAM_MEDIUM = "GothamMedium"
    static let GOTHAM_BOLD = "GothamBold"
    static let GUJARATI_SANGAM = "GujaratiSangamMN-Bold"
    
    static let GET = "GET"
    static let POST = "POST"

    static let BASE_URL = "http://staging.php-dev.in:8844/trainingapp/api"
    
    static let REGISTER = "/users/register"
    static let LOGIN = "/users/login"
    static let FORGOT = "/users/forgot"
    static let CHANGE = "/users/change"
    static let UPDATE = "/users/update"
    static let GET_USER_DATA = "/users/getUserData"
    static let GET_LIST = "/products/getList"
    static let GET_DETAIL = "/products/getDetail"
    static let SET_RATING = "/products/setRating"
    static let ADD_TO_CART = "/addToCart"
    static let EDIT_CART = "/editCart"
    static let DELETE_CART = "/deleteCart"
    static let CART = "/cart"
    static let ORDER = "/order"
    static let ORDER_LIST = "/orderList"
    static let ORDER_DETAIL = "/orderDetail"
}
