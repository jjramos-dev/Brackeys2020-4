extends Node

var starting_door="HiddenDoor"

var has_key = true
var has_gun = true

export var transitions= {
		"entrance": ["res://Levels/Stage1/Stage1.tscn","door-1.1"],	
		"door-0.2": ["res://Levels/Stage1/Stage1.tscn","door-1.1"],
		"door-1.1": ["res://Levels/Stage0/Stage0.tscn","door-0.2"],
		"door-1.2": ["res://Levels/Stage3/Stage3.tscn","door-3.1"],
		"door-1.3": ["res://Levels/Stage2/Stage2.tscn","door-2.1"],
		"door-2.1": ["res://Levels/Stage1/Stage1.tscn","door-1.3"],
		"door-2.2": ["res://Levels/Stage4/Stage4.tscn","door-4.1"],
		"door-3.1": ["res://Levels/Stage1/Stage1.tscn","door-1.2"],
		"door-4.1": ["res://Levels/Stage2/Stage2.tscn","door2.2"],
		"door-4.2":["res://Levels/Stage11/Stage11.tscn","door-11.1"],
		"door-5.1":["res://Levels/Stage7/Stage7.tscn","door-7.3"],
		"door-7.1":["res://Levels/Stage15/Stage15.tscn","door-15.2"],
		"door-7.2":["res://Levels/Stage17/Stage17.tscn","door-17.1"],
		"door-7.3":["res://Levels/Stage5/Stage5.tscn","door-5.1"],
		"door-9.1":["res://Levels/Stage11/Stage11.tscn","door-11.2"],
		"door-9.2":["res://Levels/Stage13/Stage13.tscn","door-13.1"],
		"door-11.1":["res://Levels/Stage4/Stage4.tscn","door-4.2"],
		"door-11.2":["res://Levels/Stage9/Stage9.tscn","door-9.1"],
		"door-13.1":["res://Levels/Stage9/Stage9.tscn","door-9.2"],
		"door-13.2":["res://Levels/Stage15/Stage15.tscn","door-15.1"],
		"door-15.1":["res://Levels/Stage13/Stage13.tscn","door-13.2"],
		"door-15.2":["res://Levels/Stage7/Stage7.tscn","door-7.1"],
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
