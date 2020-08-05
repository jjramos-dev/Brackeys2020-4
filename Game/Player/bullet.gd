extends RigidBody2D
class_name Bullet

export var timeout_time : = 2.5
export var speed_rewind : = 500

var collision_pos : Array
var hooks_array : Array
var on_rewind = false
var on_last_hop = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start(timeout_time)
	SIGNALS.connect("bullet_on_gun",self,"on_bullet_on_gun")

func _physics_process(delta: float) -> void:
	var vel : Vector2
	if on_last_hop:
		vel = get_parent().global_position - position
		linear_velocity = vel.normalized()*speed_rewind

func rewind():
	on_rewind = true
	mode = MODE_CHARACTER
	var vel : Vector2
	move_to_prev_hook()

func _on_Timer_timeout() -> void:
	rewind()

func set_hook(body: Node):
	var hook = preload("res://Player/hook.tscn").instance()
	add_child(hook)
	hook.position = position
	hook.set_as_toplevel(true)
	hooks_array.append(hook)

func move_to_prev_hook()->void:
	print("move_to_prev")
	print(collision_pos)
	print(position)
	var vel : Vector2
	vel = collision_pos.pop_back() - position
	linear_velocity = vel.normalized()*speed_rewind

func follow_player()->void:
	var player_touched = true
	if player_touched:
		queue_free()

func _on_bullet_body_entered(body: Node) -> void:
	if not on_rewind:
		collision_pos.append(position)
		set_hook(body)
	elif body is Enemy:
		queue_free()
	elif collision_pos.size() > 0:
		hooks_array.pop_back().queue_free()
		move_to_prev_hook()
	elif collision_pos.size() == 0:
		hooks_array.pop_back().queue_free()
		on_last_hop = true
	else:
		print("Vaya follón")
		queue_free()
		
func on_bullet_on_gun() -> void:
	if on_last_hop:
		queue_free()
