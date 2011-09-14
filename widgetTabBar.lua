-- widgetTabBar.lua
-- Description: TabBar to use when working with widgets.
--
-- Version: 1.02
--
-- Copyright (C)2011 lano78, creativefusion.se All Rights Reserved.
-- 
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy of 
-- this software and associated documentation files (the "Software"), to deal in the 
-- Software without restriction, including without limitation the rights to use, copy, 
-- modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
-- and to permit persons to whom the Software is furnished to do so, subject to the 
-- following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all copies 
-- or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
-- DEALINGS IN THE SOFTWARE.
--
--
-- Limitations: 
-- User must be able to require the widget library.
-- Works with 3-5 tabs.
-- Only tested on iphone 3-4
-- Black tabBar only, unless you make custom images
--
-- ToDo;
-- Fix so it uses vector tabBg and highlight as backgrounds and custom tabIcons centered on tabs.
-- Fix so it can use tabIcons size 30x30px for iphone 3-3G, 60x60px for iphone4 (retina)
-- Vector tabBg/highlight size = 64x44px
--
-- How to use:
-- Same way as tabBar sample by Ansca.

module(..., package.seeall)

local widget = require("widget");
local screenWidth = display.contentWidth;
local screenHeight = display.contentHeight;

function newWidgetTabBar(params)
		
		local tabBarImg;
		local tab;
		local tabBg; -- for Vector tabBg
		local tabIconDefault;
		local tabIconOver;
		local highlight;
		local highlightBg; -- for Vector highlight
		local defaultGroup;
		local highlightGroup;
		local background = params.background;
		local tabs = params.tabs;
		local default = params.default;
		local over = params.over;
		local onRelease = params.onRelease;
		
		-- Create a group that holds the tabBar
		local tabBar = display.newGroup()
		
		-- Set up the tabBar background with the rects
		if background then
			-- if using an image as tabBarBg.
					tabBarImg = display.newImageRect ( tabBar, defines.TABBAR_IMG_BG , screenWidth, 49)
					tabBarImg:setReferencePoint(display.TopLeftReferencePoint)
					tabBarImg.x = 0;
					tabBarImg.y = screenHeight - tabBarImg.height;
			
		elseif not background then
			
			-- if using vector background for tabBarBg.
			local tabBarBg = display.newGroup()
		
			local baseTop;
			local baseBottom;
			local topHighlight_1;
			local topHighlight_2;
			local topGradient;
			local bottomGradient;
			
			baseTop = display.newRect(0, screenHeight - 49 , screenWidth, 24);
			topGradient = graphics.newGradient({71, 71, 71, 255}, {21, 21, 21, 255}, "down");
			baseTop:setFillColor(topGradient);
			baseTop:setReferencePoint(display.TopLeftReferencePoint);
			
			baseBottom = display.newRect(0, screenHeight - 25, screenWidth, 25);
			bottomGradient = graphics.newGradient({0, 0, 0, 255}, {0, 0, 0, 255}, "down");
			baseBottom:setFillColor(bottomGradient);
			baseBottom:setReferencePoint(display.TopLeftReferencePoint);
			
			topHighlight_1 = display.newRect(0, screenHeight - 49, screenWidth, 2);
			topHighlight_1:setFillColor(28, 28, 28, 100);
			topHighlight_1:setReferencePoint(display.TopLeftReferencePoint);
			
			topHighlight_2 = display.newRect(0, screenHeight - 47, screenWidth, 1);
			topHighlight_2:setFillColor(87, 87, 87, 255);
			topHighlight_2:setReferencePoint(display.TopLeftReferencePoint);
						
			tabBarBg:insert(baseTop);
			tabBarBg:insert(baseBottom);
			tabBarBg:insert(topHighlight_1)
			tabBarBg:insert(topHighlight_2);
			
			-- insert the tabBar background into the tabBar group.
			tabBar:insert(tabBarBg);
			
		end
		
		if not default then
			default = {}
			for i = 1, #tabs do
				table.insert(default,"tabIcon".. i ..".png");
			end
		end
		
		if not over then
			over = {}
				
			for i = 1, #tabs do
				
				table.insert(over,"tabIcon".. i .. "_over.png");
			end
		end
		
		for i = 1, #tabs do
		tab = widget.newButton { 
			label = tabs[i],  
			size = 11, 
			font = "Helvetica", 
			onRelease = onRelease, 
			emboss = false, 
			offset = 0, 
			default = default[i], 
			over = over[i],
			width = 64,
			height = 44,
		}
		tabBar:insert(tab.view);
		
		local totalTabs = #tabs;
		local tabBtnWidth = tab.width;
		local totalBtnWidth = tabBtnWidth * totalTabs;
		local tabSpacing = (screenWidth - totalBtnWidth)/(totalTabs+1);
		
		tab:setReferencePoint(display.CenterReferencePoint);	
		tab.x = tab.width*(i-1) + tabSpacing*i + tab.width*0.5;
		tab.y = screenHeight - tab.height*0.5;
		tab.label.y = 14;
		tab.labelColor = {168, 168, 168}
		tab.id = i;
		end
		
		tabBar.selected = function(target)
		if not target then 
			target = tabBar[2];
		end
		
		if tabBar.highlight then 
			display.remove(highlight);
			highlight = nil;
			
			print(" --> highlight removed, tab:" .. target.id .." is pressed");
		end
        
		-- highlight tab.
		highlight = widget.newButton { 
			label = tabs[target.id], 
			size = 11, 
			font = "Helvetica", 
			onRelease = onRelease, 
			emboss = false, 
			offset = 0, 
			default = over[target.id], 
			over = default[target.id],
			width = 64,
			height = 44,
		}
		highlight.id = target.id;
		highlight:setReferencePoint(display.CenterReferencePoint);
		highlight.x = target.x;
		highlight.y = target.y ;
		highlight.label.y = tab.label.y;
		highlight.labelColor = { 255, 255, 255 }
		
		tabBar:insert(highlight.view);
		
		tabBar.highlight = highlight;
   end
 return tabBar;

end