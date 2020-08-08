extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var is_escapable=true

func _process(delta):

	if is_escapable:
		if Input.is_action_just_pressed("escape"):
			if $FadeOut.visible:
				$FadeOut.visible=false
				get_tree().paused=false
			else:
				$FadeOut.visible=true
				get_tree().paused=true	
