rule = {
  matches = {
    {
      { "media.class", "equals", "Audio/Sink" },
    },
  },
  apply_properties = {
    ["priority.session"] = 100,
  },
}

table.insert(alsa_monitor.rules, rule)
