extends Control


onready var map:GridContainer = $game_map
onready var apple:Control = $apple
onready var orang:Control = $orang

#rather than getting the child position. Its best to get the global rect position
#and then translating it by the size of the rect formed by app
func _ready() -> void:
	apple.rect_global_position = map.get_rect_position()
	orang.rect_global_position = Vector2(apple.rect_global_position.x + 100, apple.rect_global_position.y)
