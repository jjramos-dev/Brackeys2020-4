extends Puppet

func _ready():
	recharge_rate = 4
	discharge_rate = 8

func _on_discharge():
	if max_energy_charged > 0:
		print(max_energy_charged)
		jump(max_energy_charged)
		max_energy_charged = 0
	
	velocity = move_and_slide(velocity)
	"""var col = move_and_collide(gravity_speed)
	if col is Player:
		col.move_and_collide(gravity_speed)"""

func jump(jump_mult : int) -> void:
	jump_height = jump_height_step * jump_mult
	gravity = (2 * jump_height) / pow(time_jump_apex, 2)
	jump_force = gravity * time_jump_apex
	velocity.y = -jump_force
	
	
func apply_charge():
	if energy > max_energy_charged:
		max_energy_charged = energy
