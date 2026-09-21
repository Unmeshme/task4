extends Control


export var level_info: Resource


onready var grid: GridContainer = $game_map
onready var board: Node = $BoardState
onready var hud: Control = $HUD

var empty_list: Array = []


func _ready():
	setup_level()


func setup_level() -> void:
	setup_globals()
	grid.draw_map_background(level_info.column_size, level_info.row_size)
	board.initialize_grid(level_info.column_size, level_info.row_size)
	board.spawn_item(2)
	hud._initialize_initial_state(level_info.time_limit, level_info.total_delivery)


#TODO: Write function to load the next level
func load_next_level() -> bool:
	return false


#rightnow for interval working of the globals functions we need this
#move this to globals itself as setup and then call it form level_manager as it
#contains all the setup of a level that might be necessary for the whole game
func setup_globals() -> void:
	Globals.grid_width = level_info.column_size
	Globals.grid_height = level_info.row_size
	Globals.rect_pos = grid.rect_global_position


#TODO: write function to setup_next_level
func setup_next_level() -> void:
	pass


func on_combine() -> void:
	hud.update_score()


func _on_hud_game_has_ended() -> void:
	reset_board_and_board_state()
	setup_level()
	update()

func reset_board_and_board_state() -> void:
	board.free_board()
	grid.free_board_grid()
