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
	get_tree().call_group("delivery_item", "_make_move")



func _process(_p_delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		move_vector = Vector2(0, -1)
	if Input.is_action_just_pressed("down"):
		move_vector = Vector2(0, 1)
	if Input.is_action_just_pressed("left"):
		move_vector = Vector2(-1, 0)
	if Input.is_action_just_pressed("right"):
		move_vector = Vector2(1, 0)
	
	print(move_vector)


#tweening the motion might be good here
func _make_move() -> void:
	pass

func _set_id() -> void:
	pass
