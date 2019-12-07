$input = Get-Content $PSScriptRoot/input    
$totalfuel=0

function fuelForMass {
    param (
        $inputfuel
    )
    $reqfuel = ([System.Math]::Floor([decimal]($inputfuel / 3)) -2)
    return $reqfuel
}

foreach ($tank in $input){
    $fuel = fuelForMass -inputfuel $tank
    $addedFuel = fuelForMass -inputfuel $fuel
    $fuel += $addedFuel
    while($addedFuel -gt 0 ){

        $addedFuel = fuelForMass $addedFuel
        if ($addedFuel -gt 0) {
            $fuel += $addedFuel 
        }
    } 
    $totalfuel+=$fuel
    
}
$totalfuel