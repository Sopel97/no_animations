do
    require("entity_types")

    local function add_setting_for_entity_type(entity_type, default_value, desc)
        data:extend({
            {
                type = "bool-setting",
                name = "no-animations-disable-animations-for-" .. entity_type,
                localised_name = {"", {"mod-setting-name.no-animations-disable-animations-for"}, " ", entity_type},
                localised_description = desc,
                setting_type = "startup",
                default_value = default_value
            }
        })
    end

    for _, entry in pairs(no_animations_get_entity_types()) do
        local entity_type = entry[1]
        local default_value = entry[2]
        local desc = entry[3]
        add_setting_for_entity_type(entity_type, default_value)
    end
end