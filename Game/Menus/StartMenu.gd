extends Node2D

export var first_scene="Stage2/Stage2.tscn"
export var first_door="door-2.1-1.2"

onready var player=$Player/player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_button_up():
	OverallLogic.change_scene(first_scene,first_door)


func place_player_at_door(door):
	
	var cell_width=$Scene/TileMap.cell_size.x
	
	# Let's place the player next to the door, depending of its orientation
	player.position=door.position
	if door.scale.x>0:
		player.position.x+=cell_width
	else:
		player.position.x-=cell_width
