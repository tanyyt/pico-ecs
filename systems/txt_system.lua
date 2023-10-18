TxtSystem=System({Txt,Pos},function(ent)
 local txt,pos=ent[Txt],ent[Pos]
 if(not txt.enable)return
 SubmitPrint(SingletonEntity[DrawSystemData],txt.str,pos.x,pos.y,txt.layer,txt.col)
end)