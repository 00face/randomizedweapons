-- 00face
if SERVER then
AddCSLuaFile("randomweaponloadout.lua")
end local weapons = {
    primary= {
{["name"] = "weapon_smg"},
{["name"] = "weapon_smgx"},
    },
    
    secondary = {
{["name"] = "weapon_crowbar"},
{["name"] = "weapon_crowbar"},        
    },
    
    grenade = {
        {["name"]="weapon_tttbasegrenade"},
        {["name"]="weapon_zm_molotov"},
        {["name"]="weapon_ttt_smokegrenade"}
    },
}

hook.Add("PlayerLoadout", "GiveWeapon", function(ply)
  
    local primaryweapon = table.Random( weapons.primary )
    local secondaryweapon = table.Random( weapons.secondary )
    local grenade = table.Random( weapons.grenade )
    
  
    ply:Give(primaryweapon.name)
    
  
    ply:Give(secondaryweapon.name)
    
  
    if primaryweapon.ammo == secondaryweapon.ammo then
        ply:GiveAmmo(primaryweapon.clipsize, primaryweapon.ammo)
    elseif primaryweapon.ammo == ""then
        ply:GiveAmmo(secondaryweapon.clipsize, secondaryweapon.ammo)
    else
        ply:GiveAmmo(primaryweapon.clipsize, primaryweapon.ammo)
        ply:GiveAmmo(secondaryweapon.clipsize, secondaryweapon.ammo)
    end
    noDrop = {"weapon_fists"}    
    
    ply:Give(grenade.name)
    
    hook.Add("PlayerSpawn", "Spawnhook", function(ply)
end) 

end)
