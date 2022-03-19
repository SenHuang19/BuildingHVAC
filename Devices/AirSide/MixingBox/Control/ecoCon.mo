within BuildingControlEmulator.Devices.AirSide.MixingBox.Control;
model ecoCon
  import BuildingControlEmulator;
  parameter Modelica.SIunits.Temperature TemHig "the highest temeprature when the economizer is on";
   parameter Modelica.SIunits.Temperature TemLow "the lowest temeprature when the economizer is on";
   parameter Real DamMin "the minimum damper postion";
  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=0.5
    "Time constant of Integrator block";

  BuildingControlEmulator.Devices.Control.conPI pI(
    k=k,
    Ti=Ti,
    conPID(reverseAction=true))
    annotation (Placement(transformation(extent={{10,2},{30,22}})));
  Modelica.Blocks.Interfaces.BooleanInput On annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput SetPoi "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Mea "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Sources.BooleanExpression integerExpression(y=(Tout <= TemHig)
         and (Tout > TemLow))                                                 annotation (Placement(transformation(extent={{-80,30},
            {-60,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=DamMin) annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Modelica.Blocks.Math.Max max annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(extent={{54,46},{74,66}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal" annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput Tout
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.BooleanOutput EcoOn "Connector of Real output signal"
                                                                            annotation (Placement(transformation(extent={{100,-54},{120,-34}})));
  Modelica.Blocks.Sources.BooleanExpression integerExpression1(y=integerExpression.y and (pI.y < 0.99))
                                                                              annotation (Placement(transformation(extent={{-14,-58},{6,-38}})));
equation
  connect(integerExpression1.y, EcoOn);
  connect(pI.SetPoi, SetPoi)
    annotation (Line(
      points={{8,12},{8,10},{-60,10},{-60,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pI.Mea, Mea) annotation (Line(
      points={{8,6},{8,4},{-40,4},{-40,-80},{-120,-80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(integerExpression.y, pI.On) annotation (Line(points={{-59,40},{-59,40},
          {0,40},{0,18},{8,18}},                                                                        color={255,0,255}));
  connect(pI.y, max.u1) annotation (Line(points={{31,12},{40,12},{40,6},{50,6}}, color={0,0,127}));
  connect(max.u2, realExpression.y) annotation (Line(points={{50,-6},{40,-6},{40,-20},{31,-20}}, color={0,0,127}));
  connect(booleanToReal.u, On) annotation (Line(
      points={{-62,80},{-120,80}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(product.u1, booleanToReal.y)
    annotation (Line(
      points={{52,62},{0,62},{0,80},{-39,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(max.y, product.u2)
    annotation (Line(
      points={{73,0},{76,0},{76,28},{40,28},{40,50},{52,50}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(product.y, y) annotation (Line(
      points={{75,56},{90,56},{90,0},{110,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-34,26},{38,-34}},
          lineColor={0,127,255},
          lineThickness=1,
          textString="Eco")}),                                   Diagram(coordinateSystem(preserveAspectRatio=false)));
end ecoCon;
