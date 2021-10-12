while !$mutex
  relinquish
end

kbd = Keyboard.new

kbd.split = true
kbd.split_style = :right_side_flipped_split

kbd.uart_pin = 1  # for left side
# kbd.uart_pin = 0  # for right side

# You can make right side the "anchor" (so-called "master")
# kbd.set_anchor(:right)

kbd.init_pins(
  [12, 13, 14, 15],        # row0, row1,... respectively
  [21, 20, 19, 18, 17, 16] # col0, col1,... respectively
)

kbd.add_layer :default, %i[
  KC_GESC  KC_Q  KC_W    KC_E    KC_R  KC_T   KC_Y   KC_U  KC_I    KC_O    KC_P     KC_BSPC
  CT_TAB   KC_A  KC_S    KC_D    KC_F  KC_G   KC_H   KC_J  KC_K    KC_L    KC_SCLN  CT_QUOT
  KC_LSFT  KC_Z  KC_X    KC_C    KC_V  KC_B   KC_N   KC_M  KC_COMM KC_DOT  KC_SLSH  SF_MINS
  KC_NO    KC_NO KC_LALT KC_MHEN KC_NO KC_SPC KC_ENT KC_NO KC_HENK KC_RALT KC_NO    KC_NO
]

kbd.define_mode_key :CT_TAB, [:KC_TAB, :KC_LCTL, 120, 150]
kbd.define_mode_key :CT_QUOT, [:KC_QUOT, :KC_LCTL, 120, 150]
kbd.define_mode_key :SF_MINS, [:KC_MINS, :KC_LSFT, 120, 150]

kbd.start!
