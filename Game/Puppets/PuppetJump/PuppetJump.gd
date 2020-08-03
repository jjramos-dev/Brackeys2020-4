extends Puppet

var velocity : Vector2

func _on_discharge():
	if max_energy_charged > 0:
		jump(max_energy_charged)
		max_energy_charged = 0
	velocity = move_and_slide(gravity_speed+velocity,Vector2.UP)

func jump(jump_heigh : int) -> void:
	velocity.y += -100 - 50*jump_heigh
	#velocity.y += -500
	
	
func apply_charge(en,delta):
	if energy > max_energy_charged:
		max_energy_charged = energy
