--***********************************************************************************************
-- Tony Hardiman, Christian McDonald, Jack Hartwig, Robert Morgan
-- Team Project
-- PlayerCharacter.lua
--***********************************************************************************************

-- Requirements
local Character = require("src.Characters.Character")
local Projectile = require("src.Characters.Projectile")
local PlayerMovementShoot = require("src.Characters.PlayerMovementShoot")
local display = require("display")
local physics = require("physics")

-- Module
PlayerCharacter = {}

function PlayerCharacter.Spawn()
    local Self = Character.new(display.newCircle( 200, display.contentCenterY, 50 ))

    -- Variables
    Self.shape.MaxHealthPoints = 5
    Self.shape.GameHUD = nil
    Self.shape.CurrentHealthPoints = Self.shape.MaxHealthPoints
    Self.shape.tag = "Player"
    Self.Damage = 2

    -- Physics
    physics.addBody( Self.shape, "dynamic", {isSensor = true} )
    Self.shape.gravityScale = 0

    -- Movement
    local PlayerMovementShoot = PlayerMovementShoot.new(Self)

    function Self.shape:DealDamage(damage)
        Self.shape.CurrentHealthPoints = Self.shape.CurrentHealthPoints - damage
        Self.shape.GameHUD:UpdateHealthBar()
    end

    function Self.shape:Fire()
        Projectile.new(Self.shape, {x = Self.shape.x + 50, y = Self.shape.y}, Self.Damage, 50, 0, 15)
    end

    -- Set Game HUD for updating
    function Self:SetHUD(in_Hud)
        Self.shape.GameHUD = in_Hud
    end

    return Self
end

return PlayerCharacter