Scriptname CheatBunker:PowerArmorScript extends DynamicTerminal:Builder:Menu Conditional

ObjectReference Property Workbench Auto Const Mandatory
Furniture Property PowerArmorFrame Auto Const Mandatory
Ammo Property FusionCore Auto Const Mandatory
Message Property mSpawned Auto Const Mandatory
Message Property mCannotSpawn Auto Const Mandatory
Keyword Property FurnitureTypePowerArmor Auto Const Mandatory
Int Property iPowerArmorSearchRadius = 128 Auto Const

Int Property iArmorID = 0 Auto Const
Int Property iMaterialID = 1 Auto Const

Bool bHasArmor = false Conditional
Bool bHasMaterial = false Conditional

Function clearState()
	parent.clearState()

	bHasArmor = false
	bHasMaterial = false
EndFunction

Function updateLogic()
	if (!bHasArmor && getComponent(iArmorID).isComplete())
		bHasArmor = true
		getComponent(iMaterialID).setOptions( (getComponent(iArmorID).getValue() as CheatBunker:PowerArmorOption:Abstract).MaterialOptions )
	endif

	bHasMaterial = bHasMaterial || getComponent(iMaterialID).isComplete()
EndFunction

Function calculateCanBuild()
	setCanBuild(bHasArmor) ; material not required
EndFunction

CheatBunker:PowerArmorOption:Abstract Function getArmor()
	return getComponent(iArmorID).getValue() as CheatBunker:PowerArmorOption:Abstract
EndFunction

ObjectReference Function spawnFrame(Furniture FrameToSpawn)
	ObjectReference[] nearbyPowerArmors = Workbench.FindAllReferencesWithKeyword(FurnitureTypePowerArmor, iPowerArmorSearchRadius)
	if (nearbyPowerArmors.Length > 0)
		mCannotSpawn.Show()
		return None
	endif
	
	ObjectReference frame = Workbench.PlaceAtMe(FrameToSpawn)
	frame.AddItem(FusionCore)
	return frame
EndFunction

Function applyMod(ObjectReference piece, ObjectMod mod)
	if (mod != None)
		piece.AttachMod(mod)
	endif
EndFunction

Function applyMaterial(ObjectReference piece)
	if (bHasMaterial)
		applyMod(piece, getComponent(iMaterialID).getValue() as ObjectMod)
	endif
EndFunction

Function spawnHelmet(ObjectReference frame)
	CheatBunker:PowerArmorOption:Abstract selectedArmor = getArmor()
	ObjectReference helmet = frame.PlaceAtMe(selectedArmor.getHelmet())
	applyMod(helmet, selectedArmor.getHelmetLining())
	applyMaterial(helmet)
	frame.AddItem(helmet)
EndFunction

Function spawnTorso(ObjectReference frame)
	CheatBunker:PowerArmorOption:Abstract selectedArmor = getArmor()
	ObjectReference torso = frame.PlaceAtMe(selectedArmor.getTorso())
	applyMod(torso, selectedArmor.getTorsoLining())
	applyMaterial(torso)
	frame.addItem(torso)
EndFunction

Function spawnArm(ObjectReference frame, Armor piece)
	CheatBunker:PowerArmorOption:Abstract selectedArmor = getArmor() 
	ObjectReference arm = frame.PlaceAtMe(piece)
	applyMod(arm, selectedArmor.getArmLining())
	applyMaterial(arm)
	frame.AddItem(arm)
EndFunction

Function spawnArms(ObjectReference frame)
	CheatBunker:PowerArmorOption:Abstract selectedArmor = getArmor()
	spawnArm(frame, selectedArmor.getArmLeft())
	spawnArm(frame, selectedArmor.getArmRight())
EndFunction

Function spawnLeg(ObjectReference frame, Armor piece)
	CheatBunker:PowerArmorOption:Abstract selectedArmor = getArmor()
	ObjectReference leg = frame.PlaceAtMe(piece)
	applyMod(leg, selectedArmor.getLegLining())
	applyMaterial(leg)
	frame.AddItem(leg)
EndFunction

Function spawnLegs(ObjectReference frame)
	CheatBunker:PowerArmorOption:Abstract selectedArmor = getArmor()
	spawnLeg(frame, selectedArmor.getLegLeft())
	spawnLeg(frame, selectedArmor.getLegRight())
EndFunction

Function buildPieces(ObjectReference frame)
	spawnHelmet(frame)
	spawnTorso(frame)
	spawnArms(frame)
	spawnLegs(frame)
EndFunction

Function buildLogic()
	CheatBunker:PowerArmorOption:Abstract selectedArmor = getArmor()
	
	if (selectedArmor.canLoad())
		Furniture frameToSpawn = selectedArmor.getCustomFrame()
		if (None == frameToSpawn)
			frameToSpawn = PowerArmorFrame
		endif
		
		ObjectReference frame = spawnFrame(frameToSpawn)
		if (None != frame)
			buildPieces(frame)
			mSpawned.Show()
		endif
	endif
	
	selectedArmor.clean()
EndFunction
