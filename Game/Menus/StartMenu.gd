extends Level

export var first_scene="res://Levels/Stage2/Stage2.tscn"
export var first_door="door-2.1"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_ButtonStart_pressed():
	print("Cambiando a: "+first_scene)
	OverallLogic.change_scene(first_scene,null)
