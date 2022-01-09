within BuildingControlEmulator.Devices.Fault;
model PreSensorDev
  extends BaseClasses.Pressure;
  Real dp "Constant deviation ratio of pressure measurement";
  Modelica.Blocks.Interfaces.RealOutput p(final quantity="AbsolutePressure",
                                          final unit="Pa",
                                          min=0) "Pressure at port"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  p =  p_real*(1+dp);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end PreSensorDev;
