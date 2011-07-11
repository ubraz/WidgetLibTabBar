-- Widget viewController
-- Modified tabBar viewController with Retina support to work with widgetLib.

module (..., package.seeall)


--Values
local screenWidth = display.contentWidth;
local screenHeight = display.contentHeight;
local viewableScreenW = display.viewableContentWidth;
local viewableScreenH = display.viewableContentHeight;
local screenOffsetW = display.contentWidth -  display.viewableContentWidth;
local screenOffsetH = display.contentHeight - display.viewableContentHeight;

local newButton = widget.newButton;

function newTabBar(params)
   
   local background = params.background;
   local tabs = params.tabs;
   local default = params.default;
   local over = params.over;
   local onRelease = params.onRelease;
   --local tab;
   --local tabX = tab.width*(i-1) + tabSpacing * i + tab.width*0.5;
   --local tabY = math.floor(tab.height * 0.5 + 3);
   
   
   local tabBar = display.newGroup()
   
   if background then
      local tabBG = display.newImageRect("ui/tabBar.png", screenWidth, 49);
            --tabBG:setReferencePoint(display.TopLeftReferencePoint);
            tabBar:insert(tabBG);
   end
   
   -- Check for tab images
   if not default then
      -- if no tab images, use tab1.png, tab2.png, etc.
      default = {}
      for i = 1, #tabs do
         table.insert(default, "ui/tab".. i ..".png");
      end
   end
   
   if not over then
      -- if no over images, use tab1_over.png, tab2_over.png, etc.
      over = {}
      for i = 1, #tabs do
         table.insert(over, "ui/tab".. i .."_over.png");
      end
   end
   
   tabBar:setReferencePoint(display.TopLeftReferencePoint)
   tabBar.x = 0;
   tabBar.y = math.floor(screenHeight - tabBar.height - display.screenOriginY);
   
   -- Create the tabs
   for i = 1, #tabs do
      tab = newButton { 
         id = "i",
         default = default[i],
         over = over[i],
         onRelease = onRelease,
         label = tabs[i],
         labelColor = {100, 100, 100, 255},
         font = "Helvetica",
         size = 11,
         offset = 14,
         emboss = false,
         x = tabX, --tab.width*(i-1) + tabSpacing * i + tab.width*0.5,
         y = tabY, --math.floor(tab.height * 0.5 + 3),
         --width = ,
         --height = ,
         }
      tabBar:insert(tab.view)
      
      local tabX = tab.width * (i-1) + tabSpacing * i + tab.width*0.5;
      local tabY = math.floor(tab.height * 0.5 + 3)
      
      tab.id = i;
      
      local numberOfTabs = #tabs;   
      local tabBtnWidth = tab.width;
      local totalBtnWidth = tabBtnWidth * numberOfTabs;
      local tabSpacing = (screenWidth - totalBtnWidth)/(numberOfTabs+1)
      

   end
   
   tabBar.selected = function(target)
      if not target then target = tabBar[2] end
      if tabBar.highlight then tabBar:remove(tabBar.highlight) end
      
      local highlight = newButton {
         default = over[target.id],
         over = default[target.id],
         onRelease = onRelease,
         label = tabs[target.id],
         labelColor = {255, 255, 255, 255},
         font = "Helvetica",
         size = 11,
         offset = 14,
         emboss = false,
         x = target.x,
         y = target.y,
      }
      
      highlight.id = target.id;
      tabBar:insert(highlight.view)
      
      --highlight.x = target.x;
      --highlight.y = target.y;
      
      tabBar.highlight = highlight;
   end
   
   return tabBar;
  
end