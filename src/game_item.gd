class_name GameDeliveryItem


extends Control



var movement_tween: Tween
var scaled_value: Vector2 = Vector2(1.1, 1.1)
var scaled_down: Vector2 = Vector2(0.9, 0.9)



enum ITEM_ID{
	ITEM_APPLE = 0,
	ITEM_ORANGE
}

export (ITEM_ID) var my_id: int = ITEM_ID.ITEM_APPLE
export var audio_data: Resource

func _ready() -> void:
	#start_idle_pulse()
	pass




func spawn_animation() -> void:
	rect_pivot_offset = rect_size / 2.0
	
	var m_scale_tween : SceneTreeTween = get_tree().create_tween()
	m_scale_tween.tween_property(self, "rect_scale", scaled_value, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	m_scale_tween.tween_property(self, "rect_scale", Vector2.ONE, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func on_combine() -> void:
	var m_randomized_pitch: float = rand_range(0.9, 1.1)
	AudioManager.play_sfx(audio_data.combine_sound, m_randomized_pitch)
