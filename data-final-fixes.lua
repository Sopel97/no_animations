do
    require("entity_types")

    local exceptions_by_name = {
        ["tl-empty-smoke"] = true
    }

    local function is_table(t)
        return type(t) == 'table'
    end

    local function reset_sprite(sprite)
        if sprite.direction_count and sprite.direction_count > 1 then
            -- currently not supported fully
            -- uses a workaround that *should* work
            sprite.frame_sequence = {} -- the game should not load other frames in this case
            local num_frames = sprite.frame_count or 1
            for i = 1, num_frames do
                table.insert(sprite.frame_sequence, 1)
            end
            return
        end

        if sprite.frame_count or sprite.repeat_count then
            sprite.frame_count = 1
            sprite.repeat_count = 1
            sprite.run_mode = nil
            if sprite.frame_sequence then
                sprite.frame_sequence = { 1 } -- the game should not load other frames in this case
            end
            if sprite.stripes then
                sprite.stripes = {sprite.stripes[1]}
                sprite.stripes[1].width_in_frames = 1
                sprite.stripes[1].height_in_frames = 1
            else
                sprite.line_length = 1
            end

            if sprite.hr_version then
                reset_sprite(sprite.hr_version)
            end
        end
    end

    local function reset_animation(animation)
        if animation.layers then
            for _, layer in pairs(animation.layers) do
                reset_animation(layer)
            end
        else
            reset_sprite(animation)
        end
    end

    local function reset_animations(animations)
        if animations.animations then
            reset_animations(animations.animations)
        end

        if animations.animation then
            reset_animations(animations.animation)
        end

        if animations.fluid_animation then
            reset_animations(animations.fluid_animation)
        end

        if animations.north then
            reset_animation(animations.north)
        end
        if animations.south then
            reset_animation(animations.south)
        end
        if animations.east then
            reset_animation(animations.east)
        end
        if animations.west then
            reset_animation(animations.west)
        end

        if is_table(animations) and #animations > 0 and animations[1].frame_count then
            for _, animation in pairs(animations) do
                reset_animation(animation)
            end
        end

        if animations.frame_count then
            reset_animation(animations)
        end

        if animations.layers then
            reset_animation(animations)
        end
    end

    local function is_exception(e)
        return exceptions_by_name[e.name]
    end

    local function reset_animation_of_thing(e)
        if is_exception(e) then
            return
        end

        e.working_visualisations = nil

        if e.type == "animation" then
            reset_animations(e)
        end

        if e.light_animation then
            reset_animations(e.light_animation)
        end

        if e.turret_animation then
            reset_animations(e.turret_animation)
        end

        if e.structure then
            reset_animations(e.structure)
        end

        if e.fire then
            reset_animations(e.fire)
        end

        if e.fire_glow then
            reset_animations(e.fire_glow)
        end

        if e.idle_animation then
            reset_animations(e.idle_animation)
        end

        if e.idle_animations then
            reset_animations(e.idle_animations)
        end

        if e.animations then
            reset_animations(e.animations)
        end

        if e.picture then
            reset_animations(e.picture)
        end

        if e.pictures then
            reset_animations(e.pictures)
        end

        if e.smoke_pictures then
            reset_animations(e.smoke_pictures)
        end

        if e.animation then
            reset_animations(e.animation)
        end

        if e.fluid_animation then
            reset_animations(e.fluid_animation)
        end

        if e.base_animation then
            reset_animations(e.base_animation)
        end

        if e.horizontal_animation then
            reset_animations(e.horizontal_animation)
        end

        if e.vertical_animation then
            reset_animations(e.vertical_animation)
        end

        if e.charge_animation then
            reset_animations(e.charge_animation)
        end

        if e.discharge_animation then
            reset_animations(e.discharge_animation)
        end

        if e.satellite_animation then
            reset_animations(e.satellite_animation)
        end

        if e.glow_animation then
            reset_animations(e.glow_animation)
        end

        if e.run_animation then
            reset_animations(e.run_animation)
        end

        if e.folded_animation then
            reset_animations(e.folded_animation)
        end

        if e.attacking_animation then
            reset_animations(e.attacking_animation)
        end

        if e.attack_parameters and e.attack_parameters.animation then
            reset_animations(e.attack_parameters.animation)
        end

        if e.ending_attack_animation then
            reset_animations(e.ending_attack_animation)
        end

        if e.energy_glow_animation then
            reset_animations(e.energy_glow_animation)
        end

        if e.base_picture then
            reset_animations(e.base_picture)
        end

        if e.folding_animation then
            reset_animations(e.folding_animation)
        end

        if e.prepared_alternative_animation then
            reset_animations(e.prepared_alternative_animation)
        end

        if e.prepared_animation then
            reset_animations(e.prepared_animation)
        end

        if e.preparing_animation then
            reset_animations(e.preparing_animation)
        end

        if e.starting_attack_animation then
            reset_animations(e.starting_attack_animation)
        end

        if e.animation_overlay then
            reset_animations(e.animation_overlay)
        end

        if e.graphics_set then
            reset_animation_of_thing(e.graphics_set)
        end

        if e.wet_mining_graphics_set then
            reset_animation_of_thing(e.wet_mining_graphics_set)
        end
    end

    local function reset_animation_of_things(type)
        for _, e in pairs(data.raw[type]) do
            reset_animation_of_thing(e)
        end
    end

    for _, entity_type in pairs(no_animations_get_entity_types()) do
        if settings.startup["no-animations-disable-animations-for-" .. entity_type].value then
            reset_animation_of_things(entity_type)
        end
    end
end