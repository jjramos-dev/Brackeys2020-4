extends Node2D
class_name Gun

var mouse_pos : Vector2
export var smooth : = 0.3
export var bullet_speed : = 300

var direction = 1


func _ready() -> void:
	SIGNALS.connect("change_direction",self,"on_changed_direction")

func _physics_process(delta: float) -> void:
	mouse_pos = get_local_mouse_position()
	rotation += mouse_pos.angle() * smooth
	
	if Input.is_action_just_pressed("shoot"):
		if $bullet_pos.get_child_count() == 0:
			var bullet_node = preload("res://Player/bullet.tscn").instance()
			$bullet_pos.add_child(bullet_node)
			bullet_node.set_as_toplevel(true)
			if direction == 1:
				bullet_node.linear_velocity = Vector2(1,0).rotated(rotation)*bullet_speed
			else:
				bullet_node.linear_velocity = Vector2(-1,0).rotated(-rotation)*bullet_speed

func on_changed_direction(dir : int) -> void:
	direction = dir



func _on_bullet_area_body_entered(body: Node) -> void:
	if body is Bullet:
		SIGNALS.emit_signal("bullet_on_gun")
