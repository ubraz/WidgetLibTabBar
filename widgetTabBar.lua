
-- Project: DrawWidgets
-- Description:
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2011 Lars Nordstrom. All Rights Reserved.
---- cpmgen main.lua
module(..., package.seeall)

local widget = require("widget");
local screenWidth = display.contentWidth;
local screenHeight = display.contentHeight;
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

function widgetTabBar(params)
		
		local tabBarImg
		local tab
		local highlight
		local highlightBg
		local background = params.background;
		local tabs = params.tabs;
		local default = params.default;
		local over = params.over;
		local onRelease = params.onRelease;
		
		-- Create a group that holds the tabBar
		local tabBar = display.newGroup()
		
		-- Set up the tabBar background with the rects
		if background then
			
					tabBarImg = display.newImageRect ( tabBar, "tabBar.png", screenWidth, 49)
					tabBarImg:setReferencePoint(display.TopLeftReferencePoint)
					tabBarImg.x = 0;
					tabBarImg.y = screenHeight - tabBarImg.height;
			
		elseif not background then
			local tabBarBg = display.newGroup()
		
			local baseTop;
			local baseBottom;
			local topHighlight_1;
			local topHighlight_2;
			local topGradient;
			local bottomGradient;
			
			baseTop = display.newRect( 0, screenHeight - 49 , screenWidth, 24)
			topGradient = graphics.newGradient({71, 71, 71, 255}, {21, 21, 21, 255}, "down")
			baseTop:setFillColor(topGradient )
			baseTop:setReferencePoint(display.TopLeftReferencePoint)
			
			baseBottom = display.newRect( 0, screenHeight - 25, screenWidth, 25)
			bottomGradient = graphics.newGradient({0, 0, 0, 255}, {0, 0, 0, 255}, "down")
			baseBottom:setFillColor(bottomGradient )
			baseBottom:setReferencePoint(display.TopLeftReferencePoint)
			
			topHighlight_1 = display.newRect(0, screenHeight - 49, screenWidth, 2)
			topHighlight_1:setFillColor(28, 28, 28, 255)
			topHighlight_1:setReferencePoint(display.TopLeftReferencePoint)
			
			topHighlight_2 = display.newRect(0, screenHeight - 48, screenWidth, 1)
			topHighlight_2:setFillColor(87, 87, 87, 255)
			topHighlight_2:setReferencePoint(display.TopLeftReferencePoint)
						
			tabBarBg:insert(baseTop)
			tabBarBg:insert(baseBottom)
			tabBarBg:insert(topHighlight_1)
			tabBarBg:insert(topHighlight_2)
			
			-- insert the tabBar background into the tabBar group.
			tabBar:insert(tabBarBg)
			return tabBarBg
		end
		
		if not default then
			default = {}
			
			for i = 1, #tabs do
				table.insert(default,"tab".. i ..".png")
			end	
		end
		
		if not over then
			over = {}
			
			for i = 1, #tabs do
				table.insert(over,"tab".. i .. "_over.png")
			end
		end
		
		
		for i = 1, #tabs do
		tab = widget.newButton { 
			label = tabs[i], 
			labelColor = { 255, 255, 255 }, 
			size = 12, 
			font = "Helvetica", 
			onRelease = onRelease, 
			emboss = false, 
			offset = 0, 
			default = default[i], 
			over = over[i],
		}
		tabBar:insert(tab.view)
		
		local numberOfTabs = #tabs;
		local tabButtonWidth = tab.width;
		local totalButtonWidth = tabButtonWidth * numberOfTabs;
		local tabSpacing = (screenWidth - totalButtonWidth)/(numberOfTabs+1)
		
		tab:setReferencePoint(display.TopLeftReferencePoint)	
		tab.x = tab.width*(i-1) + tabSpacing * i + tab.width*0.5
		tab.y = screenHeight - 46
		tab.label.y = 15
		tab.id = i
		end
		
		tabBar.selected = function(target)
		if not target then 
			target = tabBar[2]
		end
		
		if tabBar.highlight then 
			tabBar:remove(tabBar.highlight) 
		end
		
			--local highlight = display.newGroup()
			--local highlightTop = display.newRoundedRect(highlight, 4, screenHeight - 47, 75, 47, 4)
			--highlightTop:setFillColor(71, 71, 71, 100)
		
		highlight = widget.newButton { 
			label = tabs[target.id], 
			labelColor = { 255, 255, 255 }, 
			size = 12, 
			font = "Helvetica", 
			onRelease = onRelease, 
			emboss = false, 
			offset = 0, 
			default = over[target.id], 
			over = default[target.id],
		}
		highlight.id = target.id;
		highlight:setReferencePoint(display.TopLeftReferencePoint)
		highlight.x = target.x
		highlight.y = target.y 
		highlight.label.y = tab.label.y
		tabBar:insert(highlight.view);
		
		tabBar.highlight = highlight
   end
 return tabBar

end