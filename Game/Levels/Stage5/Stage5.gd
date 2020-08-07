extends Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OverallLogic.has_gun:
		$Scene/gun.queue_free()

func _on_gun_body_entered(body: Node) -> void:
	OverallLogic.give_gun()
	$Scene/gun.queue_free()
