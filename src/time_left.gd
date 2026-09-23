extends Control


onready var timeValue: Label = $HBoxContainer/TimeValue
onready var timer: Timer = $Counter

signal game_has_ended

var total_time: int = 0
var time_30_percent: float = 0

#set_timer_val can be used to reset it as well
func set_timer_val(p_val: int) -> void:
	timeValue.text = str(p_val)
	total_time = p_val
	
	if time_30_percent == 0:
		time_30_percent =  0.3 * total_time


func _on_counter_timeout():
	set_timer_val(total_time - 1)
	
	if total_time <= time_30_percent:
		Globals.bonus_round = true
	
	if total_time < 0:
		emit_signal("game_has_ended")

#call this everytime new level is loaded
func reset_time_30_percent() -> void:
	time_30_percent = 0


