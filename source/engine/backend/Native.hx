package backend;

import lime.app.Application;
import lime.system.Display;
import lime.system.System;
import flixel.util.FlxColor;

#if (cpp && windows)
@:buildXml('
<target id="haxe">
	<lib name="dwmapi.lib" if="windows"/>
	<lib name="gdi32.lib" if="windows"/>
</target>
')
@:cppFileCode('
#include <windows.h>
#include <dwmapi.h>
#include <winuser.h>
#include <wingdi.h>

#define DWMWA_USE_IMMERSIVE_DARK_MODE 20
#define DWMWA_USE_IMMERSIVE_DARK_MODE_BEFORE_20 19
#define DWMWA_CAPTION_COLOR 34
#define DWMWA_TEXT_COLOR 35
#define DWMWA_BORDER_COLOR 36

struct HandleData {
	DWORD pid = 0;
	HWND handle = 0;
};

BOOL CALLBACK findByPID(HWND handle, LPARAM lParam) {
	DWORD targetPID = ((HandleData*)lParam)->pid;
	DWORD curPID = 0;

	GetWindowThreadProcessId(handle, &curPID);
	if (targetPID != curPID || GetWindow(handle, GW_OWNER) != (HWND)0 || !IsWindowVisible(handle)) {
		return TRUE;
	}

	((HandleData*)lParam)->handle = handle;
	return FALSE;
}

HWND curHandle = 0;
void getHandle() {
	if (curHandle == (HWND)0) {
		HandleData data;
		data.pid = GetCurrentProcessId();
		EnumWindows(findByPID, (LPARAM)&data);
		curHandle = data.handle;
	}
}
')
#end
class Native
{
	public static function __init__():Void
	{
		registerDPIAware();
	}

	public static function registerDPIAware():Void
	{
		#if (cpp && windows)
		untyped __cpp__('
			SetProcessDPIAware();	
			#ifdef DPI_AWARENESS_CONTEXT
			SetProcessDpiAwarenessContext(
				#ifdef DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2
				DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2
				#else
				DPI_AWARENESS_CONTEXT_SYSTEM_AWARE
				#endif
			);
			#endif
		');
		#end
	}

	private static var fixedScaling:Bool = false;

	public static function fixScaling():Void
	{
		if (fixedScaling)
			return;
		fixedScaling = true;

		#if (cpp && windows)
		final display:Null<Display> = System.getDisplay(0);
		if (display != null)
		{
			final dpiScale:Float = display.dpi / 96;
			@:privateAccess Application.current.window.width = Std.int(Main.game.width * dpiScale);
			@:privateAccess Application.current.window.height = Std.int(Main.game.height * dpiScale);

			Application.current.window.x = Std.int((Application.current.window.display.bounds.width - Application.current.window.width) / 2);
			Application.current.window.y = Std.int((Application.current.window.display.bounds.height - Application.current.window.height) / 2);
		}

		untyped __cpp__('
			getHandle();
			if (curHandle != (HWND)0) {
				HDC curHDC = GetDC(curHandle);
				RECT curRect;
				GetClientRect(curHandle, &curRect);
				FillRect(curHDC, &curRect, (HBRUSH)GetStockObject(BLACK_BRUSH));
				ReleaseDC(curHandle, curHDC);
			}
		');
		#end
	}
	
	#if windows
	@:functionCode('
		getHandle();
		if (curHandle == (HWND)0) return;

		BOOL dark = enable ? TRUE : FALSE;

		if (S_OK != DwmSetWindowAttribute(curHandle, DWMWA_USE_IMMERSIVE_DARK_MODE_BEFORE_20, &dark, sizeof(dark))) {
			DwmSetWindowAttribute(curHandle, DWMWA_USE_IMMERSIVE_DARK_MODE, &dark, sizeof(dark));
		}

		if (enable) {
			COLORREF captionColor = RGB(32, 32, 32);
			COLORREF textColor = RGB(255, 255, 255);
			COLORREF borderColor = RGB(64, 64, 64);

			DwmSetWindowAttribute(curHandle, DWMWA_CAPTION_COLOR, &captionColor, sizeof(captionColor));
			DwmSetWindowAttribute(curHandle, DWMWA_TEXT_COLOR, &textColor, sizeof(textColor));
			DwmSetWindowAttribute(curHandle, DWMWA_BORDER_COLOR, &borderColor, sizeof(borderColor));
		}
	')
	private static function setDarkMode(enable:Bool):Void {}

	public static function darkMode(enable:Bool):Void
	{
		setDarkMode(enable);
		lime.app.Application.current.window.borderless = true;
		lime.app.Application.current.window.borderless = false;
	}
	#end
}
