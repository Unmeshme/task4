extends SettingsElement

var working_bus: String = "sfx"

func _set_game_sfx() -> void:
	if !current_button_state: #state on
		AudioManager.mute_audio_bus(working_bus)
	else:
		AudioManager.unmute_audio_bus(working_bus)


func _on_button_toggled_(p_button_pressed: bool) -> void:
	AudioManager.play_sfx(button_audio_on_pressed)
	current_button_state = p_button_pressed
	_set_game_sfx()
