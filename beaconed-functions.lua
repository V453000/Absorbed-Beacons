global_beacon_transmission_effect = data.raw["beacon"]["beacon"].distribution_effectivity --or 0
global_beacon_module_slots = data.raw["beacon"]["beacon"].module_specification.module_slots --or 0
global_beacon_drain = data.raw["beacon"]["beacon"].energy_usage -- or 0
global_speed_module_1_speed_bonus = data.raw["module"]["speed-module"].effect.speed.bonus --or 0
global_speed_module_2_speed_bonus = data.raw["module"]["speed-module-2"].effect.speed.bonus --or 0
global_speed_module_3_speed_bonus = data.raw["module"]["speed-module-3"].effect.speed.bonus --or 0
global_productivity_module_1_speed_bonus = data.raw["module"]["productivity-module"].effect.speed.bonus --or 0
global_productivity_module_2_speed_bonus = data.raw["module"]["productivity-module-2"].effect.speed.bonus --or 0
global_productivity_module_3_speed_bonus = data.raw["module"]["productivity-module-3"].effect.speed.bonus --or 0
global_speed_module_1_energy_usage_bonus = data.raw["module"]["speed-module"].effect.consumption.bonus --or 0
global_speed_module_2_energy_usage_bonus = data.raw["module"]["speed-module-2"].effect.consumption.bonus --or 0
global_speed_module_3_energy_usage_bonus = data.raw["module"]["speed-module-3"].effect.consumption.bonus --or 0
global_productivity_module_1_energy_usage_bonus = data.raw["module"]["productivity-module"].effect.consumption.bonus --or 0
global_productivity_module_2_energy_usage_bonus = data.raw["module"]["productivity-module-2"].effect.consumption.bonus --or 0
global_productivity_module_3_energy_usage_bonus = data.raw["module"]["productivity-module-3"].effect.consumption.bonus --or 0

global_assembling_machine_beacon_count    = 12
global_electric_furnace_beacon_count      = 12
global_lab_beacon_count                   = 12
global_oil_refinery_beacon_count          = 16
global_chemical_plant_beacon_count        = 12
global_centrifuge_beacon_count            = 12
global_rocket_silo_beacon_count           = 20
global_electric_mining_drill_beacon_count = 4
global_pumpjack_beacon_count              = 4

function beaconed_crafting_speed(params)
  local machine_crafting_speed     = params.machine_crafting_speed or 1
  local machine_module_slots       = params.module_slots or 4
  local beacon_count               = params.beacon_count or 12
  local beacon_effect              = params.beacon_effect or 0.5
  local beacon_module_slots        = params.beacon_module_slots or 2
  local beacon_module_speed_bonus  = params.beacon_module_speed_bonus or 0.5
  local machine_module_speed_bonus = params.machine_module_speed_bonus or -0.15

  local beacon_speed_effect         = beacon_count * beacon_module_speed_bonus * beacon_effect * beacon_module_slots
  local machine_module_speed_effect = machine_module_slots * machine_module_speed_bonus
  local speed_multiplier            = 1 + machine_module_speed_effect + beacon_speed_effect
  local beaconed_crafting_speed     = machine_crafting_speed * speed_multiplier
  --machine_crafting_speed * (1 + (( (machine_module_slots * machine_module_speed_bonus) + (beacon_count*beacon_module_speed_bonus*beacon_effect*beacon_module_slots) )/100))))
  return beaconed_crafting_speed
end

function beaconed_energy_usage(params)
  local machine_energy_usage              = params.machine_energy_usage or "128kW"
  local machine_module_slots              = params.module_slots or 4
  local beacon_count                      = params.beacon_count or 12
  local beacon_effect                     = params.beacon_effect or 0.5
  local beacon_module_slots               = params.beacon_module_slots or 2
  local beacon_module_energy_usage_bonus  = params.beacon_module_energy_usage_bonus or 0.5
  local machine_module_energy_usage_bonus = params.machine_module_energy_usage_bonus or -0.15

  
  local machine_energy_usage_nokw   = string.gsub(machine_energy_usage, "kW", "")
  local machine_energy_usage_number = tonumber(machine_energy_usage_nokw, 10)

  --error(serpent.block(machine_energy_usage_number))

  local beacon_energy_usage_effect         = beacon_count * beacon_module_energy_usage_bonus * beacon_effect * beacon_module_slots
  local machine_module_energy_usage_effect = machine_module_slots * machine_module_energy_usage_bonus
  local energy_usage_multiplier            = 1 + machine_module_energy_usage_effect + beacon_energy_usage_effect
  local beaconed_energy_usage              = machine_energy_usage_number * energy_usage_multiplier
  local beaconed_energy_usage_string       = tostring(beaconed_energy_usage) .. "kW"
  
  local test = {
    beacon_energy_usage_effect         = beacon_count * beacon_module_energy_usage_bonus * beacon_effect * beacon_module_slots,
    machine_module_energy_usage_effect = machine_module_slots * machine_module_energy_usage_bonus,
    energy_usage_multiplier            = 1 + machine_module_energy_usage_effect + beacon_energy_usage_effect,
    beaconed_energy_usage              = machine_energy_usage_number * energy_usage_multiplier,
    beaconed_energy_usage_string       = tostring(beaconed_energy_usage) .. "kW",
  }
  --error(serpent.block(test))

  --error(serpent.block(beaconed_energy_usage_string))
  --machine_crafting_speed * (1 + (( (machine_module_slots * machine_module_speed_bonus) + (beacon_count*beacon_module_speed_bonus*beacon_effect*beacon_module_slots) )/100))))
  return beaconed_energy_usage_string
end