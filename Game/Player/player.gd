extends KinematicBody2D
class_name Player

var velocity := Vector2.ZERO
var speed := 250

export var fall_mult := 2
export var jump_height := 120
var time_jump_apex := 0.4

var gravity : float
var jump_force : float

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	gravity = (2 * jump_height) / pow(time_jump_apex, 2)
	jump_force = gravity * time_jump_apex
	
	if velocity.y > 0:
		velocity.y += gravity * delta * (fall_mult)
	else:
		velocity.y += gravity * delta
	
	if Input.is_action_pressed("right"):
		velocity.x = speed
		$AnimationPlayer.play("run")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		$AnimationPlayer.play("run")
		$Sprite.flip_h = true
	else:
		velocity.x = 0
		$AnimationPlayer.play("idle")

	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force
		#$AnimationPlayer.play("jump")
	
	velocity = move_and_slide(velocity,Vector2.UP)
