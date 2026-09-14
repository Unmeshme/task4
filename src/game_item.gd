class_name GameDeliveryItem


extends Control


var move_vector: Vector2 = Vector2.ZERO
var movement_tween: Tween


enum ITEM_ID{
	ITEM_APPLE = 0,
	ITEM_ORANGE
}

var my_id: int

func _ready() -> void:
	#assign min and max size plus step size it can move.
	movement_tween = Tween.new()
	add_child(movement_tween)


func _process(_p_delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		move_vector = Vector2(0, -1)
	if Input.is_action_just_pressed("down"):
		move_vector = Vector2(0, 1)
	if Input.is_action_just_pressed("left"):
		move_vector = Vector2(-1, 0)
	if Input.is_action_just_pressed("right"):
		move_vector = Vector2(1, 0)
	
	#_make_move(move_vector)


#tweening the motion might be good here
func _make_move(p_move_vector: Vector2) -> void:
	var m_target_position :Vector2 = rect_global_position + p_move_vector * 100
	
	m_target_position.x = clamp(
		m_target_position.x,
		Globals._min_rect.x,
		Globals._max_rect.x
	)
	
	m_target_position.y = clamp(
		m_target_position.y,
		Globals._min_rect.y,
		Globals._max_rect.y
	)

	movement_tween.interpolate_property(
		self,
		"rect_global_position",
		rect_global_position,
		m_target_position,
		1.0,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	movement_tween.start()

func _set_id() -> void:
	pass
