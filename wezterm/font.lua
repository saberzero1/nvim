local font = require('wezterm').font
local harfbuzz_features = { 'calt', 'liga', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08' }

local function font_with_fallback(linux_families, darwin_families)
  local result = linux_families
  if require('wezterm').target_triple:find 'darwin' ~= nil then
    result = darwin_families or linux_families
  end
  return font(result)
end

return {
  -- default font
  font = font_with_fallback {
    {
      family = 'MonaspiceNe Nerd Font',
      -- family = "MonaspiceAr Nerd Font",
      -- family = "MonaspiceXe Nerd Font",
      -- family = "MonaspiceRa Nerd Font",
      -- family = "MonaspiceKr Nerd Font",
      weight = 'Medium',
      harfbuzz_features = harfbuzz_features,
    },
    {
      family = 'Monaspace Neon',
      -- family = "Monaspace Argon",
      -- family = "Monaspace Xenon",
      -- family = "Monaspace Radon",
      -- family = "Monaspace Krypton",
      weight = 'Medium',
      harfbuzz_features = harfbuzz_features,
    },
  },

  font_rules = {
    { -- Normal
      intensity = 'Normal',
      italic = false,
      font = font_with_fallback {
        {
          family = 'Monaspace Neon',
          weight = 'Medium',
          harfbuzz_features = harfbuzz_features,
        },
        {
          family = 'MonaspiceNe Nerd Font',
          weight = 'Medium',
          harfbuzz_features = harfbuzz_features,
        },
      },
    },
    { -- Bold
      intensity = 'Bold',
      italic = false,
      font = font_with_fallback {
        {
          family = 'Monaspace Argon',
          weight = 'ExtraBold',
          harfbuzz_features = harfbuzz_features,
        },
        {
          family = 'MonaspiceAr Nerd Font',
          weight = 'ExtraBold',
          harfbuzz_features = harfbuzz_features,
        },
      },
    },
    { -- Half
      intensity = 'Half',
      italic = false,
      font = font_with_fallback {
        {
          family = 'Monaspace Krypton',
          weight = 'Book',
          harfbuzz_features = harfbuzz_features,
        },
        {
          family = 'MonaspicaKr Nerd Font',
          weight = 'Book',
          harfbuzz_features = harfbuzz_features,
        },
      },
    },
    { -- Normal italic
      intensity = 'Normal',
      italic = true,
      font = font_with_fallback {
        {
          family = 'Monaspace Argon',
          weight = 'Regular',
          style = 'Italic',
          harfbuzz_features = harfbuzz_features,
        },
        {
          family = 'MonaspiceAr Nerd Font',
          weight = 'Regular',
          style = 'Italic',
          harfbuzz_features = harfbuzz_features,
        },
      },
    },
    { -- Bold italic
      intensity = 'Bold',
      italic = true,
      font = font_with_fallback {
        {
          family = 'Monaspace Argon',
          weight = 'DemiBold',
          style = 'Italic',
          harfbuzz_features = harfbuzz_features,
        },
        {
          family = 'MonaspiceAr Nerd Font',
          weight = 'DemiBold',
          style = 'Italic',
          harfbuzz_features = harfbuzz_features,
        },
      },
    },
    { -- Half italic
      intensity = 'Half',
      italic = true,
      font = font_with_fallback {
        {
          family = 'Monaspace Argon',
          weight = 'Thin',
          style = 'Italic',
          harfbuzz_features = harfbuzz_features,
        },
        {
          family = 'MonaspiceAr Nerd Font',
          weight = 'Thin',
          style = 'Italic',
          harfbuzz_features = harfbuzz_features,
        },
      },
    },
  },
}
