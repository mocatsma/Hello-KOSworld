function main {
//  declare global stagenumber to 1.
//  declare global maxstagenumber to 4.
  doLaunch().
  DoAscent().
  //print "Main Until".
  until Apoapsis > 100000 {
    //print "thrust check main".
    DoAutostage().
    //print "Main Until continues".
    //print apoapsis.
  }
  print apoapsis.
  DoShutdown().
  executemaneuver(time:second + 30,100,100,100).
  print "executemaneuver ran".
}

function executemaneuver{
  parameter utime, radial, normal,prograde.
  local mnv is node(utime,radial,normal,prograde).
  AddManeuverToFlightPlan(mnv).
  local starttime is calculatestarttime(mnvr).
  wait until starttime - 10.
  lockSteeringAtManeuverTarget(mnv).
  wait until starttime.
  lock throttle to 1.
  wait until isManeuverComplete(mnv).
  lock throttle to 0.
  removerManeuverFromFlightplan(mnvr).
}

function AddManeuverToFlightPlan {
  parameter mnv.
  // TODO
}

function calculatestarttime {
  parameter mnv.
  // TODO
  return 0.
}

function lockSteeringAtManeuverTarget {
  parameter mnv.
  // TODO
}

function isManeuverComplete {
  parameter mnv.
  // TODO
  return true.
}

function removerManeuverFromFlightplan {
  parameter mnv.
  // TODO
}

function doLaunch {
  print "DoLaunch".
  lock throttle to 1.
  //wait 1.
  dosafestage().
  wait .5.
  //dosafestage().
  print "back from dosafestage".
}
//doLaunch().

function DoAscent{
  print "DoAscent".
  lock targetPitch to 88.963 - 1.03287 * alt:radar^0.409511.
  set targetDirection to 90.
  lock steering to heading(targetDirection, targetPitch).
  Print "Done DoAscent".
}
//DoAscent().

Function DoAutostage {
  if not(defined OldThrust){
    Print "first DoAutostage".
    declare global OldThrust to ship:availablethrust.
    print OldThrust.
    }
    print "thrust check1".
  if ship:availablethrust < (OldThrust - 10) {
    print "thrust check3".
    dosafestage().  wait 1.
    declare global OldThrust to ship:availablethrust.
//    declare global stagenumber to stagenumber + 1.
//  print "Stage: " + stagenumber + " / " + maxstagenumber.
    print "Apoapsis: " + Apoapsis.
    print "Thrust: " + OldThrust.
  }
  print "thrust check4".
}
//DoAutostage().

function DoShutdown {
  print "DoShutdown".
  lock throttle to 0.
  lock steering to prograde.
  //wait until false.
}
//doShutdown().

function dosafestage {
  print "dosafestage".
  wait until stage:ready.
  //print "stageready".
  stage.
}
//dosafestage().

main().
