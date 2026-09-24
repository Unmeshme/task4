extends Control


export var level_info: Resource


onready var grid: GridContainer = $game_map
onready var board: Node = $BoardState
onready var hud: Control = $HUD

var empty_list: Array = []


func _ready():
	setup_level()


func setup_level(p_default: int = 2) -> void:
	setup_globals()
	draw_content()
	board.get_level_item_list(level_info.item_data)
	hud.initialize_initial_state(level_info.time_limit, level_info.delivery_limit)
	board.spawn_item(p_default)



func draw_content() -> void:
	grid.draw_map_background(level_info.grid_position,level_info.column_size, level_info.row_size)
	board.initialize_grid(level_info.column_size, level_info.row_size)
	

#rightnow for interval working of the globals functions we need this
#move this to globals itself as setup and then call it form level_manager as it
#contains all the setup of a level that might be necessary for the whole game
func setup_globals() -> void:
	Globals.grid_width = level_info.column_size
	Globals.grid_height = level_info.row_size
	Globals.rect_pos = level_info.grid_position


#TODO: write function to setup_next_level
func setup_next_level() -> void:
	reset_board_and_board_state()
	print("new level info loaded")
	if level_info.next_level == null:
		return
	level_info = level_info.next_level
	setup_level(1)


func on_combine() -> void:
	hud.update_score()


func _on_hud_game_has_ended() -> void:
	reset_board_and_board_state()
	setup_level(1)
	update()

func reset_board_and_board_state() -> void:
	board.free_board()
	grid.free_board_grid()
	hud.reset_hud()
	


func _on_HUD_level_completed():
	setup_next_level()


func pause_timer() -> void:
	hud.pause_timer()


func resume_timer() -> void:
	hud.resume_timer()
