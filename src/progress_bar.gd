extends Control


onready var container: GridContainer = $Control/GridContainer


signal level_completed



var counter_elements: Dictionary = {
	"apple" : preload("res://src/DeliveryItemApple.tscn"),
	"orange" : preload("res://src/DeliveryItemOrange.tscn"),
	"cake": preload("res://src/DeliveryItemCake.tscn"),
}


var id_to_item: Dictionary = {
	0: "apple",
	1: "orange",
	2: "cake",
}


var item_to_id: Dictionary = {
	"apple": 0,
	"orange": 1,
	"cake": 2,
}


var progress_data: Dictionary
var item_data_reference: Dictionary

func generate_counter_element(p_data: Dictionary) -> void:
	container.columns = p_data.size()
	for m_key in p_data.keys():
		progress_data[m_key] = p_data[m_key]
		var m_instance = counter_elements[m_key].instance()
		container.add_child(m_instance)
		m_instance.setup(p_data[m_key])
		item_data_reference[m_key] = m_instance


func update_progress(p_change_data: Dictionary) -> void:
	for m_id in p_change_data.keys():
		progress_data[id_to_item[m_id]] -= p_change_data[m_id]
	update_label()
	check_level_completed()

func update_label() -> void:
	for m_key in progress_data.keys():
		item_data_reference[m_key].update_label(progress_data[m_key])


func reset_progress_bar() -> void:
	for m_child in container.get_children():
		m_child.queue_free()


func check_level_completed() -> void:
	var m_level_completed: bool = true
	for m_keys in progress_data:
		if progress_data[m_keys] >= 1:
			return
	
	if m_level_completed:
		emit_signal("level_completed")
