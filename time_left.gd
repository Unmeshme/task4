extends Control


onready var timeValue: Label = $HBoxContainer/TimeValue
onready var timer: Timer = $Counter

signal game_has_ended

var total_time: int = 0


#set_timer_val can be used to rest it as well
func set_timer_val(p_val: int) -> void:
	timeValue.text = str(p_val)
	total_time = p_val



func _on_counter_timeout():
	set_timer_val(total_time - 1)
	
	if total_time < 0:
		emit_signal("game_has_ended")
