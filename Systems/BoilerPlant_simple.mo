within BuildingControlEmulator.Systems;
model BoilerPlant_simple
  replaceable package MediumHW =
     Modelica.Media.Interfaces.PartialMedium
    "Medium in the hot water side";
  parameter Integer n=2
    "Number of boilers";
  parameter Integer m=1
    "Number of pumps";
  parameter Real thrhol[:]= {0.95}
    "Threshold for chiller staging";
  parameter Real Cap[:] = {2762738.20/2 for i in linspace(1, n, n)} "Rated Plant Capacity";
  parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal[:] = {2762738.20/n/20/4200 for i in linspace(1,n,n)}
    "Nominal mass flow rate at the chilled water side";
  parameter Modelica.SIunits.Temperature THW_start = 273.15 + 80
    "The start temperature of chilled water side";
  parameter Modelica.SIunits.TemperatureDifference dTHW_nominal= 20
    "Temperature difference between the outlet and inlet of the module";
  parameter Real eta[n,:]={{0.8} for i in linspace(1,n,n)} "Fan efficiency";
  parameter Modelica.SIunits.Pressure dP_nominal=478250
    "Nominal pressure drop for the secondary chilled water pump ";
  parameter Real v_flow_rate[m,:] = {{0.1*sum(mHW_flow_nominal)/m/996,0.6*sum(mHW_flow_nominal)/m/996,0.8*sum(mHW_flow_nominal)/m/996,sum(mHW_flow_nominal)/m/996,1.2*sum(mHW_flow_nominal)/m/996}};
  parameter Real pressure[m,:] = {{2*dP_nominal,1.5*dP_nominal,1.1*dP_nominal,dP_nominal,0.75*dP_nominal}};

  parameter Real Motor_eta_Sec[m,:] = {{0.6,0.76,0.87,0.86,0.74}}
    "Motor efficiency";
  parameter Real Hydra_eta_Sec[m,:] = {{1,1,1,1,1}} "Hydraulic efficiency";

  Subsystems.Pump.PumpSystem pumSecHW(
    redeclare package Medium = MediumHW,
    n=1,
    m_flow_nominal={sum(mHW_flow_nominal)},
    HydEff=Hydra_eta_Sec,
    MotEff=Motor_eta_Sec,
    VolFloCur=v_flow_rate,
    PreCur=pressure,
    dp={dP_nominal*0.25})
             annotation (Placement(transformation(extent={{22,0},{-12,36}})));
  Modelica.Blocks.Sources.Constant THWSet(k=273.15 + 80)
    annotation (Placement(transformation(extent={{-260,38},{-240,58}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Sources.Constant On(k=1)
    annotation (Placement(transformation(extent={{-260,80},{-240,100}})));
  replaceable IBPSA.Fluid.Sensors.TemperatureTwoPort senTHWBuiEnt(
    allowFlowReversal=true,
    redeclare package Medium = MediumHW,
    m_flow_nominal=sum(mHW_flow_nominal))
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-90})));
  replaceable Subsystems.Boiler.MultiBoilers        multiBoiler(
    redeclare package MediumHW = MediumHW,
    dPHW_nominal=dP_nominal*0.5,
    mHW_flow_nominal=mHW_flow_nominal,
    dTHW_nominal=dTHW_nominal,
    eta=eta,
    n=n,
    THW_start=THW_start)
    annotation (Placement(transformation(extent={{-96,-44},{-62,-16}})));
  Buildings.Fluid.Storage.ExpansionVessel expVesCHW(redeclare package Medium =
        MediumHW, V_start=10)
    annotation (Placement(transformation(extent={{30,4},{38,12}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = MediumHW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{132,110},{152,130}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = MediumHW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{130,-150},{150,-130}})));
  Devices.WaterSide.Control.PlantStageN BoilerStage(
    tWai=1800,
    n=n,
    thehol=thrhol,
    Cap=Cap) annotation (Placement(transformation(extent={{-80,58},{-60,78}})));
  Modelica.Blocks.Interfaces.RealInput dP "Measured pressure drop"
    annotation (Placement(transformation(extent={{-320,-20},{-280,20}})));
  Modelica.Blocks.Interfaces.RealOutput THWLea
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{240,-8},{260,12}})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort senTHWBuiLea(
    allowFlowReversal=true,
    redeclare package Medium = MediumHW,
    m_flow_nominal=sum(mHW_flow_nominal)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={120,18})));
  replaceable IBPSA.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package
      Medium =
        MediumHW) annotation (Placement(transformation(
        extent={{-10,12},{10,-12}},
        rotation=180,
        origin={82,18})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=senMasFlo.m_flow*4200
        *(senTHWBuiEnt.T - senTHWBuiLea.T))
    annotation (Placement(transformation(extent={{62,-50},{42,-30}})));
  Devices.Control.conPI conPI(k=0.001, Ti=60)
    annotation (Placement(transformation(extent={{66,74},{86,94}})));
  Modelica.Blocks.Sources.RealExpression SetPoi(y=dP_nominal*0.25)
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
equation
  connect(On.y, realToBoolean.u) annotation (Line(
      points={{-239,90},{-162,90}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(multiBoiler.port_a_HW, pumSecHW.port_b)
    annotation (Line(
      points={{-62,-18.8},{-62,18},{-12,18}},
      color={255,0,0},
      thickness=1));
  connect(multiBoiler.port_b_HW, senTHWBuiEnt.port_a) annotation (Line(
      points={{-62,-41.2},{-58,-41.2},{-58,-90},{100,-90}},
      color={255,0,0},
      thickness=1));

  connect(multiBoiler.THWSet, THWSet.y) annotation (Line(
      points={{-97.53,-24.4},{-200,-24.4},{-200,48},{-239,48}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senTHWBuiEnt.port_b, port_b) annotation (Line(
      points={{120,-90},{132,-90},{140,-90},{140,-140}},
      color={255,0,0},
      thickness=1));
  connect(BoilerStage.On, realToBoolean.y) annotation (Line(
      points={{-82,76},{-120,76},{-120,90},{-139,90}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(senTHWBuiEnt.T, THWLea) annotation (Line(
      points={{110,-79},{110,-79},{110,0},{110,2},{250,2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(multiBoiler.Rat, BoilerStage.Status) annotation (Line(
      points={{-60.3,-35.6},{-32,-35.6},{-32,34},{-92,34},{-92,60},{-82,60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(BoilerStage.y, multiBoiler.On) annotation (Line(
      points={{-59,68},{-42,68},{-42,28},{-142,28},{-142,-35.6},{-97.53,-35.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senTHWBuiLea.port_a, port_a) annotation (Line(
      points={{130,18},{142,18},{142,120}},
      color={255,0,0},
      thickness=1));
  connect(expVesCHW.port_a, pumSecHW.port_a) annotation (Line(
      points={{34,4},{34,-2},{54,-2},{54,18},{22,18}},
      color={255,0,0},
      thickness=1));
  connect(senMasFlo.port_b, pumSecHW.port_a) annotation (Line(
      points={{72,18},{48,18},{22,18}},
      color={255,0,0},
      thickness=1));
  connect(senMasFlo.port_a, senTHWBuiLea.port_b) annotation (Line(
      points={{92,18},{110,18}},
      color={255,0,0},
      thickness=1));
  connect(realExpression.y, BoilerStage.Loa) annotation (Line(
      points={{41,-40},{-20,-40},{-20,2},{-110,2},{-110,68},{-82,68}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conPI.On, realToBoolean.y)
    annotation (Line(points={{64,90},{-139,90}}, color={255,0,255}));
  connect(SetPoi.y, conPI.SetPoi) annotation (Line(points={{21,70},{44,70},{44,84},
          {64,84}}, color={0,0,127}));
  connect(dP, conPI.Mea) annotation (Line(points={{-300,0},{-128,0},{-128,48},{52,
          48},{52,78},{64,78}}, color={0,0,127}));
  connect(conPI.y, pumSecHW.SpeSig[1]) annotation (Line(points={{87,84},{108,84},
          {108,44},{52,44},{52,32.4},{23.53,32.4}}, color={0,0,127}));
  annotation (__Dymola_Commands(file=
          "modelica://ChillerPlantSystem/Resources/Scripts/Dymola/LejeunePlant/ChillerPlantSystem.mos"
        "Simulate and plot"),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-280,-140},{240,
            120}})),
    experiment(
      StartTime=2.9376e+006,
      StopTime=3.6288e+006,
      __Dymola_NumberOfIntervals=1440,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>The schematic drawing of the Lejeune plant is shown as folowing.</p>
<p><img src=\"Resources/Images/lejeunePlant/lejeune_schematic_drawing.jpg\" alt=\"image\"/> </p>
<p>In addition, the parameters are listed as below.</p>
<p>The parameters for the chiller plant.</p>
<p><img src=\"Resources/Images/lejeunePlant/Chiller.png\" alt=\"image\"/> </p>
<p>The parameters for the primary chilled water pump.</p>
<p><img src=\"Resources/Images/lejeunePlant/PriCHWPum.png\" alt=\"image\"/> </p>
<p>The parameters for the secondary chilled water pump.</p>
<p><img src=\"Resources/Images/lejeunePlant/SecCHWPum1.png\" alt=\"image\"/> </p>
<p><img src=\"Resources/Images/lejeunePlant/SecCHWPum2.png\" alt=\"image\"/> </p>
<p>The parameters for the condenser water pump.</p>
<p><img src=\"Resources/Images/lejeunePlant/CWPum.png\" alt=\"image\"/> </p>
</html>"),
    Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-36,-26},{28,-46}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-76,24},{-86,-2},{-66,-2},{-76,24}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,20},{74,-4}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-76,24},{-76,46},{28,46}},  color={0,0,127}),
        Line(points={{-76,-2},{-76,-36},{-36,-36}}, color={0,0,127}),
        Line(points={{62,20},{62,46},{28,46}}, color={0,0,127}),
        Line(points={{62,-4},{62,-36},{28,-36}}, color={0,0,127})}));
end BoilerPlant_simple;
