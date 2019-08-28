AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "hud.lua" )
AddCSLuaFile( "sb.lua" )
util.AddNetworkString("FMenu")
util.AddNetworkString("set")
include( "shared.lua" )
include( "sb.lua" )
DeriveGamemode( "sandbox" )
function GM:PlayerLoadout(ply)
   ply:Give('weapon_crowbar')
   ply:Give('weapon_fists')
   ply:Give('tfa_hl2_pistol')
   ply:Give('tfa_hl2_357')
   ply:Give('tfa_hl2_smg1')
   ply:Give('tfa_hl2_shotgun')
   ply:Give('tfcss_hegrenade')
   ply:Give('weapon_physcannon')
   ply:Give('tfa_hl2_crossbow')
   ply:Give('climb_swep2')
   ply:Give('grapplehook')
   ply:Give('yetanother3dmg')
   ply:GiveAmmo( 50, 'pistol', false )
   ply:GiveAmmo( 12, '357', false )
   ply:GiveAmmo( 75, 'SMG1', false )
   ply:GiveAmmo( 2, 'SMG1_Grenade', false )
   ply:GiveAmmo( 20, 'Buckshot', false )
   ply:GiveAmmo( 4, 'Grenade', false )
   ply:GiveAmmo( 12, 'XBowBolt', false )
   ply:Flashlight(true)
   ply:AllowFlashlight(true)
   return true
end




function GM:PlayerInitialSpawn(ply)
	ply:SetModel("models/player/group01/male_07.mdl")
end

function GM:ShowSpare2(ply)
	net.Start("FMenu")
	net.Send(ply)
end
net.Receive( "set", function( len, ply ) -- len is the net message length, which we don't care about, ply is the player who sent it.
	 local color = net.ReadTable()
	 local model = net.ReadString()
	 ply:SetPlayerColor(Vector(color.r/255, color.g/255, color.b/255))
	 ply:SetModel(model)
	 local oldhands = ply:GetHands()
	if ( IsValid( oldhands ) ) then oldhands:Remove() end

	local hands = ents.Create( "gmod_hands" )
	if ( IsValid( hands ) ) then
		ply:SetHands( hands )
		hands:SetOwner( ply )

		-- Which hands should we use?
		local cl_playermodel = ply:GetInfo( "cl_playermodel" )
		local info = player_manager.TranslatePlayerHands( cl_playermodel )
		if ( info ) then
			hands:SetModel( info.model )
			hands:SetSkin( info.skin )
			hands:SetBodyGroups( info.body )
		end

		-- Attach them to the viewmodel
		local vm = ply:GetViewModel( 0 )
		hands:AttachToViewmodel( vm )

		vm:DeleteOnRemove( hands )
		ply:DeleteOnRemove( hands )

		hands:Spawn()
	end
end )
