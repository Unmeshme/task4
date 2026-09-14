extends Control


onready var map:GridContainer = $game_map
onready var apple:Control = $apple
onready var orang:Control = $orange

func _ready() -> void:
	var m_apple_position = map.get_child_position(0,0)
	var m_orang_position = map.get_child_position(3,3)
	print(m_apple_position)
	apple.rect_global_position = m_apple_position
	orang.rect_global_position = m_orang_position
	
