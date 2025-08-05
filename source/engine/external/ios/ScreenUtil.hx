package external.ios;

/**
 * From Funkin
 * https://github.com/FunkinCrew/Funkin/blob/main/source/funkin/mobile/external/android/ScreenUtil.hx
 */
@:buildXml('<include name="../../../../../../../source/engine/external/ios/project/build.xml" />')
@:include('ScreenUtil.hpp')
extern class ScreenUtil
{
	@:native('getSafeAreaInsets')
	static function getSafeAreaInsets(top:cpp.RawPointer<Float>, bottom:cpp.RawPointer<Float>, left:cpp.RawPointer<Float>, right:cpp.RawPointer<Float>):Void;

	@:native('getScreenSize')
	static function getScreenSize(width:cpp.RawPointer<Float>, height:cpp.RawPointer<Float>):Void;
}
