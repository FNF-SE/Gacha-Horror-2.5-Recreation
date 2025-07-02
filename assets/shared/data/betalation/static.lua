local shaderName = "static"

function onCreate()
    makeLuaSprite("static")
    makeGraphic("shaderImage", screenWidth, screenHeight)
    setSpriteShader("shaderImage", "static")
    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        
        game.initLuaShader(shaderName);
        
        var shader0 = game.createRuntimeShader(shaderName);
        game.camGame.setFilters([new ShaderFilter(shader0)]);
        game.getLuaObject("static").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
        game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("static").shader)]);
        return;
    ]])
end

function onUpdate(elapsed)
    setShaderFloat("static", "iTime", os.clock())
end
