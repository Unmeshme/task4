extends Control


signal game_has_ended



#now hud script will orcastrate it all
onready var score: Control = $Container/PlayerScore
onready var time: Control = $Container/TimeLeft
onready var level_info: Control = $Container/ProgressBar




#this function will be called by the level manager
func _initialize_initial_state(p_time: int, p_num_delivery: int) -> void:
	score.reset()
	time.set_timer_val(p_time)
	#level_info.set_deliver_amount(p_num_delivery)
	
func update_score() -> void:
	score.update_score()


func _on_BoardState_has_combined():
	update_score()




func _on_timeLeft_game_has_ended():
	emit_signal("game_has_ended")
