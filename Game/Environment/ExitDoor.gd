extends Area2D

signal entered_door(from_level,door_name)

export var from_level=""
export var door_name="exit"



# Called when the node enters the scene tree for the first time.
func _ready():
	#print("ready door")
	from_level=get_tree().current_scene.filename
	
func _on_Door_body_entered(body):
	# Just emit a signal of player entering the door, if it is in the player group
	if body.is_in_group("player"):
		emit_signal("entered_door",from_level,door_name)
