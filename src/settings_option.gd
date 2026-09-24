extends Control
class_name SettingsElement


onready var button: Button = $Button
onready var animator: AnimationPlayer = $animator

var current_button_state: bool

#both will be shared so best to keep it in the base class
export var button_audio_hovered: AudioStreamSample
export var button_audio_on_pressed: AudioStreamSample


func _ready() -> void:
	current_button_state = button.is_pressed()


	
func _on_button_mouse_entered() -> void:
	AudioManager.play_sfx(button_audio_hovered)
	animator.play("hovered")



func _on_button_mouse_exited() -> void:
	animator.play("exited")


