extends Node

var starting_door="HiddenDoor"

var has_key = false
var has_gun = false

export var transitions= {
		"door-1.1": ["res://Menus/StartMenu.tscn","entrance"],
		"door-1.2": ["res://Levels/Stage3/Stage3.tscn","door-3.1"],
		"door-1.3": ["res://Levels/Stage4/Stage4.tscn","door-4.1"],
		"door-2.1": ["res://Menus/StartMenu.tscn","entrance"],
		"door-2.2": ["res://Levels/Stage4/Stage4.tscn","door-4.1"],
		"door-4.1": ["res://Levels/Stage2/Stage2.tscn","door-2.2"],
		"door-4.2":["res://Levels/Stage6/Stage6.tscn","door-6.1"],
		"door-6.1":["res://Levels/Stage4/Stage4.tscn","door-4.2"]}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func entered_door(door_id):
	var scene_to=transitions[door_id][0]
	var door_to=transitions[door_id][1]
	
	print("Cambio a escena: \""+scene_to+":"+door_to)
	
	change_scene(scene_to,door_to)
	
func change_scene(scene,door):
	OverallLogic.starting_door=door
	get_tree().change_scene(scene)
		

func give_key() -> void:
	has_key = true
	
func give_gun() -> void:
	has_gun = true
	SIGNALS.emit_signal("gun_picked")
