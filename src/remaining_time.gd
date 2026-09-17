extends Control


onready var remaining_time: Label = $VBoxContainer/TimeAmount
onready var timer: Timer = $Time

var current_val: int 
var timer_val: int
#write functions to update the remaining time
#call this function every other second

func update_time_val() -> void:
	current_val -= 1
	update_time_label(current_val)

func update_time_label(p_amount: int) -> void:
	remaining_time.text = str(p_amount) 

func assign_timer_val(p_val: int) -> void:
	timer_val = p_val
