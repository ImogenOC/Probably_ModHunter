local modHunter = { }

modHunter.eventHandler = function(self, ...)
  local subEvent                = select(1, ...)
  local source                = select(4, ...)
  local destGUID                = select(7, ...)
  local spellID                = select(11, ...)
  local failedType = select(14, ...)
  
  if UnitName("player") == source then
    if subEvent == "SPELL_CAST_SUCCESS" then
      if spellID == 6262 then -- Healthstone
        modHunter.items[6262] = { lastCast = GetTime() }
      end
      if spellID == 124199 then -- Landshark (itemId 77589)
        modHunter.items[77589] = { lastCast = GetTime(), exp = 0 }
      end
    end
  end
end

function modHunter.spellCooldown(spell)
  local spellName = GetSpellInfo(spell)
  if spellName then
    local spellCDstart,spellCDduration,_ = GetSpellCooldown(spellName)
    if spellCDduration == 0 then
      return 0
    elseif spellCDduration > 0 then
      local spellCD = spellCDstart + spellCDduration - GetTime()
      return spellCD
    end
  end
  return 0
end

function modHunter.useGloves(target)
  local hasEngi = false
  for i=1,9 do
    if select(7,GetProfessionInfo(i)) == 202 then hasEngi = true end
  end
  if hasEngi == false then return false end
  if GetItemCooldown(GetInventoryItemID("player", 10)) > 0 then return false end
  return true
end


function modHunter.usePot(target)
   -- Check for hero/bloodlust/etc
	if not (UnitBuff("player", 2825) or
			UnitBuff("player", 32182) or 
			UnitBuff("player", 80353) or
			UnitBuff("player", 90355)) then
		return false
	end
   -- 76089 = Virmen's Bite
	if GetItemCount(76089) < 1 then return false end
	if GetItemCooldown(76089) ~= 0 then return false end
	if not ProbablyEngine.condition["modifier.cooldowns"] then return false end
	if UnitLevel(target) ~= -1 then return false end
  if modHunter.t2d(target) > 30 then return false end
	return true 
end

function modHunter.t2d(target)
  if ProbablyEngine.module.combatTracker.enemy[UnitGUID(target)] then
    local ttdest = ProbablyEngine.module.combatTracker.enemy[UnitGUID(target)]['ttdest']
    local ttdsamp = ProbablyEngine.module.combatTracker.enemy[UnitGUID(target)]['ttdsamples']
    return (ttdest / ttdsamp)
	end
  return 600
end

function modHunter.validTarget(unit)
  if not UnitIsVisible(unit) then return false end
  if not UnitExists(unit) then return false end
  if not (UnitCanAttack("player", unit) == 1) then return false end
  if UnitIsDeadOrGhost(unit) then return false end
  local inRange = IsSpellInRange(GetSpellInfo(3044), unit) -- Arcane Shot
  if not inRange then return false end
  if inRange == 0 then return false end
  if not modHunter.immuneEvents(unit) then return false end
  return true
end


function modHunter.itemCooldown(itemID)
  return GetItemCooldown(itemID)
end

function modHunter.immuneEvents(unit)
  if UnitAura(unit,GetSpellInfo(116994))
		or UnitAura(unit,GetSpellInfo(122540))
		or UnitAura(unit,GetSpellInfo(123250))
		or UnitAura(unit,GetSpellInfo(106062))
		or UnitAura(unit,GetSpellInfo(110945))
		or UnitAura(unit,GetSpellInfo(143593)) -- General Nazgrim: Defensive Stance
    or UnitAura(unit,GetSpellInfo(143574)) -- Heroic Immerseus: Swelling Corruption
		then return false end
  return true
end

function modHunter.checkStone(target)
  if GetItemCount(6262, false, true) > 0 then
    if not modHunter.items[6262] then
      return true
    elseif (GetTime() - modHunter.items[6262].lastCast) > 120 then
      return true
    end
  end
end

function modHunter.checkShark(target)
  if GetItemCount(77589, false, false) > 0 then
    if not modHunter.items[77589] then return true end
    if modHunter.items[77589].exp ~= 0 and
      modHunter.items[77589].exp < GetTime() then return true end
  end
end


ProbablyEngine.library.register("modHunter", modHunter)
