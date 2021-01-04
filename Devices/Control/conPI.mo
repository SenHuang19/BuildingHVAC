within BuildingControlEmulator.Devices.Control;
model conPI "\"PI Controller\""

  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=0.5
    "Time constant of Integrator block";

  Modelica.Blocks.Interfaces.BooleanInput On
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-72,50},{-52,70}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  LimPID                           conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    xi_start=0,
    k=k,
    Ti=Ti,
    reset=IBPSA.Types.Reset.Input)
    annotation (Placement(transformation(extent={{-8,-30},{12,-10}})));
  Modelica.Blocks.Interfaces.RealInput SetPoi
    "Connector of setpoint input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Mea
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
equation
  connect(On, booleanToReal.u) annotation (Line(
      points={{-120,60},{-90,60},{-74,60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(conPID.u_s, SetPoi) annotation (Line(
      points={{-10,-20},{-66,-20},{-66,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conPID.y, product.u2) annotation (Line(
      points={{13,-20},{28,-20},{28,-6},{38,-6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanToReal.y, product.u1) annotation (Line(
      points={{-51,60},{28,60},{28,6},{38,6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(product.y, y) annotation (Line(
      points={{61,0},{110,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conPID.trigger, booleanToReal.u) annotation (Line(
      points={{-6,-32},{-6,-48},{-90,-48},{-90,60},{-74,60}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(const.y, conPID.y_reset_in) annotation (Line(
      points={{-39,-80},{-28,-80},{-28,-28},{-10,-28}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Mea, conPID.u_m) annotation (Line(
      points={{-120,-60},{-60,-60},{2,-60},{2,-32}},
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
          textString="PI")}),            Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end conPI;
