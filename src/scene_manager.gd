extends Control


onready var transition_manager: Control = $transition

# Called when the node enters the scene tree for the first time.
func _ready():
	load_scene()


func load_scene() -> void:
	#first fade in
	transition_manager.fade_in()
	#actual scene loading code, preloading the scenes might be the best way to do it
	#(will research the optimal/general practice for scene Loading/scene Manager)
