function no_animations_get_entity_types()
    return {
        { "assembling-machine", true },
        { "furnace", true },
        { "animation", true },
        { "accumulator", true },
        { "mining-drill", true },
        { "generator", true },
        { "electric-energy-interface", true },
        { "rocket-silo", true },
        { "explosion", true },
        { "unit-spawner", true },
        { "trivial-smoke", true },
        { "fire", true },
        { "car", true },
        { "roboport", true },
        { "burner-generator", true },
        { "pump", true },
        { "offshore-pump", true },
        { "unit", true },
        { "turret", true },
        { "corpse", true },

        { "inserter", false, "This removes inserter hands, which has no performance impact, but some people find the inserter hands distracting." },
    }
end