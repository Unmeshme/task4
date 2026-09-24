extends SettingsElement




func _on_Button_pressed() -> void:
	#play a sound and then quit the game
	yield(AudioManager.play_sfx(button_audio_on_pressed), "completed")
	get_tree().quit()
