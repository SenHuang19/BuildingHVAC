within BuildingControlEmulator.Subsystems.HydDisturbution;
model FivZonVAVDX
  replaceable package MediumAir = Modelica.Media.Interfaces.PartialMedium "Medium for the air";

  parameter Modelica.SIunits.Pressure PreAirDroMai1 "Pressure drop 1 across the duct";

  parameter Modelica.SIunits.Pressure PreAirDroMai2 "Pressure drop 2 across the main duct";

  parameter Modelica.SIunits.Pressure PreAirDroMai3 "Pressure drop 3 across the main duct";

  parameter Modelica.SIunits.Pressure PreAirDroMai4 "Pressure drop 4 across the main duct";

  parameter Modelica.SIunits.Pressure PreAirDroBra1 "Pressure drop 1 across the duct branch 1";

  parameter Modelica.SIunits.Pressure PreAirDroBra2 "Pressure drop 1 across the duct branch 2";

  parameter Modelica.SIunits.Pressure PreAirDroBra3 "Pressure drop 1 across the duct branch 3";

  parameter Modelica.SIunits.Pressure PreAirDroBra4 "Pressure drop 1 across the duct branch 4";

  parameter Modelica.SIunits.Pressure PreAirDroBra5 "Pressure drop 1 across the duct branch 5";

  parameter Modelica.SIunits.MassFlowRate mAirFloRat1 "mass flow rate for vav 1";

  parameter Modelica.SIunits.MassFlowRate mAirFloRat2 "mass flow rate for vav 2";

  parameter Modelica.SIunits.MassFlowRate mAirFloRat3 "mass flow rate for vav 3";

  parameter Modelica.SIunits.MassFlowRate mAirFloRat4 "mass flow rate for vav 4";

  parameter Modelica.SIunits.MassFlowRate mAirFloRat5 "mass flow rate for vav 5";

  parameter Modelica.SIunits.Pressure PreDroAir1 "Pressure drop in the air side of vav 1";


  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal1
    "rated heat flow rate for heating of vav 1";


  parameter Modelica.SIunits.Pressure PreDroAir2 "Pressure drop in the air side of vav 2";


  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal2
    "rated heat flow rate for heating of vav 2";

  parameter Modelica.SIunits.Pressure PreDroAir3 "Pressure drop in the air side of vav 3";


  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal3
    "rated heat flow rate for heating of vav 3";

  parameter Modelica.SIunits.Pressure PreDroAir4 "Pressure drop in the air side of vav 4";


  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal4
    "rated heat flow rate for heating of vav 4";

  parameter Modelica.SIunits.Pressure PreDroAir5 "Pressure drop in the air side of vav 1";


  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal5
    "rated heat flow rate for heating of vav 5";


  FivZonNetWor AirNetWor(
    redeclare package Medium = MediumAir,
    PreDroMai1=PreAirDroMai1,
    PreDroMai2=PreAirDroMai2,
    PreDroMai3=PreAirDroMai3,
    PreDroMai4=PreAirDroMai4,
    mFloRat1=mAirFloRat1,
    mFloRat2=mAirFloRat2,
    mFloRat3=mAirFloRat3,
    mFloRat4=mAirFloRat4,
    mFloRat5=mAirFloRat5,
    PreDroBra1=PreAirDroBra1,
    PreDroBra2=PreAirDroBra2,
    PreDroBra3=PreAirDroBra3,
    PreDroBra4=PreAirDroBra4,
    PreDroBra5=PreAirDroBra5) annotation (Placement(transformation(extent={{-74,-52},{-44,-18}})));
  Devices.AirSide.Terminal.BaseClasses.VAV_ele
                                   vAV_ele
                                      [5](redeclare package MediumAir =
        MediumAir,
    mAirFloRat={mAirFloRat1,mAirFloRat2,mAirFloRat3,mAirFloRat4,mAirFloRat5},
    PreDroAir={PreDroAir1,PreDroAir2,PreDroAir3,PreDroAir4,PreDroAir5},
    Q_flow_nominal={Q_flow_nominal1,Q_flow_nominal2,Q_flow_nominal3,Q_flow_nominal4,Q_flow_nominal5})
    annotation (Placement(transformation(extent={{20,-2},{40,18}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol[5](
    redeclare package Medium = MediumAir,
    nPorts=10,
    m_flow_nominal={mAirFloRat1,mAirFloRat2,mAirFloRat3,mAirFloRat4,mAirFloRat5},
    V=10)     annotation (Placement(transformation(extent={{20,-84},{40,-64}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow fixedHeatFlow[5]
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow[5]
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Air(redeclare package Medium =
        MediumAir)
    "Second port, typically outlet"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Air(redeclare package Medium =
        MediumAir)
    "Second port, typically outlet"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Blocks.Interfaces.RealInput AirFlowRatSetPoi[5]
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-120,90},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput yVal[5]
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.BooleanInput On[5]
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temZon[5](redeclare package Medium = MediumAir)
    annotation (Placement(transformation(extent={{8,-56},{-12,-36}})));
  Modelica.Blocks.Interfaces.RealOutput pre "Pressure at port"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput TZon[5]
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
equation

  connect(fixedHeatFlow.port, vol.heatPort) annotation (Line(points={{-20,-80},{
          0,-80},{0,-74},{20,-74}}, color={191,0,0}));
  connect(fixedHeatFlow.Q_flow, Q_flow)
    annotation (Line(points={{-40,-80},{-110,-80}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(vAV_ele.port_a, AirNetWor.ports_b) annotation (Line(points={{20,8},{-20,8},{-20,-27.18},{-44,-27.18}}, color={0,127,255}));
    for i in 1:5 loop

    connect(vAV_ele[i].port_b, vol[i].ports[1]);
    connect(temZon[i].port_b, AirNetWor.ports_a[i]);
    connect(temZon[i].port_a, vol[i].ports[2]);
    end for;

  connect(AirNetWor.port_a, port_a_Air)
    annotation (Line(points={{-74,-28.2},{-88,-28.2},{-88,40},{-100,40}}, color={0,127,255}));
  connect(AirNetWor.port_b, port_b_Air)
    annotation (Line(points={{-74,-45.2},{-80,-45.2},{-80,-60},{-100,-60}}, color={0,127,255}));
  connect(vAV_ele.AirFlowRatSetPoi, AirFlowRatSetPoi)
    annotation (Line(
      points={{19,16},{-10,16},{-34,16},{-34,100},{-110,100}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(vAV_ele.yVal, yVal) annotation (Line(
      points={{19,12},{-40,12},{-40,60},{-110,60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(vAV_ele.On, On) annotation (Line(
      points={{19,0},{6,0},{-10,0},{-110,0}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(AirNetWor.p, pre) annotation (Line(
      points={{-42.5,-35},{-8,-35},{-8,-20},{58,-20},{58,-40},{110,-40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temZon.T, TZon) annotation (Line(
      points={{-2,-35},{-2,-35},{-2,-12},{-2,-6},{78,-6},{78,40},{110,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-90,40},{80,40}}, color={0,127,255}),
        Line(points={{-90,-60},{80,-60}}, color={0,127,255}),
        Line(points={{80,40},{80,-60}}, color={0,127,255}),
        Line(points={{50,40},{50,-60}}, color={0,127,255}),
        Line(points={{20,40},{20,-60}}, color={0,127,255}),
        Line(points={{-10,40},{-10,-60}}, color={0,127,255}),
        Line(points={{-40,40},{-40,-60}}, color={0,127,255}),
        Rectangle(
          extent={{-46,0},{-34,-20}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-16,0},{-4,-20}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{14,0},{26,-20}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{44,0},{56,-20}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{74,0},{86,-20}},
          lineColor={28,108,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(coordinateSystem(preserveAspectRatio=false)));
end FivZonVAVDX;
