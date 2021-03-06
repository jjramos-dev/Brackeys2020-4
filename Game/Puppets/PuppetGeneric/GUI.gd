extends Control


export var is_escapable=true

# Called when the node enters the scene tree for the first time.
func _ready():
	SIGNALS.connect("key_picked",self,"on_key_picked")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if is_escapable:
		if Input.is_action_just_pressed("escape"):
			if $FadeOut.visible:
				$FadeOut.visible=false
				get_tree().paused=false
			else:
				$FadeOut.visible=true
				get_tree().paused=true				

func _on_Timer_timeout():
	#$Hint.visible=false
	#$Hint2.visible=false
	pass

func on_key_picked() -> void:
	print("KEY PICKED")
	$Text/AnimationPlayer.play("got_a_key")


func _on_ButtonStart_focus_entered():
	$Text/AnimationPlayer.play("StartButton")


func _on_ButtonStart_focus_exited():
	$AnimationPlayer.play("Stop")



func _on_ButtonStart_mouse_entered():
	$AnimationPlayer.play("StartButton")
	

func _on_ButtonStart_mouse_exited():
	$AnimationPlayer.play("Stop")


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		$AnimationPlayer.play("cinematic")


func _on_ControlButton_pressed():
	pass # Replace with function body.
