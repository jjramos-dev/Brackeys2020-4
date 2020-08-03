extends KinematicBody2D
class_name Puppet

#Todo add discharged? That is idle?
enum STATE {IDLE, DISCHARGING, RECHARGING} # Discharging==IDLE
var state=STATE.IDLE

export var max_energy=10

export var isTouchable=true
export var recharge_rate=4

export var stop_speed = 0.2

export var speed=100
export var fall_mult := 2
export var jump_height := 120
export var time_jump_apex := 0.4

var direction : float = 1.0
var gravity : float
var jump_force : float
var velocity : Vector2

var max_energy_charged : int = 0
var in_the_air=false
var energy=0


var recharging=false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgress.max_value=max_energy
	state=STATE.IDLE

func _physics_process(delta):
	
	gravity = (2 * jump_height) / pow(time_jump_apex, 2)
	jump_force = gravity * time_jump_apex
	
	if velocity.y > 0:
		velocity.y += gravity * delta * (fall_mult)
	else:
		velocity.y += gravity * delta
	
	if state==STATE.RECHARGING: 
		recharge(delta*recharge_rate)	

	else:
		apply_charge(energy,delta)
		discharge(delta)

	"""# todo: Copy from player!!!!!!
	if is_on_floor():
		gravity_speed=Vector2(0,10)
	else:
		gravity_speed+=Vector2(0,10*delta)
	"""
	
	
	if energy>0:	
		$TextureProgress.visible=true
		update_bar(energy)
	else:
		$TextureProgress.visible=false
		

func update_bar(en):
	$TextureProgress.value=en  # /(1.0*max_energy)  # x100

	
func discharge(en):
	state=STATE.DISCHARGING
	energy -= en
	if energy < 0:
		energy = 0
		_on_discharge()   # Should it be a signal?
		
func _on_discharge():
	state=STATE.IDLE

func apply_charge(en,delta):
	if en>0 and is_on_floor():
		direction = 1
	elif direction > 0.01:
		direction *= stop_speed
	else:
		direction = 0
	velocity.x = speed * direction
	velocity = move_and_slide(velocity,Vector2.UP)
	
func recharge(amount):
	state=STATE.RECHARGING 
	energy=energy+amount
#	if energy > max_energy_charged:
#		max_energy_charged = energy
	if energy>max_energy:
		energy=max_energy
	
	
# If is touchable, we can put energy in the Puppet:
func _on_Puppet_input_event(viewport, event, shape_idx):
	#If istouchale and is on_discharge?
	if isTouchable:
		if event is InputEventMouseButton:
			if event.pressed:
				state=STATE.RECHARGING
				recharging=true   # we need this boolean because it is not a sate compatible with the others... it's an external state. 
			elif not event.pressed:
				state=STATE.DISCHARGING
				recharging=false



func _on_Rewinder_body_entered(body):
	if state==STATE.IDLE or state==STATE.RECHARGING:
		if body.is_in_group("rewinder"):
			if body.has_method("set_rewind_toy"):
				body.set_rewind_toy(self)
				
#			# Does the variable "charging" exist?
#			if body.has_method("is_rewinding"):
#				if body.is_rewinding():
#					state=STATE.RECHARGING
#				else:
#					state=STATE.DISCHARGING
			

func _on_Rewinder_body_exited(body):
	if body.is_in_group("rewinder"):
		if body.has_method("set_rewind_toy"):
			body.set_rewind_toy(null)
			
#		if body.has_method("is_rewinding"):
#			if energy>0:
#				state=STATE.DISCHARGING
#			else:
#				state=STATE.IDLE

func set_recharging(recharge_):
	if recharge_:
		if state!=STATE.DISCHARGING:
			state=STATE.RECHARGING
	else:
		if energy>0:
			state=STATE.DISCHARGING
		else:
			state=STATE.IDLE
