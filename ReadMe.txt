tabBar for CoronaSDK widgets
1.01
This version is based on tabBar sample by Ansca.
Build Version 2011.617 (2011.8.2)
-------------------------------------------

Known errors;
none at this point.

-------------------------------------------

Limitations: 
You must be able to require the widget library to use this, if not then use viewController from CoronaSDK sample folder.

Works with 3-5 tabs.
Only tested on iphone 3-4, portrait.

-------------------------------------------

TabIcons:
sizes;
background: 
highlight,
64x44px / 128x88px on Retina, highlighted roundedRect with corner radius 4 on   	retina, color 71,71,71, Alpha at 40%. 
default, transparentBg,   
Icon: 30x30px / 60x60px Retina, You can make these smaller if you want.

-------------------------------------------

ToDo;
Vectorize all images except tabIcons

Fix so it uses vector tabBg (alpha=0) and highlight as backgrounds and custom tabIcons centered on tabs with yOffSet to fit the text label of the tab.

Fix so it can use tabIcons size 30x30px for iphone 3-3G, 60x60px for iphone4 (retina)

Vector tabBg/highlight size = 64x44px radius 2px

How to use:
Same way as tabBar sample by Ansca.
If no background is specified, then it uses the vector tabBg.

Questions?

tweet me @lano78


