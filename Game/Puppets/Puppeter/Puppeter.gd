extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func work():
	$AnimationPlayer.play("working")

func look_back():
	$AnimationPlayer.play("look_back")
	
func stopp():
	$AnimationPlayer.play("stop")

func nod():
	$AnimationPlayer.play("nood")
