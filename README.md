# zecs
An ECS framework for pico-8, based on pecs:https://github.com/jesstelford/pecs.
Because of pico-8's limitation, this library tries to use as least tokens and chars as possible, and it provides:
- ECS framework for pico-8.
- delay function to handle sequence problems in ECS.
- Preset components like hierachy, pos, spr and etc to cover the common usage.
# Quick Start
First, you should import the lua files you need into your `.p8` file. And there are four kinds of files in zecs:
- Framework core (`zecs.lua`)
- Components, only contains data (put into `comps` folder)
- Utilities, contains helper functions which operate components, and should be used between systems (put into `utils` folder)
- Systems, only contains logic (put into `systems` folder)
You need to include them as the sequence metioned above.
```
-- include zecs.lua at first
#include zecs.lua
-- then include components
#include comps/pos.lus
-- other components ...
-- then include utilities
#include utils/hierachy_pos_utils.lua
-- other utilities ...
-- then include systems
#include systems/hierachy_pos_system.lua
-- other systems ...
```
And now you have been prepared for zecs! Let's move next to api usage
## World
World contains all entities of zecs, and there is only one world in zecs.
So before you start or after game scene changed or somethine like that, always remember to clear world.
```
-- Clear world, clear all entities and systems
ClearWorld()
```
And we need to call UpdateWorld() and DrawWorld() every frame.
```
-- Call UpdateWorld() in pico-8 _update() function
function _update()
 UpdateWorld()
end
-- Call DrawWorld() in pico-8 _draw() function
function _draw()
 DrawWorld()
end
```
## Component
Component has the data we need, we could define custom Component which contains the data we need
```
-- Define a custom component called Character
Character=Component{hp=0,maxHp=0}
```
## Entity
Entity holds multiple components, but one entity could only hold one component of each type (for example an entity could not have two Character component). A world could have multiple entities.
```
-- Create an entity that holds Character component and Pos component
local ent=Entity(Pos{localX=4,localY=-14},Character{hp=3,maxHp=3})
-- Change the active state of entity, deactive entities would not be included in system's logic, this operation would be delayed until next UpdateWorld() execution
SetEntActive(ent)
-- Remove an entity from World, this operation would be delayed until next UpdateWorld() execution
RemoveEnt(ent)
-- Query entites that contain specific Components (Character and Pos)
local entities=QueryWorld{Character,Pos}
for id,ent2 in next,selectableEntities do
 -- ent2 is the entity we need
end
```
## System
System contains the actual logic we execute. We could define a system that executes only on specific entity
```
-- Define a system that influences entity that holds Character and Pos
MySystem=System({Character,Pos},function(ent)
 local character,pos=ent[Character],ent[Pos]
 -- Write your own logic
end)
```
And we need to manually add system into World
```
-- There are two kinds of system: LogicSystem, DrawSystem
-- Add custom LogicSystem into world
-- AddSystems(MySystem,MySystem2,MySystem3)

-- Add custom DrawSystem into world
-- AddDrawSystems(MyDrawSystem,MyDrawSystem2,MyDrawSystem3)
```
## Utility
Utility contains helper function that operate Component.
```
-- Custom helper function that add Character hp
function AddOneHp(ent)
 ent[Character].hp+=1
end
```
# Presets
zecs provides preset Components, Systems and Utilities to help developers code their game quickly.
## Hierachy
Component that represents entities' tree structure.
```
-- isActiveSelf: parent's active state would influence children's active state
-- parent: parent entity
-- childre: a table of children entity
Hierachy=Component{--[[parent,children,]]isActiveSelf=true}
```
Related Systems.
```
-- LogicSystem that makes active state related to Hierachy
add(systems,HierachyActiveSystem)
```
Related Utilities.
```
-- Set an entity's parent
-- parent: parent entity
-- child: child entity
SetParent(parent,child)
-- Different from SetEntActive(), this would influence all children entities
SetHierachyActive(ent)
-- Different from Remove(), this would remove all childrent entites as well
HierachyRemove(ent)
```
## Pos
Compnent that represents entity's position, needs to work with Hierachy
```

```