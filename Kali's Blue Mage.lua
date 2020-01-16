BLU = { isPVE = true, isPVP = false, ispve = true, ispvp  = false }
local self = BLU
local selfs = "BLU"
local selfslong = "Kali's Blue Mage"

local MinionPath = GetStartupPath()
local LuaPath = GetLuaModsPath()
local ModulePath = LuaPath .. [[ACR\CombatRoutines\Kali's Blue Mage\]]
local ModuleSettings = ModulePath .. [[Settings.lua]]
local ImageFolder = ModulePath .. [[Images\]]
local table = table
local math = math
local contains = table.contains

function self.IsNil(...)
	local tbl = {... }
	if #tbl > 0 then
		for i = 1, #tbl do
			local x = tbl[i]
			if x == nil or x == "" then
				return true
			end
		end
	else
		return true
	end
	return false
end
local IsNil = self.IsNil

local v = table.valid
function self.valid(...)
	local tbl = {...}
	local size = #tbl
	if size > 0 then
		local count = tbl[1]
		if type(count) == "number" then
			if size == (count + 1) then
				for i = 2, size do
					if not v(tbl[i]) then return false end
				end
				return true
			end
		else
			for i = 1, size do
				if not v(tbl[i]) then return false end
			end
			return true
		end
	end
	return false
end
local valid = self.valid

function self.Distance2D(pos,pos2,IgnoreRadius)
	if valid(2,pos,pos2) then
		if IgnoreRadius or not pos2.pos then
			return math.sqrt( math.pow(( pos2.x - pos.x ),2 ) + math.pow(( pos2.z - pos.z ),2 ))
		else
			local pos,pos2,radius,radius2 = pos.pos or pos, pos2.pos or pos2, pos.hitradius or 0.5, pos2.hitradius or 0.5
			return math.sqrt( math.pow(( pos2.x - pos.x ),2 ) + math.pow(( pos2.z - pos.z ),2 )) - (radius + radius2)
		end
	end
end
local Distance2D = self.Distance2D

function self.Distance3D(pos,pos2,IgnoreRadius)
	if valid(2,pos,pos2) then
		if IgnoreRadius or not pos.pos or not pos2.pos then
			if valid(pos.pos) then pos = pos.pos end
			if valid(pos2.pos) then pos2 = pos2.pos end
			return math.sqrt( math.pow(( pos2.x - pos.x ),2 ) + math.pow(( pos2.y - pos.y ),2 ) + math.pow(( pos2.z - pos.z ),2 ))
		else
			local pos,pos2,radius,radius2 = pos.pos or pos, pos2.pos or pos2, pos.hitradius or 0.5, pos2.hitradius or 0.5
			return math.sqrt( math.pow(( pos2.x - pos.x ),2 ) + math.pow(( pos2.y - pos.y ),2 ) + math.pow(( pos2.z - pos.z ),2 )) - (radius + radius2)
		end
	end
end
local Distance3D = self.Distance3D

function self.Not(check,...)
	local tbl = {...}
	if valid(tbl) then
		for i=1,#tbl do
			if check == tbl[i] then return false end
		end
		return true
	end
	return false
end
local Not = self.Not

function self.Is(check,...)
	local tbl = {...}
	if valid(tbl) then
		local valid = false
		for i=1,#tbl do
			if check == tbl[i] then valid = true end
		end
		if valid then
			return true
		end
	end
	return false
end
local Is = self.Is

function self.IsAll(check,...)
	local tbl = {...}
	if valid(tbl) then
		for i=1,#tbl do
			if check ~= tbl[i] then return false end
		end
		return true
	end
	return false
end
local IsAll = self.IsAll

self.classes = {
	[FFXIV.JOBS.BLUEMAGE] = true,
}

self.GUI = {
	open = false,
	visible = true,
	name = selfslong,
	WindowStyle = {
		["Text"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["TextDisabled"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["WindowBg"] = { [1] = 7, [2] = 0, [3] = 12, [4] = 0.75 },
		["ChildWindowBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["Border"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["BorderShadow"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["FrameBg"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.85 },
		["FrameBgHovered"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
		["FrameBgActive"] = { [1] = 179, [2] = 154, [3] = 195, [4] = 0.95 },
		["TitleBg"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
		["TitleBgCollapsed"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
		["TitleBgActive"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.85 },
		["MenuBarBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["ScrollbarBg"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.85 },
		["ScrollbarGrab"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
		["ScrollbarGrabHovered"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
		["ScrollbarGrabActive"] = { [1] = 179, [2] = 154, [3] = 195, [4] = 0.95 },
		["ComboBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["CheckMark"] = { [1] = 179, [2] = 154, [3] = 195, [4] = 0.95 },
		["SliderGrab"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.90 },
		["SliderGrabActive"] = { [1] = 179, [2] = 154, [3] = 195, [4] = 0.95 },
		["Button"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.85 },
		["ButtonHovered"] = { [1] = 48, [2] = 35, [3] = 55, [4] = 0.90 },
		["ButtonActive"] = { [1] = 59, [2] = 40, [3] = 70, [4] = 0.95 },
		["Header"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["HeaderHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["HeaderActive"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["Column"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["ColumnHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["ColumnActive"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["ResizeGrip"] = { [1] = 42, [2] = 31, [3] = 48, [4] = 0.75 },
		["ResizeGripHovered"] = { [1] = 68, [2] = 54, [3] = 77, [4] = 0.75 },
		["ResizeGripActive"] = { [1] = 84, [2] = 69, [3] = 95, [4] = 1.00 },
		["CloseButton"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["CloseButtonHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["CloseButtonActive"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["PlotLines"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["PlotLinesHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["PlotHistogram"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["PlotHistogramHovered"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["TextSelectedBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["TooltipBg"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["ModalWindowDarkening"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["NavHighlight"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["NavWindowingHighlight"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
		["DragDropTarget"] = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 },
	},
}
local Gui = self.GUI
local WindowStyle = self.GUI.WindowStyle

self.Data = {
	InitTime = 0,
	Action = {},
	ActionLogic = {},
	MagicalExceptions = {
		[11383] = true,
		[11401] = true,
		[11406] = true,
		[11410] = true,
		[11418] = true,
		[11424] = true,
		[18302] = true,
		[18303] = true,
		[18304] = true,
		[18306] = true,
		[18315] = true,
		[18317] = true,
		[18318] = true,
		[18322] = true,
	},
	TableLoaded = false,
	LastHotbarCheck = 0,
	Hotbar = {},
	HotbarDisabled = {},
	HotbarQueued = {},
	ImagePos = {
		disabled = {x=-2,y=-3},
		hovered = {x=-2,y=-2},
		clicked = {x=-14,y=-14},
		recast = {x=-1,y=-1}
	},
	TempFunc = {
		id = 0,
		str = ""
	},
	BattleState = 0, -- 0 = Out of Combat, 1 = Out of Combat but Target in Combat, 2 = GCD, 3 = oGCD1, 4 = oGCD2, 5 = oGCD3

	CurrentActionSelectedIndex = 0,
	CurrentActionSelected = 0,
	ChangeTargetType = {
		id = 0,
		time = 0
	},
	lastfuncchange = 0,
	lastfuncresult = false,
	lastfuncerror = "",
	lastmessage = 0,
	pos = 0,
	lastnotdown = 0,
	lastcast = 0,
	lastGCDcast = 0,
	LastCast = {},
	LastAttempt = {},
	lastInterruptTarget = 0,
	lastStunTarget = 0,
	lastSwiftCast = 0,
	lastBristle = 0,
	DrawCone = {[1]={},[2]={}},
	DrawConeTime = 0,
	DeleteDuplicate = {
		id = 0,
		time = 0,
		block = false,
	},

	DebugDrawAttemptPoint = {},
	Moving = false,
	LastMove = 0,
	LastStop = 0,
	LastCombat = 0,
}
local Data = self.Data

self.Settings = {
	open = false,
	DrawToggles = True,
	Toggles = {
		{
			name = "HP Advantage",
			enable = true
		},
		{
			name = "DPS",
			enable = true
		},
		{
			name = "AoE",
			enable = true
		},
		{
			name = "Jumping",
			enable = true
		},
		{
			name = "Magical",
			enable = true
		},
		{
			name = "Physical",
			enable = true
		},
		{
			name = "Low Chance",
			enable = true
		},
	},
	ToggleSettings = {
		Columns = 3,
		HorizontalSpacing = 3,
		VerticalSpacing = 5,
		BackgroundTransparency = 115,
		ButtonWidth = 103,
		ButtonHeight = 30,
		EnabledColor = {
			r = 0,
			g = 25,
			b = 0,
			a = 191
		},
		DisabledColor = {
			r = 25,
			g = 0,
			b = 0,
			a = 191
		}
	},
	DrawHotbar = true,
	HotbarSettings = {
		Columns = 12,
		HorizontalSpacing = 6,
		VerticalSpacing = 6,
		BackgroundTransparency = 115,
		ButtonWidth = 42,
		ButtonHeight = 45,
		WindowPadding = 14,
		CheckUpdateInterval = 5000
	},
	Actions = {
	},
	ActionDelays = {
		[11388] = 5000,
		[11403] = 15000,
		[11410] = 5000,
		[11418] = 5000,
	},
	ActionPriority = {
		11423,
		11403,
		11410,
		7562,
		11406,
		11395,
		11418,
		11388,
		11397,
		11421,
		11411,
		11400,
		11429,
		11430,
		11427,
		11425,
		11419,
		11402,
		11391,
		11386,
		11405,
		11413,
		11416,
		11404,
		11385,
		11398,
		7559,
		7560,
		11383,
		11384,
		11387,
		11389,
		11390,
		11392,
		11394,
		11396,
		11399,
		11401,
		11407,
		11408,
		11409,
		11412,
		11414,
		11415,
		11417,
		11420,
		11422,
		11424,
		11426,
		11428,
		11431
	},
	ActionData = {},
	ActionLogic = {},
	ActionDelay = 500,
	PrecastTime = 250,
	SlideCastTime = 490,
	--SwiftCastActions = {11397,18317},
	SwiftCastActions = {[11397] = true,[18317] = true},
	SwiftCastOptionalActions = {},
	--BristleActions = {11386},
	BristleActions = {[11386] = true},
	InterruptIDs = {14265,14365,14369,14680,14712,14720,14744,14890,15045,15049,15063,15318,15321},
	StunCastingIDs = {14753},
	DispelIDs = {63,1797},
	EsunaIDs = {14,271,564,700},
	DiamondbackAoEIDs = {18965},
	DiamondbackTargetIDs = {18965},
	playerCurePercent = 60,
	tankCurePercent = 70,
	playerRestoreMpPercent = 15,
	playerTankRestoreMpPercent = 30,
	partyCurePercent = 50,
	partyAoECurePercent = 70,
	playerSpikeBuffAttacksLT = 90,
	CureOutsideParty = false,
	RaiseOutsideParty = false,
	hpAdvSolo = 1,
	hpAdvParty = 3,
	DrawCone = false,
	DrawNearbyEnemyCircles = true,
}

function self.LoadSettings(tbl)
	--SaveSettings(tbl, true)
	local tbl = FileLoad(ModuleSettings)
	local function scan(tbl,tbl2,depth)
		depth = depth or 0
		if valid(2,tbl,tbl2) then
			for k,v in pairs(tbl2) do
				if type(v) == "table" then
					if tbl[k] and valid(tbl[k]) then
						tbl[k] = table.merge(tbl[k],scan(tbl[k],v,depth+1))
					else
						tbl[k] = v
					end
				else
					if tbl[k] ~= tbl2[k] then tbl[k] = tbl2[k] end
				end
			end
		end
		return tbl
	end
	self.Settings = scan(BLU.Settings,tbl)
end
local LoadSettings = self.LoadSettings

local PreviousSave,lastcheck = {},0
function self.save(force)
	if (force or TimeSince(lastcheck) > 5000) then
		lastcheck = Now()
		if not table.deepcompare(self.Settings,PreviousSave) then
			FileSave(ModuleSettings,self.Settings)
			PreviousSave = table.deepcopy(self.Settings)
		end
	end
end
local save = self.save

local data = {
	time = 0,
	var = {}
}
function self.vars(id)
	local time = Now()
	if data.time ~= time then data = {time=time,var={}} end local var = data.var
	local action = Data.Action[id]
	local actiondata = self.Settings.ActionData[id]
	local actiondelay = self.Settings.ActionDelays[id] or 0
	local LastCast = Data.LastCast[id] or 0
	local lastcast = Data.lastcast
	local lastGCDcast = Data.lastGCDcast
	local range = action.range
	local radius = action.radius
	local dist = range + radius + 1 -- adding 1 for EntityList().distance2d inaccuracy purposes
	if not var.delay then var.delay = self.Settings.ActionDelay end
	if not var.precast then var.precast = self.Settings.PrecastTime end
	if not var.player then var.player = Player end
	if not var.target then var.target = var.player:GetTarget() end
	local Entities = MEntityList("los,alive,attackable,targetable,maxdistance2d="..dist)
	return action, actiondata, actiondelay, TimeSince(LastCast), lastcast, lastGCDcast, range, radius, var.delay, var.precast, var.player, var.target, Entities, valid
end

local function Type(x,Type)
	local t = type(x)
	if Type then
		if t == Type then
			return true
		else
			return false
		end
	end
	return t
end

function self.Sign(value)
	return (value >= 0 and 1) or -1
end
local Sign = self.Sign

function self.Round(value, bracket)
	bracket = bracket or 1
	local floor = math.floor
	return floor(value / bracket + Sign(value) * 0.5) * bracket
end
local Round = self.Round

function self.HeadingToPos(pos1,pos2)
	return RadiansToHeading(math.rad(AngleFromPos(pos1,pos2)))
end
--[[

--Projects point on a line. linePoint1 and linePoint2 defines the infinite line
--point will be projected on that line and projected value will be returned.
--Formula: A + dot(AP,AB) / dot(AB,AB) * AB

local function projectPointOnLine(linePoint1, linePoint2, point)
	local ap = {
		[1] = point[1] - linePoint1[1],
		[2] = point[2] - linePoint1[2]
	}
	local ab = {
		[1] = linePoint2[1] - linePoint1[1],
		[2] = linePoint2[2] - linePoint1[2]
	}

	local function dotProduct2(v1, v2)
		return (v1[1] * v2[1]) + (v1[2] * v2[2])
	end

	local function scale2(v, s)
		v[1] = v[1] * s
		v[2] = v[2] * s
		return v
	end

	local coef = dotProduct2(ap, ab) / dotProduct2(ab, ab)
	return {linePoint1[1] + (coef * ab[1]), linePoint1[2] + (coef * ab[2])}
end


--This function assumes that the given point is on the given line.
--It only checks if the given point is on the specified segment.
local function isProjectedPointOnLine(linePoint1, linePoint2, point)
	-- x1 < x < x2
	-- y1 < y < y2
	if ((linePoint1[1] < point[1] and point[1] < linePoint2[1]) or
			(linePoint1[1] > point[1] and point[1] > linePoint2[1]) or
			(linePoint1[2] < point[2] and point[2] < linePoint2[2]) or
			(linePoint1[2] > point[2] and point[2] > linePoint2[2])) then
		return true
	end
	return false
end

-- Finds the minimum vector to maintain the given radius.
local function findNearestExitVector(projectedPoint, circleCenter, radius)
	local l1 = circleCenter[1] - projectedPoint[1]
	local l2 = circleCenter[2] - projectedPoint[2]
	local pointToCircleDist = math.sqrt((l1 * l1) + (l2 * l2))
	local minDistance = 0
	if (pointToCircleDist <= radius) then
		minDistance = radius - pointToCircleDist
	end

	local pointToCenterVector = {l1 / pointToCircleDist, l2 / pointToCircleDist}
	table.print(pointToCenterVector)
	if minDistance ~= 0 then
		return {pointToCenterVector[1] * minDistance, pointToCenterVector[2] * minDistance}
	else
		return false
	end
end

function self.isEnemyOnLine(player,entity,radius,angle,forcedHeading)
	local ppos,epos = player.pos,entity.pos
	local heading,pRadius,eRadius = ppos.h,player.hitradius, entity.hitradius
	local front = GetPosFromDistanceHeading(ppos, pRadius, heading)
	forcedHeading = forcedHeading or ppos.h

	local left = GetPosFromDistanceHeading(front, radius, forcedHeading-(math.pi*angle))
	local right = GetPosFromDistanceHeading(front, radius, forcedHeading+(math.pi*angle))
	if self.Settings.DrawCone then
		Data.DrawCone = {[1] = left,[2] = right}
		Data.DrawConeTime = Now()
	end

	-- project point on line (lineStart, lineEnd, point)
	local leftProjectedPoint = projectPointOnLine({front.x,front.z}, {left.x,left.z}, {epos.x,epos.z})
	local rightProjectedPoint = projectPointOnLine({front.x,front.z}, {right.x,right.z}, {epos.x,epos.z})

	-- is point on line (lineStart, lineEnd, point)
	local leftIsPointOnSegment = isProjectedPointOnLine({front.x,front.z}, {left.x,left.z}, {leftProjectedPoint[1],leftProjectedPoint[2]})
	local rightIsPointOnSegment = isProjectedPointOnLine({front.x,front.z}, {right.x,right.z}, {rightProjectedPoint[1],rightProjectedPoint[2]})
	-- -- calculate nearest vector (point1, point2, minimumDistance)
	--d(entity.id)
	local leftnearestVector = findNearestExitVector(leftProjectedPoint, {epos.x,epos.z}, eRadius)
	local rightnearestVector = findNearestExitVector(rightProjectedPoint, {epos.x,epos.z}, eRadius)
	if 	leftnearestVector or rightnearestVector then return true end
	return false
end

function self.IsEnemyInCone(player,entity,radius,angle,forcedHeading)
	if not entity or entity.id == player.id then return false end

	local ppos,epos = player.pos,entity.pos
	local heading,pRadius = ppos.h,player.hitradius
	local front = GetPosFromDistanceHeading(ppos, pRadius, heading)
	if forcedHeading and valid(forcedHeading) then
		if forcedHeading.pos then
			forcedHeading = self.HeadingToPos(ppos,forcedHeading.pos)
		elseif forcedHeading.x then
			forcedHeading = self.HeadingToPos(ppos,forcedHeading)
		end
	end
	local playerHeading = forcedHeading or ConvertHeading(front.h)

	local playerAngle = math.atan2(epos.x - front.x, epos.z - front.z)
	local deviation = playerAngle - playerHeading
	local absDeviation = math.abs(deviation)
	local leftover = math.abs(absDeviation - math.pi)

	if (leftover > (math.pi * (1 - angle)) and leftover < (math.pi * (1 + angle))) then
		return true
	elseif self.isEnemyOnLine(player,entity,radius,angle,forcedHeading) then
		return true
	end
	return false
end]]

function self.UpdateActions()
	local actions = ActionList:Get(1)
	for k,v in pairs(actions) do
		local id,job,usable,name = v.id,v.job,v.usable,v.name
		if usable and job == 255 then
			local Action = Data.Action
			Action[id] = v
			Action[id].name = name
			if Not(id,7561,11393) and not contains(self.Settings.ActionPriority,id) then table.insert(self.Settings.ActionPriority,id) end
			if self.Settings.Actions[id] == nil then self.Settings.Actions[id] = true end
			if not Action[id] then
				Action[id] = {
					enable = true,
					logic = function() local logic = Data.ActionLogic[id] if logic then return logic() end return true end
				}
			end
		elseif job == 36 then
			local Action = Data.Action
			Action[id] = v
			Action[id].name = name
			if Not(id,7561,11393) and not contains(self.Settings.ActionPriority,id) then table.insert(self.Settings.ActionPriority,id) end
			if self.Settings.Actions[id] == nil then self.Settings.Actions[id] = true end
		end
	end
end
local UpdateActions = self.UpdateActions

function self.CD(action)
	action = action or Data.Action[11385]
	if Type(action,"number") then
		local tbl = Data.Action[action]
		if tbl then
			action = tbl
		else
			action = SkillMgr.GetAction(action)
		end
	end
	if valid(action) then
		return (action.cdmax - action.cd) * 1000
	end
end
local CD = self.CD

local function BattleState()
	local player,delay,precast = Player,self.Settings.ActionDelay, self.Settings.PrecastTime
	local incombat,target =  player.incombat, MGetTarget()
	if gStartCombat or incombat then
		if CD() < precast then Data.BattleState = 2
		else
			local cd = Data.Action[11385].cd
			if cd < delay then Data.BattleState = 3
			elseif cd < (delay * 2) then Data.BattleState = 4
			else Data.BattleState = 5
			end
		end
	else
		if valid(target) and target.incombat then
			Data.BattleState = 1
		else
			Data.BattleState = 0
		end
	end
end

function self.TestAction(action)
	local type = type(action)
	if type == "number" then
		local id = action
		local action = self.Data.Action[action]
		local LogicReturn,target,pos = Data.ActionLogic[id]()
		d("["..id.."] Casting Logic = "..tostring(LogicReturn))
		if LogicReturn then
			if valid(target) then
				local tid,type = target.id, target.chartype
				local extra = self.Settings.ActionData[id]
				local Self,party,hostile,area
				if valid(extra) then
					Self = extra.CanTargetSelf or false
					party = extra.CanTargetParty or false
					hostile = extra.CanTargetHostile or false
					area = extra.TargetArea or false
				end
				if type == 5 or pos then -- hostile
					if hostile and tid then
						action:Cast(tid)
					elseif area and pos.x then
						action:Cast(pos.x, pos.y, pos.z)
					end
				elseif type == 2 or type == 4 then -- friendly
					if Self and tid == Player.id then
						--if id == 7561 then Data.lastSwiftCast = Now() end
						--Data.LastCast[id] = Now()
						--Data.lastcast = id
						action:Cast(tid)
					elseif party and tid then
						action:Cast(tid)
					end
				end
			else
				d("No target set for action.")
			end
		end
	elseif type == "string" then
	end
end

--[[	Projects point on a line. linePoint1 and linePoint2 defines the infinite line
		point will be projected on that line and projected value will be returned.
		Formula: A + dot(AP,AB) / dot(AB,AB) * AB

		{front.x, front.z}, {line.x,line.z}, (entity pos.x, entity pos.z}				]]
local function projectPointOnLine(linePoint1, linePoint2, point)
	local ap = {
		[1] = point[1] - linePoint1[1],
		[2] = point[2] - linePoint1[2]
	}
	local ab = {
		[1] = linePoint2[1] - linePoint1[1],
		[2] = linePoint2[2] - linePoint1[2]
	}

	local function dotProduct2(v1, v2)
		return (v1[1] * v2[1]) + (v1[2] * v2[2])
	end

	local function scale2(v, s)
		v[1] = v[1] * s
		v[2] = v[2] * s
		return v
	end

	local coef = dotProduct2(ap, ab) / dotProduct2(ab, ab)
	return {linePoint1[1] + (coef * ab[1]), linePoint1[2] + (coef * ab[2])}
end

--[[	This function assumes that the given point is on the given line.
		It only checks if the given point is on the specified segment.		]]
local function isProjectedPointOnLine(linePoint1, linePoint2, point)
	-- x1 < x < x2
	-- y1 < y < y2
	if ((linePoint1[1] <= point[1] and point[1] <= linePoint2[1]) or
			(linePoint1[1] >= point[1] and point[1] >= linePoint2[1]) or
			(linePoint1[2] <= point[2] and point[2] <= linePoint2[2]) or
			(linePoint1[2] >= point[2] and point[2] >= linePoint2[2])) then
		return true
	end
	return false
end

-- Finds the minimum vector to maintain the given radius.
local function findNearestExitVector(projectedPoint, circleCenter, radius)
	local l1 = circleCenter[1] - projectedPoint[1]
	local l2 = circleCenter[2] - projectedPoint[2]
	local pointToCircleDist = math.sqrt((l1 * l1) + (l2 * l2))
	local minDistance = 0
	if (pointToCircleDist <= radius) then
		minDistance = radius - pointToCircleDist
	end

	local pointToCenterVector = {l1 / pointToCircleDist, l2 / pointToCircleDist}
	if minDistance ~= 0 then
		return {pointToCenterVector[1] * minDistance, pointToCenterVector[2] * minDistance}
	else
		return false
	end
end

function self.isEnemyOnLine(player,entity,radius,angle,forcedHeading)
	local ppos,epos = player.pos,entity.pos
	local heading,pRadius,eRadius = ppos.h,player.hitradius, entity.hitradius

	if valid(forcedHeading) then
		local epos = forcedHeading.pos
		if valid(epos) then
			heading = math.atan2(epos.x - ppos.x, epos.z - ppos.z)
		end
	end

	if type(heading) ~= "number" then
		if valid(heading) then
			if heading.x then
				heading = heading.h
			else
				heading = heading.pos.h
			end
		else
			return false
		end
	end
	local left = GetPosFromDistanceHeading(ppos, radius, heading - (math.pi * angle))
	local right = GetPosFromDistanceHeading(ppos, radius, heading + (math.pi * angle))

	-- project point on line (lineStart, lineEnd, point)
	local leftProjectedPoint = projectPointOnLine({ppos.x,ppos.z}, {left.x,left.z}, {epos.x,epos.z})
	local rightProjectedPoint = projectPointOnLine({ppos.x,ppos.z}, {right.x,right.z}, {epos.x,epos.z})

	-- is point on line (lineStart, lineEnd, point)
	local leftIsPointOnSegment = isProjectedPointOnLine({ppos.x,ppos.z}, {left.x,left.z}, {leftProjectedPoint[1],leftProjectedPoint[2]})
	local rightIsPointOnSegment = isProjectedPointOnLine({ppos.x,ppos.z}, {right.x,right.z}, {rightProjectedPoint[1],rightProjectedPoint[2]})

	local leftpos = {x = leftProjectedPoint[1], y = ppos.y, z = leftProjectedPoint[2]}
	local rightpos = {x = rightProjectedPoint[1], y = ppos.y, z = rightProjectedPoint[2]}

	-- -- calculate nearest vector (point1, point2, minimumDistance)
	local leftnearestVector = findNearestExitVector(leftProjectedPoint, {epos.x,epos.z}, eRadius)
	local rightnearestVector = findNearestExitVector(rightProjectedPoint, {epos.x,epos.z}, eRadius)

	local V,LP,RP
	--local result = false
	if leftIsPointOnSegment then
		if Distance3D(epos,leftpos) > eRadius then -- intentionally not >=
			local leftPoint = RenderManager:WorldToScreen(leftpos)
			if valid(leftPoint) then
				V,LP = false,leftPoint --return false,leftPoint
			end
		else
			V = true --return true
		end
	elseif Distance3D(epos,left) <= eRadius then V = true --return true
	end
	if rightIsPointOnSegment then
		if Distance3D(epos,rightpos) > eRadius then -- intentionally not >=
			local rightPoint = RenderManager:WorldToScreen(rightpos)
			if valid(rightPoint) then
				V,RP = false,rightPoint --return false,rightPoint
			end
		else
			V = true --return true
		end
	elseif Distance3D(epos,right) <= eRadius then V = true --return true
	elseif Distance3D(epos,ppos,true) <= (eRadius) then V = true --return true
	end
	return V,LP,RP
	--[[local function dist(a,b)
        if valid(a,b) then
            return Round(math.abs(math.sqrt(math.pow((b.x - a.x),2)+math.pow((b.z - a.z),2))),0.1)
        end
    end
    local function IsBetween(a,b,c)
        local ab,bc,ac = dist(a,b),dist(b,c),dist(a,c)
        if ab + bc == ac then
            return true
        end
        return false
    end

    local leftPoint = {x = leftProjectedPoint[1], y = ppos.y, z = leftProjectedPoint[2]}
    local rightPoint = {x = rightProjectedPoint[1], y = ppos.y, z = rightProjectedPoint[2]}
    if IsBetween(ppos,leftPoint,left) then
        local leftPos = RenderManager:WorldToScreen(leftPoint)
        if valid(leftPos) then
            GUI:AddCircleFilled(leftPos.x,leftPos.y,4,GUI:ColorConvertFloat4ToU32(1,1,0,1))
        end
    end
    if IsBetween(ppos,rightPoint,right) then
        local rightPos = RenderManager:WorldToScreen(rightPoint)
        if valid(rightPos) then
            GUI:AddCircleFilled(rightPos.x,rightPos.y,4,GUI:ColorConvertFloat4ToU32(1,1,0,1))
        end
    end]]
end

function self.IsEnemyInCone(player,entity,radius,angle,forcedHeading)
	if valid(entity) then
		local ppos,pRadius,epos,dist3D,eRadius = player.pos, player.hitradius, entity.pos, Distance3D(player,entity), entity.hitradius
		if dist3D <= radius then
			local heading,pRadius = ppos.h,player.hitradius
			--local front = GetPosFromDistanceHeading(ppos, pRadius, heading)
			local playerHeading = ppos.h

			if valid(forcedHeading) then
				local epos = forcedHeading.pos
				if valid(epos) then
					playerHeading = math.atan2(epos.x - ppos.x, epos.z - ppos.z)
				end
			end

			local playerAngle = math.atan2(epos.x - ppos.x, epos.z - ppos.z)
			local deviation = playerAngle - playerHeading
			local absDeviation = math.abs(deviation)
			local leftover = math.abs(absDeviation - math.pi)

			if (leftover > (math.pi * (1 - angle)) and leftover < (math.pi * (1 + angle))) then
				return true
			else
				local EnemyOnLine,LP,RP = self.isEnemyOnLine(player, entity, radius + pRadius, angle, forcedHeading)
				if EnemyOnLine then
					return true
				else
					return false,LP,RP
				end
			end
		end
	end
end

function self.HpAdvantage(entity,low,med,high,vhigh,low2,med2,high2,vhigh2)
	low,med,high,vhigh = low2 or 0.25, med2 or 0.5, high2 or 1.5, vhigh or 3
	low2,med2,high2,vhigh2 = low or 80, med or 40, high or 20, vhigh2 or 0
	if self.Settings.Toggles[1].enable then
		if valid(entity) then
			if entity.contentid == 541 then return true end
			local player = Player
			local pHPmax,eHPmax,eHP = player.hp.max, entity.hp.max, entity.hp.current
			local adv,eHPP = pHPmax / eHPmax, eHP / eHPmax
			if adv > vhigh and eHPP > vhigh2 then return true
			elseif adv > high and eHPP > high2 then return true
			elseif adv > med and eHPP > med2 then return true
			elseif adv > low and eHPP > low2 then return true
			else return false end
		end
	else
		return true
	end
end

function self.ValidEntity(player,target,entity,range,check,IgnoreHitRadius) -- can substitute player for any entity
	entity = entity or target -- some backup if the function's 3rd argument is used improperly
	if valid(2,player,entity) then
		if Distance3D(player,entity,IgnoreHitRadius) <= range then
			local eIncombat,pIncombat = entity.incombat,player.incombat
			local pass = false
			if valid(target) and target.attackable then
				local tIncombat = target.incombat
				local id,tID = entity.id, target.id
				if (pIncombat and eIncombat) or (gStartCombat and (id == tID)) or tIncombat then pass = true end
			elseif entity.attackable then
				--if incombat or pIncombat then pass = true end
				if eIncombat then pass = true end
			end
			if pass then
				if type(check) == "function" then
					return check(entity)
				else
					return true
				end
			end
		end
	end
	return false
end
local ValidEntity = self.ValidEntity
-- End Copied Functions

function ColorConvert(red,green,blue,alpha,luminance,saturation,hue)
	local hue,saturation,value = GUI:ColorConvertRGBtoHSV(red,green,blue)

end

local function color(entity,inside)
	local alpha = 0.75
	if inside then
		-- Green
		return 171/255, 214/255, 71/255, alpha -- 0° Hue, 26% Saturation, 100% Brightness
	elseif entity.incombat then
		if entity.aggro then
			local claimedby = entity.claimedbyid
			if claimedby ~= 0 then
				if claimedby == Player.id then
					-- Red
					--return 1, 189/255, 189/255, alpha -- 0° Hue, 26% Saturation, 100% Brightness
					return 1, 128/255, 128/255, alpha -- 0° Hue, 50% Saturation, 100% Brightness
					--return 191/255, 96/255, 96/255, alpha -- 0° Hue, 50% Saturation, 75% Brightness
				end
				-- Purple
				--return 1, 219/255, 1, alpha -- 300° Hue, 14% Saturation, 100% Brightness
				--return 1, 128/255, 1, alpha -- 300° Hue, 50% Saturation, 100% Brightness
				return 191/255, 96/255, 191/255, alpha -- 300° Hue, 50% Saturation, 75% Brightness
			end
			-- Orange
			--return 1, 222/255, 199/255, alpha -- 25° Hue, 22% Saturation, 100% Brightness
			return 1, 181/255, 128/255, alpha -- 25° Hue, 50% Saturation, 100% Brightness
			--return 191/255, 136/255, 96/255, alpha -- 25° Hue, 50% Saturation, 75% Brightness
		end
		-- Purple
		--return 1, 219/255, 1, alpha -- 300° Hue, 14% Saturation, 100% Brightness
		--return 1, 128/255, 1, alpha -- 300° Hue, 50% Saturation, 100% Brightness
		return 191/255, 96/255, 191/255, alpha -- 300° Hue, 50% Saturation, 75% Brightness
	end
	-- Yellow
	--return 1, 247/255, 176/255, alpha -- 54° Hue, 31% Saturation, 100% Brightness
	--return 1, 242/255, 128/255, alpha -- 54° Hue, 50% Saturation, 100% Brightness
	return 217/255, 206/255, 108/255, alpha -- 54° Hue, 50% Saturation, 85% Brightness
end

function self.DrawCircle(entity,inside)
	if valid(entity) then
		local pos,radius = entity.pos, entity.hitradius
		if valid(pos) then
			local epos = RenderManager:WorldToScreen(pos)
			if valid(epos) then
				GUI:AddCircleFilled(epos.x,epos.y,5,GUI:ColorConvertFloat4ToU32(color(entity,inside)))
			end
			local heading = pos.h
			local front = GetPosFromDistanceHeading(pos, radius, heading)
			local FacingPointLeft = GetPosFromDistanceHeading(pos, radius, heading + (math.pi * 0.7))
			local FacingPointRight = GetPosFromDistanceHeading(pos, radius, heading - (math.pi * 0.7))
			local a,b,c = RenderManager:WorldToScreen(front), RenderManager:WorldToScreen(FacingPointLeft), RenderManager:WorldToScreen(FacingPointRight)
			if valid(3,a,b,c) then
				GUI:AddLine(a.x, a.y, b.x, b.y, GUI:ColorConvertFloat4ToU32(color(entity,inside)), 12)
				GUI:AddLine(a.x, a.y, c.x, c.y, GUI:ColorConvertFloat4ToU32(color(entity,inside)), 12)
			end

			local ArcRad = math.pi * 2
			local ArcLength = radius * ArcRad
			local vertices = math.ceil(ArcLength / 0.1)
			local segment = ArcRad / vertices
			local h = heading
			for i=1,vertices do
				local Left = GetPosFromDistanceHeading(pos, radius, h) h = h + segment
				local Right = GetPosFromDistanceHeading(pos, radius, h)
				if valid(Left) and valid(Right) then
					local left,right = RenderManager:WorldToScreen(Left), RenderManager:WorldToScreen(Right)
					if valid(left) and valid(right) then
						GUI:AddLine(left.x, left.y, right.x, right.y, GUI:ColorConvertFloat4ToU32(color(entity,inside)), 8)
					end
				end
			end
		end
	end
end

g_radius,g_angle,g_verticesSpacing = 8,0.25,0.5
g_showdot,g_showlabel = true,true
function self.DrawCircularSector(radius,centralAngle)
	if self.Settings.DrawCone then
		local P = Player
		local ppos = P.pos
		local playerHeading,pRadius = ppos.h,P.hitradius
		radius = pRadius + (radius or g_radius)
		centralAngle = centralAngle or g_angle

		if valid(P) and valid(ppos) then
			local p = RenderManager:WorldToScreen(ppos)
			if valid(p) then
				local LeftHeading = playerHeading - (math.pi * centralAngle)
				local RightHeading = playerHeading + (math.pi * centralAngle)
				local ArcRad = math.abs(LeftHeading - RightHeading)
				local ArcLength = radius * ArcRad
				local vertices = math.ceil(ArcLength / (g_verticesSpacing or 0.5))

				local diff = math.abs(playerHeading-LeftHeading)
				local diff2 = math.abs(playerHeading-RightHeading)
				local totalDiff = diff+diff2
				local part = totalDiff / vertices
				local c = 0
				GUI:SetWindowFontSize(1.5 - (vertices / 350))

				--for i=1,vertices do
				for i=LeftHeading, RightHeading, part do
					c = c + 1
					if c <= vertices then
						local Left = GetPosFromDistanceHeading(ppos, radius, i)
						local Right = GetPosFromDistanceHeading(ppos, radius, i+part)
						if c == vertices then Right = GetPosFromDistanceHeading(ppos, radius, RightHeading) end
						if valid(Left) and valid(Right) then
							local left,right = RenderManager:WorldToScreen(Left), RenderManager:WorldToScreen(Right)
							if valid(left) and valid(right) then
								if c == 1 then
									GUI:AddLine(p.x, p.y, left.x, left.y, GUI:ColorConvertFloat4ToU32(0.35,0.35,1,0.5), 3)
								end
								if g_showlabel then
									local mid = { x = (left.x + right.x) / 2, y = (left.y + right.y) / 2}
									local Mid = { x = (Left.x + Right.x) / 2, y = (Left.y + Right.y) / 2, z = (Left.z + Right.z) / 2}
									local midHeading = self.HeadingToPos(ppos,Mid)
									local str = tostring(c)
									local x,y = GUI:CalcTextSize(str)
									local strpos = GetPosFromDistanceHeading(ppos, radius+(0.25), midHeading)
									local STRPOS = RenderManager:WorldToScreen(strpos)
									if valid(STRPOS) then
										GUI:AddText( STRPOS.x - (x / 2), STRPOS.y, GUI:ColorConvertFloat4ToU32(1,0,0,1), c)
									end
								end
								GUI:AddLine(left.x, left.y, right.x, right.y, GUI:ColorConvertFloat4ToU32(0.35,0.35,1,0.5), 3)
								if c == vertices then
									GUI:AddLine(right.x, right.y, p.x, p.y, GUI:ColorConvertFloat4ToU32(0.35,0.35,1,0.5), 3)
								end
								--GUI:AddTriangleFilled( p.x, p.y, left.x, left.y, right.x, right.y, GUI:ColorConvertFloat4ToU32(0.35,0.35,1,0.3) )
								if g_showdot then
									if c == 1 then
										GUI:AddCircleFilled(left.x,left.y,4,GUI:ColorConvertFloat4ToU32(0,1,0,1))
									end
									if c % 2 == 0 then
										GUI:AddCircleFilled(right.x,right.y,4,GUI:ColorConvertFloat4ToU32(0,1,0,1))
									else
										GUI:AddCircleFilled(right.x,right.y,4,GUI:ColorConvertFloat4ToU32(0,0,1,1))
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

g_enemyRange = 15
function self.DrawEnemyCircle()
	if self.Settings.DrawNearbyEnemyCircles then
		local el = MEntityList("los,alive,attackable,targetable,maxdistance2d="..(g_radius+10))
		if valid(el) then
			local tbl = {}
			for id,entity in pairs(el) do
				local inside,LP,RP = self.IsEnemyInCone(Player,entity,g_radius,g_angle)
				self.DrawCircle(entity,inside)
				if valid(LP) then table.insert(tbl,LP) end
				if valid(RP) then table.insert(tbl,RP) end
			end
			if valid(tbl) then
				for i=1,#tbl do
					local pos = tbl[i]
					GUI:AddCircleFilled(pos.x,pos.y,4,GUI:ColorConvertFloat4ToU32(1,1,0,1))
				end
			end
		end
	end
end

function self.ElConeCheck(angle,el,player,target,radius,Count,check1,check2)
	if self.Settings.Toggles[3].enable then
		local count,pos,ID,tID,Count = 0,{},0,0,Count or 1
		if valid(target) then tID = target.id end
		for id,entity in pairs(el) do
			if ValidEntity(player,target,entity,radius,check1) then
				local count2 = 0
				for id2,entity2 in pairs(el) do
					if self.ValidEntity(player,target,entity2,radius) then
						if self.IsEnemyInCone(player,entity2,radius,angle,entity) then
							local c = 1
							if id2 == tID then c = 2 end
							if type(check2) == "function" then
								if check2(entity2) then
									count2 = count2 + c
								end
							else
								count2 = count2 + c
							end
						end
					end
				end
				if count2 > count or (count2 == count and id == tID) then
					count,pos,ID = count2,entity.pos,id
				end
			end
		end
		if count > Count then
			player:SetFacing(pos.x, pos.y, pos.z)
			return true,player,ID
		end
	end
end

function self.ElLineCheck(el,player,target,radius,range,Count,check1,check2)
	if self.Settings.Toggles[3].enable then
		local count,pos,nextTarget,tID,Count = 0,{},{},0,Count or 1
		if valid(target) then tID = target.id end
		for id,entity in pairs(el) do
			if ValidEntity(player,target,entity,range,check1) then
				local count2 = 0
				for id2,entity2 in pairs(el) do
					if self.ValidEntity(player,target,entity2,range) then
						entity2.hitradius = entity2.hitradius + radius
						if self.isEnemyOnLine(player,entity2,range,0,entity) then
							local c = 1
							if id2 == tID then c = 2 end
							if type(check2) == "function" then
								if check2(entity2) then
									count2 = count2 + c
								end
							else
								count2 = count2 + c
							end
						end
					end
				end
				if count2 > count or (count2 == count and id == tID) then
					count,pos,nextTarget = count2,entity.pos,entity
				end
			end
		end
		--d("count: "..tostring(count)..", Count: "..tostring(Count))
		if count > Count then
			player:SetFacing(pos.x, pos.y, pos.z)
			return true,nextTarget
		end
	end
end

function self.ElGroundCheck(el,player,target,range,radius,Count,check1,check2)
	if self.Settings.Toggles[3].enable then
		local count,pos,ppos,tID,id2,Count = 0,{},player.pos,0,0,Count or 1
		if valid(target) then tID = target.id end
		for id,entity in pairs(el) do
			if ValidEntity(player,target,entity,range+radius,check1) then
				local epos = entity.pos
				if not ValidEntity(player,target,entity,range) then -- Out of range but within range + radius check
					local EntityHeading = math.atan2(ppos.x - epos.x, ppos.z - epos.z)
					local dist = Distance3D(ppos,epos,true)
					epos = GetPosFromDistanceHeading(epos, dist-range, EntityHeading)
				end
				local count2 = 0
				for id2,entity2 in pairs(el) do
					if ValidEntity(entity,target,entity2,radius + entity2.hitradius,nil,true) then
						local c = 1
						if id2 == tID then c = 2 end
						if type(check2) == "function" then
							if check2(entity2) then
								count2 = count2 + c
							end
						else
							count2 = count2 + c
						end
					end
				end
				if count2 > count or (count2 == count and id == tID) then
					count,pos,id2 = count2,epos,entity
				end
			end
		end
		if count > Count then
			return true,id2,pos
		end
	end
end



function self.ElAroundTargetCheck(el,player,target,range,radius,Count,check1,check2)
	if self.Settings.Toggles[3].enable then
		local count,ppos,tID,id2,Count = 0,player.pos,0,0,Count or 1
		if valid(target) then tID = target.id end
		for id,entity in pairs(el) do
			if ValidEntity(player,target,entity,range,check1) then
				local count2 = 0
				for id2,entity2 in pairs(el) do
					if ValidEntity(entity,target,entity2,radius + entity2.hitradius,nil,true) then
						local c = 1
						if id2 == tID then c = 2 end
						if type(check2) == "function" then
							if check2(entity2) then
								count2 = count2 + c
							end
						else
							count2 = count2 + c
						end
					end
				end
				if count2 > count or (count2 == count and id == tID) then
					count,id2 = count2,entity
				end
			end
		end
		if count > Count then
			return true,id2
		end
	end
end

function NotBound()
	return MissingBuffs(Player,"13+88+280+378+387+457+564+608+625+713+774+783+896+986+1153+1258+1304+1305+1345+1533+1696+1722+1762+1785+1950+1953+1963")
end

function IsCasting(entity, ...)
	if valid(entity) then
		local cinfo = entity.castinginfo
		if valid(cinfo) then
			local channelingid = cinfo.channelingid or 0
			local castingid = cinfo.castingid or 0
			local tbl = {...}
			if #tbl == 1 and type(tbl[1]) == "table" then tbl = {unpack(tbl[1])} end
			if valid(tbl) then
				for i = 1, #tbl do
					local id = tbl[i]
					if Is(channelingid,id) or Is(castingid,id) then
						return true
					end
				end
			end
		end
	end
	return false
end

function IsChanneling(entity, ...)
	if valid(entity) then
		local cinfo = entity.castinginfo
		if valid(cinfo) then
			local channelingid,channeltargetid = cinfo.channelingid,cinfo.channeltargetid
			local remaining = cinfo.casttime - cinfo.channeltime
			local tbl = {...}
			if #tbl == 1 and type(tbl[1]) == "table" then tbl = {unpack(tbl[1])} end
			if valid(tbl) then
				for i = 1, #tbl do
					local id = tbl[i]
					if Is(channelingid,id) and remaining >= 0.7 then
						return true,remaining,channeltargetid
					end
				end
			end
		end
	end
	return false
end


local hasbuff,hasstart = false,false
local lastframe = 0
function self.Cast()
	BattleState()
	local player,now = Player,Now()
	local moving = player:IsMoving()
	if Data.Moving ~= moving then
		if moving then
			Data.LastMove = now
		else
			Data.LastStop = now
		end
	end
	--if player:IsMoving() then Data.LastMove = now else Data.LastStop = now end
	if player.incombat then Data.LastCombat = now end
	local cinfo,delay,frame,usedSwift,cast = player.castinginfo,self.Settings.ActionDelay,GUI:GetFrameCount(),false,true
	local last,current,Current,time = cinfo.lastcastid, cinfo.channelingid, cinfo.castingid, cinfo.casttime-cinfo.channeltime
	local precast = self.Settings.PrecastTime

	local Queue = Data.HotbarQueued
	if frame ~= lastframe and valid(Queue) and current ~= 11424 and TimeSince(Data.LastCast[11424] or 0) > 500 and MissingBuffs(player,1722) then
		for id,enabled in pairs(Queue) do
			--d(id.." = "..tostring(enabled))
			if enabled then
				local action = Data.Action[id]
				if action.usable then
					if CD(id) < 700 then
						local data = self.Settings.ActionData[id]
						local area,friendly,hostile,party,selfp = data.TargetArea, data.CanTargetFriendly, data.CanTargetHostile, data.CanTargetParty, data.CanTargetSelf
						local target = MGetTarget()
						if valid(target) then
							local tid = target.id
							if target.type == 1 then
								if party or friendly  then
									cast = false action:Cast(tid) break
								elseif selfp then
									cast = false action:Cast(player.id) break
								end
							else
								if hostile then
									cast = false action:Cast(tid) break
								elseif selfp then
									cast = false action:Cast(player.id) break
								elseif area then
									cast = false action:Cast(target.pos.x, target.pos.y, target.pos.z) break
								end
							end
						else
							if selfp then
								cast = false action:Cast(player.id) break
							end
						end
					end
				else
					Data.HotbarQueued[id] = false
					local Hotbar = Data.Hotbar
					for i=1,#Hotbar do
						if Hotbar[i].id == id then
							Hotbar[i].clicked = false
						end
					end
				end
			end
		end
	end
	if (frame ~= lastframe) and (not MIsCasting() or time < delay) and (gStartCombat or Data.BattleState ~= 0) and current ~= 11424 and TimeSince(Data.LastCast[11424] or 0) > 500 and MissingBuffs(player,1722) then -- TODO: Add non combat action support
		lastframe = frame

		local priority = self.Settings.ActionPriority
		--d("-----------------------------------------------")
		--local max = 0
		for i=1,#priority do
			local id,id2 = priority[i],priority[i] -- id = short id no duplicates, id2 = long id to include duplicates
			if id > 100000 then id = tonumber(string.sub(id,2)) end
			--if i > max then max = i end
			local toggles = self.Settings.Toggles
			local magical,physical = toggles[5].enable, toggles[6].enable
			local data = self.Settings.ActionData[id]
			local cd = CD(id)
			if cast and valid(data) and not Data.HotbarDisabled[id] and (magical or (not magical and (data.AttackTypeTargetID ~= 5 or Data.MagicalExceptions[id]))) and (physical or (not physical and data.AttackTypeTargetID == 5)) then
				--d(Data.LastCast[id])
				--d(self.Settings.ActionDelays[id])
				local action,enable,logic,lastcast,actiondelay = Data.Action[id], self.Settings.Actions[id2], Data.ActionLogic[id2], TimeSince(Data.LastCast[id] or 0), (self.Settings.ActionDelays[id2] or 0)
				--d(tostring(action.name).." = id: "..tostring(id)..", id2: "..tostring(id2))
				--d(action.name)
				local isSwiftAction,isBristleAction = self.Settings.SwiftCastActions[id2], self.Settings.BristleActions[id2]
				local SurpanakhaActive = function()
					local last = Data.LastCast[18323]
					local action,lastcast = Data.Action[18323],TimeSince(last or 0)
					if valid(action) then
						local cd,LastAttempt = action.cd,TimeSince(Data.LastAttempt[18323] or 0)
						if (cd == 0 and id == 18323) or (cd > 30 and LastAttempt < 1250) then
							local ValidActions = {18323}
							if table.contains(ValidActions,id) then
								return true,false
							else return true,true
							end
						end
					end
					return false,false
				end
				local SurpActive,BlockAction = SurpanakhaActive()
				--if BlockAction then d("["..id.."]: SurpActive = "..tostring(SurpActive)..", BlockAction = "..tostring(BlockAction)) end
				if enable and not BlockAction and valid(action) and action.usable and ((lastcast > actiondelay) or SurpActive) and ((action.casttime ~= 0 and (not MIsMoving() or HasBuffs(player,167) or isSwiftAction)) or action.casttime == 0) and ((cd <= ((precast * 2) + delay)) or SurpActive) then
					--d(action.name)
					local LogicReturn,target,pos = logic()
					if LogicReturn and valid(target) and (data.AttackTypeTargetID == 5 or MissingBuffs(target,"1307")) and (data.AttackTypeTargetID ~= 5 or MissingBuffs(target,"556")) then
						--d(action.name)
						--local pass = false
						local hasSwift,hasBristle = (TimeSince(Data.lastSwiftCast) < 400 or HasBuffs(player,167)), (TimeSince(Data.lastBristle) < 400 or HasBuffs(player,1716))
						local isSwiftAction,isBristleAction = self.Settings.SwiftCastActions[id2], self.Settings.BristleActions[id2]
						--d("["..id2.."] "..action.name.." = isSwiftAction: "..tostring(isSwiftAction)..", isBristleAction: "..tostring(isBristleAction))
						if isSwiftAction then
							local optional = self.Settings.SwiftCastOptionalActions[id2]
							if not hasSwift then
								if not optional or (optional and MIsMoving()) then LogicReturn = false end
								if (CD(7561) < precast) then
									Data.lastSwiftCast = Now()
									ActionList:Get(1,7561):Cast()
									break
								end
							end
						elseif hasSwift then LogicReturn = false
						end
						if isBristleAction then
							if not hasBristle then
								LogicReturn = false
								if (CD(11393) < precast) and Data.lastcast ~= 18323 then
									Data.lastBristle = Now()
									ActionList:Get(1,11393):Cast()
									break
								end
							end
						elseif hasBristle then LogicReturn = false
						end
						if cd > precast and id ~= 18323 then
							--pass = true
							LogicReturn = false
						--elseif id == 18323 then
						--	local cd,cdmax,lastcast = action.cd,action.cdmax,Data.LastCast[id]
						--	if cdmax ~= 0 and MissingBuffs(player,2130) and TimeSince(lastcast or 0) > 1000 then
						--		ml_error("Failed Surpanakha Check")
						--		LogicReturn = false
						--	end
						end

						--if pass then
						--	local LogicReturn,target
						--	if logic ~= nil then
						--		LogicReturn,target = logic()
						--	else
						--		LogicReturn = true
						--	end
						if LogicReturn then
							--d("CD(id): "..tostring(CD(id)))
							--d("precast: "..tostring(precast))
							--d(action.name)
							Data.LastAttempt[id] = Now()
							local tid,type = target.id, target.chartype
							local extra = self.Settings.ActionData[id]
							local Self,party,hostile,area
							if valid(extra) then
								Self = extra.CanTargetSelf or false
								party = extra.CanTargetParty or false
								hostile = extra.CanTargetHostile or false
								area = extra.TargetArea or false
							end
							if type == 5 or (valid(pos) and pos.x) then -- hostile
								if hostile and tid and(not valid(pos) or not pos.x) then
									--if cast then
									--ml_error(tostring(GUI:GetFrameCount()).." "..action.name..", CD(id): "..tostring(CD(id)))
									--cast = false action:Cast(tid) break end
									action:Cast(tid) break
								elseif area and (valid(pos) and pos.x) then
									--if cast then
									--ml_error(tostring(GUI:GetFrameCount()).." "..action.name..", CD(id): "..tostring(CD(id)))
									--cast = false action:Cast(target.x, target.y, target.z) break end
									action:Cast(pos.x, pos.y, pos.z) break
								else
									ml_error("Action: ["..id.."] "..Data.Action[id].name.." made it through type 5 target with no valid cast logic.")
								end
							elseif type == 2 or type == 4 then -- friendly
								if Self and tid == player.id then
									if id == 7561 then Data.lastSwiftCast = now usedSwift = true end
									--if cast then
									--ml_error(tostring(GUI:GetFrameCount()).." "..action.name..", CD(id): "..tostring(CD(id)))
									--cast = false action:Cast(tid) break end
									action:Cast(tid) break
								elseif party and tid then
									--if cast then
									--ml_error(tostring(GUI:GetFrameCount()).." "..action.name..", CD(id): "..tostring(CD(id)))
									--cast = false action:Cast(tid) break end
									action:Cast(tid) break
								else
									ml_error("Action: ["..id.."] "..Data.Action[id].name.." made it through type 2 or 4 target with no valid cast logic.")
								end
							else
								ml_error("Action: ["..id.."] "..Data.Action[id].name.." made it through with no target type with no valid cast logic.")
							end
						end
					end
					--end
				end
			end
		end
		--d("max: "..max)
	end
	--if not usedSwift and TimeSince(Data.lastSwiftCast) > self.Settings.ActionDelay then
	--	d("Previous LastCast: ["..last.."] "..tostring(Data.Action[last].name))
	--	if current ~= 0 and time < 1 then
	--		--d("Almost LastCast: "..Data.Action[current].name.." = "..time)
	--		Data.lastcast = current
	--		Data.LastCast[current] = now
	--
	--		Data.HotbarQueued[current] = false
	--		for i=1,#Hotbar do
	--			if Hotbar[i].id == current then
	--				Hotbar[i].clicked = false
	--			end
	--		end
	--	elseif Data.lastcast ~= last then
	--		--d("LastCast: "..Data.Action[last].name.." = "..tostring(time))
	--		Data.lastcast = player.castinginfo.lastcastid
	--		Data.LastCast[Data.lastcast] = now
	--
	--		Data.HotbarQueued[Data.lastcast] = false
	--		for i=1,#Hotbar do
	--			if Hotbar[i].id == Data.lastcast then
	--				Hotbar[i].clicked = false
	--			end
	--		end
	--	end
	--end

	--table.print(Data.HotbarQueued)
	--for i=1,#Hotbar do
	--	if Hotbar[i].clicked then d(Data.Action[Hotbar[i].id].name) end
	--end

	--if TimeSince(Data.lastSwiftCast) < 700 then
	--	if not hasbuff then
	--		if HasBuffs(Player,"167") then
	--			hasbuff = Now() d(hasbuff)
	--			d(hasbuff-Data.lastSwiftCast)
	--		end
	--	end
	--elseif hasbuff then hasbuff = false
	--end
end

function self.CastCheck()
	local player = Player
	local job,cinfo = player.job,player.castinginfo
	if job == 36 and gACRSelectedProfiles[job] == selfslong then
		local last,current,Current,time = cinfo.lastcastid, cinfo.channelingid, cinfo.castingid, cinfo.casttime-cinfo.channeltime
		local Hotbar = Data.Hotbar

		--if Not(0,current,Current) then
		if current ~= 0 or Current ~= 0 then
			local id,SlideCastTime = current,self.Settings.SlideCastTime
			if id == 0 then id = Current end

			if TimeSince(Data.LastCast[id] or 0) > SlideCastTime and time < (SlideCastTime / 1000) then
				local act = ActionList:Get(1,id)
				if valid(act) then
					local cd = act.cooldowngroup
					--d("["..tostring(os.clock()).."] Casting: "..id..", time: "..time)

					if cd == 58 then
						if Data.lastGCDcast ~= id then Data.lastGCDcast = id end
					else
						if Data.lastcast ~= id then Data.lastcast = id end
					end
					Data.LastCast[id] = Now()

					Data.HotbarQueued[id] = false
					for i=1,#Hotbar do
						if Hotbar[i].id == id then
							Hotbar[i].clicked = false
						end
					end
				end
			end
		end
	end
end
RegisterEventHandler("Gameloop.Update", self.CastCheck, "BLU Cast Check")

local function Space(x,x2)
	GUI:SameLine(x2 or 0, x or 0)
end

local function Text(str,r,g,b,a)
	GUI:Text(str)
end

local function Checkbox(str,var,reverse)
	if reverse then
		Text(str.." ") Space()
		str = "##"..str
	end
	if Type(var,"string") then
		local tbl,key = BLU,""
		for w in var:gmatch("%P+") do
			if valid(tbl) then
				if key ~= "" then tbl = tbl[key] end
				key = tonumber(w) or w
			else
				break
			end
		end
		local checked,pressed = GUI:Checkbox(str,tbl[key] or false)
		if pressed then
			tbl[key] = checked
			save(true)
			return checked,pressed
		end
	else
		return GUI:Checkbox(str,var)
	end
end

local swift,brist,inter,stun,dispel,esuna,diamondaoe,diamond

local recast = {[0]={x1=0.005,y1=0,x2=0.111,y2=0.104},[1]={x1=0.116,y1=0,x2=0.222,y2=0.104},[2]={x1=0.227,y1=0,x2=0.333,y2=0.104},[3]={x1=0.338,y1=0,x2=0.444,y2=0.104},[4]={x1=0.449,y1=0,x2=0.556,y2=0.104},[5]={x1=0.561,y1=0,x2=0.667,y2=0.104},[6]={x1=0.672,y1=0,x2=0.778,y2=0.104},[7]={x1=0.783,y1=0,x2=0.889,y2=0.104},[8]={x1=0.894,y1=0,x2=1,y2=0.104},[9]={x1=0.005,y1=0.111,x2=0.111,y2=0.215},[10]={x1=0.116,y1=0.111,x2=0.222,y2=0.215},[11]={x1=0.227,y1=0.111,x2=0.333,y2=0.215},[12]={x1=0.338,y1=0.111,x2=0.444,y2=0.215},[13]={x1=0.449,y1=0.111,x2=0.556,y2=0.215},[14]={x1=0.561,y1=0.111,x2=0.667,y2=0.215},[15]={x1=0.672,y1=0.111,x2=0.778,y2=0.215},[16]={x1=0.783,y1=0.111,x2=0.889,y2=0.215},[17]={x1=0.894,y1=0.111,x2=1,y2=0.215},[18]={x1=0.005,y1=0.222,x2=0.111,y2=0.326},[19]={x1=0.116,y1=0.222,x2=0.222,y2=0.326},[20]={x1=0.227,y1=0.222,x2=0.333,y2=0.326},[21]={x1=0.338,y1=0.222,x2=0.444,y2=0.326},[22]={x1=0.449,y1=0.222,x2=0.556,y2=0.326},[23]={x1=0.561,y1=0.222,x2=0.667,y2=0.326},[24]={x1=0.672,y1=0.222,x2=0.778,y2=0.326},[25]={x1=0.783,y1=0.222,x2=0.889,y2=0.326},[26]={x1=0.894,y1=0.222,x2=1,y2=0.326},[27]={x1=0.005,y1=0.333,x2=0.111,y2=0.438},[28]={x1=0.116,y1=0.333,x2=0.222,y2=0.438},[29]={x1=0.227,y1=0.333,x2=0.333,y2=0.438},[30]={x1=0.338,y1=0.333,x2=0.444,y2=0.438},[31]={x1=0.449,y1=0.333,x2=0.556,y2=0.438},[32]={x1=0.561,y1=0.333,x2=0.667,y2=0.438},[33]={x1=0.672,y1=0.333,x2=0.778,y2=0.438},[34]={x1=0.783,y1=0.333,x2=0.889,y2=0.438},[35]={x1=0.894,y1=0.333,x2=1,y2=0.438},[36]={x1=0.005,y1=0.444,x2=0.111,y2=0.549},[37]={x1=0.116,y1=0.444,x2=0.222,y2=0.549},[38]={x1=0.227,y1=0.444,x2=0.333,y2=0.549},[39]={x1=0.338,y1=0.444,x2=0.444,y2=0.549},[40]={x1=0.449,y1=0.444,x2=0.556,y2=0.549},[41]={x1=0.561,y1=0.444,x2=0.667,y2=0.549},[42]={x1=0.672,y1=0.444,x2=0.778,y2=0.549},[43]={x1=0.783,y1=0.444,x2=0.889,y2=0.549},[44]={x1=0.894,y1=0.444,x2=1,y2=0.549},[45]={x1=0.005,y1=0.556,x2=0.111,y2=0.66},[46]={x1=0.116,y1=0.556,x2=0.222,y2=0.66},[47]={x1=0.227,y1=0.556,x2=0.333,y2=0.66},[48]={x1=0.338,y1=0.556,x2=0.444,y2=0.66},[49]={x1=0.449,y1=0.556,x2=0.556,y2=0.66},[50]={x1=0.561,y1=0.556,x2=0.667,y2=0.66},[51]={x1=0.672,y1=0.556,x2=0.778,y2=0.66},[52]={x1=0.783,y1=0.556,x2=0.889,y2=0.66},[53]={x1=0.894,y1=0.556,x2=1,y2=0.66},[54]={x1=0.005,y1=0.667,x2=0.111,y2=0.771},[55]={x1=0.116,y1=0.667,x2=0.222,y2=0.771},[56]={x1=0.227,y1=0.667,x2=0.333,y2=0.771},[57]={x1=0.338,y1=0.667,x2=0.444,y2=0.771},[58]={x1=0.449,y1=0.667,x2=0.556,y2=0.771},[59]={x1=0.561,y1=0.667,x2=0.667,y2=0.771},[60]={x1=0.672,y1=0.667,x2=0.778,y2=0.771},[61]={x1=0.783,y1=0.667,x2=0.889,y2=0.771},[62]={x1=0.894,y1=0.667,x2=1,y2=0.771},[63]={x1=0.005,y1=0.778,x2=0.111,y2=0.882},[64]={x1=0.116,y1=0.778,x2=0.222,y2=0.882},[65]={x1=0.227,y1=0.778,x2=0.333,y2=0.882},[66]={x1=0.338,y1=0.778,x2=0.444,y2=0.882},[67]={x1=0.449,y1=0.778,x2=0.556,y2=0.882},[68]={x1=0.561,y1=0.778,x2=0.667,y2=0.882},[69]={x1=0.672,y1=0.778,x2=0.778,y2=0.882},[70]={x1=0.783,y1=0.778,x2=0.889,y2=0.882},[71]={x1=0.894,y1=0.778,x2=1,y2=0.882},[72]={x1=0.005,y1=0.889,x2=0.111,y2=0.993},[73]={x1=0.116,y1=0.889,x2=0.222,y2=0.993},[74]={x1=0.227,y1=0.889,x2=0.333,y2=0.993},[75]={x1=0.338,y1=0.889,x2=0.444,y2=0.993},[76]={x1=0.449,y1=0.889,x2=0.556,y2=0.993},[77]={x1=0.561,y1=0.889,x2=0.667,y2=0.993},[78]={x1=0.672,y1=0.889,x2=0.778,y2=0.993},[79]={x1=0.783,y1=0.889,x2=0.889,y2=0.993},[80]={x1=0.894,y1=0.889,x2=1,y2=0.993}}

--stop = 1.9459999799728
function self.Draw()
	--if Player.castinginfo.channelingid == 11406 then
	--	local act = ActionList:Get(1,11406)
	--	local cd,ct = act.cd,act.casttime
	--	if ActionList:Get(1,11406).cd >= stop then
	--		Player:Move(FFXIV.MOVEMENT.FORWARD)
	--		--d("["..os.clock().."] ActionList:IsReady(): "..tostring(ActionList:IsReady()))
	--		local cinfo = Player.castinginfo
	--		d("["..os.clock().."] "..(cinfo.casttime-cinfo.channeltime))
	--	end
	--else
	--	Player:Stop()
	--end

	--if ActionList:Get(1,11406).cd >= stop then
	--	if not moving then
	--		moving = true
	--		ml_global_information.Await(math.ceil(stop*1000),1,function()
	--			Player:Move(FFXIV.MOVEMENT.FORWARD)
	--			--ml_global_information.Await(1,200,math.ceil(stop*1000)+200, function () local move = Player:IsMoving() if move then Player:StopMovement() else return true end end)
	--			ml_global_information.AwaitDo(100,3000, function () return not Player:IsMoving() end, function () Player:StopMovement() end)
	--		end)
	--	end
	--	--end
	--else moving = false
	--end
	local style = GUI:GetStyle()
	if Gui.open then
		GUI:PushStyleVar(GUI.StyleVar_WindowMinSize,606,301)
		local c = 0
		for k,v in pairs(WindowStyle) do if v[4] ~= 0 then c = c + 1 loadstring([[GUI:PushStyleColor(GUI.Col_]]..k..[[, ]]..(v[1]/255)..[[, ]]..(v[2]/255)..[[, ]]..(v[3]/255)..[[, ]]..v[4]..[[)]])() end end
		Gui.visible, Gui.open = GUI:Begin(Gui.name, Gui.open)
		if Gui.visible then
			local tabindex, tabname = GUI_DrawTabs(Gui.main_tabs)
			if (tabname == GetString("General")) then
				BLU.Settings.DrawToggles = GUI:Checkbox("Draw Toggles",BLU.Settings.DrawToggles)
				GUI:SameLine(0,15)
				BLU.Settings.DrawHotbar = GUI:Checkbox("Draw Hotbar",BLU.Settings.DrawHotbar)
				GUI:Text("")
				GUI:PushItemWidth(50)
				local val,changed = GUI:InputText("Action Delay (Default: 500)",self.Settings.ActionDelay,GUI.InputTextFlags_CharsDecimal)
				if changed and val~= "" then
					val = tonumber(val)
					if val > 0 and val < 1500 then
						self.Settings.ActionDelay = val
					end
				end
				GUI:PopItemWidth()
				GUI:SameLine(0,15)
				GUI:PushItemWidth(50)
				local val,changed = GUI:InputText("Action Precast Time (Default: 250)",self.Settings.PrecastTime,GUI.InputTextFlags_CharsDecimal)
				if changed and val~= "" then
					val = tonumber(val)
					if val > 0 and val < 700 then
						self.Settings.PrecastTime = val
					end
				end
				GUI:PopItemWidth()

				BLU.Settings.CureOutsideParty = GUI:Checkbox("Cure Outside Party",BLU.Settings.CureOutsideParty)
				GUI:SameLine(0,15)
				BLU.Settings.RaiseOutsideParty = GUI:Checkbox("Raise Outside Party",BLU.Settings.RaiseOutsideParty)

				GUI:PushItemWidth(50)
				local val,changed = GUI:InputText("Player Cure Percent",self.Settings.playerCurePercent,GUI.InputTextFlags_CharsDecimal)
				if changed and val~= "" then
					val = tonumber(val)
					if val > 0 and val < 100 then
						self.Settings.playerCurePercent = val
					end
				end
				GUI:PopItemWidth()
				GUI:SameLine(0,15)
				GUI:PushItemWidth(50)
				local val,changed = GUI:InputText("Tank Cure Percent",self.Settings.tankCurePercent,GUI.InputTextFlags_CharsDecimal)
				if changed and val~= "" then
					val = tonumber(val)
					if val > 0 and val < 100 then
						self.Settings.tankCurePercent = val
					end
				end
				GUI:PopItemWidth()


				GUI:PushItemWidth(50)
				local val,changed = GUI:InputText("Party Cure Percent",self.Settings.partyCurePercent,GUI.InputTextFlags_CharsDecimal)
				if changed and val~= "" then
					val = tonumber(val)
					if val > 0 and val < 100 then
						self.Settings.partyCurePercent = val
					end
				end
				GUI:PopItemWidth()
				GUI:SameLine(0,15)
				GUI:PushItemWidth(50)
				local val,changed = GUI:InputText("AoE Cure Percent",self.Settings.partyAoECurePercent,GUI.InputTextFlags_CharsDecimal)
				if changed and val~= "" then
					val = tonumber(val)
					if val > 0 and val < 100 then
						self.Settings.partyAoECurePercent = val
					end
				end
				GUI:PopItemWidth()
				GUI:PushItemWidth(50)
				local val,changed = GUI:InputText("Spike Buff Percentage",self.Settings.playerSpikeBuffAttacksLT,GUI.InputTextFlags_CharsDecimal)
				if changed and val~= "" then
					val = tonumber(val)
					if val > 0 and val < 100 then
						self.Settings.playerSpikeBuffAttacksLT = val
					end
				end
				GUI:PopItemWidth()

				local function unpack(tbl)
					local str = ""
					for i=1,#tbl do
						str = str..tbl[i]
						if i ~= #tbl then str = str.."," end
					end
					return str
				end

				--if not swift then swift = unpack(self.Settings.SwiftCastActions) end
				--GUI:Text("Swift Cast Actions: ")
				--GUI:SameLine(0,0)
				--local val,changed = GUI:InputText("##SwiftCastActions",swift)
				--if changed then
				--	local tbl = {}
				--	for w in val:gmatch("[^,]+") do tbl[#tbl+1] = tonumber(w) end
				--	if table.valid(tbl) then
				--		swift = val
				--		BLU.Settings.SwiftCastActions = tbl
				--	end
				--end

				--if not brist then brist = unpack(self.Settings.BristleActions) end
				--GUI:Text("Bristle Actions: ")
				--GUI:SameLine(0,0)
				--local val,changed = GUI:InputText("##BristleActions",brist)
				--if changed then
				--	local tbl = {}
				--	for w in val:gmatch("[^,]+") do tbl[#tbl+1] = tonumber(w) end
				--	if table.valid(tbl) then
				--		brist = val
				--		self.Settings.BristleActions = tbl
				--	end
				--end

				if not inter then inter = unpack(BLU.Settings.InterruptIDs) end
				GUI:Text("Interrupt IDs: ")
				GUI:SameLine(0,0)
				local val,changed = GUI:InputText("##InterruptIDs",inter)
				if changed then
					local tbl = {}
					for w in val:gmatch("[^,]+") do tbl[#tbl+1] = tonumber(w) end
					if table.valid(tbl) then
						inter = val
						BLU.Settings.InterruptIDs = tbl
					end
				end

				if not stun then stun = unpack(BLU.Settings.StunCastingIDs) end
				GUI:Text("Stun Casting IDs: ")
				GUI:SameLine(0,0)
				local val,changed = GUI:InputText("##StunCastingIDs",stun)
				if changed then
					local tbl = {}
					for w in val:gmatch("[^,]+") do tbl[#tbl+1] = tonumber(w) end
					if table.valid(tbl) then
						stun = val
						BLU.Settings.StunCastingIDs = tbl
					end
				end

				if not dispel then dispel = unpack(BLU.Settings.DispelIDs) end
				GUI:Text("Dispel IDs: ")
				GUI:SameLine(0,0)
				local val,changed = GUI:InputText("##DispelIDs",dispel)
				if changed then
					local tbl = {}
					for w in val:gmatch("[^,]+") do tbl[#tbl+1] = tonumber(w) end
					if table.valid(tbl) then
						dispel = val
						BLU.Settings.DispelIDs = tbl
					end
				end

				if not esuna then esuna = unpack(BLU.Settings.EsunaIDs) end
				GUI:Text("Esuna IDs: ")
				GUI:SameLine(0,0)
				local val,changed = GUI:InputText("##EsunaIDs",esuna)
				if changed then
					local tbl = {}
					for w in val:gmatch("[^,]+") do tbl[#tbl+1] = tonumber(w) end
					if table.valid(tbl) then
						esuna = val
						BLU.Settings.EsunaIDs = tbl
					end
				end

				if not diamondaoe then diamondaoe = unpack(BLU.Settings.DiamondbackAoEIDs) end
				GUI:Text("Diamondback AoE IDs: ")
				GUI:SameLine(0,0)
				local val,changed = GUI:InputText("##DiamondbackAoEIDs",diamondaoe)
				if changed then
					local tbl = {}
					for w in val:gmatch("[^,]+") do tbl[#tbl+1] = tonumber(w) end
					if table.valid(tbl) then
						diamondaoe = val
						BLU.Settings.DiamondbackAoEIDs = tbl
					end
				end

				if not diamond then diamond = unpack(BLU.Settings.DiamondbackTargetIDs) end
				GUI:Text("Diamondback Target IDs: ")
				GUI:SameLine(0,0)
				local val,changed = GUI:InputText("##DiamondbackTargetIDs",diamond)
				if changed then
					local tbl = {}
					for w in val:gmatch("[^,]+") do tbl[#tbl+1] = tonumber(w) end
					if table.valid(tbl) then
						diamond = val
						BLU.Settings.DiamondbackTargetIDs = tbl
					end
				end


			elseif (tabname == GetString("Actions")) then
				local s,tbl,style = 0,self.Settings.ActionPriority,GUI:GetStyle()
				local size = #tbl
				for i=1,size do
					local id,id2 = tbl[i],tbl[i] -- id = short id no duplicates, id2 = long id to include duplicates
					if id > 100000 then id = tonumber(string.sub(id,2)) end
					local x,y = GUI:CalcTextSize(tostring(i)..": "..Data.Action[id].name.." ["..tostring(id).."] (#)")
					if x > s then s = x end
				end
				GUI:PushItemWidth(s + style.itemspacing.x + style.framepadding.x + style.scrollbarsize)
				local x,y = GUI:GetContentRegionAvail()
				GUI:ListBoxHeader("##Actions",size,math.floor(((y - (GUI:GetStyle().itemspacing.y * 2)) / GUI:GetTextLineHeightWithSpacing())))
				local nothovering = true
				for i=1,size do
					local id,id2 = tbl[i],tbl[i] -- id = short id no duplicates, id2 = long id to include duplicates
					if id > 100000 then id = tonumber(string.sub(id,2)) end
					local action = Data.Action[id]
					local s = function() if Data.CurrentActionSelectedIndex == i then return true else return false end end
					local enabled = self.Settings.Actions[id2]
					if enabled then
						GUI:PushStyleColor(GUI.Col_Text,217/255,230/255,235/255,255/255)
					else
						GUI:PushStyleColor(GUI.Col_Text,217/255,230/255,235/255,148/255)
					end
					local n = ""
					if id2 > 100000 then
						local num = tonumber(string.sub(tostring(id2),1,#tostring(id2)*-1))
						n = " ("..tostring(num)..")"
					end
					GUI:Selectable(tostring(i)..": "..action.name.." ["..tostring(id).."]"..n.."##"..tostring(id2), s())
					GUI:PopStyleColor()

					if GUI:IsItemHovered(GUI.HoveredFlags_AllowWhenBlockedByPopup + GUI.HoveredFlags_AllowWhenBlockedByActiveItem + GUI.HoveredFlags_AllowWhenOverlapped) then
						nothovering = false
						if GUI:IsMouseDown(0) then
							if Data.pos == 0 and Data.lastnotdown == i then
								if Data.pos ~= i then Data.pos = i end
								if Data.CurrentActionSelectedIndex ~= i then
									Data.CurrentActionSelectedIndex = i
									Data.CurrentActionSelected = id2
									Data.lastfuncchange = 0
									Data.lastfuncresult = false
									Data.lastfuncerror = "Waiting..."
								end
							elseif GUI:IsWindowFocused() and Data.pos ~= 0 and Data.pos ~= i then
								local move = self.Settings.ActionPriority[Data.pos]
								if i > Data.pos then -- Shift list up, replacing last with first
									for c=Data.pos,i-1 do
										self.Settings.ActionPriority[c] = self.Settings.ActionPriority[c+1]
									end
								else -- Shift list down replacing first with last
									for c=Data.pos,i+1,-1 do
										self.Settings.ActionPriority[c] = self.Settings.ActionPriority[c-1]
									end
								end
								self.Settings.ActionPriority[i] = move
								Data.pos = i
								if Data.CurrentActionSelectedIndex ~= i then
									Data.CurrentActionSelectedIndex = i
									Data.CurrentActionSelected = tbl[i]
									Data.lastfuncchange = 0
									Data.lastfuncresult = false
									Data.lastfuncerror = "Waiting..."
								end
							end
						else
							if Data.lastnotdown ~= i then Data.lastnotdown = i end
						end
						if GUI:IsMouseReleased(1) then
							self.Settings.Actions[id2] = not self.Settings.Actions[id2]
						end
					end
					if Data.pos ~= 0 and (GUI:IsMouseReleased(0) or not GUI:IsMouseDown(0)) then
						Data.pos = 0
					end
				end
				if nothovering then
					if Data.lastnotdown ~= 0 then Data.lastnotdown = 0 end
				end
				GUI:ListBoxFooter()
				GUI:PopItemWidth()
				--GUI:EndChild() GUI:SameLine(0,15)
				GUI:SameLine(0,15)
				GUI:BeginChild("##ActionSettings",0,0,false)
				local id = Data.CurrentActionSelected
				local id,id2 = Data.CurrentActionSelected,Data.CurrentActionSelected -- id = short id no duplicates, id2 = long id to include duplicates
				if id > 100000 then id = tonumber(string.sub(id,2)) end
				local action = Data.Action[id]
				if valid(action) then
					local name = action.name
					local data = self.Settings.ActionData[id]
					if not valid(data) then
						self.Settings.ActionData[id] = { Name = name, CanTargetSelf = false, CanTargetParty = false, CanTargetHostile = false, TargetArea = false}
						data = self.Settings.ActionData[id]
					end

					GUI:AlignFirstTextHeightToWidgets()
					local str = ""
					if self.Settings.Actions[id2]==nil then self.Settings.Actions[id2] = true end
					if self.Settings.Actions[id2] then str = "Enabled" else str = "Disabled" end
					--self.Settings.Actions[id2] = GUI:Checkbox(str,self.Settings.Actions[id2]) GUI:SameLine(0,15)
					Checkbox(str,"Settings.Actions["..id2.."]") Space(15)
					GUI:Text("Priority: ") GUI:SameLine(0,0)
					GUI:PushItemWidth(GUI:CalcTextSize(Data.CurrentActionSelectedIndex) + (style.framepadding.x * 2))
					local pos,changed = GUI:InputText("##pos",Data.CurrentActionSelectedIndex,GUI.InputTextFlags_CharsDecimal)
					if changed and pos~= "" and tonumber(pos) then
						pos = tonumber(pos)
						local size = #self.Settings.ActionPriority
						if pos > size then pos = size end
						table.remove(self.Settings.ActionPriority,Data.CurrentActionSelectedIndex)
						table.insert(self.Settings.ActionPriority,pos,id2)
						Data.CurrentActionSelectedIndex = pos
					end
					GUI:PopItemWidth()
					GUI:SameLine(0,5)
					if GUI:SmallButton("Duplicate") then
						for e=100000,900000,100000 do
							local act = e+id
							if not table.contains(self.Settings.ActionPriority,act) then
								table.insert(self.Settings.ActionPriority,pos+1,act)
								if not self.Settings.Actions[id2] then self.Settings.Actions[id2] = true end
								Data.pos = Data.CurrentActionSelectedIndex+1
								if Data.CurrentActionSelectedIndex ~= Data.pos then
									Data.CurrentActionSelectedIndex = Data.pos
									Data.CurrentActionSelected = tbl[Data.pos]
									Data.lastfuncchange = 0
									Data.lastfuncresult = false
									Data.lastfuncerror = "Waiting..."
								end
								break
							end
						end
					end
					GUI:SameLine(0,5)
					local tbl2 = Data.DeleteDuplicate
					if id2 > 100000 then
						GUI:SmallButton("Delete")
						if GUI:IsItemActive() then
							if not tbl2.block then
								if tbl2.id == id2 then
									if TimeSince(tbl2.time) > 3000 then
										table.remove(self.Settings.ActionPriority,Data.CurrentActionSelectedIndex)
										tbl2.id = 0
										tbl2.time = 0
										tbl2.block = true
										local e = Data.CurrentActionSelectedIndex - 1
										if e < 1 then e = Data.CurrentActionSelectedIndex + 1 end
										Data.pos = e
										if Data.CurrentActionSelectedIndex ~= e then
											Data.CurrentActionSelectedIndex = e
											Data.CurrentActionSelected = tbl[e]
											Data.lastfuncchange = 0
											Data.lastfuncresult = false
											Data.lastfuncerror = "Waiting..."
										end
									else
										GUI:SetTooltip(string.format("%.1f",3 - (TimeSince(tbl2.time)/1000)))
									end
								else
									tbl2.id = id2
									tbl2.time = Now()
								end
							end
						else
							if tbl2.id == id2 then tbl2.id = 0 end
						end
					end
					if GUI:IsMouseReleased(0) then if tbl2.block then tbl2.block = false end end
					GUI:SameLine(0,15)
					GUI:Text("Action Delay: ") GUI:SameLine(0,0)
					local delay = self.Settings.ActionDelays[id2] or 0
					GUI:PushItemWidth(GUI:CalcTextSize("12345") + (style.framepadding.x * 2))
					local str,changed = GUI:InputText("##delay",delay,GUI.InputTextFlags_CharsDecimal)
					if changed then
						self.Settings.ActionDelays[id2] = tonumber(str)
					end
					GUI:PopItemWidth() GUI:SameLine(0,0)
					GUI:Text(" ms")
					if id ~= 7561 then
						Space(15)
						local SwiftCastOptional = self.Settings.SwiftCastOptionalActions[id2]
						if SwiftCastOptional then
							GUI:PushStyleColor(GUI.Col_CheckMark,1,1,0,0.95)
						end
						local checked,pressed = Checkbox("Swiftcast", "Settings.SwiftCastActions["..id2.."]")
						if pressed then
							if GUI:IsKeyDown(17) and checked then
								self.Settings.SwiftCastOptionalActions[id2] = true
							else
								self.Settings.SwiftCastOptionalActions[id2] = false
							end
						end
						if SwiftCastOptional then
							GUI:PopStyleColor(1)
						end
					end
					if id ~= 11393 then
						Space(15)
						Checkbox("Bristle", "Settings.BristleActions["..id2.."]")
					end

					GUI:AlignFirstTextHeightToWidgets()
					GUI:Text("Target Type: ") GUI:SameLine(0,0)
					local notactive = true
					local Self,friendly,party,hostile,area = data.CanTargetSelf,data.CanTargetFriendly,data.CanTargetParty,data.CanTargetHostile,data.TargetArea
					GUI:RadioButton("Self",Self)
					if GUI:IsItemActive() then
						local tbl = Data.ChangeTargetType
						if tbl.id == id2 then
							if TimeSince(tbl.time) > 3000 then
								data.CanTargetSelf = true
								data.CanTargetFriendly = false
								data.CanTargetParty = false
								data.CanTargetHostile = false
								data.TargetArea = false
							else
								GUI:SetTooltip(string.format("%.1f",3 - (TimeSince(tbl.time)/1000)))
							end
						else
							tbl.id = id2
							tbl.time = Now()
						end
						notactive = false
					end GUI:SameLine(0,5)
					GUI:RadioButton("Friendly",friendly)
					if GUI:IsItemActive() then
						local tbl = Data.ChangeTargetType
						if tbl.id == id2 then
							if TimeSince(tbl.time) > 3000 then
								data.CanTargetSelf = false
								data.CanTargetFriendly = true
								data.CanTargetParty = false
								data.CanTargetHostile = false
								data.TargetArea = false
							else
								GUI:SetTooltip(string.format("%.1f",3 - (TimeSince(tbl.time)/1000)))
							end
						else
							tbl.id = id2
							tbl.time = Now()
						end
						notactive = false
					end GUI:SameLine(0,5)
					GUI:RadioButton("Party",party)
					if GUI:IsItemActive() then
						local tbl = Data.ChangeTargetType
						if tbl.id == id2 then
							if TimeSince(tbl.time) > 3000 then
								data.CanTargetSelf = false
								data.CanTargetFriendly = false
								data.CanTargetParty = true
								data.CanTargetHostile = false
								data.TargetArea = false
							else
								GUI:SetTooltip(string.format("%.1f",3 - (TimeSince(tbl.time)/1000)))
							end
						else
							tbl.id = id2
							tbl.time = Now()
						end
						notactive = false
					end GUI:SameLine(0,5)
					GUI:RadioButton("Hostile",hostile)
					if GUI:IsItemActive() then
						local tbl = Data.ChangeTargetType
						if tbl.id == id2 then
							if TimeSince(tbl.time) > 3000 then
								data.CanTargetSelf = false
								data.CanTargetFriendly = false
								data.CanTargetParty = false
								data.CanTargetHostile = true
								data.TargetArea = false
							else
								GUI:SetTooltip(string.format("%.1f",3 - (TimeSince(tbl.time)/1000)))
							end
						else
							tbl.id = id2
							tbl.time = Now()
						end
						notactive = false
					end GUI:SameLine(0,5)
					GUI:RadioButton("Ground",area)
					if GUI:IsItemActive() then
						local tbl = Data.ChangeTargetType
						if tbl.id == id2 then
							if TimeSince(tbl.time) > 3000 then
								data.CanTargetSelf = false
								data.CanTargetFriendly = false
								data.CanTargetParty = false
								data.CanTargetHostile = false
								data.TargetArea = true
							else
								GUI:SetTooltip(string.format("%.1f",3 - (TimeSince(tbl.time)/1000)))
							end
						else
							tbl.id = id2
							tbl.time = Now()
						end
						notactive = false
					end
					if notactive and Data.ChangeTargetType.id ~= 0 and Data.ChangeTargetType.id == id2 then
						Data.ChangeTargetType = {id=0,time=0}
					end

					local func = Data.TempFunc
					local targetstring = ""
					if data.CanTargetSelf then targetstring = "1"
					elseif data.CanTargetParty then targetstring = "2"
					elseif data.CanTargetHostile then targetstring = "3"
					elseif data.TargetArea then targetstring = "4"
					end

					--if func.id ~= id then func.id = id func.str = self.Settings.ActionLogic[id] or "local action,player,target,targettype,valid = self.Data.Action["..tostring(id).."],player,MGetTarget(),"..targetstring..",table.valid\n--- DO NOT EDIT ABOVE THIS LINE ---\n" end
					if func.id ~= id2 then
						local str = "local action, actiondata, actiondelay, LastCast, lastcast, lastGCDcast, range, radius, delay, precast, player, target, el, valid = BLU.vars("..id..")\n--- DO NOT EDIT ABOVE THIS LINE ---\n"
						func.id = id2 func.str = self.Settings.ActionLogic[id2] or ""
						for w in func.str:gmatch("\n--- DO NOT EDIT ABOVE THIS LINE ---\n(.+)$") do str = str..w end
						func.str = str
					end
					GUI:SameLine(0,0)
					local str = "Edit in Notepad++"
					local strX,strY = GUI:CalcTextSize(str)
					local winX = GUI:GetContentRegionAvailWidth()
					local padX,padY = style.framepadding.x, style.framepadding.y
					GUI:SameLine(0,winX - (strX + (padX * 2)))
					--GUI:SameLine(0,30)
					if GUI:Button(str,strX + (padX * 2), strY + (padY * 2)) then
						local message3 = "`n-- Remember to copy your changes and paste them into the game after you finish --`n                                    -- 3 --"
						local message2 = "`n-- Remember to copy your changes and paste them into the game after you finish --`n                                    -- 2 --"
						local message1 = "`n-- Remember to copy your changes and paste them into the game after you finish --`n                                    -- 1 --"
						local code = func.str:gsub("\n","`n"):gsub("\"","`\\\""):gsub("\t\t","    ")
						--GUI:SetClipboardText(func.str)
						local paste = "[void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.SendKeys]::SendWait('^{a}'); [System.Windows.Forms.SendKeys]::SendWait('^{v}')"
						local PS = io.popen([[powershell -Command "Set-Clipboard -Value """]]..message3..[["""; $process = Start-Process 'notepad++' -PassThru -ArgumentList '-llua -multiInst -noPlugin -nosession'; $process.WaitForInputIdle(); ]]..paste..[[; Start-Sleep -Milliseconds 500; Set-Clipboard -Value """]]..message2..[["""; ]]..paste..[[; Start-Sleep -Milliseconds 500; Set-Clipboard -Value """]]..message1..[["""; ]]..paste..[[; Start-Sleep -Milliseconds 500; Set-Clipboard -Value """]]..code..[["""; ]]..paste..[[;"]])
						PS:close()
					end

					local x,y = GUI:GetContentRegionAvail()
					--local str,changed = GUI:InputTextMultiline("##func", func.str, x, y - (GUI:GetTextLineHeightWithSpacing() + style.itemspacing.y + style.framepadding.y * 2))
					local str, changed = GUI:InputTextEditor("##func", func.str, x, y - (GUI:GetTextLineHeightWithSpacing() + style.itemspacing.y + style.framepadding.y * 2), GUI.InputTextFlags_AllowTabInput)
					if changed then
						func.str = str
						Data.lastfuncchange = Now()
						Data.lastfuncresult = false
						Data.lastfuncerror = "Waiting..."
					end
					if (Data.lastfuncchange ~= 0 and TimeSince(Data.lastfuncchange) > 3000) or (GUI:IsKeyDown(17) and GUI:IsKeyReleased(83)) then
						Data.lastfuncchange = 0
						local tbl = ml_input_mgr.validLuaFunc({code=str,name=" "})
						Data.lastfuncresult = tbl.valid
						Data.lastfuncerror = tbl.errorText or ""
						save(true)
					end
					if Data.lastfuncresult then
						local str2 = "Save Function"
						local x,y = GUI:CalcTextSize(str2)
						if GUI:Button(str2, x + GUI:GetStyle().framepadding.x * 2, y + style.framepadding.y * 2) or (GUI:IsKeyDown(17) and GUI:IsKeyReleased(83)) then
							self.Settings.ActionLogic[id2] = str
							Data.ActionLogic[id2] = loadstring(str)
							Data.lastmessage = Now()
							save(true)
						end
					elseif Data.lastfuncerror == "Waiting..." then
						local str2 = "Waiting..."
						local x,y = GUI:CalcTextSize(str2)
						GUI:Button(str2, x + GUI:GetStyle().framepadding.x * 2, y + style.framepadding.y * 2)
					else
						local str2 = "Error"
						local x,y = GUI:CalcTextSize(str2)
						GUI:Button(str2, x + GUI:GetStyle().framepadding.x * 2, y + style.framepadding.y * 2)
						if GUI:IsItemHovered() then
							GUI:BeginTooltip()
							GUI:PushTextWrapPos(250)
							GUI:Text(Data.lastfuncerror)
							GUI:PopTextWrapPos()
							GUI:EndTooltip()
						end
					end
					local time = Data.lastmessage
					if time ~= 0 and TimeSince(time) < 5000 then
						GUI:SameLine(0,15)
						GUI:TextColored( 0, 1, 0, 1,"Saving")
					end
				else
					local x = GUI:GetContentRegionAvailWidth()
					if x > 500 then x = 500 end
					GUI:PushTextWrapPos(x)
					GUI:Text("Select an action to edit it's properties and logic.\n\nEach action is listed by priority, from top to bottom.\nIf an action's logic is determined to be valid, it will send off the confirmation and stop checking further skills.\n\nTo rearrange actions, simply drag and drop an action.\nRight-Click an action to quick enable/disable.")
					GUI:PopTextWrapPos()
				end
				GUI:EndChild()
			elseif (tabname == GetString("QT Settings")) then
				GUI:Text("Work in Progress")
			elseif (tabname == GetString("QT Customize")) then
				GUI:Text("Work in Progress")
			elseif (tabname == GetString("Hotbar Settings")) then
				GUI:Text("Work in Progress")
			elseif (tabname == GetString("Hotbar Customize")) then
				GUI:Text("Work in Progress")
			end

			-- Min / Max size logic --
			local x,y = GUI:GetWindowSize()
			local x2,y2 = GUI:GetScreenSize()
			if y < 301 then
				GUI:SetWindowSize(x,301)
			elseif y >  y2 / 1.25 then
				GUI:SetWindowSize(x,y2/1.25)
			end
		end
		GUI:End()
		GUI:PopStyleColor(c)
		GUI:PopStyleVar(1)
	end
	if self.Settings.open ~= Gui.open then self.Settings.open = Gui.open end
	save()

	if self.Settings.DrawToggles then
		local Toggles = self.Settings.Toggles
		local Settings = self.Settings.ToggleSettings
		GUI:PushStyleColor(GUI.Col_WindowBg, 7/255, 0/255, 12/255, Settings.BackgroundTransparency/255)
		flags = (GUI.WindowFlags_NoTitleBar + GUI.WindowFlags_NoResize + GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse + GUI.WindowFlags_NoCollapse)
		GUI:Begin("KaliBluToggles##KaliBluToggles", true, flags)
		GUI:PushStyleVar(GUI.StyleVar_ItemSpacing, Settings.HorizontalSpacing, Settings.VerticalSpacing)
		local x = Settings.ButtonWidth + (Settings.HorizontalSpacing * 2)
		GUI:Columns(Settings.Columns,"BLU Toggles",false)
		for i=1,#Toggles do
			if i ~= 2 then
				local toggle = Toggles[i]
				local name,enable = toggle.name,toggle.enable
				GUI:SetColumnWidth(-1,x)
				local r,g,b,a = 0,0,0,0
				if enable then
					r,g,b,a = Settings.EnabledColor.r,Settings.EnabledColor.g,Settings.EnabledColor.b,Settings.EnabledColor.a
				else
					r,g,b,a = Settings.DisabledColor.r,Settings.DisabledColor.g,Settings.DisabledColor.b,Settings.DisabledColor.a
				end

				GUI:PushStyleColor(GUI.Col_Button,r/255,g/255,b/255,a/255)
				GUI:PushStyleColor(GUI.Col_ButtonHovered,r/255,g/255,b/255,a/255)
				GUI:PushStyleColor(GUI.Col_ButtonActive,r/255,g/255,b/255,a/255)
				if GUI:Button(name,Settings.ButtonWidth,Settings.ButtonHeight) then
					self.Settings.Toggles[i].enable = not enable
				end
				GUI:PopStyleColor(3)
				GUI:NextColumn()
			elseif Data.Action[18322].usable then
				local toggle = Toggles[i]
				local name = toggle.name,toggle.enable
				GUI:SetColumnWidth(-1,x)
				local r,g,b,a = 0,0,0,0
				if name == "DPS" then
					r,g,b,a = 115,40,40,Settings.EnabledColor.a
				elseif name == "Healer" then
					r,g,b,a = 52,102,36,Settings.EnabledColor.a
				elseif name == "Tank" then
					r,g,b,a = 45,49,128,Settings.EnabledColor.a
				end

				GUI:PushStyleColor(GUI.Col_Button,r/255,g/255,b/255,a/255)
				GUI:PushStyleColor(GUI.Col_ButtonHovered,r/255,g/255,b/255,a/255)
				GUI:PushStyleColor(GUI.Col_ButtonActive,r/255,g/255,b/255,a/255)
				if GUI:Button(name,Settings.ButtonWidth,Settings.ButtonHeight) then
					if name == "DPS" then
						self.Settings.Toggles[i].name = "Healer"
					elseif name == "Healer" then
						self.Settings.Toggles[i].name = "Tank"
					else
						self.Settings.Toggles[i].name = "DPS"
					end
				end
				GUI:PopStyleColor(3)
				GUI:NextColumn()
			end
		end
		GUI:Columns(1)
		GUI:PopStyleVar()
		GUI:SetWindowSize(((x * Settings.Columns) - (Settings.HorizontalSpacing * 2)) + (style.windowpadding.x * 2), 0)
		GUI:End()
		GUI:PopStyleColor()
	end



	if self.Settings.DrawHotbar and self.Data.TableLoaded then
		if TimeSince(Data.LastHotbarCheck) > self.Settings.HotbarSettings.CheckUpdateInterval then
			Data.LastHotbarCheck = Now()
			--self.Data.Hotbar = {}
			local c = 0
			for id,action in table.pairsbykeys(Data.Action) do
				local hotbar = self.Data.Hotbar
				if action.usable then
					c = c + 1
					local slot = hotbar[c]
					if slot then
						if slot.id ~= id then
							hotbar[c] = {id=id,hovered=false,clicked=false,enabled=true}
						end
					else
						hotbar[c] = {id=id,hovered=false,clicked=false,enabled=true}
					end
				end
				for i=1,#hotbar do
					local ha = hotbar[i]
					if valid(ha) and ha.id then
						local ac = Data.Action[ha.id]
						if valid(ac) then
							if not ac.usable then table.remove(hotbar,i) end
						else
							table.remove(hotbar,i)
						end
					else
						table.remove(hotbar,i)
					end
				end
			end
		end

		local Hotbar = self.Data.Hotbar
		local Settings = self.Settings.HotbarSettings
		GUI:PushStyleColor(GUI.Col_WindowBg, 7/255, 0/255, 12/255, Settings.BackgroundTransparency/255)
		GUI:PushStyleVar(GUI.StyleVar_WindowPadding,Settings.WindowPadding,Settings.WindowPadding)
		flags = (GUI.WindowFlags_NoTitleBar + GUI.WindowFlags_NoResize + GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse + GUI.WindowFlags_NoCollapse)
		GUI:Begin("KaliBluHotbar##KaliBluHotbar", true, flags)
		GUI:PushStyleVar(GUI.StyleVar_ItemSpacing, Settings.HorizontalSpacing, Settings.VerticalSpacing)
		local x = Settings.ButtonWidth + (Settings.HorizontalSpacing * 2)
		--GUI:Columns(Settings.Columns,"BLU Hotbar",false)
		local canclick = true
		for i=1,#Hotbar do
			--GUI:SetColumnWidth(-1,x)
			--if i == 1 or i == 5 then GUI:NextColumn() GUI:NextColumn() GUI:NextColumn() GUI:NextColumn() end
			local button = Hotbar[i]
			local id,hovered,clicked,enabled = button.id,button.hovered,button.clicked,button.enabled
			local action = Data.Action[id]
			local data = self.Settings.ActionData[id]
			if valid(2,action,data) then
				--local name,enable = toggle.name,toggle.enable

				local image = {
					filepath = ImageFolder..(data.Icon):match("^.+/(.+)$"),
					sizeX = 40,
					sizeY = 40,
					UV0_x = 0,
					UV0_y = 0,
					UV1_x = 1,
					UV1_y = 1,
					bg_col_R = 255/255,
					bg_col_G = 255/255,
					bg_col_B = 255/255,
					bg_col_A = 1,
					tint_col_R = 0,
					tint_col_G = 0,
					tint_col_B = 0,
					tint_col_A = 0,
				}
				local image2 = {
					filepath = ImageFolder.."Recast.png",
					sizeX = 42,
					sizeY = 45,
					UV0_x = 0,
					UV0_y = 0,
					UV1_x = 1,
					UV1_y = 1,
					bg_col_R = 255/255,
					bg_col_G = 255/255,
					bg_col_B = 255/255,
					bg_col_A = 1,
					tint_col_R = 0,
					tint_col_G = 0,
					tint_col_B = 0,
					tint_col_A = 0,
				}

				local pX,pY = GUI:GetCursorPos()
				if i < 5 then
					pX = Settings.WindowPadding + ((40 + Settings.HorizontalSpacing) * 3) + ((40 + Settings.HorizontalSpacing) * i)
					pY = Settings.WindowPadding
					GUI:SetCursorPos(pX,pY)
				elseif i < 17 then
					local c = ((i - 4) % 12) - 1 if c < 0 then c = 11 end
					pX = Settings.WindowPadding + ((40 + Settings.HorizontalSpacing) * c)
					pY = Settings.WindowPadding + 40 + Settings.VerticalSpacing
					GUI:SetCursorPos(pX,pY)
				else
					local c = ((i - 4) % 12) - 1 if c < 0 then c = 11 end
					pX = Settings.WindowPadding + ((40 + Settings.HorizontalSpacing) * c)
					pY = Settings.WindowPadding + 40 + Settings.VerticalSpacing + 40 + Settings.VerticalSpacing
					GUI:SetCursorPos(pX,pY)
				end
				GUI:Image(image.filepath, image.sizeX, image.sizeY, image.UV0_x, image.UV0_y, image.UV1_x, image.UV1_y, image.bg_col_R, image.bg_col_G, image.bg_col_B, image.bg_col_A, image.tint_col_R, image.tint_col_G, image.tint_col_B, image.tint_col_A)
				button.hovered = GUI:IsItemHovered()
				if GUI:IsItemClicked(0) and canclick then
					clicked = not clicked
					button.clicked = clicked
					Data.HotbarQueued[id] = clicked
					if not enabled and clicked then
						enabled = not enabled
						button.enabled = enabled
					end
					canclick = false
				end
				if GUI:IsItemClicked(1) and canclick then
					enabled = not enabled
					button.enabled = enabled
					Data.HotbarDisabled[id] = not enabled
					if not enabled and clicked then
						clicked = not clicked
						button.clicked = clicked
					end
					canclick = false
				end

				if hovered then
					local image = {
						filepath = ImageFolder.."hovered.png",
						sizeX = 44,
						sizeY = 44,
						UV0_x = 0,
						UV0_y = 0,
						UV1_x = 1,
						UV1_y = 1,
						bg_col_R = 255/255,
						bg_col_G = 255/255,
						bg_col_B = 255/255,
						bg_col_A = 1,
						tint_col_R = 0,
						tint_col_G = 0,
						tint_col_B = 0,
						tint_col_A = 0,
					}
					local hovered = Data.ImagePos.hovered
					local x,y = hovered.x,hovered.y
					GUI:SetCursorPos(pX+x,pY+y)
					GUI:Image(image.filepath, image.sizeX, image.sizeY, image.UV0_x, image.UV0_y, image.UV1_x, image.UV1_y, image.bg_col_R, image.bg_col_G, image.bg_col_B, image.bg_col_A, image.tint_col_R, image.tint_col_G, image.tint_col_B, image.tint_col_A)
				end
				if clicked then
					local image = {
						filepath = ImageFolder.."clicked.png",
						sizeX = 68,
						sizeY = 68,
						UV0_x = 0,
						UV0_y = 0,
						UV1_x = 1,
						UV1_y = 1,
						bg_col_R = 255/255,
						bg_col_G = 255/255,
						bg_col_B = 255/255,
						bg_col_A = 1,
						tint_col_R = 0,
						tint_col_G = 0,
						tint_col_B = 0,
						tint_col_A = 0,
					}
					local clicked = Data.ImagePos.clicked
					local x,y = clicked.x,clicked.y
					GUI:SetCursorPos(pX+x,pY+y)
					GUI:Image(image.filepath, image.sizeX, image.sizeY, image.UV0_x, image.UV0_y, image.UV1_x, image.UV1_y, image.bg_col_R, image.bg_col_G, image.bg_col_B, image.bg_col_A, image.tint_col_R, image.tint_col_G, image.tint_col_B, image.tint_col_A)
				end
				if not enabled then
					local image = {
						filepath = ImageFolder.."disabled.png",
						sizeX = 44,
						sizeY = 46,
						UV0_x = 0,
						UV0_y = 0,
						UV1_x = 1,
						UV1_y = 1,
						bg_col_R = 255/255,
						bg_col_G = 255/255,
						bg_col_B = 255/255,
						bg_col_A = 1,
						tint_col_R = 0,
						tint_col_G = 0,
						tint_col_B = 0,
						tint_col_A = 0,
					}
					local disabled = Data.ImagePos.disabled
					local x,y = disabled.x,disabled.y
					GUI:SetCursorPos(pX+x,pY+y)
					GUI:Image(image.filepath, image.sizeX, image.sizeY, image.UV0_x, image.UV0_y, image.UV1_x, image.UV1_y, image.bg_col_R, image.bg_col_G, image.bg_col_B, image.bg_col_A, image.tint_col_R, image.tint_col_G, image.tint_col_B, image.tint_col_A)
				end

				local cd,cdmax = action.cd,action.cdmax
				local cd = cdmax - cd
				if enabled and cd > 0 then
					local Recast = Data.ImagePos.recast
					local x,y = Recast.x,Recast.y
					GUI:SetCursorPos(pX+x,pY+y)
					local split = cdmax / 80
					local i = 80 - math.ceil(cd / split)
					local tbl = recast[i]
					image2.UV0_x, image2.UV0_y, image2.UV1_x, image2.UV1_y = tbl.x1, tbl.y1, tbl.x2, tbl.y2
					GUI:Image(image2.filepath, image2.sizeX, image2.sizeY, image2.UV0_x, image2.UV0_y, image2.UV1_x, image2.UV1_y, image2.bg_col_R, image2.bg_col_G, image2.bg_col_B, image2.bg_col_A, image2.tint_col_R, image2.tint_col_G, image2.tint_col_B, image2.tint_col_A)
				end
			end
			--GUI:NextColumn()
		end
		--GUI:Columns(1)
		GUI:PopStyleVar()
		GUI:SetWindowSize((Settings.HorizontalSpacing * 11) + (40 * 12) + (Settings.WindowPadding * 2), (Settings.VerticalSpacing * 2) + (40 * 3) + (Settings.WindowPadding * 2))
		GUI:End()
		GUI:PopStyleVar()
		GUI:PopStyleColor()
	end

	if self.Settings.DrawCone then
		local maxWidth, maxHeight = GUI:GetScreenSize()
		GUI:SetNextWindowPos(0, 0, GUI.SetCond_Always)
		GUI:SetNextWindowSize(maxWidth,maxHeight,GUI.SetCond_Always)
		GUI:PushStyleColor(GUI.Col_WindowBg, 0, 0, 0, 0)
		flags = (GUI.WindowFlags_NoInputs + GUI.WindowFlags_NoBringToFrontOnFocus + GUI.WindowFlags_NoTitleBar + GUI.WindowFlags_NoResize + GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoCollapse)
		GUI:Begin("DrawCircularSector", true, flags)
		self.DrawCircularSector()
		self.DrawEnemyCircle()
		if valid(Data.DebugDrawAttemptPoint) then
			local pos = RenderManager:WorldToScreen(Data.DebugDrawAttemptPoint)
			if valid(pos) then
				GUI:AddCircleFilled(pos.x,pos.y,4,GUI:ColorConvertFloat4ToU32(1,1,0,1))
			else
				Data.DebugDrawAttemptPoint = {}
			end
		end
		GUI:End()
		GUI:PopStyleColor()

		local c = 0
		for k,v in pairs(WindowStyle) do if v[4] ~= 0 then c = c + 1 loadstring([[GUI:PushStyleColor(GUI.Col_]]..k..[[, ]]..(v[1]/255)..[[, ]]..(v[2]/255)..[[, ]]..(v[3]/255)..[[, ]]..v[4]..[[)]])() end end
		GUI:Begin("Draw Circular Sector", true, GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse + GUI.WindowFlags_NoCollapse + GUI.WindowFlags_AlwaysAutoResize)

		g_showdot = GUI:Checkbox("Draw Dots",g_showdot) GUI:SameLine(0,10)
		g_showlabel = GUI:Checkbox("Show Labels",g_showlabel)

		GUI:PushItemWidth(150)
		local val,changed = GUI:SliderFloat("Radius",g_radius, 0.1, 50,"%.1f")
		if changed and val > 0 then g_radius = val end

		local val,changed = GUI:SliderFloat("Angle", g_angle, 0.001, 1,"%.3f")
		if changed and val > 0 and val <=1 then g_angle = val end

		local val,changed = GUI:SliderFloat("Spacing", g_verticesSpacing, 0.1, 5,"%.1f")
		if changed and val > 0 then g_verticesSpacing = val end
		GUI:PopItemWidth()


		GUI:End()
		GUI:PopStyleColor(c)
	end
end

function self.OnOpen()
	Gui.open = not Gui.open
	UpdateActions()
end

function self.OnLoad()
	if not FolderExists(ModulePath) then FolderCreate(ModulePath) end
	LoadSettings(SettingsTable)
	Gui.open = self.Settings.open
	UpdateActions()
	for k,v in pairs(self.Settings.ActionLogic) do
		Data.ActionLogic[k] = loadstring(v)
	end
	--Data.lastcast = last
	--Data.LastCast[last] = 0
	Gui.main_tabs = GUI_CreateTabs("General,Actions,QT Settings,QT Customize,Hotbar Settings,Hotbar Customize",true)

	--SkillMgr.GUI.manager.open = true
end

function self.OnUpdate(event, tickcount)
	local file = ModulePath.."output.txt"
	if Data.TableLoaded then
	elseif Data.InitTime ~= 0 and TimeSince(Data.InitTime) > 5000 then
		local cmd = self.cmd
		if io.type(cmd) == "file" then
			local exists = FileExists(file)
			if exists then
				local File = io.open(file,"r")
				local tbl = loadstring("local tbl = "..File:read("*a"):gsub("%[","{"):gsub("%]","}"):gsub("null","nil"):gsub("\":","\"%]="):gsub("{\"","{%[\""):gsub(",\"",",%[\"").."return tbl")() File:close() cmd:close()
				Data.InitTime = Now()
				if valid(tbl) and table.size(tbl) > 1 then
					tbl = tbl.Results
					local url = ""
					for i=1,#tbl do
						local t = tbl[i]
						for k,v in pairs(t) do
							if v == 0 then t[k] = false elseif v == 1 then t[k] = true end
						end
						local id = t.ID
						self.Settings.ActionData[id] = t

						local icon = t.Icon
						local filename = icon:match("^.+/(.+)$")
						if not FileExists(ImageFolder..filename) then
							if #url ~= 0 then url = url.."," end
							url = url.."\"\"\"https://xivapi.com"..icon.."\"\"\""
						end
					end
					if #url ~= 0 then
						cmd = io.popen([[PowerShell -Command "$ErrorActionPreference = """Stop"""; $urls = ]]..url..[[; $client = New-Object System.Net.WebClient; ForEach ($url in $urls) { $filename = Split-Path $url -leaf; $client.DownloadFile($url,"""]]..ImageFolder..[[$($filename)"""); Start-Sleep -Milliseconds 50}"]])
						cmd:close()
					end
					Data.TableLoaded = true
				end
				return true
			end
		end
	elseif Data.InitTime == 0 then
		Data.InitTime = Now()

		self.cmd = io.popen([[PowerShell -Command "$ErrorActionPreference = """Stop"""; (New-Object System.Net.WebClient).DownloadString('https://xivapi.com/search?indexes=Action&filters=IsPlayerAction=1,ClassJobCategory.BLU=1&columns=Aspect,AttackTypeTargetID,CanTargetFriendly,CanTargetHostile,CanTargetParty,CanTargetSelf,TargetArea,AffectsPosition,Icon,ID,Name&sort_field=ID') | Out-File -Encoding ASCII -FilePath """]]..file..[[""""]]),{}

	end
end

return BLU

--[[

-- Notes --

    Casts:
         7561 : Swiftcast
        11393 : Bristle

    Buffs:
    	   2 : Stun
         167 : Swiftcast
        1716 : Boost (from Bristle)
        2124 : Aetherial Mimicry: Tank
        2125 : Aetherial Mimicry: DPS
        2126 : Aetherial Mimicry: Healer

    Stuns:
       11396 : Bomb Toss     [3s]
       11403 : Faze			 [6s]
       11412 : Sticky Tongue [4s]
       18314 : Perpetual Ray [1s] (Ignores Resistance)

]]