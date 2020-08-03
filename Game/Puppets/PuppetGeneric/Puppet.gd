extends KinematicBody2D
class_name Puppet


enum STATE {IDLE, DISCHARGING, RECHARGING} # Discharging==IDLE
var state=STATE.IDLE

export var max_energy=10

export var isTouchable=true
export var recharge_rate=4

export var speed=1000

var max_energy_charged : int = 0
var in_the_air=false
var energy=0

var direction=Vector2(1,0)
var gravity_speed=Vector2(0,20)

var recharging=false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgress.max_value=max_energy
	state=STATE.IDLE

func _physics_process(delta):
	
	if recharging: 
		recharge(delta*recharge_rate)	

	else:
		apply_charge(energy,delta)
		discharge(delta)

	# todo: Copy from player!!!!!!
	if is_on_floor():
		gravity_speed=Vector2(0,10)
	else:
		gravity_speed+=Vector2(0,10*delta)
	
	# todo: change. Show only when player near or charging.
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
	var dir=Vector2(0,0)
	if en>0:
		#if is_on_floor():
		dir=direction
	move_and_slide(dir*speed*delta+gravity_speed,Vector2.UP)
	
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
				recharging=true   # we need this boolean because it is not a sate compatible with the others... it's an external state. 
			elif not event.pressed:
				recharging=false



func _on_Rewinder_body_entered(body):
	if state==STATE.IDLE or state==STATE.RECHARGING:
		if body.is_in_group("rewinder"):
			# Does the variable "charging" exist?
			if "rewinding" in body:
				if body.rewinding:
					state=STATE.RECHARGING
				else:
					state=STATE.DISCHARGING
			

func _on_Rewinder_body_exited(body):
	if body.is_in_group("rewinder"):
		if "rewinding" in body:
			state=STATE.DISCHARGING
