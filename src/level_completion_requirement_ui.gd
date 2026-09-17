extends Control


onready var required_amount: Label = $HBoxContainer/RequiredContainer/RequiredAmount
onready var delivered_amount: Label = $HBoxContainer/DeliveryContainer/DeliveryCompleted

var level_deliver_amount: int

func update_delivered_amount(p_amt: int) -> void:
	delivered_amount.text = str(p_amt)


func set_deliver_amount(p_amt: int) -> void:
	level_deliver_amount = p_amt
