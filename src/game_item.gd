class_name GameDeliveryItem


extends Control



var movement_tween: Tween
var scaled_value: Vector2 = Vector2(1.1, 1.1)
var scaled_down: Vector2 = Vector2(0.9, 0.9)

enum ITEM_ID{
	ITEM_APPLE = 0,
	ITEM_ORANGE
}

var my_id: int
#position inside the grid
#var curr_position: Vector2

func _ready() -> void:
	#start_idle_pulse()
	pass


func start_idle_pulse() -> void:
	rect_pivot_offset = rect_size / 2.0
	var m_pulse_tween: SceneTreeTween = get_tree().create_tween()
	
	m_pulse_tween.set_loops()
	
	#scale out sequence
	m_pulse_tween.tween_property(
		self,
		"rect_scale",
		scaled_value,
		.2
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	m_pulse_tween.tween_property(
		self,
		"rect_scale",
		Vector2.ONE,
		.2
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func spawn_animation() -> void:
	rect_pivot_offset = rect_size / 2.0
	var m_scale_tween : SceneTreeTween = get_tree().create_tween()
	
	m_scale_tween.tween_property(self, "rect_scale", scaled_value, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	m_scale_tween.tween_property(self, "rect_scale", Vector2.ONE, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT_IN)
