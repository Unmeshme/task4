extends Control


signal game_has_ended
signal level_completed


#now hud script will orcastrate it all
onready var score: Control = $Container/PlayerScore
onready var time: Control = $Container/TimeLeft
onready var level_info: Control = $Container/ProgressBar



#this function will be called by the level manager
func initialize_initial_state(p_time: int, p_num_delivery: Dictionary) -> void:
	score.reset()
	time.set_timer_val(p_time)
	level_info.generate_counter_element(p_num_delivery)
	
func update_score() -> void:
	score.update_score()


func _on_BoardState_has_combined(p_data: Dictionary):
	update_score()
	level_info.update_progress(p_data)

func _on_timeLeft_game_has_ended():
	emit_signal("game_has_ended")

func reset_hud() -> void:
	level_info.reset_progress_bar()


func _on_progressbar_level_completed():
	emit_signal("level_completed")

func pause_timer() -> void:
	time.pause_timer()


func resume_timer() -> void:
	time.resume_timer()
