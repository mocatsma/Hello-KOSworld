function main {
//  declare global stagenumber to 1.
//  declare global maxstagenumber to 4.
  doLaunch().
  DoAscent().
  print "Main Until".
  until Apoapsis > 100000 {
  print "thrust check main".
    DoAutostage().
    print "Main Until continues".
    print apoapsis.
  }
  DoShutdown().
}

function doLaunch {
  print "DoLaunch".
  lock throttle to 1.
  //wait 1.
  dosafestage().
  wait .5.
  dosafestage().
  print "back from dosafestage".
}
doLaunch().

function DoAscent{
  print "DoAscent".
  lock targetPitch to 88.963 - 1.03287 * alt:radar^0.409511.
  set targetDirection to 90.
  lock steering to heading(targetDirection, targetPitch).
  Print "Done DoAscent".
}
DoAscent().

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
DoAutostage().

function DoShutdown {
  lock throttle to 0.
  lock steering to prograde.
  wait until false.
}
doShutdown().

function dosafestage {
  print "dosafestage".
  wait until stage:ready.
  print "stageready".
  stage.
}

main().
