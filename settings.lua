do
    require("entity_types")

    local function add_setting_for_entity_type(entity_type)
        data:extend({
            {
                type = "bool-setting",
                name = "no-animations-disable-animations-for-" .. entity_type,
                localised_name = {"", {"mod-setting-name.no-animations-disable-animations-for"}, " ", entity_type},
                setting_type = "startup",
                default_value = true
            }
        })
    end

    for _, entity_type in pairs(no_animations_get_entity_types()) do
        add_setting_for_entity_type(entity_type)
    end
end