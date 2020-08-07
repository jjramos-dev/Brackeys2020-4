extends Control

var has_a_gun=false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_gun_body_entered(body):
	if !has_a_gun:
		has_a_gun=true
		$AnimationPlayer.play("got_a_gun")
	else:
		$AnimationPlayer.play("stop")
