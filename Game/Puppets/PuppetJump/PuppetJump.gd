extends Puppet

var on_jump := false
var on_fall := false
var jump_time := 0.5
var energy_discharge

func _ready():
	recharge_rate = 4
	discharge_rate = 4

func _on_discharge():
	._on_discharge()
	if max_energy_charged > 0 and not on_jump:
		on_jump = true
		state = STATE.DISCHARGED
		$Timer.start(jump_time)

func jump() -> void:
	position.y -= max_energy_charged/2

func fall() -> void:
	position.y += energy_discharge/2
	
func apply_charge():
	match state:
		STATE.IDLE:
			$AnimationPlayer.play("idle")
			
		STATE.DISCHARGED:
			$AnimationPlayer.play("discharging")
			print("play discharged")
			
		STATE.RECHARGING:
			$AnimationPlayer.play("recharging")
			print("play recharging")
	
	if energy > max_energy_charged:
		max_energy_charged = energy
	if on_jump:
		jump()
	if on_fall:
		fall()
	if not on_jump and not on_fall:
		velocity = move_and_slide(velocity,Vector2.UP)

func _on_Timer_timeout() -> void:
	if on_jump:
		on_jump = false
		$Timer.start(jump_time - 0.1)
		energy_discharge = max_energy_charged
		max_energy_charged = 0
		on_fall = true
	elif on_fall:
		on_fall = false
