within BuildingControlEmulator.Systems.Examples;
model Floor
  import BuildingControlEmulator;
  extends Modelica.Icons.Example;
  package MediumAir = IBPSA.Media.Air "Medium model for air";
  package MediumCooWat = IBPSA.Media.Water "Medium model for chilled water";
  package MediumHeaWat = IBPSA.Media.Water "Medium model for heating water";

  parameter Modelica.SIunits.Pressure PreDroCoiAir =  50  "Pressure drop in the air side";
  parameter Modelica.SIunits.Pressure PreDroMixingBoxAir =  50 "Pressure drop in the air side";
  parameter Modelica.SIunits.Pressure PreDroCooWat = 79712 "Pressure drop in the water side";

  parameter Modelica.SIunits.Temperature TemEcoHig = 273.15 + 15.58 "the highest temeprature when the economizer is on";
  parameter Modelica.SIunits.Temperature TemEcoLow = 273.15 + 0 "the lowest temeprature when the economizer is on";
  parameter Real MixingBoxDamMin = 0.3 "the minimum damper postion";

  parameter Modelica.SIunits.Time waitTime(min=0) = 1800
      "Wait time before transition fires";
  parameter Modelica.SIunits.VolumeFlowRate VolFloCur[:] = {(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)/1.2*0.5,(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)/1.2*0.7,(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)/1.2,(mAirFloRat1 + mAirFloRat2 + mAirFloRat3 + mAirFloRat4 + mAirFloRat5)/1.2*2} "Volume flow rate curve";
  parameter Real HydEff[:] = {0.93*0.65,0.93*0.7,0.93,0.93*0.6} "Hydraulic efficiency";
  parameter Real MotEff[:] = {0.6045*0.65,0.6045*0.7,0.6045,0.6045*0.6} "Motor efficiency";

  parameter Modelica.SIunits.Pressure SupPreCur[:] = {1400,1000,700,700*0.5} "Pressure curve";
  parameter Modelica.SIunits.Pressure RetPreCur[:] = {600,400,200,100} "Pressure curve";


