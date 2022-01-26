if g_specializationManager:getSpecializationByName("adjustableCamera") == nil then
    g_specializationManager:addSpecialization(
      "adjustableCamera", 
      "AdjustableCamera", 
      Utils.getFilename("AdjustableCamera.lua", 
      g_currentModDirectory), 
      true
    )
end

for typeName, typeEntry in pairs(g_vehicleTypeManager.types) do
  if
        
      SpecializationUtil.hasSpecialization(Enterable, typeEntry.specializations)
     
  
  then
       g_vehicleTypeManager:addSpecialization(typeName, "adjustableCamera")
  end
end