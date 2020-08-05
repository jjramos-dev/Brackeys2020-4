extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Let's look for our doors:
	for door in $Doors.get_children():
		door.connect("entered_door",self,"_on_door_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_door_entered(scene,door):
	print("Reached door "+door)

func _on_Door_entered_door():
	print("Llega al final!!!!")
