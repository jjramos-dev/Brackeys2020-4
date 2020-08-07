extends Node

var can_be_killed : = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func can_be_killed() -> bool:
	return can_be_killed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for child in get_children():
		if not child.is_pressed():
			can_be_killed = false
			return
	can_be_killed = true
