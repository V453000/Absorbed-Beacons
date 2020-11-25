local original_lab = data.raw["lab"]["lab"]
local beaconed_data = {
  machine_energy_usage              = original_lab.energy_usage,
  machine_emissions                 = original_lab.energy_source.emissions_per_minute,
  machine_crafting_speed            = original_lab.researching_speed,
  machine_module_slots              = original_lab.module_specification.module_slots,
  beacon_count                      = global_lab_beacon_count,
  average_beacon_count              = global_lab_average_beacon_count,
  beacon_effect                     = global_beacon_transmission_effect,
  beacon_module_slots               = global_beacon_module_slots,
  beacon_module_speed_bonus         = global_speed_module_3_speed_bonus,
  beacon_module_energy_usage_bonus  = global_speed_module_3_energy_usage_bonus,
  machine_module_speed_bonus        = global_productivity_module_3_speed_bonus,
  machine_module_energy_usage_bonus = global_productivity_module_3_energy_usage_bonus,
  machine_module_productivity_bonus = global_productivity_module_3_productivity_bonus,
  machine_module_pollution_bonus    = global_productivity_module_3_pollution_bonus,
  original_animation_speed          = 1/3,
  tier_animation_speed_multiplier   = global_tier_3_animation_speed_multiplier,
  custom_animation_speed_multiplier = 1,
  emission_hack                     = 1
}
local beaconed_lab_3_animation_speed = 1/3--beaconed_stats(beaconed_data).beaconed_animation_speed

beaconed_lab_3 = util.table.deepcopy(data.raw["lab"]["lab"])
beaconed_lab_3.name = "beaconed-lab-3"
beaconed_lab_3.icon = "__Built-in-Beacons__/graphics/icons/beaconed-lab-3.png"
beaconed_lab_3.minable.result = "beaconed-lab-3"
beaconed_lab_3.researching_speed = beaconed_stats(beaconed_data).beaconed_crafting_speed
beaconed_lab_3.energy_source.drain = beaconed_stats(beaconed_data).beaconed_drain_string
beaconed_lab_3.energy_usage = beaconed_stats(beaconed_data).beaconed_energy_usage_string
beaconed_lab_3.allowed_effects = {"productivity", "pollution"}
beaconed_lab_3.fast_replaceable_group = "lab"

if settings.startup["productivity-mode"].value == 'Modded Modules' then
  beaconed_lab_3.module_specification.module_slots = data.raw["lab"]["lab"].module_specification.module_slots * 2
  if settings.startup["show-module-slot-row-length"].value > 0 then
    beaconed_lab_3.module_specification.module_info_max_icons_per_row = settings.startup["show-module-slot-row-length"].value
  end
  if settings.startup["show-module-slot-rows"].value > 0 then
    beaconed_lab_3.module_specification.module_info_max_icon_rows = settings.startup["show-module-slot-rows"].value
  end
else
  beaconed_lab_3.module_specification.module_slots = 0
  beaconed_lab_3.base_productivity = beaconed_stats(beaconed_data).beaconed_base_productivity
end

if settings.startup["modded-entity-graphics"].value == "ON" then
  beaconed_lab_3.on_animation.layers[1] = 
    {
      filename = "__Built-in-Beacons__/graphics/entity/beaconed-lab/lab-space.png",
      width = 98,
      height = 87,
      frame_count = 33,
      line_length = 11,
      animation_speed = beaconed_lab_3_animation_speed,
      shift = util.by_pixel(0, 1.5),
      hr_version =
      {
        filename = "__Built-in-Beacons__/graphics/entity/beaconed-lab/hr-lab-space.png",
        width = 194,
        height = 174,
        frame_count = 33,
        line_length = 11,
        animation_speed = beaconed_lab_3_animation_speed,
        shift = util.by_pixel(0, 1.5),
        scale = 0.5
      }
    }

    table.insert(beaconed_lab_3.on_animation.layers,
    {
      filename = "__Built-in-Beacons__/graphics/entity/beaconed-lab/beaconed-lab-overlay.png",
      width = 288,
      height = 288,
      frame_count = 1,
      line_length = 1,
      repeat_count = 33,
      animation_speed = beaconed_lab_3_animation_speed,
      shift = util.by_pixel(0, 8),
      tint = beaconed_lab_3_tint,
      hr_version =
      {
        filename = "__Built-in-Beacons__/graphics/entity/beaconed-lab/hr-beaconed-lab-overlay.png",
        width = 576,
        height = 576,
        frame_count = 1,
        line_length = 1,
        repeat_count = 33,
        animation_speed = beaconed_lab_3_animation_speed,
        shift = util.by_pixel(0, 8),
        tint = beaconed_lab_3_tint,
        scale = 0.5
      }
    }
  )
  table.insert(beaconed_lab_3.off_animation.layers,
    {
      filename = "__Built-in-Beacons__/graphics/entity/beaconed-lab/beaconed-lab-overlay.png",
      width = 288,
      height = 288,
      frame_count = 1,
      line_length = 1,
      repeat_count = 1,
      animation_speed = beaconed_lab_3_animation_speed,
      shift = util.by_pixel(0, 8),
      tint = beaconed_lab_3_tint,
      hr_version =
      {
        filename = "__Built-in-Beacons__/graphics/entity/beaconed-lab/hr-beaconed-lab-overlay.png",
        width = 576,
        height = 576,
        frame_count = 1,
        line_length = 1,
        repeat_count = 1,
        animation_speed = beaconed_lab_3_animation_speed,
        shift = util.by_pixel(0, 8),
        tint = beaconed_lab_3_tint,
        scale = 0.5
      }
    }
  )
end

if settings.startup["modded-entity-graphics"].value ~= "OFF" then
  for i,layer in pairs(beaconed_lab_3.on_animation.layers) do
    layer.animation_speed = beaconed_lab_3_animation_speed
    if (layer.hr_version) then
      layer.hr_version.animation_speed = beaconed_lab_3_animation_speed
    end
  end
end

data:extend({
  beaconed_lab_3
})
data:extend({
  {
    type = "item",
    name = "beaconed-lab-3",
    icon = "__Built-in-Beacons__/graphics/icons/beaconed-lab-3.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "production-machine",
    order = "g[lab]",
    place_result = "beaconed-lab-3",
    stack_size = 10,
    localised_description = {'item-description.beaconed-lab-3', global_lab_beacon_count}
  },
})
data:extend({
  {
    type = "recipe",
    name = "beaconed-lab-3",
    enabled = false,
    icon = "__Built-in-Beacons__/graphics/icons/beaconed-lab-3.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "built-in-beacons-3",
    order = "h",
    ingredients =
    {
      {"beaconed-lab-2", 1},
      {"speed-module-3", global_lab_average_beacon_count * global_beacon_module_slots}
    },
    results = {
      {type = "item", name = "beaconed-lab-3", amount = 1},
      {type = "item", name = "speed-module-2", amount = global_lab_average_beacon_count * global_beacon_module_slots, show_details_in_recipe_tooltip = false}
    },
    allow_as_intermediate = false,
    main_product = "beaconed-lab-3",
    localised_description = {'item-description.beaconed-lab-3', global_lab_beacon_count}
  }
})

if global_logging == true then
  log(serpent.block( beaconed_data ))
  log(serpent.block( beaconed_stats(beaconed_data) ))
end