parameter Modelica.SIunits.Pressure PreAirDroMai1 = 140 "Pressure drop 1 across the duct";

  parameter Modelica.SIunits.Pressure PreAirDroMai2 = 140 "Pressure drop 2 across the main duct";

  parameter Modelica.SIunits.Pressure PreAirDroMai3 = 120 "Pressure drop 3 across the main duct";

  parameter Modelica.SIunits.Pressure PreAirDroMai4 = 152 "Pressure drop 4 across the main duct";

  parameter Modelica.SIunits.Pressure PreAirDroBra1 = 0 "Pressure drop 1 across the duct branch 1";

  parameter Modelica.SIunits.Pressure PreAirDroBra2 = 0 "Pressure drop 1 across the duct branch 2";

  parameter Modelica.SIunits.Pressure PreAirDroBra3 = 0 "Pressure drop 1 across the duct branch 3";

  parameter Modelica.SIunits.Pressure PreAirDroBra4 = 0 "Pressure drop 1 across the duct branch 4";

  parameter Modelica.SIunits.Pressure PreAirDroBra5 = 0 "Pressure drop 1 across the duct branch 5";

  parameter Modelica.SIunits.Pressure PreWatDroMai1 = 79712*0.2 "Pressure drop 1 across the pipe";

  parameter Modelica.SIunits.Pressure PreWatDroMai2 = 79712*0.2 "Pressure drop 2 across the main pipe";

  parameter Modelica.SIunits.Pressure PreWatDroMai3 = 79712*0.2 "Pressure drop 3 across the main pipe";

  parameter Modelica.SIunits.Pressure PreWatDroMai4 = 79712*0.2 "Pressure drop 4 across the main pipe";

  parameter Modelica.SIunits.Pressure PreWatDroBra1 =  0 "Pressure drop 1 across the pipe branch 1";

  parameter Modelica.SIunits.Pressure PreWatDroBra2 =  0 "Pressure drop 1 across the pipe branch 2";

  parameter Modelica.SIunits.Pressure PreWatDroBra3 =  0 "Pressure drop 1 across the pipe branch 3";

  parameter Modelica.SIunits.Pressure PreWatDroBra4 =  0 "Pressure drop 1 across the pipe branch 4";

  parameter Modelica.SIunits.Pressure PreWatDroBra5 =  0 "Pressure drop 1 across the pipe branch 5";

  parameter Modelica.SIunits.MassFlowRate mAirFloRat1 = 10.92*1.2 "mass flow rate for vav 1";

  parameter Modelica.SIunits.MassFlowRate mAirFloRat2 = 2.25*1.2 "mass flow rate for vav 2";

  parameter Modelica.SIunits.MassFlowRate mAirFloRat3 = 1.49*1.2 "mass flow rate for vav 3";

  parameter Modelica.SIunits.MassFlowRate mAirFloRat4 = 1.9*1.2 "mass flow rate for vav 4";

  parameter Modelica.SIunits.MassFlowRate mAirFloRat5 = 1.73*1.2 "mass flow rate for vav 5";

  parameter Modelica.SIunits.MassFlowRate mWatFloRat1 = mAirFloRat1*0.3*(35-12.88)/4.2/20 "mass flow rate for vav 1";

  parameter Modelica.SIunits.MassFlowRate mWatFloRat2 = mAirFloRat2*0.3*(35-12.88)/4.2/20 "mass flow rate for vav 2";

  parameter Modelica.SIunits.MassFlowRate mWatFloRat3 = mAirFloRat3*0.3*(35-12.88)/4.2/20 "mass flow rate for vav 3";

  parameter Modelica.SIunits.MassFlowRate mWatFloRat4 = mAirFloRat4*0.3*(35-12.88)/4.2/20 "mass flow rate for vav 4";

  parameter Modelica.SIunits.MassFlowRate mWatFloRat5 = mAirFloRat5*0.3*(35-12.88)/4.2/20 "mass flow rate for vav 5";

  parameter Modelica.SIunits.Pressure PreDroAir1 = 200 "Pressure drop in the air side of vav 1";
  parameter Modelica.SIunits.Pressure PreDroWat1 = 79712
                                                      "Pressure drop in the water side of vav 1";
  parameter Modelica.SIunits.Efficiency eps1(max=1) = 0.8
    "Heat exchanger effectiveness of vav 1";

  parameter Modelica.SIunits.Pressure PreDroAir2 = 124
                                                      "Pressure drop in the air side of vav 2";
  parameter Modelica.SIunits.Pressure PreDroWat2 = 79712
                                                      "Pressure drop in the water side of vav 2";
  parameter Modelica.SIunits.Efficiency eps2(max=1) = 0.8
    "Heat exchanger effectiveness of vav 2";

  parameter Modelica.SIunits.Pressure PreDroAir3 = 124
                                                      "Pressure drop in the air side of vav 3";
  parameter Modelica.SIunits.Pressure PreDroWat3 = 79712 "Pressure drop in the water side of vav 3";
  parameter Modelica.SIunits.Efficiency eps3(max=1) = 0.8
    "Heat exchanger effectiveness of vav 3";

  parameter Modelica.SIunits.Pressure PreDroAir4 = 124 "Pressure drop in the air side of vav 4";
  parameter Modelica.SIunits.Pressure PreDroWat4 = 79712
                                                      "Pressure drop in the water side of vav 4";
  parameter Modelica.SIunits.Efficiency eps4(max=1) = 0.8
    "Heat exchanger effectiveness of vav 4";

  parameter Modelica.SIunits.Pressure PreDroAir5 = 124
                                                      "Pressure drop in the air side of vav 1";
  parameter Modelica.SIunits.Pressure PreDroWat5 = 79712
                                                      "Pressure drop in the water side of vav 1";
  parameter Modelica.SIunits.Efficiency eps5(max=1) = 0.8
    "Heat exchanger effectiveness of vav 5";

  BuildingControlEmulator.Systems.Floor floor(
    redeclare package MediumAir = MediumAir,
    redeclare package MediumHeaWat = MediumHeaWat,
    redeclare package MediumCooWat = MediumCooWat,
    PreDroCoiAir=PreDroCoiAir,
    PreDroMixingBoxAir=PreDroMixingBoxAir,
    PreDroCooWat=PreDroCooWat,
    TemEcoHig=TemEcoHig,
    TemEcoLow=TemEcoLow,
    MixingBoxDamMin=MixingBoxDamMin,
    waitTime=waitTime,
    HydEff=HydEff,
    MotEff=MotEff,
    VolFloCur=VolFloCur,
    SupPreCur=SupPreCur,
    RetPreCur=RetPreCur,
    PreAirDroMai1=PreAirDroMai1,
    PreAirDroMai2=PreAirDroMai2,
    PreAirDroMai3=PreAirDroMai3,
    PreAirDroMai4=PreAirDroMai4,
    PreAirDroBra1=PreAirDroBra1,
    PreAirDroBra2=PreAirDroBra2,
    PreAirDroBra3=PreAirDroBra3,
    PreAirDroBra4=PreAirDroBra4,
    PreAirDroBra5=PreAirDroBra5,
    PreWatDroMai1=PreWatDroMai1,
    PreWatDroMai2=PreWatDroMai2,
    PreWatDroMai3=PreWatDroMai3,
    PreWatDroMai4=PreWatDroMai4,
    PreWatDroBra1=PreWatDroBra1,
    PreWatDroBra2=PreWatDroBra2,
    PreWatDroBra3=PreWatDroBra3,
    PreWatDroBra4=PreWatDroBra4,
    PreWatDroBra5=PreWatDroBra5,
    mAirFloRat1=mAirFloRat1,
    mAirFloRat2=mAirFloRat2,
    mAirFloRat3=mAirFloRat3,
    mAirFloRat4=mAirFloRat4,
    mAirFloRat5=mAirFloRat5,
    mWatFloRat1=mWatFloRat1,
    mWatFloRat2=mWatFloRat2,
    mWatFloRat3=mWatFloRat3,
    mWatFloRat4=mWatFloRat4,
    mWatFloRat5=mWatFloRat5,
    PreDroAir1=PreDroAir1,
    PreDroWat1=PreDroWat1,
    eps1=eps1,
    PreDroAir2=PreDroAir2,
    PreDroWat2=PreDroWat2,
    eps2=eps2,
    PreDroAir3=PreDroAir3,
    PreDroWat3=PreDroWat3,
    eps3=eps3,
    PreDroAir4=PreDroAir4,
    PreDroWat4=PreDroWat4,
    eps4=eps4,
    PreDroAir5=PreDroAir5,
    PreDroWat5=PreDroWat5,
    eps5=eps5,
    duaFanAirHanUnit(Fan_k=0.01))
    annotation (Placement(transformation(extent={{-24,-20},{26,22}})));
  IBPSA.Fluid.Sources.Boundary_pT sou(
    nPorts=2,
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 100000)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  IBPSA.Fluid.Sources.Boundary_pT souCooWat(
    redeclare package Medium = MediumCooWat,
    nPorts=1,
    p(displayUnit="Pa") = 100000 + PreDroCooWat)
              annotation (Placement(transformation(extent={{-22,60},{-42,80}})));

  IBPSA.Fluid.Sources.Boundary_pT sinCooWat(
    nPorts=1,
    redeclare package Medium = MediumCooWat,
    p(displayUnit="Pa") = 100000,
    T=279.15)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  IBPSA.Fluid.Sources.Boundary_pT souHeaWat(
    nPorts=1,
    p(displayUnit="Pa") = 100000 + PreWatDroMai1 + PreWatDroMai2 + PreWatDroMai3 + PreWatDroMai4 + PreWatDroBra5 + PreDroWat5,
    redeclare package Medium = MediumHeaWat)
    annotation (Placement(transformation(extent={{0,60},{20,80}})));

  IBPSA.Fluid.Sources.Boundary_pT sinHeaWat(
    nPorts=1,
    p(displayUnit="Pa") = 100000,
    redeclare package Medium = MediumHeaWat)
    annotation (Placement(transformation(extent={{60,60},{40,80}})));

  Modelica.Blocks.Sources.Ramp loa[5](duration=86400, height=1*1000*10)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Blocks.Sources.Constant const[5](k=273.15 + 24)
    annotation (Placement(transformation(extent={{-100,18},{-80,38}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 12.88)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Constant const2(k=400)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-100,-106},{-80,-86}})));
  Modelica.Blocks.Sources.Ramp ramp1[
                                    5](duration=86400, height=1) annotation (Placement(transformation(extent={{-100,42},
            {-80,62}})));
  Modelica.Blocks.Sources.Ramp ramp2[
                                    5](duration=86400,
    offset=0,
    height=0)                                                    annotation (Placement(transformation(extent={{-72,-60},
            {-52,-40}})));
  Modelica.Blocks.Sources.Constant const3[5](k=273.15 + 20)
    annotation (Placement(transformation(extent={{0,-100},{-20,-80}})));
