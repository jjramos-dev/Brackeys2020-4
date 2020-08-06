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
	physics_material_override.bounce = 1

func _physics_process(delta: float) -> void:
	var vel : Vector2
	var draw = true
	if on_last_hop:
		vel = get_parent().global_position - position
		linear_velocity = vel.normalized()*speed_rewind

"""func draw_rope()->void:
	if not on_rewind:
		draw_line(Vector2(0,0), Vector2(50, 50), Color(255, 0, 0), 1)
	else:
		pass"""

func rewind():
	on_rewind = true
	SIGNALS.emit_signal("on_rewind")
	mode = MODE_CHARACTER
	physics_material_override.bounce = 0
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
		SIGNALS.emit_signal("bullet_col",position)
		set_hook(body)
	elif body is Enemy:
		queue_free()
	elif collision_pos.size() > 0:
		hooks_array.pop_back().queue_free()
		SIGNALS.emit_signal("hook_deleted")
		move_to_prev_hook()
	elif collision_pos.size() == 0:
		if hooks_array.size() > 0:
			hooks_array.pop_back().queue_free()
			SIGNALS.emit_signal("hook_deleted")
		on_last_hop = true
	else:
		queue_free()
		
func on_bullet_on_gun() -> void:
	if on_last_hop:
		SIGNALS.emit_signal("bullet_queued")
		queue_free()
