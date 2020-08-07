extends KinematicBody2D
class_name Enemy

var velocity := Vector2.ZERO
export var speed := 150
var direction := 1

export var fall_mult := 2
export var jump_height := 120
export var time_jump_apex := 0.4

var gravity : float
var jump_force : float
var on_wall := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("run")

func _physics_process(delta: float) -> void:
	gravity = (2 * jump_height) / pow(time_jump_apex, 2)
	jump_force = gravity * time_jump_apex
	
	if velocity.y > 0:
		velocity.y += gravity * delta * (fall_mult)
	else:
		velocity.y += gravity * delta
	
	#Change direction if is on wall or on edge
	if is_on_wall():
		on_wall = true
		print("onwall")
		$on_wall_time.start(0.2)
		change_direction()
	
	
	#TODO make raycast work with tilemap
	"""if $RayCast2D.is_colliding() == false:
		change_direction()
	else:
		if $RayCast2D.get_collision_point().y > 360:
			change_direction()"""
	
	#Change velocity depending on the place
	#the enemy is looking to
	velocity.x = speed * direction
	
	#Condicion para idle
	#	velocity.x = 0
	#	$AnimationPlayer.play("idle")

	#Condición para saltar
		#velocity.y = -jump_force
		#$AnimationPlayer.play("jump")
	
	"""if test_move(Transform2D(0.0,Vector2(position.x+speed,position.y)),Vector2(0,-1)) == false:
		change_direction()"""
	
	velocity = move_and_slide(velocity,Vector2.UP)

func change_direction() -> void:
	scale.x = -1 * scale.x
	direction *= -1

#Function to turn toward the enemy or the bullet
func _on_proximity_detection_body_entered(body: Node) -> void:
	if body is Player:
	#if body is Player or body is Bullet:
		print("Player or bullet entered")


func _on_proximity_detection_body_exited(body: Node) -> void:
	if body is Player:
	#if body is Player or body is Bullet:
		print("Player or bullet exited")


func _on_floor_detection_body_exited(body: Node) -> void:
	print("Body exited")
	if body.name == "TileMap" and not on_wall:
		change_direction()
	"""var tilemap := false
	
	for body in $floor_detection.get_overlapping_bodies():
		print(body.name)
		if body.name == "TileMap":
			print("Tilemap")
			tilemap = true
	if not tilemap:
		change_direction()"""
		

func _on_on_wall_time_timeout() -> void:
	on_wall = false
