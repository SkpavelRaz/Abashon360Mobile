enum KAssetName { main_logo, ic_login_bg }

extension AssetsExtention on KAssetName {
  String get imagePath {
    String _rootPath = 'assets';
    String _svgDir = '$_rootPath/svg';
    String _imageDir = '$_rootPath/images';

    switch (this) {
      case KAssetName.ic_login_bg:
        return "$_imageDir/auth_bg.png";

      case KAssetName.main_logo:
        return "$_imageDir/ic_abashon_logo.png";

      default:
        return "";
    }
  }
}
