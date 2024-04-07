
Ksp-TeleTab
Author - The-Last-Knight @ https://discord.gg/ks-productions
===================================================================================================================

A basic script that allows admins/players to teleport to anywhere the config defines, By using a TeleTab Tablet "item". Preset your catagories and locations within the config and simply obtain the TeleTab Tablet to do the rest :-) 
Config Editible Menu Names/Icons/descriptions/locations - Create/add as many as you desire.
Menu sounds.
Fade out/in upon teleportation
Cost for teleportation per location adjustable in the config.lua
Lowered cost for returning to players last location
Ped and Vehicle teleportation
Server sided money handling
===================================================================================================================

Instulation:

1 - Download the file and extract the contents.
2 - Script folder name MUST be (Ksp-TeleTab) If it shows as Ksp-TeleTab-Main or else remove the (-Main).
3 - Upload it to your [standalone] folder.
4 - Add the following line to qb-core/shared/items.lua
                          ==============================================================================================================================================================================
						  teletab 			         = {name = 'teletab', label = 'Teleport Tablet', weight = 2000, type = 'item', image = 'teletab.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'A secured TeleTab tablet'}, 
						  ==============================================================================================================================================================================
5 - Add the included teletab.png image to qb-core/inventory/html/images folder
6 - Restart server and go back on and give your self the item "teletab" and check everything is working :-D
7 - Enjoy! & dont ask me for support! this is an easy one :-P
8 - Consider following me & join my discord for more free scripts! :-)

===================================================================================================================

Dependecies:

qb-core
Ksp-Menu - (could easily adapt to other menus)

(Easy to convert to standalone or ESX)

===================================================================================================================

License Agreement - KS Productions

Grant of License: This document certifies the grant of a license to the bearer for the use of the accompanying file (hereinafter referred to as "the File"). The licensee is authorized to modify and adapt the File to meet their personal or organizational needs.

Restrictions:

Resale Prohibition: The licensee is expressly prohibited from selling, redistributing, or otherwise commercializing the File in its original or any modified form.
Copyright: All code contained within the File is the intellectual property of KS Productions. The licensee must not replicate, distribute, or claim any portion of the code as their own.
Support: KS Productions commits to providing support exclusively for paid versions of the File. Releases distributed without charge are not eligible for support services.
Term: This license is effective immediately upon the purchase of the File and extends to all future versions released by KS Productions.

Copyright Notice: KS Productions holds and reserves all rights to the File and its content, including subsequent versions, under copyright law. Unauthorized use, duplication, or distribution is strictly prohibited.

Copyright © 2021 KS Productions. All rights reserved.

===================================================================================================================