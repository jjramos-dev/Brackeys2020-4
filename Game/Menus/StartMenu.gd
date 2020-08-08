extends Level

export var first_scene="res://Levels/Stage2/Stage2.tscn"
export var credits_scene="res://Menus/Credits.tscn"
export var first_door="door-2.1"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_StartButton_pressed():
	OverallLogic.change_scene(first_scene,null)


func _on_CreditsButton_pressed():
	OverallLogic.change_scene(credits_scene,null)


func _on_ExitButton_pressed():
	get_tree().quit() # default behavior


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().quit() # default behavior
