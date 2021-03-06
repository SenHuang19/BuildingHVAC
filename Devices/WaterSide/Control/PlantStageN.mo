within BuildingControlEmulator.Devices.WaterSide.Control;
model PlantStageN "Combined stage controller for N chillers or N boilers"
  parameter Real tWai "Waiting time";

  parameter Real thehol[n-1] "Threshold";

  parameter Real Cap[n] "Rated Plant Capacity";

  parameter Integer n=3
    "the number of chillers";

  Modelica.Blocks.Interfaces.RealOutput y[n]( each start=0)
    "Output of stage control"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanInput
                                       On "On signal"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput Status[n] "Compressor speed ratio"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput Loa
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  PlantStageCondition plantNStageCondition(
    thehol=thehol,
    n=n,
    Cap=Cap) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  BaseClasses.StageN NStage(tWai=tWai, n=n)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
equation

  for i in 1:n loop
     y[i] =if i <= integer(NStage.y) then 1 else 0;
  end for;

  connect(plantNStageCondition.OnSin, On) annotation (Line(
      points={{-62,0},{-80,0},{-80,80},{-120,80}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(plantNStageCondition.Loa, Loa) annotation (Line(
      points={{-62,6},{-78,6},{-94,6},{-94,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(plantNStageCondition.Status, Status) annotation (Line(
      points={{-62,-6},{-80,-6},{-80,-80},{-120,-80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(plantNStageCondition.Off, NStage.Off) annotation (Line(
      points={{-39,-4},{-20,-4},{-20,-6},{-10,-6}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(plantNStageCondition.On, NStage.On) annotation (Line(
      points={{-39,4},{-20,4},{-20,6},{-10,6}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-56,42},{58,-42}},
          lineColor={0,0,255},
          textString="ChiSta"),
        Text(
          extent={{-44,-144},{50,-112}},
          lineColor={0,0,255},
          textString="%name")}),
    Documentation(revisions="<html>
<ul>
<li>
March 19, 2014 by Sen Huang:<br/>
First implementation.
</li>
</ul>
</html>"));
end PlantStageN;
