extends KinematicBody2D
class_name Player

var rewinding=false
var rewind_toy=null
var do_not_move = false
var velocity := Vector2.ZERO
var speed := 125

export var check_visibility=true

export var fall_mult := 2
export var jump_height := 60.0
var time_jump_apex := 0.4

var gravity : float = 750
var jump_force : float = 300

var direction : = 1

func _ready() -> void:
	print("Ready player one")
	SIGNALS.connect("gun_picked",self,"on_gun_picked")
	SIGNALS.connect("player_hit",self,"on_player_hit")
	#SIGNALS.connect("key_picked",self,"on_key_picked")
	#on_gun_picked()
	if OverallLogic.has_gun:
		on_gun_picked()

func _physics_process(delta: float) -> void:
	#gravity = (2 * jump_height) / pow(time_jump_apex, 2)
	#jump_force = gravity * time_jump_apex
	if do_not_move:
		return
	if velocity.y > 0:
		velocity.y += gravity * delta * (fall_mult)
	else:
		velocity.y += gravity * delta
	if Input.is_action_pressed("right") and \
	   Input.is_action_pressed("left"):
		velocity.x = 0
		$AnimationPlayer.play("idle")
	elif Input.is_action_pressed("right"):
		velocity.x = speed
		$AnimationPlayer.play("run")
		if direction == -1:
			direction = 1
			SIGNALS.emit_signal("change_direction",direction)
			scale.x = -1
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		$AnimationPlayer.play("run")
		if direction == 1:
			direction = -1
			SIGNALS.emit_signal("change_direction",direction)
			scale.x = -1
	else:
		velocity.x = 0
		$AnimationPlayer.play("idle")
	
	#if rewind_toy!=null and OverallLogic.has_key:
	if rewind_toy!=null:
		if Input.is_action_pressed("rewind"):
			if OverallLogic.has_key:
				rewind_toy.set_recharging(true)
		else:
			rewind_toy.set_recharging(false)
			
	if Input.is_action_just_pressed("jump") and \
		is_on_floor():
		velocity.y = -jump_force
		#$AnimationPlayer.play("jump")
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	velocity = move_and_slide(velocity,Vector2.UP)
	
func is_rewinding():
	return rewinding
	
func set_rewind_toy(toy_) -> void:
	rewind_toy=toy_


func _on_VisibilityNotifier2D_screen_exited() -> void:
	if check_visibility:
		 get_tree().reload_current_scene()

func on_gun_picked() -> void:
	$gun_pos/gun.visible = true
	

func on_player_hit() -> void:
	do_not_move = true
	for i in 16:
		$Sprite.modulate = Color("6dff0000")
		yield(get_tree(), "idle_frame")
		$Sprite.modulate = Color("ff6d6d")
		yield(get_tree(), "idle_frame")
		position += Vector2(rand_range(-3,3),rand_range(-3,3))
	do_not_move = false
"""
func on_key_picked() -> void:
	#Cargar algo en el sprite
	pass
"""









