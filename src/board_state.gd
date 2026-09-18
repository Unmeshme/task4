extends Control


signal has_combined

const PITCH_VARIATION_LOWER_BOUND: float = 0.9
const PITCH_VARIATION_UPPER_BOUND: float = 1.1


export var board_items: Resource
export var move_sound: AudioStream

var occupied: Dictionary = {}
var empty_grid: Array = []
var is_animating: bool = false
var buffered_input: Vector2 = Vector2.ZERO


var scaled_value: Vector2 = Vector2(1.1, 1.1)

func _ready() -> void:
	randomize()


func initialize_grid(p_width: int, p_height: int) -> void:
	empty_grid.clear()
	for m_i in range(p_width):
		for m_j in range(p_height):
			empty_grid.append(Vector2(m_i, m_j))


#and also spawning the items
func spawn_item(p_count: int = 1) -> void:
	if empty_grid.empty():
		return

	for _i in range(p_count):
		var m_item_scene: PackedScene = board_items.level_items[randi() % board_items.level_items.size()]
		var m_item: Control = m_item_scene.instance() as Control
		m_item.rect_scale = Vector2.ZERO
		add_child(m_item)
		var m_random_grid_val: Vector2 = get_random_free_cell()
		m_item.rect_global_position = Globals.convert_grid_to_global(m_random_grid_val)
		occupied[m_random_grid_val] = m_item
		m_item.spawn_animation()


func get_random_free_cell() -> Vector2:
	if empty_grid.empty():
		return Vector2(-1,-1)
	var m_random_index: int = randi() % empty_grid.size()
	var m_cell: Vector2 = empty_grid[m_random_index]
	empty_grid.remove(m_random_index)
	return m_cell


#poll input
func _unhandled_input(p_event: InputEvent) -> void:
	var m_dir: Vector2 = Vector2.ZERO
	
	if p_event.is_action_pressed("up"):
		m_dir = Vector2.UP
	if p_event.is_action_pressed("down"):
		m_dir = Vector2.DOWN
	if p_event.is_action_pressed("left"):
		m_dir = Vector2.LEFT
	if p_event.is_action_pressed("right"):
		m_dir = Vector2.RIGHT
	
	if m_dir != Vector2.ZERO:
		if is_animating:
			return
		else:
			var m_did_move: bool = move_items(m_dir)
			if m_did_move:
				play_move_audio()



#will be responsible for making the moves
func move_items(p_move: Vector2) -> bool:
	if occupied.empty():
		return false
	
	is_animating = true
	var m_cells_to_process: Array = []
	var m_merged_this_turn: Array = []
	var m_did_move: bool = false
	
	if p_move == Vector2.LEFT or p_move == Vector2.RIGHT:
		for m_y in range(Globals.grid_height):
			m_cells_to_process.append_array(get_row_data(m_y, p_move))
	else:
		for m_x in range(Globals.grid_width):
			m_cells_to_process.append_array(get_column_data(m_x, p_move))
			
	for m_cell in m_cells_to_process:
		if not occupied.has(m_cell):
			continue
			
		var m_item: Control = occupied[m_cell]
		if not is_instance_valid(m_item):
			continue
			
		var m_target: Vector2 = m_cell
		var m_will_merge: bool = false
		var m_merge_target_cell: Vector2 = Vector2(-1, -1)
		
		while true:
			var m_next: Vector2 = m_target + p_move
			
			if m_next.x < 0 or m_next.x >= Globals.grid_width or m_next.y < 0 or m_next.y >= Globals.grid_height:
				break
				
			if not occupied.has(m_next):
				m_target = m_next
			elif occupied.has(m_next):
				var m_other_item: Control = occupied[m_next]
				
				# Check if the target is valid and hasn't been merged into already
				if is_instance_valid(m_other_item) and not m_next in m_merged_this_turn:
					if m_other_item.get("my_id") == m_item.get("my_id"):
						m_will_merge = true
						m_merge_target_cell = m_next
				break
		
		if m_will_merge:
			m_did_move = true
			var m_target_item: Control = occupied[m_merge_target_cell]
			

			occupied.erase(m_cell)
			occupied.erase(m_merge_target_cell)
			
			empty_grid.append(m_cell)
			empty_grid.append(m_merge_target_cell)
			

			m_merged_this_turn.append(m_merge_target_cell)
			
			var m_world_pos: Vector2 = Globals.convert_grid_to_global(m_merge_target_cell)


			var m_tween: SceneTreeTween = get_tree().create_tween()
			m_tween.tween_property(m_item, "rect_global_position", m_world_pos, 0.15)
			m_tween.tween_callback(m_item, "queue_free")

			if is_instance_valid(m_target_item):
				if m_target_item.has_method("on_combine"):
					m_target_item.on_combine()
				var m_scale_tween: SceneTreeTween = get_tree().create_tween()
				m_scale_tween.tween_property(m_target_item, "rect_scale", scaled_value, 0.1)
				m_scale_tween.tween_property(m_target_item, "rect_scale", Vector2.ZERO, 0.1)
				m_scale_tween.tween_callback(m_target_item, "queue_free")
				emit_signal("has_combined")

		elif m_target != m_cell:
			m_did_move = true
			occupied.erase(m_cell)
			occupied[m_target] = m_item
			empty_grid.append(m_cell)
			empty_grid.erase(m_target)
			
			var m_world_pos: Vector2 = Globals.convert_grid_to_global(m_target)
			var m_animation_tween: SceneTreeTween = get_tree().create_tween()
			m_animation_tween.tween_property(m_item, "rect_global_position", m_world_pos, 0.15)

	if m_did_move:
		spawn_item()
		
	is_animating = false
	return m_did_move



func get_row_data(p_row_index: int , p_dir: Vector2) -> Array:
	var m_x_position: Array = []
	
	for m_cell in occupied.keys():
		if m_cell.y == p_row_index:
			m_x_position.append(int(m_cell.x))
		
	m_x_position.sort()
	
	if p_dir == Vector2.RIGHT:
		m_x_position.invert()
	
	var m_sorted_cells: Array = []
	for m_x in m_x_position:
		m_sorted_cells.append(Vector2(m_x, p_row_index))
	
	return m_sorted_cells


func get_column_data(p_column_index: int, p_dir: Vector2) -> Array:
	var m_y_position: Array = []
	
	for m_cell in occupied.keys():
		if m_cell.x == p_column_index:
			m_y_position.append(int(m_cell.y))
	
	m_y_position.sort()
	
	if p_dir == Vector2.DOWN:
		m_y_position.invert()
	
	var m_sorted_cells: Array = []
	for m_y in m_y_position:
		m_sorted_cells.append(Vector2(p_column_index, m_y))
	
	return m_sorted_cells


func play_move_audio() -> void:
	var m_random_pitch: float = rand_range(PITCH_VARIATION_LOWER_BOUND, PITCH_VARIATION_UPPER_BOUND)
	AudioManager.play_sfx(move_sound, 0.0 , m_random_pitch)
