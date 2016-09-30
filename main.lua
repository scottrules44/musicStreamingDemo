local musicStreaming = require( "plugin.musicStreaming" )
musicStreaming.init()
local start = 0
--enter in url for streaming
local myNativeBox = native.newTextField( display.contentCenterX, display.contentCenterY-100, 200, 50 )

local playText = display.newText( "Play", display.contentCenterX, display.contentCenterY-180, native.systemFont, 20 )
playText:addEventListener( "tap", function (  )
	if (start == 0) then
		musicStreaming.play(myNativeBox.text, function ( e )
			local json = require("json")
			json.encode(e)
			if (e.response == "error loading song") then
				playText.text = "Play"
				print("error")
			end
			if (e.response == "starting") then
				playText.text = "Pause"
				start = 1
			end
			if (e.response == "finshed") then
				playText.text = "Play"
				start = 0
			end
		end)
		playText.text = "loading"
		
	elseif (playText.text== "Resume" and start == 1) then
		musicStreaming.resume(myNativeBox.text)
		playText.text = "Pause"
	elseif (playText.text== "Pause" and start == 1) then
		musicStreaming.pause(myNativeBox.text)
		playText.text = "Resume"
	end
end )
