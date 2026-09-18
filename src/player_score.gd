extends Control

onready var player_score_amount: Label = $HBoxContainer/ScoreValue

#assume per delivery gives the player 10 score point
#for now we can keep it static and later we can make it more dynamic
#with combo

var score: int = 0

func update_score() -> void:
	score += 10
	update_score_label()

func get_score() -> int:
	return score

func reset() -> void:
	score = 0
	update_score_label()

func update_score_label() -> void:
	player_score_amount.text = str(score)
