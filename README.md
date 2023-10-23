# Zecs
An ECS framework for pico-8, based on pecs:https://github.com/jesstelford/pecs.
Because of pico-8's limitation, this library tries to use as least tokens and chars as possible, and it provides:
- ECS framework for pico-8.
- delay function to handle sequence problems in ECS.
- Preset components like hierarchy, pos, spr and etc to cover the common usage.
# Quick Start
First, you should import the lua files you need into your `.p8` file. And there are four kinds of files in zecs:
- Framework core (`zecs.lua`).
- Components, only contain data (put into `comps` folder).
- Utilities, contain helper functions which operate components, and should be used between systems (put into `utils` folder).
- Systems, only contain logic (put into `systems` folder).
We need to include them as the sequence metioned below.
```lua
-- include zecs.lua at first
#include zecs.lua

-- then include components
#include comps/pos.lus
-- other components ...

-- then include utilities
#include utils/hierarchy_pos_utils.lua
-- other utilities ...

-- then include systems
#include systems/hierarchy_pos_system.lua
-- other systems ...
```
And now we have been prepared for Zecs! Let's move next to api usage.
## World
World contains all entities of Zecs, and there is only one World in Zecs.
So before we start or after game scene changed or somethine like that, always remember to clear World.
```lua
-- clear World, clear all entities and systems
ClearWorld()
```
And we need to call UpdateWorld() and DrawWorld() every frame.
```lua
-- call UpdateWorld() in pico-8 _update() function
function _update()
 UpdateWorld()
end

-- call DrawWorld() in pico-8 _draw() function
function _draw()
 cls()
 DrawWorld()
end
```
We could queue a callback until next UpdateWorld().
```lua
-- queue a callback
QueueCb(function()
 print("Queue Callback")
end)
```
## Component
Component has the data we need, we could define our custom Component.
```lua
-- define a custom component called Character
Character=Component{hp=0,maxHp=0}
```
## Entity
Entity holds multiple components, but one entity could only hold one component of each type (for example an entity could not have two Character component). A world could have multiple entities.
```lua
-- create an entity that holds Character component and Pos component, this entity would be added in World when next UpdateWorld()
local ent=Entity(Pos{localX=4,localY=-14},Character{hp=3,maxHp=3})

-- change the active state of entity, deactive entities would not be included in system's logic, this operation would be delayed until next UpdateWorld() execution
SetActiveDelay(ent)

-- remove an entity from World, this operation would be delayed until next UpdateWorld() execution
RemoveDelay(ent)

-- query entites that contain specific Components (Character and Pos)
local filtered=QueryWorld{Character,Pos}
for id,ent2 in next,filtered do
 -- ent2 is the entity we need
end
-- or only get the single one entity
local ent3=QueryWorldSingle{Character,Pos}
```
We could add/remove component after entity created.
```lua
-- add component, it would be delayed until next UpdateWorld()
ent+=Pos{localX=1,locaY=-2}
-- remove component, it would be delayed until next UpdateWorld()
ent-=Pos
```
## System
System contains the actual logic we execute. We could define a system that executes only on specific entities.
There are two kinds of Systems in Zecs, the only different is that they would be executed in UpdateWorld() or DrawWorld().
```lua
-- define a system that influences entity that holds Character and Pos
MySystem=System({Character,Pos},function(ent)
 local character,pos=ent[Character],ent[Pos]
 -- write our own logic
end)

-- DrawSystem's defination is the same as LogicSystem
MyDrawSystem=System({Character,Pos},function(ent)
 -- wirte out own code
end)
```
And we need to manually add System into World.
```lua
-- There are two kinds of system: LogicSystem, DrawSystem
-- Add custom LogicSystem into world
AddSystems(MySystem,MySystem2,MySystem3)

-- Add custom DrawSystem into world
AddDrawSystems(MyDrawSystem,MyDrawSystem2,MyDrawSystem3)
```
## Utility
Utility contains helper function that operate Component. Usually they should be used between many Systems.
```lua
-- custom helper function that add Character hp
function AddOneHp(ent)
 ent[Character].hp+=1
end
```
# Presets
Zecs provides preset Components, Systems and Utilities to help developers code their game quickly.
## Logic
Components, Systems and Utilities used for logic.
### Hierarchy
Component that represents entities' tree structure.
```lua
-- isActiveSelf: parent's active state would influence children's active state
-- parent: parent entity
-- childre: a table of children entity
Hierarchy{children={}--[[,parent,isActiveSelf=true]]}
```
Related Systems.
```lua
-- LogicSystem that makes active state related to Hierarchy
AddSystems(HierarchyActiveSystem)
```
Related Utilities.
```lua
-- set an entity's parent
-- parent: parent entity
-- child: child entity
SetParent(parent,child)

-- different from SetActiveDelay(), this would influence all children entities, this operation would takes influence until next HierarchyActiveSystem update
SetHierarchyActive(ent)

-- different from RemoveDelay(), this would remove all childrent entites as well, this operation would be delayed until next UpdateWorld()
HierarchyRemoveDelay(ent)
```
### Pos
Compnent that represents entity's position, needs to work with Hierarchy.
```lua
-- x,y world position
-- x,y local position in hierarchy
Pos{--[[x=0,y=0,]]localX=0,localY=0}
```
Related Systems.
```lua
-- System to sync world position with hierarchy
AddSystems(HierarchyPosSystem)
```
Related Utilities.
```lua
-- set world position
SetPos(ent,x,y)
-- set local position
SetLocalPos(ent,localX,localY)
```
## Draw
Components, Systems and Utilities used for draw.
### DrawSystem
Component that contains draw call data.
```lua
-- contains all draw call
DrawSystemData{dcs={}}
```
System to draw all the things.
```lua
-- this system to draw spr, sspr, map and print
AddDrawSystems(DrawSystem)
```
To make draw system work, we need to have an Entity that holds DrawSystemData and add DrawSystem to World.
**Warning: There should be only one DrawSystemData in World!**
```lua
-- create an entity with DrawSystemData
Entity(DrawSystemData{dcs={}})
-- add DrawSystem to World
AddDrawSystems(DrawSystem)
```
If we want to insert some draw call into specific layer, we could use SubmitOther() function.
```lua
-- draw a rect in layer 20
SubmitDraw(QueryWorldSingle{DrawSystemData},function()
 rect(0,10,20,20)
end,20)
```
### Spr
Component that draws a spr. It needs to work with Pos.
```lua
-- enable: disable it, it would not draw anything
-- id: the id of sprite
-- width/height: scale the sprite, 1 == 8 pixels
-- flipX/Y: flip the draw
-- layer: the layer of this draw, more greater more later
Spr{id=0--[[,width=1,height=1,enable=true,flipX=false,flipY=false,layer=0]]}
```
System that submits spr drawcall.
```lua
AddDrawSystems(SprSystem)
```
### Sspr
Component that draws a sspr. It needs to work with Pos.
```lua
-- enable：disable it, it would not draw anything
-- x/y: the left-up position of sspr in SpriteEditor
-- width/height: the width/height of sspr in SpriteEditor, 1 == 1 pixel
-- destWidth/destHeight: the width/height when draw, 1 == 1 pixel. -1 means it would keep sync with width/height
-- layer: the layer of this draw, more greater more later
Sspr{x=0,y=0,width=10,height=10--[[enable=true,destWidth=-1,destHeight=-1,flipX=false,flipY=false,layer=0]]}
```
System that submits sspr drawcall.
```lua
AddDrawSystems(SsprSystem)
```
### Map
Component that draws a map. It needs to work with Pos.
```lua
-- enable：disable it, it would not draw anything
-- cellX/Y: the left-up position of the map in MapEditor
-- cellWidth/Height: the width/height of the map
-- layers:  a bitfield. When given, only sprites with matching sprite flags are drawn. For example, when LAYERS is 0x5, only sprites with flag 0 and 2 are drawn
-- layer: the layer of this draw, more greater more later
Map{cellX=0,cellY=0,cellWidth=10,cellHeight=10--[[,layers=0,enable=true,layer=0]]}
```
System that submits map drawcall.
```lua
AddDrawSystems(MapSystem)
```
### Txt
Component that draws print a text. It needs to work with Pos.
```lua
-- enable： disable it, it would not draw anything
-- col: color of the print, -1 means keep sync with last print
-- layer: the layer of this draw, more greater more later
-- str: text content of this print
Txt{str="test"--[[,enable=true,col=-1,layer=0]]}
```
System that submits print drawcall.
```lua
AddDrawSystems(TxtSystem)
```