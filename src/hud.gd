extends Control

#now hud script will orcastrate it all

onready var score: Control = $PlayerScore
onready var time: Control = $RemainingTime
onready var level_info: Control = $LevelCompletionRequirement


#this function will be called by the level manager
func _initialize_initial_state(p_time: int, p_num_delivery: int) -> void:
	score.reset()
	time.set_timer_val(p_time)
	level_info.set_deliver_amount(p_num_delivery)
	
