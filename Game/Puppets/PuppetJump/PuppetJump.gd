extends Puppet

var on_jump := false

func _ready():
	recharge_rate = 4
	discharge_rate = 8

func _on_discharge():
	._on_discharge()
	if max_energy_charged > 0 and not on_jump:
		on_jump = true
		$Timer.start(0.4)

func jump_3() -> void:
	position.y -= max_energy_charged

func apply_charge():
	if energy > max_energy_charged:
		max_energy_charged = energy
	if on_jump:
		jump_3()
	else:
		velocity = move_and_slide(velocity,Vector2.UP)

func _on_Timer_timeout() -> void:
	on_jump = false
	max_energy_charged = 0
