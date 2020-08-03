extends Puppet

var velocity : Vector2

func _on_discharge():
	if max_energy_charged > 0:
		jump(max_energy_charged)
		max_energy_charged = 0
	
	velocity = move_and_slide(velocity+gravity_speed)
	"""var col = move_and_collide(gravity_speed)
	if col is Player:
		col.move_and_collide(gravity_speed)"""

func jump(jump_heigh : int) -> void:
	velocity.y += -100 - 50*jump_heigh
	#velocity.y += -500
	
	
func apply_charge(en,delta):
	if energy > max_energy_charged:
		max_energy_charged = energy
