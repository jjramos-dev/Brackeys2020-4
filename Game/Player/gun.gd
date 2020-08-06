extends Node2D
class_name Gun

var mouse_pos : Vector2
export var smooth : = 0.3
export var bullet_speed : = 300

var bullet_node : Bullet
var direction = 1
var to_draw : = false
onready var rope_node : Line2D = $rope

func _ready() -> void:
	SIGNALS.connect("change_direction",self,"on_changed_direction")
	SIGNALS.connect("bullet_queued",self,"on_bullet_queued")
	SIGNALS.connect("bullet_col",self,"on_bullet_col")
	SIGNALS.connect("hook_deleted",self,"on_hook_deleted")
	rope_node.set_as_toplevel(true)
	rope_node.global_position = Vector2.ZERO
	rope_node.global_rotation = 0
	
func _physics_process(delta: float) -> void:
	mouse_pos = get_local_mouse_position()
	rotation += mouse_pos.angle() * smooth
	if rotation > 2*PI:
		rotation -= 2*PI
	if rotation < -2*PI:
		rotation += 2*PI
	if (rotation > 0 and rotation < PI/2) or \
	   (rotation > -PI/2 and rotation < 0) or \
	   (rotation > 3*PI/2 and rotation < 2*PI) or\
	   (rotation < -3*PI/2 and rotation > -2*PI):
		$Sprite.flip_v = false
		$Sprite.offset.y = 0
	else:
		$Sprite.flip_v = true
		$Sprite.offset.y = 6
	
	if OverallLogic.has_gun and \
		Input.is_action_just_pressed("shoot"):
		if $bullet_pos.get_child_count() == 0:
			to_draw = true
			bullet_node = preload("res://Player/bullet.tscn").instance()
			$bullet_pos.add_child(bullet_node)
			bullet_node.set_as_toplevel(true)
			if direction == 1:
				bullet_node.linear_velocity = Vector2(1,0).rotated(rotation)*bullet_speed
			else:
				bullet_node.linear_velocity = Vector2(-1,0).rotated(-rotation)*bullet_speed
	
	if to_draw:
		var n_points = rope_node.get_point_count()
		if n_points == 0:
			rope_node.add_point($bullet_pos.global_position)
			rope_node.add_point(bullet_node.global_position)
		else:
			rope_node.set_point_position(0, $bullet_pos.global_position)
			rope_node.set_point_position(n_points-1, bullet_node.global_position)
	else:
		if rope_node.get_point_count() > 0:
			rope_node.clear_points()
#	update()
	
	
#func _draw() -> void:
#	if to_draw:
#		print("Draw")
#		draw_line(position, bullet_node.global_position, Color(255, 0, 0), 1)

func on_changed_direction(dir : int) -> void:
	direction = dir

func _on_bullet_area_body_entered(body: Node) -> void:
	if body is Bullet:
		SIGNALS.emit_signal("bullet_on_gun")

func on_bullet_queued() -> void:
	to_draw = false

func on_bullet_col(pos : Vector2) -> void:
	rope_node.add_point(pos)

func on_hook_deleted() -> void:
	rope_node.remove_point(rope_node.get_point_count()-2)
	
	
	
	
	
	
