-- ProbablyEngine Rotation Packager
-- Modified Hunter Rotation for BM/SV
-- Created on Nov 6th 2013 2:10 am
ProbablyEngine.rotation.register_custom(255, "ModHunter_SV", 
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

    -- Cooldowns
    {{
      { "#gloves", "@modHunter.useGloves" },
      { "!/use Potion of Virmen's Bite", "@modHunter.usePot" },
      { "Rapid Fire" },
      { "Dire Beast", "player.spell(120679).exists" },
      { "Stampede", "modifier.boss" },
      { "A Murder of Crows", {
          "player.spell(131894).exists",
          "modifier.boss"
      }},
      { "Lynx Rush", "player.spell(120697).exists" },
      --{ "Rabid", "player.spell(53401).exists" },
    }, "modifier.cooldowns" },

    -- Shared
    { "Kill Shot", "target.health <= 20" },
    { "Explosive Shot", "player.buff(Lock and Load)" },
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
    }, "modifier.multitarget" },

    -- Single
    { "Serpent Sting", "!target.debuff(Serpent Sting)" },
    { "Black Arrow"},
    { "Cobra Shot", "target.debuff(Serpent Sting).duration < 4" },
    { "Explosive Shot" },
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
})

