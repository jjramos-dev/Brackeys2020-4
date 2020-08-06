extends Node2D

signal entered_door(scene,door)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player=$Player/player

# Called when the node enters the scene tree for the first time.
func _ready():
	var initial_door=null
	
	if OverallLogic.has_key:
		$Scene/Key.queue_free()
	
	# Let's look for our Killer obstacles, to connect to their signals:
	for killer in $Killing.get_children():
		killer.connect("hit_by_killing",self,"_on_hit_by_killing")

	# Let's look for our doors, to connect to their signals:
	for door in $Doors.get_children():
		door.connect("entered_door",self,"_on_door_entered")
	
		# oportunistically, let's place the player next to the entering door.
		if door.door_name==OverallLogic.starting_door:
			initial_door=door
			place_player_at_door(door)
	
	# When the scene emits the signal of reaching a door,
	# the OverallLogic will be notified.
	connect("entered_door",OverallLogic,"entered_door")

	print("Ready killing!")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_door_entered(scene,door):
	# print("Reached door "+door)
	emit_signal("entered_door",door)

#func set_player_initial_door(door):
#	print("Puerta...")


func place_player_at_door(door):
	
	var cell_width=$Scene/TileMap.cell_size.x
	
	# Let's place the player next to the door, depending of its orientation
	player.position=door.position
	if door.scale.x>0:
		player.position.x+=cell_width
	else:
		player.position.x-=cell_width
		

func kill():
	get_tree().reload_current_scene() # Should it be managed here?


func _on_hit_by_killing(_name):
	print("Reload!!!!!!!")
	kill()
	
func _on_Exterior_body_entered(body):
	if body.is_in_group("player"):
		kill()
