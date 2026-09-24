extends SettingsElement


var working_bus: String = "background"

func _set_background_music() -> void:
	if !current_button_state:
		AudioManager.mute_audio_bus(working_bus)
	else:
		AudioManager.unmute_audio_bus(working_bus)


#if pressed when the toggle is green (true) -> will give us false
func _on_button_toggled_(p_button_pressed: bool) -> void:
	AudioManager.play_sfx(button_audio_on_pressed)	
	current_button_state = p_button_pressed
	_set_background_music()
