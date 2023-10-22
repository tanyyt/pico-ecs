MapMoveSystem=System({Map,Pos},function(ent)
 local pos=ent[Pos]
 SetLocalPos(ent,pos.localX+flr(rnd(3))-1,pos.localY+flr(rnd(3))-1)
end)

SprMoveSystem=System({Spr,Pos},function(ent)
 local pos=ent[Pos]
 SetLocalPos(ent,pos.localX+flr(rnd(3))-1,pos.localY+flr(rnd(3))-1)
 if(time()>5)HierachyRemoveDelay(ent)
end)

ActiveControlSystem=System({Map},function(ent)
 local sprEnt=QueryWorldSingle{Spr}
 if(sprEnt)SetHierachyActive(sprEnt,rnd(2)>1)
end)

ComponentControlSystem=System({Txt},function(ent)
 local rect=ent[DrawRectComponent]
 if rnd(2)>1 then
  if not rect then
   ent+=DrawRectComponent{layer=-10}
  end
 else
  if rect then
   ent-=DrawRectComponent
  end
 end
end)

DrawRectSystem=System({DrawRectComponent,Pos},function(ent)
 local pos,drawRect=ent[Pos],ent[DrawRectComponent]
 SubmitDraw(QueryWorldSingle{DrawSystemData},function()
  rectfill(pos.x,pos.y,pos.x+rnd(5)+2,pos.y+rnd(10)+5,3)
 end,drawRect.layer)
end)