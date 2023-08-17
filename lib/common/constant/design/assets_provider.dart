extension AssetsUtils on String {

  /// assets/svg/$this.svg
  String get svg => 'assets/svg/$this.svg';

  /// assets/images/$this.png
  String get png => 'assets/images/$this.png';

  /// assets/images/$this.jpg
  String get jpg => 'assets/images/$this.jpg';

  /// assets/animations/$this.json
  String get json => 'assets/animations/$this.json';

  /// assets/animations/$this.flr
  String get flr => 'assets/animations/$this.flr';

  /// assets/animations/$this.riv
  String get riv => 'assets/animations/$this.riv';
}

abstract class AppAssets {

  /// region SVG Section
  static get backButtonSvg => 'back_button'.svg;
  static get menuSvg => 'menu'.svg;
  static get tableSvg => 'table'.svg;
  static get logoSvg => 'logo'.svg;
  static get controlSvg => 'control'.svg;

  ///endregion


//...
//...

  ///! JPG  Section
  ///! PNG  Section



  /// region JSON Section
  static get dataAnimation => 'data'.json;
  static get paperAnimation => 'paper'.json;
  static get glovesAnimation => 'gloves'.json;

  ///endregion
  ///! FLR  Section

}
