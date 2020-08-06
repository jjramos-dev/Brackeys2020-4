extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	#$Hint.visible=false
	#$Hint2.visible=false
	pass


func _on_ButtonStart_focus_entered():
	$AnimationPlayer.play("StartButton")


func _on_ButtonStart_focus_exited():
	$AnimationPlayer.play("Stop")



func _on_ButtonStart_mouse_entered():
	$AnimationPlayer.play("StartButton")
	

func _on_ButtonStart_mouse_exited():
	$AnimationPlayer.play("Stop")
