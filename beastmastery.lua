-- ProbablyEngine Rotation Packager
-- Modified Hunter Rotation for BM/SV
-- Created on Nov 6th 2013 2:10 am
ProbablyEngine.rotation.register_custom(253, "ModHunter_BM", 
{
    -- Combat
    { "pause", "modifier.lshift" },
    -- Pet
    -- TODO: Is this working correctly?
    { "883", "!pet.exists" }, -- Call Pet 1
    -- TODO: this isn't working correctly, need to revisit
    --{ "Heart of the Phoenix", "!pet.alive" }, -- Heart of the Phoenix (55709)
    { "982", "!pet.alive" }, -- Revive Pet

    -- Traps (doesn't work in OSX due to a bug with the right alt/shift/control buttons)
    { "Explosive Trap", "modifier.ralt", "ground" },
    { "Snake Trap"    , "modifier.ralt", "ground" },
    { "Freezing Trap" , "modifier.ralt", "ground" },
    -- Binding Shot
    { "Binding Shot" , "modifier.lcontrol", "ground" },
    -- Barrage
    { "Barrage", {
      "player.spell(120360).exists",
       "modifier.lalt"
    }},

    -- Interrupt
    {{
      { "Counter Shot" },
      { "Scatter Shot", "player.spell(Counter Shot).cooldown" }
      -- TODO: This doesn't work correctly, need to revisit
      --{ "19801", "@modHunter.enrageEvents" } -- Tranquilizing Shot
     }, "modifier.interrupts"
    },

    -- Survival
    --{ "Deterrence", "player.health < 40" },
    { "Exhilaration", {
      "player.spell(109304).exists",
      "player.health < 50" 
    }},
    -- TODO: These are bugged and break the rotation if not in your bag, need to revisit
    --{ "#5512", "player.health < 40" }, -- Healthstone
    --{ "#76097", "player.health < 40" }, -- Master Healing Potion
    { "Mend Pet", {
        "pet.health <= 75",
        "pet.exists",
        "!pet.buff(Mend Pet)"
    }},
    -- Misdirect to focus target or pet when threat is > 50%
    { "Misdirection", { 
        "focus.exists", 
        "target.threat > 50"
    }, "focus" },
    { "Misdirection", { 
        "pet.exists", 
        "!focus.exists", 
        "target.threat > 50"
    }, "pet" },


    { "109260", { -- Aspect of the Iron Hawk
        "player.spell(109260).exists",
        "!player.buff(109260)",
        "!player.moving"
    }},
    { "13165", { -- Aspect of the Hawk
        "!player.spell(109260).exists",
        "!player.buff(13165)",
        "!player.moving"
    }},

    -- Cooldowns
    {{
      --{ "!/use Potion of Virmen's Bite", "@modHunter.usePot" },
      -- TODO: Verify that this actually works
      { "#76089", "@modHunter.usePot" },
      { "121818", "player.spell(121818).exists" }, -- Stampede
      { "131894", "player.spell(131894).exists" }, -- A Murder of Crows
      { "120697", "player.spell(120697).exists" }, -- Lynx Rush
      -- TODO: How to track and handle Rabpid which is a pet spell
      --{ "Rabid", "player.spell(53401).exists" },
    }, "modifier.cooldowns" },

    -- Shared
    { "#gloves" },
    { "Kill Shot", "target.health <= 20" },
    { "Dire Beast", "player.spell(120679).exists" },
    { "Bestial Wrath" },
    -- TODO: play with timing of BW some more
    --{ "Bestial Wrath", {
    --    "player.spell(Kill Command).cooldown = 0"
    --}},
    { "Kill Command", {
        "pet.exists",
        "@coreHunter.petInRange"
    }},
    { "Rapid Fire" },
    { "Focus Fire", {
        "player.buff(Frenzy).count = 5",
        "!player.buff(Bestial Wrath)"
    }},
    { "Fervor", {
      "player.spell(82726).exists",
      "player.focus < 50" 
    }},

    -- AoE
    {{
      { "Barrage", "player.spell(120360).exists" },
      { "Multi-Shot", {
          "player.buff(Thrill of the Hunt)",
          "player.focus >= 60"
      }},
      --{ "Glaive Toss", "player.spell(117050).exists" },
      { "Multi-Shot", "player.focus >= 80" },
      { "Cobra Shot", "player.focus < 40" }
    }, 
    {
        "modifier.multitarget",
        "modifier.enemies > 2" -- Even is AOE is enabled, don't use unless there are at least 3 enemies
    },     
    },

    -- Single
    { "Serpent Sting", "!target.debuff(Serpent Sting)" },
    { "Cobra Shot", "target.debuff(Serpent Sting).duration < 4" },
    { "Glaive Toss" },
    -- TODO: Is it a good idea to use Barrage on CD?
    --{ "Barrage" },
    { "Powershot", "player.spell(109259).exists" },
    { "Arcane Shot", {
        "player.buff(Thrill of the Hunt)",
        "player.focus >= 60"
    }},
    { "Arcane Shot", "player.focus >= 80"},
    { "Cobra Shot" }
},
{
  -- Out of combat
    { "Mend Pet", {
        "pet.health <= 75",
        "pet.alive",
        "!pet.buff(Mend Pet)"
    }},
    {{
    {"5118", { -- Aspect of the Cheetah
        "player.moving",
        "!player.buff(5118)"
    }},
    { "109260", { -- Aspect of the Iron Hawk
        "player.spell(109260).exists",
        "!player.buff(109260)",
        "!player.moving"
    }},
    { "13165", { -- Aspect of the Hawk
        "!player.spell(109260).exists",
        "!player.buff(13165)",
        "!player.moving"
    }},
    }, "toggle.aspect" },
}, ProbablyEngine.library.libs.modHunter.buttons )

