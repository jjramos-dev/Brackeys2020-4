extends KinematicBody2D
class_name Puppet

#Todo add discharged? That is idle?
enum STATE {IDLE, DISCHARGING, RECHARGING, DISCHARGED} # Discharging==IDLE
var state=STATE.IDLE

export var max_energy=10

export var isTouchable=true
export var recharge_rate=4
export var discharge_rate=4

export var stop_speed = 0.2

export var speed=50
export var fall_mult := 2
export var jump_height_step := 10.0
export var time_jump_apex := 0.4
export var direction : float = 1.0

var jump_height : float = 60.0

var gravity : float = 750
var jump_force : float = 300
var velocity : Vector2

var max_energy_charged : int = 0
var in_the_air=false
var energy=0


var next_to_charger=false
var not_move = false
var recharging=false;

onready var rewinder_key : Key = $Key

# Just negate it if the player doesn't have the key.
export var key_usable=true

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgress.visible=false
	hide_key()
	$TextureProgress.max_value=max_energy
	state=STATE.IDLE
	if direction == -1.0:
		scale.x = -1

func _physics_process(delta):
	
	#gravity = (2 * jump_height) / pow(time_jump_apex, 2)
	#jump_force = gravity * time_jump_apex
	if not_move:
		return
	if velocity.y > 0:
		velocity.y += gravity * delta * (fall_mult)
	else:
		velocity.y += gravity * delta
	
	if OverallLogic.has_key:
		if state==STATE.RECHARGING: 
			recharge(delta*recharge_rate)
			recharge_key()
		else:
			#apply_charge(energy,delta)
			apply_charge()
			discharge(delta*discharge_rate)
			discharge_key()
		
	if energy>0 or (next_to_charger and OverallLogic.has_key):	
		$TextureProgress.visible=true
		update_bar(energy)
	else:
		$TextureProgress.visible=false
		hide_key()



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
	hide_key()

func apply_charge():
	"""if energy > 0 and is_on_floor():
		direction = 1
	elif direction > 0.01:
		direction *= stop_speed
	else:
		direction = 0"""
	var mult := 10.0
	if energy < 1:
		mult = 5.0
	if energy < 0.5:
		mult = 0
	velocity.x = speed * direction * mult / max_energy   # Just to follow the way its facing
	velocity = move_and_slide(velocity,Vector2.UP)
	
	if scale.x<0:
		print(str(scale.x))
	
func recharge(amount):
	if next_to_charger:
		state=STATE.RECHARGING 
		energy=energy+amount
#		if energy > max_energy_charged:
#			max_energy_charged = energy
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
			#print("Entered rewinder "+self.name)
			if body.has_method("set_rewind_toy"):
				body.set_rewind_toy(self)
			
			next_to_charger=true
			
				
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

			next_to_charger=false
			
			if energy>0:
				state=STATE.DISCHARGING
			else:
				state=STATE.IDLE

func set_recharging(recharge_):
	if recharge_:
		if state!=STATE.DISCHARGING:
			state=STATE.RECHARGING
	else:
		if energy>0:
			state=STATE.DISCHARGING
		else:
			state=STATE.IDLE

func show_key():
	if rewinder_key!=null:
		rewinder_key.visible=true
	
func hide_key():
	if rewinder_key != null:
		rewinder_key.stop()
		rewinder_key.visible=false
	
func recharge_key():
	if rewinder_key!=null:
		show_key()
		rewinder_key.recharge()

func discharge_key():
	if rewinder_key!=null:
		show_key()
		rewinder_key.discharge()