equation
  connect(floor.port_Fre_Air, sou.ports[1])
    annotation (Line(points={{-24,9.4},{-56,9.4},{-56,2},{-80,2}}, color={0,127,255}));
  connect(floor.port_Exh_Air, sou.ports[2])
    annotation (Line(points={{-24,-7.4},{-80,-7.4},{-80,-2}}, color={0,127,255}));
  connect(sinCooWat.ports[1], floor.port_b_CooWat)
    annotation (Line(points={{-60,70},{-52,70},{-52,40},{-14,40},{-14,22}}, color={0,127,255}));
  connect(floor.port_a_CooWat, souCooWat.ports[1])
    annotation (Line(points={{-4,22.42},{-4,46},{-48,46},{-48,70},{-42,70}},
                                                                          color={0,127,255}));
  connect(floor.port_a_HeaWat, souHeaWat.ports[1])
    annotation (Line(points={{6,22},{6,22},{6,46},{24,46},{24,70},{20,70}}, color={0,127,255}));
  connect(floor.port_b_HeaWat, sinHeaWat.ports[1])
    annotation (Line(points={{16,22},{16,36},{34,36},{34,70},{40,70}}, color={0,127,255}));
  connect(loa.y, floor.Q_flow) annotation (Line(
      points={{21,-50},{60,-50},{60,-16.01},{28.75,-16.01}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const1.y, floor.DisTemPSetPoi) annotation (Line(
      points={{-79,-30},{-64,-30},{-46,-30},{-46,13.6},{-27,13.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const2.y, floor.PreSetPoi) annotation (Line(
      points={{-79,-70},{-38,-70},{-38,5.41},{-26.75,5.41}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanExpression.y, floor.OnZon) annotation (Line(
      points={{-79,-96},{-34,-96},{-34,-20},{-27,-20}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(floor.OnFan, floor.OnZon) annotation (Line(
      points={{-27,-11.6},{-34,-11.6},{-34,-20},{-27,-20}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(ramp1.y, floor.AirFlowRatSetPoi) annotation (Line(
      points={{-79,52},{-54,52},{-54,-2.99},{-26.75,-2.99}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ramp2.y, floor.yVal) annotation (Line(
      points={{-51,-50},{-42,-50},{-42,-15.8},{-27,-15.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const.y, floor.ZonCooTempSetPoi) annotation (Line(
      points={{-79,28},{-44,28},{-44,22},{-27,22}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(const3.y, floor.ZonHeaTempSetPoi) annotation (Line(
      points={{-21,-90},{-50,-90},{-50,17.8},{-27,17.8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=86400));
end Floor;
