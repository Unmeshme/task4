extends Control


onready var required: Label = $container/hcontainer/Required


func setup(p_required: int) -> void:
	#set the minrect to the value I have? though its already done by the gui
	required.text = str(p_required)

func update_label(p_label_val: int) -> void:
	if p_label_val < 1:
		required.text = "Done"
	else:
		required.text = str(p_label_val)
