function InitExampleScene()
 -- create entities
 Entity(DrawSystemData{dcs={}})
 local mapEnt=Entity(Hierachy{children={}},Pos{localX=32,localY=32},Map{cellX=1,cellY=0,cellWidth=7,cellHeight=4,layer=1})
 local sprEnt=Entity(Hierachy{children={}},Pos{localX=0,localY=0},Spr{id=0,layer=999})
 local ssprEnt=Entity(Hierachy{children={}},Pos{localX=0,localY=0},Sspr{x=40,y=0,width=32,height=32,layer=5})
 local txtEnt=Entity(Hierachy{children={}},Pos{localX=0,localY=0},Txt{str="Hello World!",layer=-20})
 SetParent(mapEnt,sprEnt)
 SetParent(sprEnt,ssprEnt)
 SetParent(mapEnt,txtEnt)
 -- add systems
 AddSystems(HierachyActiveSystem,HierachyPosSystem,MapMoveSystem,SprMoveSystem,ActiveControlSystem,ComponentControlSystem)
 AddDrawSystems(MapSystem,SprSystem,SsprSystem,TxtSystem,DrawRectSystem,DrawSystem)
end