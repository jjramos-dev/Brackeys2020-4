extends Level


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OverallLogic.has_key:
		$Scene/Key.queue_free()

func _on_Key_body_entered(body: Node) -> void:
	OverallLogic.give_key()
	$Scene/Key.queue_free()
