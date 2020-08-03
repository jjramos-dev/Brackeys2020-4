extends KinematicBody2D


export var max_energy=10

export var isTouchable=true
export var recharge_rate=4

export var speed=1000

var in_the_air=false
var energy=0

var direction=Vector2(1,0)
var gravity_speed=Vector2(0,20)

var recharging=false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgress.max_value=max_energy

func _physics_process(delta):
	if recharging:
		recharge(delta*recharge_rate)	

	else:
		apply_charge(energy,delta)
		discharge(delta)
		
	if is_on_floor():
		gravity_speed=Vector2(0,10)
	else:
		gravity_speed+=Vector2(0,10*delta)
	
		
	if energy>0:	
		$TextureProgress.visible=true
		update_bar(energy)
	else:
		$TextureProgress.visible=false
		

func update_bar(en):
	$TextureProgress.value=en  # /(1.0*max_energy)  # x100

	
func discharge(en):
	energy-=en
	if energy<0:
		energy=0
		_on_discharge()   # Should it be a signal?
		
func _on_discharge():
	move_and_slide(gravity_speed,Vector2.UP)

func apply_charge(en,delta):
	var dir=Vector2(0,0)
	if en>0:
		#if is_on_floor():
		dir=direction
	move_and_slide(dir*speed*delta,Vector2(0,1))
	
func recharge(amount):
	energy=energy+amount
	
# If is touchable, we can put energy in the Puppet:
func _on_Puppet_input_event(viewport, event, shape_idx):
	if isTouchable:
		if event is InputEventMouseButton:
			if event.pressed:
				recharging=true
			elif not event.pressed:
				recharging=false

