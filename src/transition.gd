extends Control



onready var animator: AnimationPlayer = $AnimationPlayer

func fade_out() -> void:
	animator.play("dark_to_transparant")


func fade_in() -> void:
	animator.play("transparant_to_dark")

#honestly better to not have this so I can control the actual fade in and out?
func _on_AnimationPlayer_animation_finished(p_anim_name: String):
	if p_anim_name == "transparant_to_dark":
		fade_out()
