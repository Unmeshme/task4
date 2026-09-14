extends GridContainer

#this script will be responsible for creating the map the player will play in

var num_column: int = 4
var num_square: int = 16
var get_first_square_pos: Vector2 = Vector2.ZERO

const DEFAULT_SQUARE = preload("res://src/square.tscn")


#fix this function  to give correct values first lol
func _get_rect_position() -> Vector2:
	return rect_global_position

func draw_map_background() -> void:
	columns = Globals.grid_width
	var m_rows: int = Globals.grid_height
	
	for _i in range(columns * m_rows):
		var m_instance: Control = DEFAULT_SQUARE.instance()
		add_child(m_instance)
