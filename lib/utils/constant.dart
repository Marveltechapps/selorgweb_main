import 'package:flutter/material.dart';

//
var title = "";
var id = "";
var isMainCategory = false;
var mainCatId = "";
var isCategory = false;
var catId = "";

// svgs
var appTextImage = 'assets/appIcon.svg';

// pngs
var orangeImage = 'assets/orange.png';

var applogoImage = "assets/applogo.svg";
var phoneNumber = "6385932548";
var userId = "67e7c3c70d5dd4a47a57fe40";
var locationInitiatted = "";
String location = "No Location Found";
int noOfIteminCart = 0;
bool isLoggedInvalue = false;
int selectedIndex = 0;
int cartCount = 0;

// colors
var whiteColor = Colors.white;
var whitecolor = Colors.white;
var appbackgroundColor = Color(0xfff8f8f8);
var blackColor = Colors.black;
var appColor = Color(0xFF034703);
var greenColor = Color(0xFF67C33C);
var greyColor = Color(0x40000000);
var greyColor2 = Color(0xbb000000);
var otpColor = Color(0xFF52764E);
var redColor = Color(0xFFD92626);
var hometopColor = Color(0xFFD7FCA7);

// icons // svg

// search screen
var closesvg = "assets/icons/close.svg";
var backsvg = "assets/icons/back.svg";
// home widget
var profilesvg = "assets/icons/profile.svg";

// bottom navigation bar
var categorysvg = "assets/icons/category.svg";
var categoryssvg = "assets/icons/category_s.svg";
var homesvg = "assets/icons/home.svg";
var homessvg = "assets/icons/home_s.svg";
var cartsvg = "assets/icons/cart.svg";
var cartssvg = "assets/icons/cart_s.svg";
var profilessvg = "assets/icons/profiles.svg";

// setting
var ordersvg = "assets/icons/order.svg";
var customersvg = "assets/icons/customer.svg";
var addresssvg = "assets/icons/address.svg";
var generalInfosvg = "assets/icons/info.svg";
var notificationsvg = "assets/icons/notification.svg";
var refundssvg = "assets/icons/refunds.svg";
var paymentsvg = "assets/icons/payment.svg";
var privacysvg = "assets/icons/privacy.svg";
var termssvg = "assets/icons/terms.svg";

// cart
var coinsvg = "assets/icons/coin.svg";
var drbsvg = "assets/icons/drb.svg";
var ncdsvg = "assets/icons/ncd.svg";

// address
var editsvg = "assets/icons/edit.svg";
var deletesvg = "assets/icons/delete.svg";
var addaddresssvg = "assets/icons/add_address.svg";
//

// images // svg
var playStore = "assets/play_store.svg";
var appStore = "assets/app_store.svg";
// order
var emptyordersvg = "assets/empty_order.jpg";
// cart
var emptycartsvg = "assets/emptycart.svg";

// images
var placeHolderImage = "assets/placeholder.png";
var appLogo = "assets/applogo.svg";
var bgImage = "assets/bgimage.png";
var homeTop = "assets/hometop.png";
var profileImage = "assets/profile.png";
var homeImage = "assets/home.png";
var homesImage = "assets/home_s.png";
var categoryImage = "assets/category.png";
var categorysImage = "assets/category_s.png";
var cartImage = "assets/cart.png";
var cartsImage = "assets/cart_s.png";
var locationImage = "assets/locationimage.png";
var locationIcon = "assets/location_icon.png";
var couponImage = "assets/coupon.svg";
var ncdImage = "assets/ncd.png";
var drbImage = "assets/drb.png";
var productImage = "assets/product.png";
var verfiedImage = "assets/verified.png";
var cancelledImage = "assets/cancelled.png";
var successImage = "assets/success.png";
var viewCartImage = "assets/view_cart.png";
var emptyCartImage = "assets/emptycart.png";
var locIcon = "assets/locIcon.png";
var addIcon = "assets/add.png";
var oneIcon = "assets/one.png";
var twoIcon = "assets/two.png";
var threeIcon = "assets/three.png";
var fourIcon = "assets/four.png";
var fiveIcon = "assets/five.png";
var sixIcon = "assets/six.png";
var rateBanner = "assets/rate.png";
var crossIcon = "assets/cross.png";
var paymentIcon = "assets/payment.png";
var tipsImage = "assets/tips.png";
// icons
var gstIcon = "assets/gst.png";
var orderIcon = "assets/icons/order.png";
var customerIcon = "assets/icons/customer.png";
var addressIcon = "assets/icons/address.png";
var forwardIcon = "assets/icons/forward.png";
var generalInfoIcon = "assets/icons/info.png";
var notificationIcon = "assets/icons/notification.png";
var profileIcon = "assets/icons/profile.png";
var refundsIcon = "assets/icons/refunds.png";
var suggestIcon = "assets/icons/suggest.png";

// gif

var loadGif = "assets/loadgif.gif";

var getLatLonUrl =
    "https://maps.googleapis.com/maps/api/place/details/json?place_id=";
var baseUrl = "http://43.204.144.74:3000/v1/";
var otpUrl = "${baseUrl}otp/send-otp";
var verifyOtpUrl = "${baseUrl}otp/verify-otp";
var resendOtpUrl = "${baseUrl}otp/resend-otp";
var maincategoryUrl = "${baseUrl}mainCategory/list";
var categoryUrl = "${baseUrl}categoryList/list";
var grabEssaentialsUrl = "${baseUrl}grabEssentials/list";
var bannerUrl = "${baseUrl}bannerslist/list";
var bannerProductUrl = "${baseUrl}bannerProductList/list";
// {{local_URL}}v1/bannerProductList/list?banner_id=677212d080a962bfdeb320e0&product_id=6793896361c4500641a079c2
var saveAddressUrl = "${baseUrl}addresses/create";
var updateAddressUrl = "${baseUrl}addresses";
//{{local_URL}}bannerProductList/list?banner_id=677212d080a962bfdeb320e0
var deleteAddressUrl = "${baseUrl}addresses/";
var productUrl = "${baseUrl}productStyle/list";
var productDetailUrl = "${baseUrl}productStyle/";
var similarProductUrl = "${baseUrl}similarProduct/list?productId=";
var similarProductDetailUrl = "${baseUrl}similarProduct/";
var subCategoryUrl = "${baseUrl}subcategories/";
var addCartUrl = "${baseUrl}carts/add";
var removeCartUrl = "${baseUrl}carts/decrease";
var cartUrl = "${baseUrl}carts/";
var getAddressUrl = "${baseUrl}addresses/";
//?category_id=676431ddedae32578ae6d222
var faqUrl = "${baseUrl}faqs/";
var termsAndConditionUrl = "${baseUrl}terms/list";
var privacyPolicyUrl = "${baseUrl}privacy/list";
var faqsUrl = "${baseUrl}faqs/list";
var updateCartUrl = "${baseUrl}carts/update";
var updateDeliveryTipUrl = "${baseUrl}carts/update-delivery-tip";
var seachLocationUrl = "${baseUrl}location/search?query=";
var searchProductUrl = "${baseUrl}productStyle/search?query=";
var profileSaveUrl = "${baseUrl}users/create";
var getSavedProfileUrl = "${baseUrl}users/";
var updateProfileUrl = "${baseUrl}users/update-profile";
var clearCartUrl = "${baseUrl}carts/clear-cart?mobileNumber=";
var latlonggetAddressUrl =
    "https://maps.googleapis.com/maps/api/geocode/json?latlng=";
// var seachLocationUrl =
//     "https://nominatim.openstreetmap.org/search?format=json&q=";
