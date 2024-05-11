import 'dart:io';

final platform = Platform.isAndroid ? "10.0.2.2" : "localhost";

String linkServerName = "http://$platform/ApiPHPfiles";
String linkImageRoot = "http://$platform/ApiPHPfiles/profile/upload";
// Auth
String linkSignUp = "$linkServerName/auth/signup.php";
String linklogin = "$linkServerName/auth/login.php";
String linkUserDelete = "$linkServerName/auth/delete.php";
String linkAdminlogin = "$linkServerName/auth/adminLogin.php";
String linkResetPassword = "$linkServerName/auth/resetPass.php";

// order
String linkorderAdd = "$linkServerName/orders/add.php";
String linkorderView = "$linkServerName/orders/view.php";

String linkorderDelete = "$linkServerName/orders/delete.php";
String linkorderDeleteAll = "$linkServerName/orders/deleteAll.php";
String linkorderEdit = "$linkServerName/orders/edit.php";

// Checkout_orders
String linkchehckorderAdd = "$linkServerName/orders/add.php";
String linkcheckorderView = "$linkServerName/orders/view.php";

// items

String linkitemAdd = "$linkServerName/items/add.php";
String linkitemView = "$linkServerName/items/view.php";
String linkitemDelete = "$linkServerName/items/Delete.php";
String linkitemEdit = "$linkServerName/items/Edit.php";
String linkImageItemRoot = "http://$platform/ApiPHPfiles/items/upload";

// wallet
String linkEditWallet = "$linkServerName/Wallet/edit.php";

// theme
String linkEditTheme = "$linkServerName/theme/edit.php";

// profilePics

String linkImageUplaod = "$linkServerName/profile/pfpUpload.php";
String linkImageView = "$linkServerName/profile/pfpView.php";
