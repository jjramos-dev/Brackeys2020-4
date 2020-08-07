extends StaticBody2D


var platform_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func is_pressed() -> bool:
	return platform_pressed

func enable_platform():
	$enable_time.start(0.3)

func disable_platform():
	#scale.y = 1
	modulate = Color("FFFFFF")
	platform_pressed = false

func _on_over_it_body_entered(body: Node) -> void:
	if body is Player or body.is_in_group("bullet"):
		print("entered")
		enable_platform()


func _on_over_it_body_exited(body: Node) -> void:
	if body is Player or body.is_in_group("bullet"):
		print("exited")
		$disable_time.start(3)

func _on_enable_time_timeout() -> void:
	platform_pressed = true
	#scale.y = 0.5
	modulate = Color("4e2557")

func _on_disable_time_timeout() -> void:
	for body in $over_it.get_overlapping_bodies():
		if body is Player:
			return
	disable_platform()














