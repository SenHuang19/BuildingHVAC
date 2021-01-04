within BuildingControlEmulator.Devices.FlowMover.Control;
model VAVDualFanControl
  import BuildingControlEmulator;
  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=0.5
    "Time constant of Integrator block";
  parameter Modelica.SIunits.Time waitTime(min=0) = 0
      "Wait time before transition fires";
  parameter Real SpeRat
      "Speed ratio";
  BuildingControlEmulator.Devices.FlowMover.Control.CyclingOn cyclingOn(waitTime=
        waitTime)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  BuildingControlEmulator.Devices.Control.conPI variableSpeed(k=k, Ti=Ti)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Interfaces.BooleanInput On
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput SetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput Mea
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Math.Gain gain(k=SpeRat)
    annotation (Placement(transformation(extent={{84,-44},{92,-36}})));
  BuildingControlEmulator.Devices.Control.Constant constantSpeed
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Blocks.Interfaces.RealOutput ySup "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput yRet "Output signal connector"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.BooleanInput CyclingOn
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-62,0},{-42,20}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite oveSpeSup
    annotation (Placement(transformation(extent={{48,32},{64,48}})));
  IBPSA.Utilities.IO.SignalExchange.Overwrite ovePreSetPoi
    annotation (Placement(transformation(extent={{-70,-88},{-54,-72}})));
equation
  connect(variableSpeed.On, On) annotation (Line(
      points={{-62,56},{-80,56},{-80,60},{-120,60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(variableSpeed.Mea, Mea) annotation (Line(
      points={{-62,44},{-70,44},{-70,-20},{-120,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cyclingOn.OnSigOut, constantSpeed.On) annotation (Line(points={{-39,-30},
          {-30.5,-30},{-22,-30}}, color={255,0,255}));
  connect(variableSpeed.y, max.u1) annotation (Line(
      points={{-39,50},{-10,50},{-10,46},{18,46}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(constantSpeed.y, max.u2) annotation (Line(
      points={{1,-30},{10,-30},{10,34},{18,34}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gain.y, yRet) annotation (Line(
      points={{92.4,-40},{110,-40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gain.u, ySup) annotation (Line(
      points={{83.2,-40},{76,-40},{76,40},{110,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(cyclingOn.CyclingOn, CyclingOn) annotation (Line(
      points={{-62,-30},{-80,-30},{-80,-60},{-120,-60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(not1.u, On) annotation (Line(
      points={{-64,10},{-80,10},{-80,60},{-120,60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(not1.y, cyclingOn.OnSigIn) annotation (Line(
      points={{-41,10},{-24,10},{-24,-8},{-80,-8},{-80,-26},{-62,-26}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(max.y, oveSpeSup.u)
    annotation (Line(points={{41,40},{46.4,40}}, color={0,0,127}));
  connect(oveSpeSup.y, ySup) annotation (Line(
      points={{64.8,40},{110,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(SetPoi, ovePreSetPoi.u) annotation (Line(
      points={{-120,20},{-86,20},{-86,-80},{-71.6,-80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ovePreSetPoi.y, variableSpeed.SetPoi) annotation (Line(
      points={{-53.2,-80},{-32,-80},{-32,26},{-74,26},{-74,50},{-62,50}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-66,50},{62,-48}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="VAVDualFanControl")}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end VAVDualFanControl;
