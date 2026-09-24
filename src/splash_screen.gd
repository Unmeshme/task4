extends Control


export var splash_screen_audio: AudioStreamSample

onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("on_load")
	yield(get_tree().create_timer(1.0), "timeout")
	AudioManager.play_sfx(splash_screen_audio)


#just create a signal here and then we can do stuff outside, i.e inside the game manager
func _on_animationplayer_animation_finished(_p_anim_name: String) -> void:
	#play a transition animation right here lol
	for m_child in get_children():
		m_child.queue_free()
	queue_free()
