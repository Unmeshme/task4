extends Node


export var level_info: Resource
# Called when the node enters the scene tree for the first time.

const RECT_WIDTH: int = 100


onready var map: GridContainer = $game_map

#keep a virtual grid that keeps track of occupied squares and avoids it when spawing
#new delivery Items
var empty_list: Array = []

func _ready():
	
	#this only assigns now LevelManager should also generate the levels
	#as for generation of levels, it should also move to the next level when
	#Level is completed

	randomize()
	Globals.grid_width = level_info.column_size
	Globals.grid_height = level_info.row_size
	Globals.move_size = RECT_WIDTH
	Globals.rect_pos = map.rect_global_position
	Globals.max_width = int(Globals.rect_pos.x + RECT_WIDTH * Globals.grid_width)
	Globals.max_height = int(Globals.rect_pos.y + RECT_WIDTH * Globals.grid_height)
	
	initialize_grid(Globals.grid_width, Globals.grid_height)
	map.draw_map_background()
	spawn_delivery_item()



func convert_grid_to_global(p_position: Vector2) -> Vector2:
	return Globals.rect_pos + RECT_WIDTH * p_position


func spawn_delivery_item(p_count: int = 1) ->void:
	for _i in range(p_count):
		var m_item_scene: PackedScene = level_info.level_items[randi() % level_info.level_items.size()]
		var m_item: Control = m_item_scene.instance() as Control
		add_child(m_item)
		m_item.rect_global_position = convert_grid_to_global(get_random_free_cell())


func initialize_grid(p_width: int, p_height: int) -> void:
	empty_list.clear()
	for m_i in range(p_width):
		for m_j in range(p_height):
			empty_list.append(Vector2(m_i, m_j))


func get_random_free_cell() -> Vector2:
	if empty_list.empty():
		return Vector2(-1,-1) #game over situation
		
	var m_random_index: int = randi() % empty_list.size()
	#remove the current index from the array and return the index
	var m_cell: Vector2 = empty_list[m_random_index]
	empty_list.remove(m_random_index)
	return m_cell
