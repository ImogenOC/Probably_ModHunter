-- ProbablyEngine Rotation Packager
-- Custom Beast Mastery Hunter Rotation
-- Created on Nov 6th 2013 2:10 am
ProbablyEngine.rotation.register_custom(253, "ModHunter_BM", 
{
    -- Combat
    { "pause", "modifier.lshift" },
    -- Pet
    { "!/cast [@pet,dead] Revive Pet; Call Pet 1", "!pet.alive" },
    { "!/cast [@pet,dead] Revive Pet; Call Pet 1", "!pet.exists" },
    -- Traps
    { "Explosive Trap", "modifier.ralt", "ground" },
    { "Snake Trap"    , "modifier.rshift", "ground" },
    { "Freezing Trap" , "modifier.rcontrol", "ground" },
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
     }, "modifier.interrupts"
    },

    -- Survival
    --{ "Deterrence", "player.health < 40" },
    { "Exhilaration", {
      "player.spell(109304).exists",
      "player.health < 50" 
    }},
    { "!/use healthstone",
      {
        "player.health < 40",
        "@modHunter.checkStone"
      }
    },
    { "Mend Pet", {
        "pet.health <= 75",
        "pet.exists",
        "!pet.buff(Mend Pet)"
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

    -- Cooldowns
    {{
      { "#gloves", "@modHunter.useGloves" },
      { "!/use Potion of Virmen's Bite", "@modHunter.usePot" },
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
      { "Rabid", {
          "player.spell(53401).exists",
          "player.buff(Bestial Wrath)"
      }},
      { "Stampede", "modifier.boss" },
      { "A Murder of Crows", {
          "player.spell(131894).exists",
          "modifier.boss"
      }},
      { "Lynx Rush", "player.spell(120697).exists" },
      { "Rapid Fire" },
      --{ "Rabid", "player.spell(53401).exists" },
    }, "modifier.cooldowns" },

    -- Shared
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
      --{ "Barrage", "player.spell(120360).exists" },
      { "Glaive Toss", "player.spell(117050).exists" },
      { "Multi-Shot", {
          "player.buff(Thrill of the Hunt)",
          "player.focus >= 60"
      }},
      { "Multi-Shot", "player.focus >= 80" },
      { "Cobra Shot", "player.focus < 40" }
    }, "modifier.multitarget" },

    -- Single
    { "Kill Shot", "target.health <= 20" },
    { "Serpent Sting", "!target.debuff(Serpent Sting)" },
    { "Cobra Shot", "target.debuff(Serpent Sting).duration < 4" },
    { "Glaive Toss", "player.spell(117050).exists" },
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
    }}
})

