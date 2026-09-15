extends Control


export var level_info: Resource


onready var grid: GridContainer = $game_map
onready var board: Node = $BoardState

var empty_list: Array = []



func _ready():
	setup_level()



func setup_level() -> void:
	setup_globals()
	grid.draw_map_background(level_info.column_size, level_info.row_size)
	board.initialize_grid(level_info.column_size, level_info.row_size)
	board.spawn_item(2)


func load_next_level() -> bool:
	return false


#rightnow for interval working of the globals functions we need this
func setup_globals() -> void:
	Globals.grid_width = level_info.column_size
	Globals.grid_height = level_info.row_size
	Globals.rect_pos = grid.rect_global_position


func setup_next_level() -> void:
	pass

