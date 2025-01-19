CameraSystem=System({Camera,Pos},function(ent)
 local camera,pos=ent[Camera],ent[Pos]
 if camera.enable then
  camera(pos.x,pos.y)
 else
  camera()
 end
end)