package debug.codename;

import openfl.text.TextField;

class ShadowBuildField extends TextField {
	public function new() {
		super();
		defaultTextFormat = Framerate.textFormat;
		autoSize = LEFT;
		multiline = wordWrap = false;
		reload();
	}

	public function reload()
		text = 'Shadow Engine v${states.MainMenuState.shadowEngineVersion}';
}
