extends Node2D

export var speed=1
export var inverted=false

# Called when the node enters the scene tree for the first time.
func _ready():
	if inverted:
		$AnimationPlayer.play("running")
	else:			
		$AnimationPlayer.play_backwards("running")
	$AnimationPlayer.playback_speed=speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
