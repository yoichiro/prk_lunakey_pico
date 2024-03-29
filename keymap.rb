require "via"
require "sounder"

kbd = Keyboard.new

kbd.via = true
kbd.via_layer_count = 4

kbd.split = true
if tud_mounted?
  kbd.uart_pin = 1 # for left side
else
  kbd.uart_pin = 0 # for right side
end

kbd.init_pins(
  [12, 13, 14, 15],        # row0, row1,... respectively
  [21, 20, 19, 18, 17, 16] # col0, col1,... respectively
)

kbd.add_layer :default, [
  :KC_ESC,  :KC_Q,    :KC_W,    :KC_E,    :KC_R,    :KC_T,     :KC_Y,    :KC_U,    :KC_I,    :KC_O,    :KC_P,     :KC_BSPC,
  :CT_TAB,  :KC_A,    :KC_S,    :KC_D,    :KC_F,    :KC_G,     :KC_H,    :KC_J,    :KC_K,    :KC_L,    :KC_SCOLON,:CT_QUOT,
  :KC_LSFT, :KC_Z,    :KC_X,    :KC_C,    :KC_V,    :KC_B,     :KC_N,    :KC_M,    :KC_COMM, :KC_DOT,  :KC_SLSH,  :SF_MINS,
  :KC_NO,   :KC_NO,   :KC_LALT, :KC_LANG2,:LOWER,   :KC_SPC,   :KC_ENT,  :RAISE,   :KC_LANG1,:KC_RALT, :KC_NO,    :KC_NO
]
kbd.add_layer :lower, [
  :KC_BSLS, :KC_CIRC, :KC_EXLM, :KC_AMPR, :KC_PIPE, :KC_DLR,   :KC_AT,   :KC_ASTER,:KC_PLUS, :KC_EQL,  :KC_PERC,  :KC_BSPC,
  :CT_TAB,  :KC_1,    :KC_2,    :KC_3,    :KC_4,    :KC_5,     :KC_6,    :KC_7,    :KC_8,    :KC_9,    :KC_0,     :KC_DQUO,
  :KC_LSFT, :KC_Z,    :KC_X,    :KC_C,    :KC_V,    :KC_B,     :KC_N,    :KC_COLON,:KC_LABK, :KC_RABK, :KC_QUES,  :KC_UNDS,
  :KC_NO,   :KC_NO,   :KC_LGUI, :KC_LANG2,:LOWER,   :KC_SPC,   :KC_ENT,  :ADJUST,  :KC_LANG1,:KC_LGUI, :KC_NO,    :KC_NO
]
kbd.add_layer :raise, [
  :KC_BSLS, :KC_CIRC, :KC_EXLM, :KC_AMPR, :KC_PIPE, :KC_DLR,   :KC_AT,   :KC_ASTER,:KC_PLUS, :KC_EQL,  :KC_PERC,  :KC_BSPC,
  :KC_HASH, :KC_GRV,  :KC_LBRC, :KC_RBRC, :KC_LPRN, :KC_RPRN,  :KC_PGUP, :KC_HOME, :KC_UP,   :KC_END,  :KC_SCOLON,:KC_DQUO,
  :KC_LSFT, :KC_TILD, :KC_X,    :KC_C,    :KC_LCBR, :KC_RCBR,  :KC_PGDN, :KC_LEFT, :KC_DOWN, :KC_RGHT, :KC_SLSH,  :SF_MINS,
  :KC_NO,   :KC_NO,   :KC_LGUI, :KC_LANG2,:ADJUST,  :KC_SPC,   :KC_ENT,  :RAISE,   :KC_LANG1,:KC_LGUI, :KC_NO,    :KC_NO
]
kbd.add_layer :adjust, [
  :KC_NO  , :KC_NO,   :KC_NO  , :KC_NO  , :KC_NO  , :KC_NO  ,  :KC_F1,   :KC_F2,   :KC_F3,   :KC_F4,   :KC_F5,    :KC_F6,
  :KC_NO  , :KC_NO  , :KC_NO  , :KC_NO  , :KC_NO  , :KC_NO  ,  :KC_F7,   :KC_F8,   :KC_F9,   :KC_F10,  :KC_F11,   :KC_F12,
  :KC_NO  , :KC_NO  , :KC_VOLD, :KC_VOLU, :KC_MUTE, :KC_NO  ,  :KC_NO  , :KC_NO  , :KC_CAPS, :KC_NO  , :KC_NO  ,  :KC_NO  ,
  :KC_NO,   :KC_NO,   :KC_NO  , :KC_NO  , :KC_NO  , :KC_NO  ,  :KC_NO  , :KC_NO  , :KC_NO  , :KC_NO  , :KC_NO,    :KC_NO
]

kbd.define_mode_key :CT_TAB, [:KC_TAB, :KC_LCTL, 120, 150]
kbd.define_mode_key :CT_QUOT, [:KC_QUOT, :KC_LCTL, 120, 150]
kbd.define_mode_key :SF_MINS, [:KC_MINS, :KC_LSFT, 120, 150]
kbd.define_mode_key :LOWER, [nil, :lower, 120, 150]
kbd.define_mode_key :RAISE, [nil, :raise, 120, 150]
kbd.define_mode_key :ADJUST, [nil, :adjust, 120, 150]

rgb = RGB.new(
  6,
  6,
  0,
  false
)
rgb.effect = :rainbow_mood
kbd.append rgb

sounder = Sounder.new(8)

kbd.on_start do
  if kbd.anchor?
    sounder.play "T200 L8 O7 c O6 c"
  end
end

kbd.start!
