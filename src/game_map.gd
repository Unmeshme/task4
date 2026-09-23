extends GridContainer


#this script will be responsible for creating the map the player will play in
var get_first_square_pos: Vector2 = Vector2.ZERO

const DEFAULT_SQUARE = preload("res://src/square.tscn")


#fix this function  to give correct values first lol
func _get_rect_position() -> Vector2:
	return rect_global_position

func draw_map_background(p_position: Vector2,p_columns: int, p_width: int) -> void:
	#set the global rect position
	rect_global_position = p_position
	columns = p_columns
	var m_rows: int = p_width
	for _i in range(columns * m_rows):
		var m_instance: Control = DEFAULT_SQUARE.instance()
		add_child(m_instance)

func free_board_grid() -> void:
	for m_child in get_children():
		m_child.queue_free()
