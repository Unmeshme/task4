extends Node

export var game_bg_music: AudioStream


#READY is entered when entering the scene tree...
 
func _ready() -> void:
	#initial setup and then per level setup will be done by level manager
	#Globals.setup()
	AudioManager.play_bg_music(game_bg_music)
