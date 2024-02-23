if g_specializationManager:getSpecializationByName("AdjustableCamera") == nil then
    g_specializationManager:addSpecialization(
      "AdjustableCamera", 
      "AdjustableCamera", 
      Utils.getFilename("AdjustableCamera.lua", 
      g_currentModDirectory), 
      nil
    )
end

for typeName, typeEntry in pairs(g_vehicleTypeManager.types) do
  if
        
      SpecializationUtil.hasSpecialization(Enterable, typeEntry.specializations)
     
  
  then
       g_vehicleTypeManager:addSpecialization(typeName, "AdjustableCamera")
  end
end