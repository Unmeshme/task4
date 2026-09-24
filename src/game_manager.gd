extends Control


export var game_bg_music: AudioStream

onready var level_manager: Control = $LevelManager
onready var settings : Control = $SettingsPage
var currently_inside_settings: bool = false



func _unhandled_input(p_event: InputEvent) -> void:
	if p_event.is_action_pressed("esc") and not currently_inside_settings:
		settings.show()
		hide_level_manager()
		currently_inside_settings = true
	elif p_event.is_action_pressed("esc") and currently_inside_settings:
		show_level_manager()
		settings.hide()
		currently_inside_settings = false


#READY is entered when entering the scene tree...
func _ready() -> void:
	#initial setup and then per level setup will be done by level manager
	#Globals.setup()
	AudioManager.play_bg_music(game_bg_music)
	settings.hide()
	

func hide_level_manager() -> void:
	level_manager.hide()
	level_manager.propagate_call("set_process_unhandled_input", [false])
	level_manager.pause_timer()

func show_level_manager() -> void:
	level_manager.show()
	level_manager.propagate_call("set_process_unhandled_input", [true])
	level_manager.resume_timer()
