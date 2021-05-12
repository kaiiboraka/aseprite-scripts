-- Aseprite Script to open dialog to create related shades
-- Written by aquova, 2018
-- https://github.com/aquova/aseprite-scripts
-- MODIFIED by kaiiboraka, 2021
-- https://github.com/kaiiboraka/aseprite-scripts

-- Open dialog, ask user for a color
function userInput()   
	local dlg = Dialog
	{
		title="Color to Shade"
	}
    -- Creates a starting color of black
    local defaultColor = Color{r=0, g=0, b=0, a=255}
	local colorfg = app.fgColor
	local colorbg = app.bgColor
    dlg:color{ id="color1", label="Choose a color", color=colorfg }
    dlg:button{ id="ok", text="OK" }
    dlg:button{ id="cancel", text="Cancel" }
    --dlg:show()

    return dlg.data
end

function generateColors(color)
    local colors = {}
    for light=1,0,-0.1 do
        local newCol = Color{h=color.hslHue, s=color.hslSaturation, l=light}
        table.insert(colors, newCol)
    end

    return colors
end

function showOutput(color)
    local dlg = Dialog
	{
		title = "Shades of Color"
	}
    local colorsList = generateColors(color)

    for i=1,#colorsList do
        dlg:newrow()
        dlg:shades{id='shade',
		colors={colorsList[i]},
		onclick=function(ev) app.fgColor=ev.color end }
    end

    dlg:button{ id="ok", text="OK" }
    dlg:show{wait=false}
end

-- Run script
do
    local color = userInput()
    --if color.ok then
        local userColor = Color{r=color.color1.red, g=color.color1.green, b=color.color1.blue, a=color.color1.alpha}
        showOutput(userColor)
    --end
end
