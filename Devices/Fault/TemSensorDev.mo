within BuildingControlEmulator.Devices.Fault;
model TemSensorDev
  extends BaseClasses.TemperatureTwoPort;
  Modelica.Blocks.Interfaces.RealOutput T(final quantity="ThermodynamicTemperature",
                                          final unit="K",
                                          displayUnit = "degC",
                                          min = 0,
                                          start=T_start)
    "Temperature of the passing fluid"
       annotation (Placement(transformation(
        origin={0,110},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Real dt "Constant deviation of temperature measurement";

equation

  T = T_real + dt;
    annotation (Placement(transformation(
        origin={0,110},
        extent={{10,-10},{-10,10}},
        rotation=270)));
end TemSensorDev;
