extends GridContainer

#this script will be responsible for creating the map the player will play in

var num_column: int = 4
var num_square: int = 16
var get_first_square_pos: Vector2 = Vector2.ZERO

const DEFAULT_SQUARE = preload("res://src/square.tscn")


var grid: Array = [
	0,0,0,1,0,0,0,0,2,0,0,0,0,0,0,0
]


func _ready() -> void:
	columns = num_column
	
	for m_i in range(num_column * num_column):
		var m_default_square_instance: Control = DEFAULT_SQUARE.instance()
		add_child(m_default_square_instance)
		
	yield(get_tree(), "idle_frame")
	
	#this might be useful idk
	get_child_position(0,1)


#fix this function  to give correct values first lol
func get_child_position(p_row: int, p_height: int) -> Vector2 :
	var m_index : int = p_row * columns + p_height
	if m_index < get_child_count():
		var m_child: Control = get_child(m_index)
		
		if m_child:
			var m_local_pos: Vector2 = m_child.rect_position
			var m_screen_pos: Vector2 = m_child.rect_global_position
			
			print("%s %s" %[m_local_pos, m_screen_pos])
			return m_screen_pos
	return Vector2(-1,-1)
